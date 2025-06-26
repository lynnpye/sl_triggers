;/
You can use this as a reference for building your own sl_triggers Extension.
Required and Optional overrides have been noted.
/;
scriptname sl_triggersExtensionCore extends sl_triggersExtension

import sl_triggersStatics

ActorBase Property				pkSentinelBase Auto
FormList Property				TheContainersWeKnowAndLove Auto ; so many naming schemes to choose from

Actor Property pkSentinel Auto Hidden

string	EVENT_TOP_OF_THE_HOUR					= "TopOfTheHour"
string	EVENT_TOP_OF_THE_HOUR_HANDLER			= "OnTopOfTheHour"

int		EVENT_ID_KEYMAPPING 					= 1
int		EVENT_ID_TOP_OF_THE_HOUR				= 2
int  	EVENT_ID_NEW_SESSION					= 3
int		EVENT_ID_PLAYER_CELL_CHANGE				= 4
int		EVENT_ID_PLAYER_LOADING_SCREEN			= 5
int		EVENT_ID_CONTAINER						= 6
string	ATTR_EVENT								= "event"
string	ATTR_KEYMAPPING							= "keymapping"
string	ATTR_MODIFIERKEYMAPPING 				= "modifierkeymapping"
string	ATTR_USEDAK								= "usedak"
string  ATTR_DAYTIME							= "daytime"
string	ATTR_LOCATION							= "location"
string  ATTR_COMMONCONTAINERMATCHING			= "comconmat"
string  ATTR_DEEPLOCATION						= "deeplocation"
string  ATTR_CONTAINER_CORPSE					= "container_corpse"
string  ATTR_CONTAINER_EMPTY					= "container_empty"
string	ATTR_CHANCE								= "chance"
string	ATTR_DO_1								= "do_1"
string	ATTR_DO_2								= "do_2"
string	ATTR_DO_3								= "do_3"

GlobalVariable		Property DAKStatus				Auto Hidden
Bool				Property DAKAvailable			Auto Hidden
GlobalVariable		Property DAKHotKey				Auto Hidden
float				Property TohElapsedTime			Auto Hidden
float				Property LastTopOfTheHour		Auto Hidden
float				Property NextTopOfTheHour		Auto Hidden


; Variables
bool	handlingTopOfTheHour = false ; only because the check is in a sensitive event handler

; this will contain a deduplicated list of all keycodes of interest, including modifiers
; so with 4 keycodes and 2 modifiers (assuming none of the modifiers are themselves also keycodes) this would be 6 in length
int[]		_keycodes_of_interest
; matching length boolean state array for fast lookup
;bool[]		_keycode_status
bool[]		_keystates

; onInit we will refresh these with what we find
; and edit them during MCM updates as needed
string[]	triggerKeys_topOfTheHour
string[]	triggerKeys_keyDown
string[]	triggerKeys_newSession
string[]	triggerKeys_playercellchange
string[]	triggerKeys_playerloadingscreen
string[]	triggerKeys_container

bool		playerCellChangeHandlingReady
float 		last_time_PlayerCellChangeEvent
string[]	common_container_names

Event OnInit()
	if !self
		return
	endif

	playerCellChangeHandlingReady = false
	pkSentinel = PlayerRef.PlaceActorAtMe(pkSentinelBase)

	; REQUIRED CALL
	UnregisterForUpdate()
	RegisterForSingleUpdate(0.01)
EndEvent

Event OnUpdate()
	SLTInit()
EndEvent

Function SLTReady()
	if !pkSentinel
		pkSentinel = PlayerRef.PlaceActorAtMe(pkSentinelBase)
	endif
	RelocatePlayerLoadingScreenSentinel()
	playerCellChangeHandlingReady = true

	_keystates = PapyrusUtil.BoolArray(256, false)
	UpdateDAKStatus()
	RefreshData()
EndFunction

Function RefreshData()
	RefreshTheContainersWeKnowAndLove()
	RefreshTriggerCache()
	RegisterEvents()
EndFunction

bool Function CustomResolveScoped(sl_triggersCmd CmdPrimary, string scope, string token)
	if scope == "core"
		if token == "toh_elapsed"
			CmdPrimary.CustomResolveResult = TohElapsedTime as string
			return true
		endif
	elseif scope == "system"
		if token == "is_available.core"
			CmdPrimary.CustomResolveResult = IsEnabled as int
			return true
		endif
	endif
	return false
