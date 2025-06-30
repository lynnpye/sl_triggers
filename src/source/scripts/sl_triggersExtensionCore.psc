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

int Property CS_DEFAULT 		= 0 AutoReadOnly Hidden
int Property CS_SLTINIT		 	= 1 AutoReadOnly Hidden
int Property CS_POLLING 		= 2 AutoReadOnly Hidden

int CS_STATE

Function QueueUpdateLoop(float afDelay = 1.0)
	if !self
		return
	endif
	RegisterForSingleUpdate(afDelay)
EndFunction

Event OnInit()
	if !self
		return
	endif

	playerCellChangeHandlingReady = false

	; REQUIRED CALL
	CS_STATE = CS_SLTINIT
	UnregisterForUpdate()
	QueueUpdateLoop(0.01)
EndEvent

Event OnUpdate()
	if CS_SLTINIT == CS_STATE
		SLTInit()
		
		CS_STATE = CS_POLLING
		QueueUpdateLoop(0.01)
		return
	elseif CS_POLLING == CS_STATE
		if PopulateSentinel()
			return
		elseif !PlayerRef
			QueueUpdateLoop()
			return
		elseif PlayerRef && PlayerRef.Is3DLoaded()
			QueueUpdateLoop(0.1)
			return
		endif
	endif
EndEvent

bool Function PopulateSentinel()
	if pkSentinel
		; got filled at some point when we weren't looking, huzzah!
		RelocatePlayerLoadingScreenSentinel()
		playerCellChangeHandlingReady = true
		return true
	elseif !PlayerRef
		;SLTDebugMsg("Core.OnUpdate: pollingForSentinel requested, PlayerRef is not filled, polling 1 second")
		return false
	elseif PlayerRef.Is3DLoaded()
		pkSentinel = PlayerRef.PlaceActorAtMe(pkSentinelBase)

		if pkSentinel
			;SLTDebugMsg("Core.OnUpdate: pollingForSentinel requested, PlayerRef.Is3DLoaded, pkSentinel is (" + pkSentinel + ")")
			RelocatePlayerLoadingScreenSentinel()
			playerCellChangeHandlingReady = true
			return true
		;else
			; keep checking until satisfied?
			;SLTDebugMsg("Core.OnUpdate: pollingForSentinel requested, waiting 1 second to check for pkSentinel and player 3d loaded; this isn't actually good... it means placeactoratme failed even when PlayerRef.Is3dLoaded()")
		endif
	endif
	return false
EndFunction

Function PopulatePerk()
	if !SLT.SLTRContainerPerk
		SLTErrMsg("Core.PopulatePerk: SLTRContainerPerk is not filled; Container activation tracking disabled; this is probably an error")
	else
		If !PlayerRef.HasPerk(SLT.SLTRContainerPerk)
			;SLTDebugMsg("Core.OnUpdate: Adding SLTRContainerPerk to PlayerRef")
			PlayerRef.AddPerk(SLT.SLTRContainerPerk)

			If !PlayerRef.HasPerk(SLT.SLTRContainerPerk)
				SLTErrMsg("Core.PopulatePerk: SLTRContainerPerk is not present on PlayerRef even after validation; Container activation tracking disabled; this is probably an error")
			else
				;SLTInfoMsg("Core.PopulatePerk: Registering/1 for OnSLTRPlayerContainerActivate")
				SafeRegisterForModEvent_Quest(self, EVENT_SLTR_ON_PLAYER_CONTAINER_ACTIVATE(), EVENT_SLTR_ON_PLAYER_CONTAINER_ACTIVATE())
			Endif
		else
			;SLTInfoMsg("Core.PopulatePerk: Registering/2 for OnSLTRContainerActivate")
			SafeRegisterForModEvent_Quest(self, EVENT_SLTR_ON_PLAYER_CONTAINER_ACTIVATE(), EVENT_SLTR_ON_PLAYER_CONTAINER_ACTIVATE())
		Endif
	Endif