EndFunction

Event OnUpdateGameTime()
	if !self
		return
	endif
	If !IsEnabled
		Return
	EndIf
	
	if handlingTopOfTheHour
		float currentTime = Utility.GetCurrentGameTime() ; Days as float
		
		If currentTime >= nextTopOfTheHour
			tohElapsedTime = currentTime - lastTopOfTheHour
			lastTopOfTheHour = currentTime
			
			SendModEvent(EVENT_TOP_OF_THE_HOUR, "", tohElapsedTime)
			AlignToNextHour(currentTime)
		else
			RegisterForSingleUpdateGameTime((nextTopOfTheHour - currentTime) * 24.0 * 1.04)
		EndIf
	EndIf
EndEvent

Event OnNewSession(int _newSessionId)
	if !self
		Return
	endif
	
	If !IsEnabled
		Return
	EndIf
	
	HandleNewSession(_newSessionId)
EndEvent

Event OnTopOfTheHour(String eventName, string strArg, Float fltArg, Form sender)
	if !self
		Return
	endif
	
	If !IsEnabled
		Return
	EndIf
	
	HandleTopOfTheHour()
	;checkEvents(-1, 4, PlayerRef)
EndEvent

Event OnKeyUp(int KeyCode, float holdTime)
	if !self
		Return
	endif

	_keystates[KeyCode] = false
EndEvent

Event OnKeyDown(Int KeyCode)
	if !self
		Return
	endif

	_keystates[KeyCode] = true
	
	If !IsEnabled
		SLTWarnMsg("Not enabled yet, exiting OnKeyDown early")
	else
		HandleOnKeyDown()
	Endif
EndEvent

Function Send_SLTR_OnPlayerCellChange()
	; optional send actual mod event, otherwise at least pass it off to our handlers
	SendModEvent(EVENT_SLTR_ON_PLAYER_CELL_CHANGE())
	HandleOnPlayerCellChange()
EndFunction

Function SLTR_Internal_PlayerCellChange()
	if !playerCellChangeHandlingReady
		return
	endif
	float nowtime = Utility.GetCurrentRealTime()

	if (nowtime - last_time_PlayerCellChangeEvent) < 0.1
		; ignoring flutter
		return
	endif
	last_time_PlayerCellChangeEvent = nowtime
	RelocatePlayerLoadingScreenSentinel()
	Send_SLTR_OnPlayerCellChange()
EndFunction

Function RelocatePlayerLoadingScreenSentinel()
	pkSentinel.MoveTo(PlayerRef, 0.0, 0.0, 256.0)
EndFunction

Function Send_SLTR_OnPlayerLoadingScreen()
	; optional send actual mod event, otherwise at least pass it off to our handlers
	SendModEvent(EVENT_SLTR_ON_PLAYER_LOADING_SCREEN())
	HandleOnPlayerLoadingScreen()
EndFunction

; in the example, called OnPlayerLoadingScreen() but surely it's for more than that?
Function SLTR_Internal_PlayerNewSpaceEvent()
	RelocatePlayerLoadingScreenSentinel()
	Send_SLTR_OnPlayerLoadingScreen()
EndFunction

Function Send_SLTR_OnPlayerActivateContainer(ObjectReference containerRef, bool container_is_corpse, bool container_is_empty)
	Keyword playerLocationKeyword = SLT.GetPlayerLocationKeyword()

	HandlePlayerContainerActivation(containerRef, container_is_corpse, container_is_empty, playerLocationKeyword)

	int handle = ModEvent.Create(EVENT_SLTR_ON_CONTAINER_ACTIVATE())
	ModEvent.PushForm(handle, containerRef)
	ModEvent.PushBool(handle, container_is_corpse)
	ModEvent.PushBool(handle, container_is_empty)
	ModEvent.PushForm(handle, playerLocationKeyword)
	ModEvent.Send(handle)
EndFunction

Function SLTR_Internal_PlayerActivatedContainer(ObjectReference containerRef, bool container_is_corpse, bool container_is_empty)
	if !containerRef
		return
	endif
	Send_SLTR_OnPlayerActivateContainer(containerRef, container_is_corpse, container_is_empty)