EndFunction

Function SLTReady()
	PopulatePerk()
	if CS_POLLING != CS_STATE && !pkSentinel
		CS_STATE = CS_POLLING
		UnregisterForUpdate()
		QueueUpdateLoop(0.01)
	endif

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
	elseif scope == "request"
		if token == "core.activatedContainer"
			CmdPrimary.CustomResolveFormResult = CmdPrimary.GetRequestForm(token)
			return true
		elseif token == "core.activatedContainer.is_corpse"
			CmdPrimary.CustomResolveBoolResult = CmdPrimary.GetRequestVar(token) as int
			return true
		elseif token == "core.activatedContainer.is_empty"
			CmdPrimary.CustomResolveBoolResult = CmdPrimary.GetRequestVar(token) as int
			return true
		elseif token == "core.activatedContainer.is_common"
			CmdPrimary.CustomResolveBoolResult = CmdPrimary.GetRequestVar(token) as int
			return true
		elseif token == "core.activatedContainer.count"
			ObjectReference _acon = CmdPrimary.GetRequestForm("activatedContainer") as ObjectReference
			if !_acon
				CmdPrimary.SFE("Core.CustomResolveScoped: requested activatedContainer.count but no ObjectReference available")
			endif
			CmdPrimary.CustomResolveIntResult = _acon.GetNumItems()
			return true
		elseif token == "core.was_player.inside"
			CmdPrimary.CustomResolveBoolResult = CmdPrimary.GetRequestVar(token) as int
			return true
		elseif token == "core.was_player.outside"
			CmdPrimary.CustomResolveBoolResult = CmdPrimary.GetRequestVar(token) as int
			return true
		elseif token == "core.was_player.in_safe_area"
			Keyword _pkwd = CmdPrimary.GetRequestForm("core.playerLocationKeyword") as Keyword
			CmdPrimary.CustomResolveBoolResult = SLT.IsLocationKeywordSafe(_pkwd)
			return true
		elseif token == "core.was_player.in_city"
			Keyword _pkwd = CmdPrimary.GetRequestForm("core.playerLocationKeyword") as Keyword
			CmdPrimary.CustomResolveBoolResult = SLT.IsLocationKeywordCity(_pkwd)
			return true
		elseif token == "core.was_player.in_wilderness"
			Keyword _pkwd = CmdPrimary.GetRequestForm("core.playerLocationKeyword") as Keyword
			CmdPrimary.CustomResolveBoolResult = SLT.IsLocationKeywordWilderness(_pkwd)
			return true
		elseif token == "core.was_player.in_dungeon"
			Keyword _pkwd = CmdPrimary.GetRequestForm("core.playerLocationKeyword") as Keyword
			CmdPrimary.CustomResolveBoolResult = SLT.IsLocationKeywordDungeon(_pkwd)
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

Event OnSLTRPlayerCellChange(bool isNewGameLaunch, bool isNewSession, Form fkwPlayerLocation, bool playerWasInInterior)
	if SLT.bDebugMsg
		Keyword kwpLocation = fkwPlayerLocation as Keyword
		SLTDebugMsg("\tCore.OnSLTRPlayerCellChange: isNewGameLaunch:" + isNewGameLaunch + " / isNewSession: " + isNewSession + " / keywordPlayerLocation : " + kwpLocation + " / playerWasInInterior:" + playerWasInInterior)
	endif
EndEvent

int cellPreviousSessionId;
Function Send_SLTR_OnPlayerCellChange()
	if !PlayerRef || !PlayerRef.Is3DLoaded() || PlayerRef.IsDisabled()
        SLTDebugMsg("Core.Send_SLTR_OnPlayerCellChange: Player not ready for cell change processing")
        return
    endif

	float nowtime = Utility.GetCurrentRealTime()
	bool isNewGameLaunch = false
	; i.e. still this game load
	if last_time_PlayerCellChangeEvent && nowtime > last_time_PlayerCellChangeEvent
		if (nowtime - last_time_PlayerCellChangeEvent) < 1.0
			; ignoring flutter
			SLTDebugMsg("Core.Send_SLTR_OnPlayerCellChange: ignoring flutter")
			return
		endif
	; i.e. new launch of the .exe; not reversing time (is there an API for that?)
	else
		;SLTDebugMsg("Core.Send_SLTR_OnPlayerCellChange: new launch detected")
		isNewGameLaunch = true
	endif
	last_time_PlayerCellChangeEvent = nowtime

	RelocatePlayerLoadingScreenSentinel()

	int nowSessionId = sl_triggers.GetSessionId()
	bool isNewSession = nowSessionId != cellPreviousSessionId
	if isNewSession
		cellPreviousSessionId = nowSessionId
	endif

	if isNewGameLaunch && !isNewSession
		SLTWarnMsg("Core.Send_SLTR_OnPlayerCellChange: IsNewGameLaunch(" + isNewGameLaunch + ") but isNewSession(" + isNewSession + ") this really ought to be an error")
	endif

	; should
	; optional send actual mod event, otherwise at least pass it off to our handlers
	Keyword playerLocationKeyword = SLT.GetPlayerLocationKeyword()

	HandleOnPlayerCellChange(isNewGameLaunch, isNewSession, playerLocationKeyword, PlayerRef.IsInInterior())

	int mehandle = ModEvent.Create(EVENT_SLTR_ON_PLAYER_CELL_CHANGE())
	; is this in response to a "new launch" (i.e. new run of SkyrimSE.exe) ; multiple can be true
	ModEvent.PushBool(mehandle, isNewGameLaunch)
	; is this in response to "new session" (i.e. game load or new game) ; this should imply isNewGameLaunch and otherwise ought to be an error in my opinion
	ModEvent.PushBool(mehandle, isNewSession)
	ModEvent.PushForm(mehandle, playerLocationKeyword)
	ModEvent.PushBool(mehandle, PlayerRef.IsInInterior())
	ModEvent.Send(mehandle)

	isNewGameLaunch = false
EndFunction

Function SLTR_Internal_PlayerCellChange()
	if !playerCellChangeHandlingReady
		return
	endif
	Send_SLTR_OnPlayerCellChange()
EndFunction

Function RelocatePlayerLoadingScreenSentinel()
	pkSentinel.MoveTo(PlayerRef, 0.0, 0.0, 256.0)
EndFunction

Event OnSLTRPlayerLoadingScreen(string _eventName, string _strvalue, float _fltvalue, Form _frmvalue)
	if SLT.bDebugMsg
		SLTDebugMsg("\tCore.OnSLTRPlayerLoadingScreen")
	endif
EndEvent

Function Send_SLTR_OnPlayerLoadingScreen()
	; optional send actual mod event, otherwise at least pass it off to our handlers
	HandleOnPlayerLoadingScreen()

	SendModEvent(EVENT_SLTR_ON_PLAYER_LOADING_SCREEN())
EndFunction

; in the example, called OnPlayerLoadingScreen() but surely it's for more than that?
Function SLTR_Internal_PlayerNewSpaceEvent()
	RelocatePlayerLoadingScreenSentinel()
	Send_SLTR_OnPlayerLoadingScreen()
EndFunction

Event OnSLTRPlayerContainerActivate(Form fcontainerRef, bool isConCorpse, bool isConEmpty, Form fkwPlayerLocation, bool playerWasInInterior)
	if SLT.bDebugMsg
		ObjectReference containerRef = fcontainerRef as ObjectReference
		Keyword kwpLocation = fkwPlayerLocation as Keyword

		SLTDebugMsg("\tCore.OnSLTRPlayerContainerActivate fcontainerRef(" + fcontainerRef + ") / containerRef(" + containerRef + ") / isConCorpse(" + isConCorpse + ") / isConEmpty(" + isConEmpty + ") / fkwPlayerLocation(" + fkwPlayerLocation + ") / kwpLocation(" + kwpLocation + ")")
	endif