EndFunction

Function RefreshTheContainersWeKnowAndLove()
	TheContainersWeKnowAndLove.Revert()
	Container containerToAdd
	Int i = JsonUtil.FormListCount(FN_MoreContainersWeKnowAndLove(), "dt_additional")
	While i
		i -=1
		containerToAdd = JsonUtil.FormListGet(FN_MoreContainersWeKnowAndLove(), "dt_additional", i) As Container
		If containerToAdd
			TheContainersWeKnowAndLove.AddForm(containerToAdd)
		EndIf	
	EndWhile
	
	; and some hard-coded entries to prevent requiring Dawnguard and Dragonborn as hard dependencies
	;/
	, "020040A5|Dawnguard.esm"
	, "02019DD6|Dawnguard.esm"
	, "03025E46|Dragonborn.esm"
	, "0302AABA|Dragonborn.esm"
	, "0302AABF|Dragonborn.esm"
	, "0302AAC2|Dragonborn.esm"
	, "0302C456|Dragonborn.esm"
	, "0302C461|Dragonborn.esm"
	, "03024FA5|Dragonborn.esm"
	, "0302C464|Dragonborn.esm"
	/;
	containerToAdd = sl_triggers.GetForm("0x040A5|Dawnguard.esm") as Container
	if containerToAdd
		TheContainersWeKnowAndLove.AddForm(containerToAdd)
	endif
	containerToAdd = sl_triggers.GetForm("0x019DD6|Dawnguard.esm") as Container
	if containerToAdd
		TheContainersWeKnowAndLove.AddForm(containerToAdd)
	endif
	containerToAdd = sl_triggers.GetForm("0x025E46|Dragonborn.esm") as Container
	if containerToAdd
		TheContainersWeKnowAndLove.AddForm(containerToAdd)
	endif
	containerToAdd = sl_triggers.GetForm("0x02AABA|Dragonborn.esm") as Container
	if containerToAdd
		TheContainersWeKnowAndLove.AddForm(containerToAdd)
	endif
	containerToAdd = sl_triggers.GetForm("0x02AABF|Dragonborn.esm") as Container
	if containerToAdd
		TheContainersWeKnowAndLove.AddForm(containerToAdd)
	endif
	containerToAdd = sl_triggers.GetForm("0x02AAC2|Dragonborn.esm") as Container
	if containerToAdd
		TheContainersWeKnowAndLove.AddForm(containerToAdd)
	endif
	containerToAdd = sl_triggers.GetForm("0x02C456|Dragonborn.esm") as Container
	if containerToAdd
		TheContainersWeKnowAndLove.AddForm(containerToAdd)
	endif
	containerToAdd = sl_triggers.GetForm("0x02C461|Dragonborn.esm") as Container
	if containerToAdd
		TheContainersWeKnowAndLove.AddForm(containerToAdd)
	endif
	containerToAdd = sl_triggers.GetForm("0x024FA5|Dragonborn.esm") as Container
	if containerToAdd
		TheContainersWeKnowAndLove.AddForm(containerToAdd)
	endif
	containerToAdd = sl_triggers.GetForm("0x02C464|Dragonborn.esm") as Container
	if containerToAdd
		TheContainersWeKnowAndLove.AddForm(containerToAdd)
	endif

	common_container_names = JsonUtil.StringListToArray(FN_MoreContainersWeKnowAndLove(), "dt_common")
EndFunction