EndEvent

Function Send_SLTR_OnPlayerActivateContainer(ObjectReference containerRef, bool container_is_corpse, bool container_is_empty)
	;SLTDebugMsg("Core.Send_SLTR_OnPlayerActivateContainer containerRef(" + containerRef + ") corpse(" + container_is_corpse + ") empty(" + container_is_empty + ")")
	Keyword playerLocationKeyword = SLT.GetPlayerLocationKeyword()

	HandlePlayerContainerActivation(containerRef, container_is_corpse, container_is_empty, playerLocationKeyword, PlayerRef.IsInInterior())

	int handle = ModEvent.Create(EVENT_SLTR_ON_PLAYER_CONTAINER_ACTIVATE())
	ModEvent.PushForm(handle, containerRef)
	ModEvent.PushBool(handle, container_is_corpse)
	ModEvent.PushBool(handle, container_is_empty)
	ModEvent.PushForm(handle, playerLocationKeyword)
	ModEvent.PushBool(handle, PlayerRef.IsInInterior())
	ModEvent.Send(handle)
EndFunction

Function SLTR_Internal_PlayerActivatedContainer(ObjectReference containerRef, bool container_is_corpse, bool container_is_empty)
	if !containerRef
		SLTErrMsg("Core.SLTR_Internal_PlayerActivatedContainer: containerRef is null")
		return
	endif
	Send_SLTR_OnPlayerActivateContainer(containerRef, container_is_corpse, container_is_empty)
EndFunction

Function RefreshTheContainersWeKnowAndLove()
	TheContainersWeKnowAndLove.Revert()
	Container containerToAdd
	Int i = JsonUtil.StringListCount(FN_MoreContainersWeKnowAndLove(), "dt_additional")
	While i
		i -=1
		Form conForm = sl_triggers.GetForm(JsonUtil.StringListGet(FN_MoreContainersWeKnowAndLove(), "dt_additional", i))
		if conForm
			TheContainersWeKnowAndLove.AddForm(conForm)
		else
			SLTErrMsg("Core.RefreshTheContainersWeKnowAndLove: unable to load form for " + i)
		endif
	EndWhile

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
	if !self || !IsEnabled
		return
	endif

	UnregisterForModEvent(EVENT_SLT_ON_NEW_SESSION())
	if triggerKeys_newSession.Length > 0
		SafeRegisterForModEvent_Quest(self, EVENT_SLT_ON_NEW_SESSION(), "OnNewSession")
	endif

	UnregisterForModEvent(EVENT_TOP_OF_THE_HOUR)
	handlingTopOfTheHour = false
	if triggerKeys_topOfTheHour.Length > 0
		SafeRegisterForModEvent_Quest(self, EVENT_TOP_OF_THE_HOUR, EVENT_TOP_OF_THE_HOUR_HANDLER)
		AlignToNextHour()
		handlingTopOfTheHour = true
	endif
	
	if triggerKeys_keyDown.Length > 0
		RegisterForKeyEvents()
	endif

	SafeRegisterForModEvent_Quest(self, EVENT_SLTR_ON_PLAYER_CELL_CHANGE(), "OnSLTRPlayerCellChange")

	SafeRegisterForModEvent_Quest(self, EVENT_SLTR_ON_PLAYER_LOADING_SCREEN(), "OnSLTRPlayerLoadingScreen")

	if SLT.SLTRContainerPerk
		if PlayerRef && !PlayerRef.HasPerk(SLT.SLTRContainerPerk)
			;SLTDebugMsg("Core.RegisterEvents: during check for OnSLTRContainerActivate, adding missing perk to player")
			PlayerRef.AddPerk(SLT.SLTRContainerPerk)
		endif

		if PlayerRef.HasPerk(SLT.SLTRContainerPerk)
			;SLTDebugMsg("Core.RegisterEvents: registering OnSLTRContainerActivate")
			SafeRegisterForModEvent_Quest(self, EVENT_SLTR_ON_PLAYER_CONTAINER_ACTIVATE(), EVENT_SLTR_ON_PLAYER_CONTAINER_ACTIVATE())
		else
			SLTDebugMsg("Core.RegisterEvents: failed/1 to register OnSLTRContainerActivate: IsEnabled(" + IsEnabled + ") / SLT.SLTRContainerPerk(" + SLT.SLTRContainerPerk + ") / PlayerRef(" + PlayerRef + ") / PlayerRef.HasPerk(" + (SLT && SLT.SLTRContainerPerk && PlayerRef && PlayerRef.HasPerk(SLT.SLTRContainerPerk)) + ")")
		endif
	else
		SLTDebugMsg("Core.RegisterEvents: failed/2 to register OnSLTRContainerActivate: IsEnabled(" + IsEnabled + ") / SLT.SLTRContainerPerk(" + SLT.SLTRContainerPerk + ") / PlayerRef(" + PlayerRef + ") / PlayerRef.HasPerk(" + (SLT && SLT.SLTRContainerPerk && PlayerRef && PlayerRef.HasPerk(SLT.SLTRContainerPerk)) + ")")
	EndIf
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