Function RefreshTriggerCache()
	triggerKeys_topOfTheHour			= PapyrusUtil.StringArray(0)
	triggerKeys_keyDown					= PapyrusUtil.StringArray(0)
	triggerKeys_newSession				= PapyrusUtil.StringArray(0)
	triggerKeys_playercellchange		= PapyrusUtil.StringArray(0)
	triggerKeys_playerloadingscreen		= PapyrusUtil.StringArray(0)
	triggerKeys_container				= PapyrusUtil.StringArray(0)
	int i = 0
	
	while i < TriggerKeys.Length
		string _triggerFile = FN_T(TriggerKeys[i])

		if !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
			int eventCode = JsonUtil.GetIntValue(_triggerFile, ATTR_EVENT)
	
			if eventCode == EVENT_ID_TOP_OF_THE_HOUR ; topofthehour
				triggerKeys_topOfTheHour = PapyrusUtil.PushString(triggerKeys_topOfTheHour, TriggerKeys[i])
			elseif eventCode == EVENT_ID_KEYMAPPING
				triggerKeys_keyDown = PapyrusUtil.PushString(triggerKeys_keyDown, TriggerKeys[i])
			elseif eventCode == EVENT_ID_NEW_SESSION
				triggerKeys_newSession = PapyrusUtil.PushString(triggerKeys_newSession, TriggerKeys[i])
			elseif eventCode == EVENT_ID_PLAYER_CELL_CHANGE
				triggerKeys_playercellchange = PapyrusUtil.PushString(triggerKeys_playercellchange, TriggerKeys[i])
			elseif eventCode == EVENT_ID_PLAYER_LOADING_SCREEN
				triggerKeys_playerloadingscreen = PapyrusUtil.PushString(triggerKeys_playerloadingscreen, TriggerKeys[i])
			elseif eventCode == EVENT_ID_CONTAINER
				triggerKeys_container = PapyrusUtil.PushString(triggerKeys_container, TriggerKeys[i])
			endif
		endif

		i += 1
	endwhile

	_keycodes_of_interest = PapyrusUtil.IntArray(0)
	;_keycode_status = PapyrusUtil.BoolArray(0)
	if triggerKeys_keyDown.Length > 0
		i = 0

		while i < triggerKeys_keyDown.Length
			string triggerKey = triggerKeys_keyDown[i]
			string _triggerFile = FN_T(triggerKey)
			
			int keycode = JsonUtil.GetIntValue(_triggerFile, ATTR_KEYMAPPING)

			if _keycodes_of_interest.Find(keycode) < 0
				_keycodes_of_interest = PapyrusUtil.PushInt(_keycodes_of_interest, keycode)
			endif
			if JsonUtil.HasIntValue(_triggerFile, ATTR_MODIFIERKEYMAPPING)
				keycode = JsonUtil.GetIntValue(_triggerFile, ATTR_MODIFIERKEYMAPPING)
				if _keycodes_of_interest.Find(keycode) < 0
					_keycodes_of_interest = PapyrusUtil.PushInt(_keycodes_of_interest, keycode)
				endif
			endif
			i += 1
		endwhile

		;_keycode_status = PapyrusUtil.BoolArray(_keycodes_of_interest.Length)
	endif
EndFunction

; this function attempts to trigger a SingleUpdateGameTime just in time for the 
; next game-time top of the hour
; the 1.04 multiplier is to intentionally overshoot a tiny bit to ensure our trigger works
Function AlignToNextHour(float _curTime = -1.0)
	if triggerKeys_topOfTheHour.Length <= 0
		return
	endif
	
	; days
    float currentTime = _curTime
	if currentTime < 0.0
		currentTime = Utility.GetCurrentGameTime() ; Days as float
	endif
	; days
	float daysPassed = Math.Floor(currentTime) as float
	; hours
	float hoursToday = (currentTime - daysPassed) * 24.0
	float nextHourToday = Math.Floor(hoursToday + 1.0) as float
	float untilNextHour = nextHourToday - hoursToday
	
	nextTopOfTheHour = currentTime + (untilNextHour / 24.0)
	
	; because the timing for this has been ornery to say the least
    RegisterForSingleUpdateGameTime(untilNextHour * 1.04)
EndFunction

Function UpdateDAKStatus()
	dakavailable = false
	DAKStatus = GetForm_DAK_Status() as GlobalVariable
	DAKHotKey = GetForm_DAK_HotKey() as GlobalVariable
	
	if DAKStatus
		dakavailable = true
	endif
EndFunction

; selectively enables only events with triggers
Function RegisterEvents()
	UnregisterForModEvent(EVENT_SLT_ON_NEW_SESSION())
	if IsEnabled && triggerKeys_newSession.Length > 0
		SafeRegisterForModEvent_Quest(self, EVENT_SLT_ON_NEW_SESSION(), "OnNewSession")
	endif

	UnregisterForModEvent(EVENT_TOP_OF_THE_HOUR)
	handlingTopOfTheHour = false
	if IsEnabled && triggerKeys_topOfTheHour.Length > 0
		SafeRegisterForModEvent_Quest(self, EVENT_TOP_OF_THE_HOUR, EVENT_TOP_OF_THE_HOUR_HANDLER)
		AlignToNextHour()
		handlingTopOfTheHour = true
	endif
	
	if IsEnabled && triggerKeys_keyDown.Length > 0
		RegisterForKeyEvents()
	endif