Function HandleOnPlayerCellChange(bool isNewGameLaunch, bool isNewSession, Keyword playerLocationKeyword, bool playerWasInInterior)
	;SLTDebugMsg("Core.HandleOnPlayerCellChange: isNewGameLaunch(" + isNewGameLaunch + ") / isNewSession(" + isNewSession + ")")
	int i = 0
	int j

	int cmdRequestId
	int		requestTargetFormId = PlayerRef.GetFormID() ; conveniently so, in this case
	string triggerKey
	string _triggerFile
	string command
	int    ival
	bool   doRun
	float  chance
	while i < triggerKeys_playercellchange.Length
		triggerKey = triggerKeys_playercellchange[i]
		_triggerFile = FN_T(triggerKey)

		; could filter by isNewGameLaunch and/or isNewSession too
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
							doRun = playerWasInInterior
						elseif ival == 2
							doRun = !playerWasInInterior
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
				endIf
				
				if doRun
					int cmdThreadId

					command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
					if command
						cmdRequestId = GetNextPlayerCellChangeRequestId(requestTargetFormId, cmdRequestId, playerWasInInterior, playerLocationKeyword)
						cmdThreadId = SLT.GetNextInstanceId()
						RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
					endIf
					command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
					if command
						cmdRequestId = GetNextPlayerCellChangeRequestId(requestTargetFormId, cmdRequestId, playerWasInInterior, playerLocationKeyword)
						cmdThreadId = SLT.GetNextInstanceId()
						RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
					endIf
					command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
					if command
						cmdRequestId = GetNextPlayerCellChangeRequestId(requestTargetFormId, cmdRequestId, playerWasInInterior, playerLocationKeyword)
						cmdThreadId = SLT.GetNextInstanceId()
						RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
					endIf
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

int Function GetNextPlayerCellChangeRequestId(int requestTargetFormId, int cmdRequestId, bool playerWasInInterior, Keyword playerLocationKeyword)
	if !cmdRequestId
		cmdRequestId = SLT.GetNextInstanceId()

		sl_triggersCmd.PrecacheRequestVar(SLT, requestTargetFormId, cmdRequestId, "core.was_player.inside", playerWasInInterior)
		sl_triggersCmd.PrecacheRequestVar(SLT, requestTargetFormId, cmdRequestId, "core.was_player.outside", !playerWasInInterior)
		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.playerLocationKeyword", playerLocationKeyword)
	endif
	return cmdRequestId
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