EndFunction

Function RegisterForKeyEvents()
	UnregisterForAllKeys()
	int i = 0
	while i < _keycodes_of_interest.Length
		RegisterForKey(_keycodes_of_interest[i])
		i += 1
	endwhile
EndFunction

Function HandleNewSession(int _newSessionId)
	int i = 0
	string triggerKey
	string _triggerFile
	string command
	
	while i < triggerKeys_newSession.Length
		triggerKey = triggerKeys_newSession[i]
		_triggerFile = FN_T(triggerKey)

		if !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
			if command
				RequestCommand(PlayerRef, command)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
			if command
				RequestCommand(PlayerRef, command)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
			if command
				RequestCommand(PlayerRef, command)
			endIf
		endif

		i += 1
	endwhile
EndFunction

Function HandleTopOfTheHour()
	int i = 0
	string triggerKey
	string _triggerFile
	string command
	float chance
	
	while i < triggerKeys_topOfTheHour.Length
		triggerKey = triggerKeys_topOfTheHour[i]
		_triggerFile = FN_T(triggerKey)

		if !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE)

			if chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
				command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
				if command
					RequestCommand(PlayerRef, command)
				endIf
				command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
				if command
					RequestCommand(PlayerRef, command)
				endIf
				command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
				if command
					RequestCommand(PlayerRef, command)
				endIf
			endif
		endif
		i += 1
	endwhile
EndFunction

Function HandleOnKeyDown()
	; all we know at this point is that at least one of the keys of interest were pressed
	; now we iterate all of the triggers (by slotnoprefix), check the status array against their
	; settings, and execute or skip
	int i = 0
	bool doRun
	bool dakused
	int ival
	int statusidx
	string value
	string triggerKey
	string command
	string _triggerFile
	
	while i < triggerKeys_keyDown.Length
		triggerKey = triggerKeys_keyDown[i]

		_triggerFile = FN_T(triggerKey)
		
		dakused = false
		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
		
		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_KEYMAPPING)
			;statusidx = _keycodes_of_interest.Find(ival)
			
			; check keycode status, must be true
			;if statusidx < 0
			;	doRun = false
			;else
			if ival
				;doRun = _keycode_status[statusidx]
				doRun = _keystates[ival]
			endif
		endif
		
		; check dynamic activation key if in use and specified
		if doRun && DAKAvailable && JsonUtil.HasIntValue(_triggerFile, ATTR_USEDAK)
			doRun = (JsonUtil.GetIntValue(_triggerFile, ATTR_USEDAK) != 0)
			if doRun
				; if they had DAK setting AND it was true, then dakused is true
				; and doRun is determined by DAK status
				dakused = true
				doRun = DAKStatus.GetValue() as bool
			endif
		endif
		
		; check modifier status only if specified
		; if dakused, we do not try to manage via modifier
		if doRun && !dakused && JsonUtil.HasIntValue(_triggerFile, ATTR_MODIFIERKEYMAPPING)
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_MODIFIERKEYMAPPING)
			
			; only if mapped
			if ival > -1
				;statusidx = _keycodes_of_interest.Find(ival)
				
				;if statusidx < 0
				;	doRun = false
				;else
				if ival
					;doRun = _keycode_status[statusidx]
					doRun = _keystates[ival]
				endif
			endif
		endif
		
		if doRun
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
			if command
				RequestCommand(PlayerRef, command)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
			if command
				RequestCommand(PlayerRef, command)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
			if command
				RequestCommand(PlayerRef, command)
			endIf
		endif
		
		i += 1
	endwhile
EndFunction