Function HandlePlayerContainerActivation(ObjectReference containerRef, bool container_is_corpse, bool container_is_empty, Keyword playerLocationKeyword, bool playerWasInInterior)
	if !containerRef
		return
	endif

	int i = 0
	int j

	int cmdRequestId
	int		requestTargetFormId = PlayerRef.GetFormID() ; conveniently so, in this case
	bool   	doRun
	string 	triggerKey
	string 	_triggerFile
	string 	command

	int    	ival
	bool 	bval

	bool	isCommonalityDetermined = false
	bool 	container_is_common = false
	
	float chance

	while i < triggerKeys_container.Length
		triggerKey = triggerKeys_container[i]
		_triggerFile = FN_T(triggerKey)

		if !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE)

			if chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
				ival = 0

				doRun =	true

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_CONTAINER_EMPTY)
					if ival != 0
						doRun = (ival == 2)
					endif
				endif

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_CONTAINER_CORPSE)
					if ival != 0
						doRun = (ival == 2)
					endif
				endif

				; if needed: are we filtering for commons?
				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_COMMONCONTAINERMATCHING)
					if ival != 0 ; 0 is Any
						if !isCommonalityDetermined
							isCommonalityDetermined = true
							container_is_common = false
							j = 0
							while j < common_container_names.Length && !bval
								if common_container_names[j] == containerRef.GetDisplayName()
									container_is_common = true
								endif
								j += 1
							endwhile
						endif
						doRun = (container_is_common && ival == 1) || (!container_is_common && ival == 2)
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
							doRun = playerWasInInterior
						elseif ival == 2
							doRun = !playerWasInInterior
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
					int cmdThreadId

					command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
					if command
						cmdRequestId = GetNextPlayerContainerActivationRequestId(requestTargetFormId, cmdRequestId, containerRef, container_is_corpse, container_is_empty, container_is_common, playerWasInInterior, playerLocationKeyword)
						cmdThreadId = SLT.GetNextInstanceId()
						RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
					endIf
					command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
					if command
						cmdRequestId = GetNextPlayerContainerActivationRequestId(requestTargetFormId, cmdRequestId, containerRef, container_is_corpse, container_is_empty, container_is_common, playerWasInInterior, playerLocationKeyword)
						cmdThreadId = SLT.GetNextInstanceId()
						RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
					endIf
					command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
					if command
						cmdRequestId = GetNextPlayerContainerActivationRequestId(requestTargetFormId, cmdRequestId, containerRef, container_is_corpse, container_is_empty, container_is_common, playerWasInInterior, playerLocationKeyword)
						cmdThreadId = SLT.GetNextInstanceId()
						RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
					endIf
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

int Function GetNextPlayerContainerActivationRequestId(int requestTargetFormId, int cmdRequestId, Form containerRef, bool container_is_corpse, bool container_is_empty, bool container_is_common, bool playerWasInInterior, Keyword playerLocationKeyword)
	if !cmdRequestId
		cmdRequestId = SLT.GetNextInstanceId()

		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.activatedContainer", containerRef)
		sl_triggersCmd.PrecacheRequestVar(SLT, requestTargetFormId, cmdRequestId, "core.activatedContainer.is_corpse", container_is_corpse)
		sl_triggersCmd.PrecacheRequestVar(SLT, requestTargetFormId, cmdRequestId, "core.activatedContainer.is_empty", container_is_empty)
		sl_triggersCmd.PrecacheRequestVar(SLT, requestTargetFormId, cmdRequestId, "core.activatedContainer.is_common", container_is_common)

		sl_triggersCmd.PrecacheRequestVar(SLT, requestTargetFormId, cmdRequestId, "core.was_player.inside", playerWasInInterior)
		sl_triggersCmd.PrecacheRequestVar(SLT, requestTargetFormId, cmdRequestId, "core.was_player.outside", !playerWasInInterior)
		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.playerLocationKeyword", playerLocationKeyword)
	endif
	return cmdRequestId
EndFunction