Function HandleOnPlayerCellChange()
	int i = 0
	string triggerKey
	string _triggerFile
	string command
	int    ival
	bool   doRun
	float  chance
	while i < triggerKeys_playercellchange.Length
		triggerKey = triggerKeys_playercellchange[i]
		_triggerFile = FN_T(triggerKey)

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE)

			if chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
				ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DAYTIME)
				if ival != 0 ; 0 is Any
					if ival == 1 && dayTime() != 1
						doRun = false
					elseIf ival == 2 && dayTime() != 2
						doRun = false
					endIf
				endIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_LOCATION)
					if ival != 0 ; 0 is Any
						if ival == 1 && !PlayerRef.IsInInterior()
							doRun = false
						elseIf ival == 2 && PlayerRef.IsInInterior()
							doRun = false
						endIf
					endIf
				endIf
				
				command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
				if command
					RequestCommand(PlayerRef, command)
				endIf
				command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
				if command
					RequestCommand(PlayerRef, command)
				endIf
				command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
				if command
					RequestCommand(PlayerRef, command)
				endIf
			endif
		endif
		i += 1
	endwhile
EndFunction

Function HandleOnPlayerLoadingScreen()
	int i = 0
	string triggerKey
	string _triggerFile
	string command
	float  chance
	while i < triggerKeys_playerloadingscreen.Length
		triggerKey = triggerKeys_playerloadingscreen[i]
		_triggerFile = FN_T(triggerKey)

		if !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE)

			if chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
				command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
				if command
					RequestCommand(PlayerRef, command)
				endIf
				command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
				if command
					RequestCommand(PlayerRef, command)
				endIf
				command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
				if command
					RequestCommand(PlayerRef, command)
				endIf
			endif
		endif
		i += 1
	endwhile
EndFunction

Function HandlePlayerContainerActivation(ObjectReference containerRef, bool container_is_corpse, bool container_is_empty, Keyword playerLocationKeyword)
	if !containerRef
		return
	endif

	int i = 0
	int j

	bool   doRun
	string triggerKey
	string _triggerFile
	string command

	int    	ival
	bool 	bval
	
	float chance

	while i < triggerKeys_container.Length
		triggerKey = triggerKeys_container[i]
		_triggerFile = FN_T(triggerKey)

		if !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE)

			if chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
				ival = 0

				doRun =	(container_is_empty == (JsonUtil.GetIntValue(_triggerFile, ATTR_CONTAINER_EMPTY) == 2)) && (container_is_corpse == (JsonUtil.GetIntValue(_triggerFile, ATTR_CONTAINER_CORPSE) == 2))

				; if needed: are we filtering for commons?
				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_COMMONCONTAINERMATCHING)
					if ival != 0 ; 0 is Any
						bval = false
						j = 0
						while j < common_container_names.Length && !bval
							if common_container_names[j] == containerRef.GetDisplayName()
								bval = true
							endif
							j += 1
						endwhile
						doRun = (bval && ival == 1) || (!bval && ival == 2)
					endif
				endif

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DEEPLOCATION)
					if ival != 0
;/
0 - Any

1 - Inside
2 - Outside
3 - Safe (Home/Jail/Inn)
4 - City (City/Town/Habitation/Dwelling)
5 - Wilderness (!pLoc(DEFAULT)/Hold/Fort/Bandit Camp)
6 - Dungeon (Cave/et. al.)

; LocationKeywords[i - 7]
5 - Player Home
6 - Jail
...
/;

						if ival == 1
							doRun = PlayerRef.IsInInterior()
						elseif ival == 2
							doRun = !PlayerRef.IsInInterior()
						elseif ival == 3
							doRun = SLT.IsLocationKeywordSafe(playerLocationKeyword)
						elseif ival == 4
							doRun = SLT.IsLocationKeywordCity(playerLocationKeyword)
						elseif ival == 5
							doRun = SLT.IsLocationKeywordWilderness(playerLocationKeyword)
						elseif ival == 6
							doRun = SLT.IsLocationKeywordDungeon(playerLocationKeyword)
						else
							j = ival - 7
							doRun = playerLocationKeyword == SLT.LocationKeywords[j]
						endif
					endif
				endif

				if doRun
					command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
					if command
						RequestCommand(PlayerRef, command)
					endIf
					command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
					if command
						RequestCommand(PlayerRef, command)
					endIf
					command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
					if command
						RequestCommand(PlayerRef, command)
					endIf
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction