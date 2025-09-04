;/
You can use this as a reference for building your own sl_triggers Extension.
Required and Optional overrides have been noted.
/;
scriptname sl_triggersExtensionCore extends sl_triggersExtension

import sl_triggersStatics

FormList Property				ContainerBlacklist Auto ; so many naming schemes to choose from

int		EVENT_ID_KEYMAPPING 					= 1
int		EVENT_ID_TOP_OF_THE_HOUR				= 2
int  	EVENT_ID_NEW_SESSION					= 3
int		EVENT_ID_PLAYER_CELL_CHANGE				= 4
int		EVENT_ID_CONTAINER						= 5
int		EVENT_ID_LOCATION_CHANGE				= 6
int		EVENT_ID_EQUIPMENT_CHANGE				= 7
int		EVENT_ID_PLAYER_COMBAT_STATUS			= 8
int		EVENT_ID_PLAYER_ON_HIT					= 9
int		EVENT_ID_TIMER							= 10
int		EVENT_ID_HARVESTED_PLANT				= 11
int		EVENT_ID_FAST_TRAVEL					= 12
int		EVENT_ID_VAMPIRISM						= 13
int		EVENT_ID_LYCANTHROPY					= 14
int 	EVENT_ID_VAMPIRE_FEEDING				= 15

string ATTR_MOD_VERSION						= "__slt_mod_version__"
string ATTR_EVENT							= "event"
string ATTR_KEYMAPPING						= "keymapping"
string ATTR_MODIFIERKEYMAPPING 				= "modifierkeymapping"
string ATTR_USEDAK							= "usedak"
string ATTR_DAYTIME							= "daytime"
string ATTR_LOCATION						= "location"
string ATTR_COMMONCONTAINERMATCHING			= "comconmat"
string ATTR_DEEPLOCATION					= "deeplocation"
string ATTR_DEEPLOCATION_LEAVING			= "deeplocation_leaving"
string ATTR_DEEPLOCATION_ENTERING			= "deeplocation_entering"
string ATTR_CONTAINER_CORPSE				= "container_corpse"
string ATTR_CONTAINER_EMPTY					= "container_empty"
string ATTR_CLEARED_LEAVING					= "cleared_leaving"
string ATTR_CLEARED_ENTERING				= "cleared_entering"
string ATTR_HAS_ENCHANTMENTS				= "has_enchantments"
string ATTR_ITEM_IS_UNIQUE					= "item_is_unique"
string ATTR_EQUIPPING						= "equipping"
string ATTR_IS_ARMED						= "is_armed"
string ATTR_IS_CLOTHED						= "is_clothed"
string ATTR_IS_WEAPON_DRAWN					= "is_weapon_drawn"
string ATTR_EQUIPPED_ITEM_TYPE				= "equipped_item_type"
string ATTR_ARMOR_SLOT						= "armor_slot"
string ATTR_CHANCE							= "chance"
string ATTR_COMBAT_STATE					= "combat_state"
string ATTR_PLAYER_ATTACKING				= "player_attacking"
string ATTR_WAS_POWER_ATTACK				= "was_power_attack"
string ATTR_WAS_SNEAK_ATTACK				= "was_sneak_attack"
string ATTR_WAS_BASH_ATTACK					= "was_bash_attack"
string ATTR_WAS_BLOCKED						= "was_blocked"
string ATTR_TIMER_DELAY						= "timer_delay"
string ATTR_VAMPIRISM						= "vampirism"
string ATTR_LYCANTHROPY						= "lycanthropy"
string ATTR_DO_1							= "do_1"
string ATTR_DO_2							= "do_2"
string ATTR_DO_3							= "do_3"
string ATTR_DO_4							= "do_4"

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
int[]		__checked_modifier_keys
; matching length boolean state array for fast lookup
;bool[]		_keycode_status
bool[]		_keystates

int[] Property CheckedModifierKeys Hidden
	int[] Function Get()
		return __checked_modifier_keys
	EndFunction
EndProperty

; onInit we will refresh these with what we find
; and edit them during MCM updates as needed
string[]	triggerKeys_topOfTheHour
string[]	triggerKeys_keyDown
string[]	triggerKeys_newSession
string[]	triggerKeys_playercellchange
string[]	triggerKeys_container
string[]	triggerKeys_location_change
string[]	triggerKeys_equipment_change
string[]	triggerKeys_player_combat_status
string[]	triggerKeys_player_on_hit
string[]	triggerKeys_timer
string[]	triggerKeys_harvesting
string[]	triggerKeys_fast_travel
string[] 	triggerKeys_vampirism
string[]	triggerKeys_lycanthropy
string[]	triggerKeys_vampire_feeding

float 		last_time_PlayerCellChangeEvent
string[]	common_container_names
float[]		timer_next_run_time
float[]		timer_delays
float 		_lastRealTimeTimerProcessed

bool Function IsMCMConfigurable()
	return true
EndFunction

Function QueueUpdateLoop(float afDelay = 1.0)
	if !self
		return
	endif
	RegisterForSingleUpdate(afDelay)
EndFunction

Event OnInit()
	if SLT.Debug_Extension || SLT.Debug_Extension_Core
		SLTDebugMsg("Core.OnInit")
	endif

	if !self
		SLTDebugMsg("Core.OnInit: I am not myself")
		return
	endif

	if SLT.Debug_Extension || SLT.Debug_Extension_Core
		SLTDebugMsg("Core.OnInit: Calling SLTInit()")
	endif
	SLTInit()

	UnregisterForUpdate()
	QueueUpdateLoop(0.01)
EndEvent

Function DoPlayerLoadGame()
	if SLT.Debug_Extension || SLT.Debug_Extension_Core
		SLTDebugMsg("Core.DoPlayerLoadGame: Calling SLTInit()")
	endif

	SLTInit()
	
	UnregisterForUpdate()
	QueueUpdateLoop(0.01)
EndFunction

Event OnUpdate()
	if SLT.Debug_Extension || SLT.Debug_Extension_Core
		SLTDebugMsg("Core.OnUpdate")
	endif
	QueueUpdateLoop(60)
	HandleTimers()
EndEvent

Function PopulatePerk()
	if SLT.Debug_Extension || SLT.Debug_Extension_Core
		SLTDebugMsg("Core.PopulatePerk")
	endif
	if !SLT.SLTRContainerPerk
		SLTErrMsg("Core.PopulatePerk: SLTRContainerPerk is not filled; Container activation tracking disabled; this is probably an error")
	else
		If !PlayerRef.HasPerk(SLT.SLTRContainerPerk)
			PlayerRef.AddPerk(SLT.SLTRContainerPerk)

			If !PlayerRef.HasPerk(SLT.SLTRContainerPerk)
				SLTErrMsg("Core.PopulatePerk: SLTRContainerPerk is not present on PlayerRef even after validation; Container activation tracking disabled; this is probably an error")
			Endif
		Endif
	Endif
EndFunction

Function SLTReady()
	if SLT.Debug_Extension || SLT.Debug_Extension_Core
		SLTDebugMsg("Core.SLTReady")
	endif

	PopulatePerk()
	
	_keystates = PapyrusUtil.BoolArray(256, false)

	ClearKeystates()
	UpdateDAKStatus()
	RefreshData()
EndFunction

Function ClearKeystates()
	if SLT.Debug_Extension_Core
		SLTDebugMsg("Core.ClearKeystates")
	endif
	int i = 0
	while i < _keystates.Length
		_keystates[i] = false
		i += 1
	endwhile
EndFunction

Function RefreshData()
	if SLT.Debug_Extension || SLT.Debug_Extension_Core
		SLTDebugMsg("Core.RefreshData")
	endif
	RefreshContainerBlacklist()
	RegisterEvents()
EndFunction

bool Function CustomResolveScoped(sl_triggersCmd CmdPrimary, string scope, string token)
	if scope == "core"
		if token == "toh_elapsed"
			CmdPrimary.CustomResolveFloatResult = TohElapsedTime
			return true
		endif
	elseif scope == "system"
		if token == "is_available.core"
			CmdPrimary.CustomResolveBoolResult = IsEnabled
			return true
		elseif token == "toh_elapsed"
			CmdPrimary.CustomResolveFloatResult = TohElapsedTime
			return true
		endif
	elseif scope == "request"
		if token == "core.activatedContainer"
			CmdPrimary.CustomResolveFormResult = CmdPrimary.GetRequestForm(token)
			return true
		elseif token == "core.activatedContainer.is_corpse"
			CmdPrimary.CustomResolveBoolResult = CmdPrimary.GetRequestBool(token)
			return true
		elseif token == "core.activatedContainer.is_empty"
			CmdPrimary.CustomResolveBoolResult = CmdPrimary.GetRequestBool(token)
			return true
		elseif token == "core.activatedContainer.is_common"
			CmdPrimary.CustomResolveBoolResult = CmdPrimary.GetRequestBool(token)
			return true
		elseif token == "core.activatedContainer.count"
			ObjectReference _acon = CmdPrimary.GetRequestForm("activatedContainer") as ObjectReference
			if !_acon
				CmdPrimary.SFE("Core.CustomResolveScoped: requested activatedContainer.count but no ObjectReference available")
			endif
			CmdPrimary.CustomResolveIntResult = _acon.GetNumItems()
			return true
		elseif token == "core.was_player.inside"
			CmdPrimary.CustomResolveBoolResult = CmdPrimary.GetRequestBool(token)
			return true
		elseif token == "core.was_player.outside"
			CmdPrimary.CustomResolveBoolResult = CmdPrimary.GetRequestBool(token)
			return true
		elseif token == "core.was_player.in_safe_area"
			Keyword _pkwd = CmdPrimary.GetRequestForm("core.playerLocationKeyword") as Keyword
			if _pkwd
				CmdPrimary.CustomResolveBoolResult = SLT.IsLocationKeywordSafe(_pkwd)
			endif
			return true
		elseif token == "core.was_player.in_city"
			Keyword _pkwd = CmdPrimary.GetRequestForm("core.playerLocationKeyword") as Keyword
			if _pkwd
				CmdPrimary.CustomResolveBoolResult = SLT.IsLocationKeywordCity(_pkwd)
			endif
			return true
		elseif token == "core.was_player.in_wilderness"
			Keyword _pkwd = CmdPrimary.GetRequestForm("core.playerLocationKeyword") as Keyword
			if _pkwd
				CmdPrimary.CustomResolveBoolResult = SLT.IsLocationKeywordWilderness(_pkwd)
			endif
			return true
		elseif token == "core.was_player.in_dungeon"
			Keyword _pkwd = CmdPrimary.GetRequestForm("core.playerLocationKeyword") as Keyword
			if _pkwd
				CmdPrimary.CustomResolveBoolResult = SLT.IsLocationKeywordDungeon(_pkwd)
			endif
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
		float currentTime = SLT.GetTheGameTime()
		
		If currentTime >= nextTopOfTheHour
			tohElapsedTime = currentTime - lastTopOfTheHour
			lastTopOfTheHour = currentTime
			
			If (SLT.Debug_Extension_Core_TopOfTheHour)
				SLTDebugMsg("Core.OnUpdateGameTime: sending mod event EVENT_TOP_OF_THE_HOUR; currentTime(" + currentTime + ") NextTopOfTheHour(" + NextTopOfTheHour + ")")
			EndIf
			
			SendModEvent("TopOfTheHour", "", tohElapsedTime)
			AlignToNextHour(currentTime)
		else
			float deltaWait = (NextTopOfTheHour - currentTime) * 24.0 * 1.04
			If (SLT.Debug_Extension_Core_TopOfTheHour)
				SLTDebugMsg("Core.OnUpdateGameTime: gametime update ran too early, waiting extra deltaTime(" + deltaWait + ")  should be much less than 1.0; // currentTime(" + currentTime + ") NextTopOfTheHour(" + NextTopOfTheHour + ")")
			EndIf
			RegisterForSingleUpdateGameTime(deltaWait)
		EndIf
	EndIf
EndEvent

Event OnSLTNewSession(int _newSessionId)
	If (SLT.Debug_Extension_Core)
		SLTDebugMsg("Core.OnSLTNewSession: _newSessionId:" + _newSessionId)
	EndIf

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
EndEvent

Event OnKeyUp(int KeyCode, float holdTime)
	if !self
		Return
	endif

	_keystates[KeyCode] = false

	If (SLT.Debug_Extension_Core_Keymapping)
		SLTDebugMsg("Core.OnKeyUp: key(" + KeyCode + ")")
	EndIf
EndEvent

Event OnKeyDown(Int KeyCode)
	if !self
		Return
	endif

	_keystates[KeyCode] = true

	If (SLT.Debug_Extension_Core_Keymapping)
		SLTDebugMsg("Core.OnKeyDown: key(" + KeyCode + ")")
	EndIf
	
	If IsEnabled
		HandleOnKeyDown(KeyCode)
	ElseIf SLT.Debug_Extension_Core_Keymapping
		SLTWarnMsg("Core.OnKeyDown: Not enabled yet, exiting OnKeyDown early")
	Endif
EndEvent

Event OnSLTRPlayerEquipEvent(Form baseForm, ObjectReference objRef, bool is_equipping)
	if SLT.Debug_Extension_Core
		SLTDebugMsg("Core.OnSLTRPlayerEquipEvent")
	endif
	HandleEquipmentChange(baseForm, objRef, is_equipping)
EndEvent

Event OnSLTRPlayerCombatStateChanged(Actor target, bool player_in_combat)
	HandlePlayerCombatStateChanged(target, player_in_combat)
EndEvent

Event OnSLTRPlayerHit(Form kattacker, Form ktarget, int ksourceFormID, int kprojectileFormID, bool was_player_attacker, bool kPowerAttack, bool kSneakAttack, bool kBashAttack, bool kHitBlocked)
	HandlePlayerOnHit(kattacker, ktarget, ksourceFormID, kprojectileFormID, was_player_attacker, kPowerAttack, kSneakAttack, kBashAttack, kHitBlocked)
EndEvent

Event OnSLTRHarvesting(ObjectReference harvestSource)
	Flora targetFlora = harvestSource.GetBaseObject() as Flora
	if targetFlora
		Form ingr = targetFlora.GetIngredient()
		if ingr
			HandleHarvesting(harvestSource)
		endif
	else
		TreeObject targetTree = harvestSource.GetBaseObject() as TreeObject
		if targetTree
			Form ingr = targetTree.GetIngredient()
			if ingr
				HandleHarvesting(harvestSource)
			endif
		else
			Activator acti = harvestSource.GetBaseObject() as Activator
			if acti
				HandleHarvesting(harvestSource)
			endif
		endif
	endif
EndEvent

int cellPreviousSessionId
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
			If (SLT.Debug_Extension_Core)
				SLTDebugMsg("Core.Send_SLTR_OnPlayerCellChange: ignoring flutter; note that this is bookkeeping, might not have triggers to run")
			EndIf
			return
		endif
	; i.e. new launch of the .exe; not reversing time (is there an API for that?)
	else
		;SLTDebugMsg("Core.Send_SLTR_OnPlayerCellChange: new launch detected")
		isNewGameLaunch = true
	endif
	last_time_PlayerCellChangeEvent = nowtime


	int nowSessionId = sl_triggers.GetSessionId()
	bool isNewSession = nowSessionId != cellPreviousSessionId
	if isNewSession
		cellPreviousSessionId = nowSessionId
	endif

	if triggerKeys_playercellchange.Length > 0
		; should
		; optional send actual mod event, otherwise at least pass it off to our handlers
		Keyword playerLocationKeyword = SLT.GetPlayerLocationKeyword()

		HandleOnPlayerCellChange(isNewGameLaunch, isNewSession, playerLocationKeyword, PlayerRef.IsInInterior())
	endif

	isNewGameLaunch = false
EndFunction

Function SLTR_Internal_PlayerCellChange()
	if triggerKeys_playercellchange.Length > 0
		Send_SLTR_OnPlayerCellChange()
	endif
EndFunction

Function Send_SLTR_OnPlayerActivateContainer(ObjectReference containerRef, bool container_is_corpse, bool container_is_empty)
	if triggerKeys_container.Length > 0
		;SLTDebugMsg("Core.Send_SLTR_OnPlayerActivateContainer containerRef(" + containerRef + ") corpse(" + container_is_corpse + ") empty(" + container_is_empty + ")")
		Keyword playerLocationKeyword = SLT.GetPlayerLocationKeyword()

		HandlePlayerContainerActivation(containerRef, container_is_corpse, container_is_empty, playerLocationKeyword, PlayerRef.IsInInterior())
	endif
EndFunction

Function SLTR_Internal_PlayerActivatedContainer(ObjectReference containerRef, bool container_is_corpse, bool container_is_empty)
	if !containerRef
		SLTErrMsg("Core.SLTR_Internal_PlayerActivatedContainer: containerRef is null")
		return
	endif
	if triggerKeys_container.Length > 0
		Send_SLTR_OnPlayerActivateContainer(containerRef, container_is_corpse, container_is_empty)
	endif
EndFunction

Function RefreshContainerBlacklist()
	if SLT.Debug_Cmd
		SLTDebugMsg("Core.RefreshContainerBlacklist: starting")
	endif

	ContainerBlacklist.Revert()
	Container containerToAdd
	Int i = JsonUtil.StringListCount(FN_ContainerBlacklistJSON(), "dt_blacklist")
	string conFormStr
	string[] conFormStrParts
	Form conForm

	While i
		i -=1
		conFormStr = JsonUtil.StringListGet(FN_ContainerBlacklistJSON(), "dt_blacklist", i)
		conFormStrParts = PapyrusUtil.StringSplit(conFormStr, ":")
		if conFormStrParts.Length == 2
			int modindex = Game.GetModByName(conFormStrParts[0])
			if 255 == modindex
				; not present
				SLTWarnMsg("Core.RefreshContainerBlacklist: mod unavailable(" + conFormStrParts[0] + "); skipping entry '" + conFormStr + "'")
				conForm = none
			else
				conForm = sl_triggers.GetForm(conFormStr)
			endif
		else
			conFormStrParts = PapyrusUtil.StringSplit(conFormStr, "|")
			if conFormStrParts.Length == 2
				int modindex = Game.GetModByName(conFormStrParts[1])
				if 255 == modindex
					; not present
					SLTWarnMsg("Core.RefreshContainerBlacklist: mod unavailable(" + conFormStrParts[1] + "); skipping entry '" + conFormStr + "'")
					conForm = none
				else
					conForm = sl_triggers.GetForm(conFormStr)
				endif
			else
				conForm = sl_triggers.GetForm(conFormStr)
			endif
		endif

		if conForm
			ContainerBlacklist.AddForm(conForm)
		else
			SLTWarnMsg("Core.RefreshContainerBlacklist: unable to load form for " + i)
		endif
	EndWhile

	common_container_names = JsonUtil.StringListToArray(FN_ContainerBlacklistJSON(), "dt_common")
	
	if SLT.Debug_Cmd
		SLTDebugMsg("Core.RefreshContainerBlacklist: completed")
	endif
EndFunction

Function RefreshTriggerCache()
	triggerKeys_topOfTheHour			= PapyrusUtil.StringArray(0)
	triggerKeys_keyDown					= PapyrusUtil.StringArray(0)
	triggerKeys_newSession				= PapyrusUtil.StringArray(0)
	triggerKeys_playercellchange		= PapyrusUtil.StringArray(0)
	triggerKeys_container				= PapyrusUtil.StringArray(0)
	triggerKeys_location_change			= PapyrusUtil.StringArray(0)
	triggerKeys_equipment_change		= PapyrusUtil.StringArray(0)
	triggerKeys_player_combat_status	= PapyrusUtil.StringArray(0)
	triggerKeys_player_on_hit			= PapyrusUtil.StringArray(0)
	triggerKeys_harvesting				= PapyrusUtil.StringArray(0)
	triggerKeys_fast_travel				= PapyrusUtil.StringArray(0)
	triggerKeys_vampirism				= PapyrusUtil.StringArray(0)
	triggerKeys_lycanthropy				= PapyrusUtil.StringArray(0)
	triggerKeys_vampire_feeding			= PapyrusUtil.StringArray(0)

	; paired - and handled differently /
	;/
	; we want timers that don't change between trigger refreshes to retain any 
	; existing timer progress.
	; "not changing" - for a given triggerKey, the timer_delay is unchanged
	/;
	int i
	int timerKeyLength = triggerKeys_timer.Length

	; if these are empty, it gives us initialized empty lists
	; if not, it doesn't change anything
	triggerKeys_timer					= PapyrusUtil.ResizeStringArray(triggerKeys_timer, timerKeyLength)
	timer_next_run_time					= PapyrusUtil.ResizeFloatArray(timer_next_run_time, timerKeyLength)
	timer_delays						= PapyrusUtil.ResizeFloatArray(timer_delays, timerKeyLength)

	;triggerKeys_timer					= PapyrusUtil.StringArray(0)
	;timer_next_run_time				= PapyrusUtil.FloatArray(0)
	;timer_delays						= PapyrusUtil.FloatArray(0)
	; / paired


	float nowtime = Utility.GetCurrentRealTime()

	i = 0	
	while i < TriggerKeys.Length
		string _triggerFile = FN_T(TriggerKeys[i])

		if !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
			int eventCode = JsonUtil.GetIntValue(_triggerFile, ATTR_EVENT)
	
			if eventCode == EVENT_ID_TOP_OF_THE_HOUR
				triggerKeys_topOfTheHour = 			PapyrusUtil.PushString(triggerKeys_topOfTheHour, TriggerKeys[i])
			elseif eventCode == EVENT_ID_KEYMAPPING
				triggerKeys_keyDown = 				PapyrusUtil.PushString(triggerKeys_keyDown, TriggerKeys[i])
			elseif eventCode == EVENT_ID_NEW_SESSION
				triggerKeys_newSession = 			PapyrusUtil.PushString(triggerKeys_newSession, TriggerKeys[i])
			elseif eventCode == EVENT_ID_PLAYER_CELL_CHANGE
				triggerKeys_playercellchange = 		PapyrusUtil.PushString(triggerKeys_playercellchange, TriggerKeys[i])
			elseif eventCode == EVENT_ID_CONTAINER
				triggerKeys_container = 			PapyrusUtil.PushString(triggerKeys_container, TriggerKeys[i])
			elseif eventCode == EVENT_ID_LOCATION_CHANGE
				triggerKeys_location_change = 		PapyrusUtil.PushString(triggerKeys_location_change, TriggerKeys[i])
			elseif eventCode == EVENT_ID_EQUIPMENT_CHANGE
				triggerKeys_equipment_change = 		PapyrusUtil.PushString(triggerKeys_equipment_change, TriggerKeys[i])
			elseif eventCode == EVENT_ID_PLAYER_COMBAT_STATUS
				triggerKeys_player_combat_status = 	PapyrusUtil.PushString(triggerKeys_player_combat_status, TriggerKeys[i])
			elseif eventCode == EVENT_ID_PLAYER_ON_HIT
				triggerKeys_player_on_hit = 		PapyrusUtil.PushString(triggerKeys_player_on_hit, TriggerKeys[i])
			elseif eventCode == EVENT_ID_HARVESTED_PLANT
				triggerKeys_harvesting = 			PapyrusUtil.PushString(triggerKeys_harvesting, TriggerKeys[i])
			elseif eventCode == EVENT_ID_FAST_TRAVEL
				triggerKeys_fast_travel = 			PapyrusUtil.PushString(triggerKeys_fast_travel, TriggerKeys[i])
			elseif eventCode == EVENT_ID_VAMPIRISM
				triggerKeys_vampirism = 			PapyrusUtil.PushString(triggerKeys_vampirism, TriggerKeys[i])
			elseif eventCode == EVENT_ID_LYCANTHROPY
				triggerKeys_lycanthropy =			PapyrusUtil.PushString(triggerKeys_lycanthropy, TriggerKeys[i])
			elseif eventCode == EVENT_ID_VAMPIRE_FEEDING
				triggerKeys_vampire_feeding =		PapyrusUtil.PushString(triggerKeys_vampire_feeding, TriggerKeys[i])
			elseif eventCode == EVENT_ID_TIMER
				string triggerKey = TriggerKeys[i]
				float timerDelay = JsonUtil.GetFloatValue(_triggerFile, ATTR_TIMER_DELAY)
				
				int tkeyidx = triggerKeys_timer.Find(triggerKey)
				If (tkeyidx > -1)
					; found
					if timerDelay == timer_delays[tkeyidx]
						; update timer_next_run_time to reflect the new reality
						timer_next_run_time[tkeyidx] = (timer_next_run_time[tkeyidx] - _lastRealTimeTimerProcessed) + nowtime
						If (SLT.Debug_Extension_Core_Timer)
							SLTDebugMsg("Core.RefreshTriggerCache: Timer: refreshing timer_next_run_time, no timerDelay change detected;  trigger(" + triggerKey + ") delay(" + timer_delays[tkeyidx] + ") nextruntime(" + timer_next_run_time[tkeyidx] + ") currentime(" + nowtime + ")")
						EndIf
					else
						if timerDelay > 0
							; new timerDelay, no mercy
							timer_delays[tkeyidx] = timerDelay * 60
							timer_next_run_time[tkeyidx] = nowtime + (timerDelay * 60)
							If (SLT.Debug_Extension_Core_Timer)
								SLTDebugMsg("Core.RefreshTriggerCache: Timer: updating with new timerDelay;  trigger(" + triggerKey + ") delay(" + timer_delays[tkeyidx] + ") nextruntime(" + timer_next_run_time[tkeyidx] + ") currentime(" + nowtime + ")")
							EndIf
						else
							; timerDelay is now zero, remove it
							string sukey = DOMAIN_EXTENSION() + "Core:TMP_STRING[]"
							StorageUtil.StringListCopy(self, sukey, triggerKeys_timer)
							StorageUtil.StringListPluck(self, sukey, tkeyidx, "")
							triggerKeys_timer = StorageUtil.StringListToArray(self, sukey)
							StorageUtil.StringListClear(self, sukey)
							sukey = DOMAIN_EXTENSION() + "Core:TMP_FLOAT[]"
							StorageUtil.FloatListCopy(self, sukey, timer_delays)
							StorageUtil.FloatListPluck(self, sukey, tkeyidx, 0.0)
							timer_delays = StorageUtil.FloatListToArray(self, sukey)
							StorageUtil.FloatListClear(self, sukey)
							StorageUtil.FloatListCopy(self, sukey, timer_next_run_time)
							StorageUtil.FloatListPluck(self, sukey, tkeyidx, 0.0)
							timer_next_run_time = StorageUtil.FloatListToArray(self, sukey)
							StorageUtil.FloatListClear(self, sukey)

							If (SLT.Debug_Extension_Core_Timer)
								SLTDebugMsg("Core.RefreshTriggerCache: Timer: removing due to now having timerDelay 0;  trigger(" + triggerKey + ") delay(" + timer_delays[tkeyidx] + ") nextruntime(" + timer_next_run_time[tkeyidx] + ") currentime(" + nowtime + ")")
							EndIf
						endif
					endif
				else
					If (timerDelay > 0)
						; new
						triggerKeys_timer = PapyrusUtil.PushString(triggerKeys_timer, triggerKey)
						timer_delays = PapyrusUtil.PushFloat(timer_delays, timerDelay * 60)
						timer_next_run_time = PapyrusUtil.PushFloat(timer_next_run_time, nowtime + (timerDelay * 60))
						If (SLT.Debug_Extension_Core_Timer)
							SLTDebugMsg("Core.RefreshTriggerCache: Timer: adding;  trigger(" + triggerKey + ") delay(" + timer_delays[tkeyidx] + ") nextruntime(" + timer_next_run_time[tkeyidx] + ") currentime(" + nowtime + ")")
						EndIf
					else
						If (SLT.Debug_Extension_Core_Timer)
							SLTDebugMsg("Core.RefreshTriggerCache: Timer: not adding due to now having timerDelay 0;  trigger(" + triggerKey + ") delay(" + timer_delays[tkeyidx] + ") nextruntime(" + timer_next_run_time[tkeyidx] + ") currentime(" + nowtime + ")")
						EndIf
					EndIf
				EndIf
			endif
		endif

		i += 1
	endwhile

	_keycodes_of_interest = PapyrusUtil.IntArray(0)
	if triggerKeys_keyDown.Length > 0
		If (!__checked_modifier_keys.Length)
			__checked_modifier_keys = new int[6]
			__checked_modifier_keys[0] = 29
			__checked_modifier_keys[1] = 157
			__checked_modifier_keys[2] = 56
			__checked_modifier_keys[3] = 184
			__checked_modifier_keys[4] = 42
			__checked_modifier_keys[5] = 54
		EndIf

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
		_keycodes_of_interest = PapyrusUtil.MergeIntArray(_keycodes_of_interest, CheckedModifierKeys, true)
	endif
	if SLT.Debug_Extension_Core_Keymapping
		SLTDebugMsg("Core.RefreshTriggerCache: triggerKeys_keyDown.Length(" + triggerKeys_keyDown.Length + ")  _keycodes_of_interest.Length(" + _keycodes_of_interest.Length + ")")
	endif
EndFunction

; this function attempts to trigger a SingleUpdateGameTime just in time for the 
; next game-time top of the hour
; the 1.04 multiplier is to intentionally overshoot a tiny bit to ensure our trigger works
Function AlignToNextHour(float _curTime)
	if triggerKeys_topOfTheHour.Length <= 0
		return
	endif

	If (SLT.Debug_Extension_Core_TopOfTheHour)
		SLTDebugMsg("Core.AlignToNextHour: _curTime(" + _curTime + ")")
	EndIf
	
	; days
    float currentTime = _curTime
	; days
	float daysPassed = Math.Floor(currentTime) as float
	; hours
	float currentHours = (currentTime - daysPassed) * 24.0
	float hoursPassed = Math.Floor(currentHours) as float
	float hoursNeeded = 1.0 - (currentHours - (Math.Floor(currentHours) as float))
	
	NextTopOfTheHour = currentTime + (hoursNeeded / 24.0)

	If (SLT.Debug_Extension_Core_TopOfTheHour)
		float _waitTime = hoursNeeded
		SLTDebugMsg("Core.AlignToNextHour: RegisterForSingleUpdateGameTime(" + _waitTime + ") should typically be around 1.0")
	EndIf

    RegisterForSingleUpdateGameTime(hoursNeeded * 1.04)
EndFunction

Function UpdateDAKStatus()
	dakavailable = false
	DAKStatus = GetForm_DAK_Status() as GlobalVariable
	DAKHotKey = GetForm_DAK_HotKey() as GlobalVariable
	
	if DAKStatus
		dakavailable = true
	endif
EndFunction

Function HandleVersionUpdate(int oldVersion, int newVersion)
	If (SLT.Debug_Extension || SLT.Debug_Setup || SLT.Debug_Extension_Core)
		SLTDebugMsg("Core.HandleVersionUpdate: oldVersion(" + SLTRVersion + ") newVersion(" + newVersion + ")")
	EndIf
EndFunction

; selectively enables only events with triggers
Function RegisterEvents()
	if !self || !IsEnabled
		return
	endif
	If (SLT.Debug_Extension_Core)
		SLTDebugMsg("Core.RegisterEvents")
	EndIf

	UnregisterForModEvent(EVENT_SLT_ON_NEW_SESSION())
	if triggerKeys_newSession.Length > 0
		SafeRegisterForModEvent_Quest(self, EVENT_SLT_ON_NEW_SESSION(), "OnSLTNewSession")
	endif

	UnregisterForModEvent("TopOfTheHour")
	handlingTopOfTheHour = false
	if triggerKeys_topOfTheHour.Length > 0
		SafeRegisterForModEvent_Quest(self, "TopOfTheHour", "OnTopOfTheHour")
		AlignToNextHour(SLT.GetTheGameTime())
		handlingTopOfTheHour = true
	endif
	
	UnregisterForAllKeys()
	if triggerKeys_keyDown.Length > 0
		RegisterForKeyEvents()
	endif

	;SafeRegisterForModEvent_Quest(self, EVENT_SLTR_ON_PLAYER_CELL_CHANGE(), "OnSLTRPlayerCellChange")

	;SafeRegisterForModEvent_Quest(self, EVENT_SLTR_ON_PLAYER_LOADING_SCREEN(), "OnSLTRPlayerLoadingScreen")

	if SLT.SLTRContainerPerk
		if PlayerRef && !PlayerRef.HasPerk(SLT.SLTRContainerPerk)
			If (SLT.Debug_Extension_Core)
				SLTDebugMsg("Core.RegisterEvents: during check for OnSLTRContainerActivate, adding missing perk to player")
			EndIf
			PlayerRef.AddPerk(SLT.SLTRContainerPerk)
		endif

		if PlayerRef.HasPerk(SLT.SLTRContainerPerk)
			;SLTDebugMsg("Core.RegisterEvents: registering OnSLTRContainerActivate")
			;SafeRegisterForModEvent_Quest(self, EVENT_SLTR_ON_PLAYER_CONTAINER_ACTIVATE(), EVENT_SLTR_ON_PLAYER_CONTAINER_ACTIVATE())
		else
			SLTDebugMsg("Core.RegisterEvents: failed/1 to register OnSLTRContainerActivate: IsEnabled(" + IsEnabled + ") / SLT.SLTRContainerPerk(" + SLT.SLTRContainerPerk + ") / PlayerRef(" + PlayerRef + ") / PlayerRef.HasPerk(" + (SLT && SLT.SLTRContainerPerk && PlayerRef && PlayerRef.HasPerk(SLT.SLTRContainerPerk)) + ")")
		endif
	else
		SLTDebugMsg("Core.RegisterEvents: failed/2 to register OnSLTRContainerActivate: IsEnabled(" + IsEnabled + ") / SLT.SLTRContainerPerk(" + SLT.SLTRContainerPerk + ") / PlayerRef(" + PlayerRef + ") / PlayerRef.HasPerk(" + (SLT && SLT.SLTRContainerPerk && PlayerRef && PlayerRef.HasPerk(SLT.SLTRContainerPerk)) + ")")
	EndIf

	UnregisterForModEvent(EVENT_SLTR_ON_PLAYER_EQUIP())
	if triggerKeys_equipment_change.Length > 0
		SafeRegisterForModEvent_Quest(self, EVENT_SLTR_ON_PLAYER_EQUIP(), EVENT_SLTR_ON_PLAYER_EQUIP())
		sl_triggers_internal.SetEquipSinkEnabled(true)
	else
		sl_triggers_internal.SetEquipSinkEnabled(false)
	endif

	UnregisterForModEvent(EVENT_SLTR_ON_PLAYER_COMBAT_STATE_CHANGED())
	if triggerKeys_player_combat_status.Length > 0
		SafeRegisterForModEvent_Quest(self, EVENT_SLTR_ON_PLAYER_COMBAT_STATE_CHANGED(), EVENT_SLTR_ON_PLAYER_COMBAT_STATE_CHANGED())
		sl_triggers_internal.SetCombatSinkEnabled(true)
	else
		sl_triggers_internal.SetCombatSinkEnabled(false)
	endif

	UnregisterForModEvent(EVENT_SLTR_ON_PLAYER_HIT())
	if triggerKeys_player_on_hit.Length > 0
		SafeRegisterForModEvent_Quest(self, EVENT_SLTR_ON_PLAYER_HIT(), EVENT_SLTR_ON_PLAYER_HIT())
		sl_triggers_internal.SetHitSinkEnabled(true)
	else
		sl_triggers_internal.SetHitSinkEnabled(false)
	endif

	bool enableActivateSink = false
	UnregisterForModEvent(EVENT_SLTR_ON_HARVESTING())
	if triggerKeys_harvesting.Length > 0
		SafeRegisterForModEvent_Quest(self, EVENT_SLTR_ON_HARVESTING(), EVENT_SLTR_ON_HARVESTING())
		enableActivateSink = true
	endif

	sl_triggers_internal.SetActivateSinkEnabled(enableActivateSink)
EndFunction

Function RegisterForKeyEvents()
	if SLT.Debug_Extension_Core_Keymapping
		SLTDebugMsg("Core.RegisterForKeyEvents: Unregistering for all keys")
	endif
	UnregisterForAllKeys()
	int i = 0
	while i < _keycodes_of_interest.Length
		RegisterForKey(_keycodes_of_interest[i])
		if SLT.Debug_Extension_Core_Keymapping
			SLTDebugMsg("Core.RegisterForKeyEvents: Registering for key:" + _keycodes_of_interest[i] + ":")
		endif
		i += 1
	endwhile
	if SLT.Debug_Extension_Core_Keymapping
		SLTDebugMsg("Core.RegisterForKeyEvents: Done")
		if _keycodes_of_interest.Length < 1
			SLTDebugMsg("Core.RegisterForKeyEvents: No keycodes registered, shouldn't be catching anything")
		endif
	endif
EndFunction

Function HandleTimers()
	int i = 0
	string triggerKey
	string _triggerFile
	string command
	bool   	doRun
	int ival
	float chance

	float nowtime = Utility.GetCurrentRealTime()
	_lastRealTimeTimerProcessed = nowtime
	If (SLT.Debug_Extension_Core_Timer || SLT.Debug_Extension_Core)
		SLTDebugMsg("Core.HandleTimers: starting at nowtime(" + nowtime + ")")
	EndIf

	doRun = triggerKeys_timer.Length > 0
	If (!doRun)
		If (SLT.Debug_Extension_Core_Timer)
			SLTDebugMsg("Core.HandleTimers: exiting, no timers set")
		EndIf
		return
	EndIf

	bool playerWasInInterior = PlayerRef.IsInInterior()
	Keyword playerLocationKeyword = SLT.GetPlayerLocationKeyword()

	while i < triggerKeys_timer.Length
		if nowtime > timer_next_run_time[i]
			; update values
			timer_next_run_time[i] = nowtime + timer_delays[i]

			; process it
			triggerKey = triggerKeys_timer[i]
			_triggerFile = FN_T(triggerKey)

			If (SLT.Debug_Extension_Core_Timer)
				SLTDebugMsg("Core.HandleTimers: running trigger (" + _triggerFile + ")")
			EndIf

			doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

			If (doRun)
				chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)

				doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
				
				If (SLT.Debug_Extension_Core_Timer)
					SLTDebugMsg("Core.HandleTimers: doRun(" + doRun + ") from ATTR_CHANCE")
				EndIf
			EndIf

			if doRun
				ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_ARMED)
				if ival != 0
					if ival == 1
						doRun = PlayerRef.GetEquippedItemType(0) != 0 || PlayerRef.GetEquippedItemType(1) != 0
					elseif ival == 2
						doRun = PlayerRef.GetEquippedItemType(0) == 0 && PlayerRef.GetEquippedItemType(1) == 0
					elseif ival == 3
						doRun = PlayerRef.GetEquippedItemType(1) == 0
					endif
				endif
				
				If (SLT.Debug_Extension_Core_Timer)
					SLTDebugMsg("Core.HandleTimers: doRun(" + doRun + ") from ATTR_IS_ARMED")
				EndIf
			endif

			if doRun
				ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_CLOTHED)
				if ival != 0
					if ival == 1
						doRun = PlayerRef.GetEquippedArmorInSlot(32) != none
					elseif ival == 2
						doRun = PlayerRef.GetEquippedArmorInSlot(32) == none
					elseif ival == 3
						Armor bodyItem = PlayerRef.GetEquippedArmorInSlot(32)
						doRun = (bodyItem == none) || bodyItem.HasKeywordString("zad_Lockable")
					endif
				endif
				
				If (SLT.Debug_Extension_Core_Timer)
					SLTDebugMsg("Core.HandleTimers: doRun(" + doRun + ") from ATTR_IS_CLOTHED")
				EndIf
			endif

			if doRun
				ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_WEAPON_DRAWN)
				if ival != 0
					if ival == 1
						doRun = PlayerRef.IsWeaponDrawn()
					elseif ival == 2
						doRun = !PlayerRef.IsWeaponDrawn()
					endif
				endif
				
				If (SLT.Debug_Extension_Core_Timer)
					SLTDebugMsg("Core.HandleTimers: doRun(" + doRun + ") from ATTR_IS_WEAPON_DRAWN")
				EndIf
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
						doRun = playerLocationKeyword == SLT.LocationKeywords[ival - 7]
					endif
				endif
				
				If (SLT.Debug_Extension_Core_Timer)
					SLTDebugMsg("Core.HandleTimers: doRun(" + doRun + ") from ATTR_DEEPLOCATION")
				EndIf
			endIf
				
			if doRun ;do doRun
				If (SLT.Debug_Extension_Core_Timer)
					SLTDebugMsg("Core.HandleTimers: doRun(" + doRun + ") running SLTScript/1()")
				EndIf
				command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
				string _instanceId
				if command
					If (SLT.Debug_Extension_Core_Timer)
						SLTDebugMsg("Core.HandleTimers: doRun(" + doRun + ") running SLTScript/1(" + command + ")")
					EndIf
					RequestCommand(PlayerRef, command)
				endIf
				command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
				if command
					If (SLT.Debug_Extension_Core_Timer)
						SLTDebugMsg("Core.HandleTimers: doRun(" + doRun + ") running SLTScript/2(" + command + ")")
					EndIf
					RequestCommand(PlayerRef, command)
				endIf
				command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
				if command
					If (SLT.Debug_Extension_Core_Timer)
						SLTDebugMsg("Core.HandleTimers: doRun(" + doRun + ") running SLTScript/3(" + command + ")")
					EndIf
					RequestCommand(PlayerRef, command)
				endIf
				command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
				if command
					If (SLT.Debug_Extension_Core_Timer)
						SLTDebugMsg("Core.HandleTimers: doRun(" + doRun + ") running SLTScript/4(" + command + ")")
					EndIf
					RequestCommand(PlayerRef, command)
				endIf
			endIf
		endif

		i += 1
	endwhile

	If (SLT.Debug_Extension_Core_Timer)
		SLTDebugMsg("Core.HandleTimers: exiting")
	EndIf
EndFunction

Function HandleNewSession(int _newSessionId)
	If (SLT.Debug_Extension_Core)
		SLTDebugMsg("Core.HandleNewSession: _newSessionId:" + _newSessionId)
	EndIf
	int i = 0
	string triggerKey
	string _triggerFile
	string command
	bool   	doRun
	int ival
	float chance
	
	while i < triggerKeys_newSession.Length
		triggerKey = triggerKeys_newSession[i]
		_triggerFile = FN_T(triggerKey)

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		If (doRun)
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)

			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		EndIf

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_ARMED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedItemType(0) != 0 || PlayerRef.GetEquippedItemType(1) != 0
				elseif ival == 2
					doRun = PlayerRef.GetEquippedItemType(0) == 0 && PlayerRef.GetEquippedItemType(1) == 0
				elseif ival == 3
					doRun = PlayerRef.GetEquippedItemType(1) == 0
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_CLOTHED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedArmorInSlot(32) != none
				elseif ival == 2
					doRun = PlayerRef.GetEquippedArmorInSlot(32) == none
				elseif ival == 3
					Armor bodyItem = PlayerRef.GetEquippedArmorInSlot(32)
					doRun = (bodyItem == none) || bodyItem.HasKeywordString("zad_Lockable")
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_WEAPON_DRAWN)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.IsWeaponDrawn()
				elseif ival == 2
					doRun = !PlayerRef.IsWeaponDrawn()
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
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
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
	bool doRun
	int ival
	
	while i < triggerKeys_topOfTheHour.Length
		triggerKey = triggerKeys_topOfTheHour[i]
		_triggerFile = FN_T(triggerKey)

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		If (doRun)
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)

			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		EndIf
			
		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_ARMED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedItemType(0) != 0 || PlayerRef.GetEquippedItemType(1) != 0
				elseif ival == 2
					doRun = PlayerRef.GetEquippedItemType(0) == 0 && PlayerRef.GetEquippedItemType(1) == 0
				elseif ival == 3
					doRun = PlayerRef.GetEquippedItemType(1) == 0
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_CLOTHED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedArmorInSlot(32) != none
				elseif ival == 2
					doRun = PlayerRef.GetEquippedArmorInSlot(32) == none
				elseif ival == 3
					Armor bodyItem = PlayerRef.GetEquippedArmorInSlot(32)
					doRun = (bodyItem == none) || bodyItem.HasKeywordString("zad_Lockable")
				endif
				if SLT.Debug_Extension_Core_TopOfTheHour
					SLTDebugMsg("Core.HandleTopOfTheHour: doRun(" + doRun + ") due to ATTR_IS_CLOTHED/" + ival)
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_WEAPON_DRAWN)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.IsWeaponDrawn()
				elseif ival == 2
					doRun = !PlayerRef.IsWeaponDrawn()
				endif
			endif
		endif

		if doRun
			If (SLT.Debug_Extension_Core_TopOfTheHour)
				SLTDebugMsg("Core.HandleTopOfTheHour: running _triggerFile(" + _triggerFile + ")")
			EndIf
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
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				RequestCommand(PlayerRef, command)
			endIf
		endif
		i += 1
	endwhile
EndFunction

Function HandleOnKeyDown(int keyPressed)
	if SLT.Debug_Extension_Core || SLT.Debug_Extension_Core_Keymapping
		SLTDebugMsg("Core.HandleOnKeyDown: starting")
	endif

	; all we know at this point is that at least one of the keys of interest were pressed
	; now we iterate all of the triggers (by slotnoprefix), check the status array against their
	; settings, and execute or skip
	int i = 0
	bool doRun
	bool dakused
	bool checkedModifierKeyDetected
	int ival
	int statusidx
	string value
	string triggerKey
	string command
	string _triggerFile
	bool hasModifierKey
	float chance
	
	while i < triggerKeys_keyDown.Length
		triggerKey = triggerKeys_keyDown[i]
		_triggerFile = FN_T(triggerKey)
		
		if SLT.Debug_Extension_Core_Keymapping
			SLTDebugMsg("Core.HandleOnKeyDown: triggerKey(" + triggerKey + ") _triggerFile(" + _triggerFile + ")")
		endif
		
		dakused = false
		hasModifierKey = false
		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
		
		if SLT.Debug_Extension_Core_Keymapping
			SLTDebugMsg("Core.HandleOnKeyDown: missing deleted attribute (allowed to run?)(" + doRun + ")")
		endif
		
		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_KEYMAPPING)
			;statusidx = _keycodes_of_interest.Find(ival)
			
			; check keycode status, must be true
			;if statusidx < 0
			;	doRun = false
			;else
			if ival != keyPressed
				;doRun = _keycode_status[statusidx]
				doRun = false
			endif
		
			if SLT.Debug_Extension_Core_Keymapping
				SLTDebugMsg("Core.HandleOnKeyDown: has matching keystate(" + doRun + ")   ival(" + ival + ")  keystate[ival](" + _keystates[ival] + ")")
			endif
		endif
		
		; check dynamic activation key if in use and specified
		if doRun && DAKAvailable && JsonUtil.HasIntValue(_triggerFile, ATTR_USEDAK)
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_USEDAK)
			if ival == 1
				; if they had DAK setting AND it was true, then dakused is true
				; and doRun is determined by DAK status
				dakused = true
				hasModifierKey = true

				doRun = DAKStatus.GetValue() as bool
			endif
		
			if SLT.Debug_Extension_Core_Keymapping
				SLTDebugMsg("Core.HandleOnKeyDown: dakavailable and usedak set; has matching keystate(" + doRun + ")   ival(" + DAKStatus.GetValue() as bool + ")")
			endif
		endif
		
		; check modifier status only if specified
		; if dakused, we do not try to manage via modifier
		if doRun && !dakused && JsonUtil.HasIntValue(_triggerFile, ATTR_MODIFIERKEYMAPPING)
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_MODIFIERKEYMAPPING)
			
			; only if mapped
			if ival > 0
				hasModifierKey = true
				
				doRun = _keystates[ival]
			endif
		
			if SLT.Debug_Extension_Core_Keymapping
				SLTDebugMsg("Core.HandleOnKeyDown: DAK not used, checking modifier key; has matching keystate(" + doRun + ")   ival(" + ival + ")  keystate[ival](" + _keystates[ival] + ")")
			endif
		endif

		if doRun && !hasModifierKey
			; do not run if no modifier key was specified but one was pressed
			; we check:
			; L CTRL/29, R CTRL/157, L ALT/56, R ALT/184, L SHIFT/42, R SHIFT/54
			ival = __checked_modifier_keys.Length
			checkedModifierKeyDetected = false
			while ival > 0 && !checkedModifierKeyDetected
				ival -= 1
				if _keystates[__checked_modifier_keys[ival]]
					checkedModifierKeyDetected = true
				endif
			endwhile
			If (checkedModifierKeyDetected)
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: no modifier key requested, but one is pressed; negating run request for trigger (" + _triggerFile + ")")
				endif
				doRun = false
			else
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: no modifier key requested, and none are pressed; allowing run request for trigger (" + _triggerFile + ")")
				endif
			EndIf
		else
			if SLT.Debug_Extension_Core_Keymapping
				SLTDebugMsg("Core.HandleOnKeyDown: doRun(" + doRun + ") hasModifierKey(" + hasModifierKey + ") ; was looking for (doRun && !hasModifierKey)")
			endif
		endif
			
		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_ARMED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedItemType(0) != 0 || PlayerRef.GetEquippedItemType(1) != 0
				elseif ival == 2
					doRun = PlayerRef.GetEquippedItemType(0) == 0 && PlayerRef.GetEquippedItemType(1) == 0
				elseif ival == 3
					doRun = PlayerRef.GetEquippedItemType(1) == 0
				endif
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: doRun(" + doRun + ") due to ATTR_IS_ARMED/" + ival)
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_CLOTHED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedArmorInSlot(32) != none
				elseif ival == 2
					doRun = PlayerRef.GetEquippedArmorInSlot(32) == none
				elseif ival == 3
					Armor bodyItem = PlayerRef.GetEquippedArmorInSlot(32)
					doRun = (bodyItem == none) || bodyItem.HasKeywordString("zad_Lockable")
				endif
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: doRun(" + doRun + ") due to ATTR_IS_CLOTHED/" + ival)
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_WEAPON_DRAWN)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.IsWeaponDrawn()
				elseif ival == 2
					doRun = !PlayerRef.IsWeaponDrawn()
				endif
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: doRun(" + doRun + ") due to ATTR_IS_WEAPON_DRAWN/" + ival)
				endif
			endif
		endif
		
		if doRun
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
			if command
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: do_1(" + command + ")")
				endif
				RequestCommand(PlayerRef, command)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
			if command
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: do_2(" + command + ")")
				endif
				RequestCommand(PlayerRef, command)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
			if command
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: do_3(" + command + ")")
				endif
				RequestCommand(PlayerRef, command)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: do_4(" + command + ")")
				endif
				RequestCommand(PlayerRef, command)
			endIf
		endif
		
		i += 1
	endwhile
	
	if SLT.Debug_Extension_Core_Keymapping
		SLTDebugMsg("Core.HandleOnKeyDown: done")
	endif
EndFunction

Function HandleOnPlayerCellChange(bool isNewGameLaunch, bool isNewSession, Keyword playerLocationKeyword, bool playerWasInInterior)
	if SLT.Debug_Extension_Core
		SLTDebugMsg("Core.HandleOnPlayerCellChange: isNewGameLaunch(" + isNewGameLaunch + ") / isNewSession(" + isNewSession + ") / playerLocationKeyword(" + playerLocationKeyword + ") / playerWasInInterior(" + playerWasInInterior + ")")
	endif

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
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)
			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DAYTIME)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = DayTime()
				elseIf ival == 2
					doRun = !DayTime()
				endIf
			endIf
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_ARMED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedItemType(0) != 0 || PlayerRef.GetEquippedItemType(1) != 0
				elseif ival == 2
					doRun = PlayerRef.GetEquippedItemType(0) == 0 && PlayerRef.GetEquippedItemType(1) == 0
				elseif ival == 3
					doRun = PlayerRef.GetEquippedItemType(1) == 0
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_CLOTHED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedArmorInSlot(32) != none
				elseif ival == 2
					doRun = PlayerRef.GetEquippedArmorInSlot(32) == none
				elseif ival == 3
					Armor bodyItem = PlayerRef.GetEquippedArmorInSlot(32)
					doRun = (bodyItem == none) || bodyItem.HasKeywordString("zad_Lockable")
				endif
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: doRun(" + doRun + ") due to ATTR_IS_CLOTHED/" + ival)
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_WEAPON_DRAWN)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.IsWeaponDrawn()
				elseif ival == 2
					doRun = !PlayerRef.IsWeaponDrawn()
				endif
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
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				cmdRequestId = GetNextPlayerCellChangeRequestId(requestTargetFormId, cmdRequestId, playerWasInInterior, playerLocationKeyword)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
		endif
		i += 1
	endwhile
EndFunction

int Function GetNextPlayerCellChangeRequestId(int requestTargetFormId, int cmdRequestId, bool playerWasInInterior, Keyword playerLocationKeyword)
	if !cmdRequestId
		cmdRequestId = SLT.GetNextInstanceId()

		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.was_player.inside", playerWasInInterior)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.was_player.outside", !playerWasInInterior)
		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.playerLocationKeyword", playerLocationKeyword)
	endif
	return cmdRequestId
EndFunction

Function HandlePlayerContainerActivation(ObjectReference containerRef, bool container_is_corpse, bool container_is_empty, Keyword playerLocationKeyword, bool playerWasInInterior)
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

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
		
		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)
			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_CONTAINER_EMPTY)
			if ival != 0
				if ival == 1
					doRun = !container_is_empty
				elseif ival == 2
					doRun = container_is_empty
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_CONTAINER_CORPSE)
			if ival != 0
				if ival == 1
					doRun = !container_is_corpse
				elseif ival == 2
					doRun = container_is_corpse
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_ARMED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedItemType(0) != 0 || PlayerRef.GetEquippedItemType(1) != 0
				elseif ival == 2
					doRun = PlayerRef.GetEquippedItemType(0) == 0 && PlayerRef.GetEquippedItemType(1) == 0
				elseif ival == 3
					doRun = PlayerRef.GetEquippedItemType(1) == 0
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_CLOTHED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedArmorInSlot(32) != none
				elseif ival == 2
					doRun = PlayerRef.GetEquippedArmorInSlot(32) == none
				elseif ival == 3
					Armor bodyItem = PlayerRef.GetEquippedArmorInSlot(32)
					doRun = (bodyItem == none) || bodyItem.HasKeywordString("zad_Lockable")
				endif
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: doRun(" + doRun + ") due to ATTR_IS_CLOTHED/" + ival)
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_WEAPON_DRAWN)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.IsWeaponDrawn()
				elseif ival == 2
					doRun = !PlayerRef.IsWeaponDrawn()
				endif
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
				if ival == 1
					doRun = !container_is_common
				elseif ival == 2
					doRun = container_is_common
				endif
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
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				cmdRequestId = GetNextPlayerContainerActivationRequestId(requestTargetFormId, cmdRequestId, containerRef, container_is_corpse, container_is_empty, container_is_common, playerWasInInterior, playerLocationKeyword)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
		endif
		i += 1
	endwhile
EndFunction

int Function GetNextPlayerContainerActivationRequestId(int requestTargetFormId, int cmdRequestId, Form containerRef, bool container_is_corpse, bool container_is_empty, bool container_is_common, bool playerWasInInterior, Keyword playerLocationKeyword)
	if !cmdRequestId
		cmdRequestId = SLT.GetNextInstanceId()

		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.activatedContainer", containerRef)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.activatedContainer.is_corpse", container_is_corpse)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.activatedContainer.is_empty", container_is_empty)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.activatedContainer.is_common", container_is_common)

		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.was_player.inside", playerWasInInterior)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.was_player.outside", !playerWasInInterior)
		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.playerLocationKeyword", playerLocationKeyword)
	endif
	return cmdRequestId
EndFunction

Function HandleLocationChanged(Location akOldLoc, Location akNewLoc)
	If (SLT.Debug_Extension_Core)
		SLTDebugMsg("Core.HandleLocationChanged: akOldLoc(" + akOldLoc + ") akNewLoc(" + akNewLoc + ")")
	EndIf

	if triggerKeys_location_change.Length < 1
		return
	endif

	int cmdRequestId
	int		requestTargetFormId = PlayerRef.GetFormID() ; conveniently so, in this case
	bool  playerWasInInterior = PlayerRef.IsInInterior()
	int i = 0
	int j
	bool[]	flagset_leaving = new bool[19]
	bool[]	flagset_entering = new bool[19]
	
	SLT.GetLocationFlags(akOldLoc, flagset_leaving)
	SLT.GetLocationFlags(akNewLoc, flagset_entering)
	Keyword playerLocationKeyword = SLT.GetPlayerLocationKeyword()

	bool   	doRun
	string 	triggerKey
	string 	_triggerFile
	string 	command

	int    	ival
	bool 	bval
	
	float chance

	while i < triggerKeys_location_change.Length
		triggerKey = triggerKeys_location_change[i]
		_triggerFile = FN_T(triggerKey)

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)

			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DAYTIME)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = DayTime()
				elseIf ival == 2
					doRun = !DayTime()
				endIf
			endIf
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_CLEARED_LEAVING)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = akOldLoc.IsCleared()
				elseIf ival == 2
					doRun = !akOldLoc.IsCleared()
				endIf
			endIf
		endIf

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_CLEARED_ENTERING)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = akNewLoc.IsCleared()
				elseIf ival == 2
					doRun = !akNewLoc.IsCleared()
				endIf
			endIf
		endIf

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_ARMED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedItemType(0) != 0 || PlayerRef.GetEquippedItemType(1) != 0
				elseif ival == 2
					doRun = PlayerRef.GetEquippedItemType(0) == 0 && PlayerRef.GetEquippedItemType(1) == 0
				elseif ival == 3
					doRun = PlayerRef.GetEquippedItemType(1) == 0
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_CLOTHED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedArmorInSlot(32) != none
				elseif ival == 2
					doRun = PlayerRef.GetEquippedArmorInSlot(32) == none
				elseif ival == 3
					Armor bodyItem = PlayerRef.GetEquippedArmorInSlot(32)
					doRun = (bodyItem == none) || bodyItem.HasKeywordString("zad_Lockable")
				endif
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: doRun(" + doRun + ") due to ATTR_IS_CLOTHED/" + ival)
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_WEAPON_DRAWN)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.IsWeaponDrawn()
				elseif ival == 2
					doRun = !PlayerRef.IsWeaponDrawn()
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DEEPLOCATION_ENTERING)
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
					doRun = SLT.IsFlagsetSafe(flagset_entering)
				elseif ival == 4
					doRun = SLT.IsFlagsetInCity(flagset_entering)
				elseif ival == 5
					doRun = SLT.IsFlagsetInWilderness(flagset_entering)
				elseif ival == 6
					doRun = SLT.IsFlagsetInDungeon(flagset_entering)
				else
					j = ival - 6
					doRun = flagset_entering[j]
				endif
			endif
		endIf

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DEEPLOCATION_LEAVING)
			if ival != 0
				SLT.GetLocationFlags(akOldLoc, flagset_leaving)
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
					doRun = SLT.IsFlagsetSafe(flagset_leaving)
				elseif ival == 4
					doRun = SLT.IsFlagsetInCity(flagset_leaving)
				elseif ival == 5
					doRun = SLT.IsFlagsetInWilderness(flagset_leaving)
				elseif ival == 6
					doRun = SLT.IsFlagsetInDungeon(flagset_leaving)
				else
					j = ival - 6
					doRun = flagset_leaving[j]
				endif
			endif
		endIf
		
		if doRun
			int cmdThreadId
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
			if command
				cmdRequestId = GetNextLocationChangeRequestId(requestTargetFormId, cmdRequestId, playerWasInInterior, playerLocationKeyword, akOldLoc, akNewLoc)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
			if command
				cmdRequestId = GetNextLocationChangeRequestId(requestTargetFormId, cmdRequestId, playerWasInInterior, playerLocationKeyword, akOldLoc, akNewLoc)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
			if command
				cmdRequestId = GetNextLocationChangeRequestId(requestTargetFormId, cmdRequestId, playerWasInInterior, playerLocationKeyword, akOldLoc, akNewLoc)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				cmdRequestId = GetNextLocationChangeRequestId(requestTargetFormId, cmdRequestId, playerWasInInterior, playerLocationKeyword, akOldLoc, akNewLoc)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
		endif

		i += 1
	endwhile
EndFunction

int Function GetNextLocationChangeRequestId(int requestTargetFormId, int cmdRequestId, bool playerWasInInterior, Keyword playerLocationKeyword, Location akOldLoc, Location akNewLoc)
	if !cmdRequestId
		cmdRequestId = SLT.GetNextInstanceId()

		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.was_player.inside", playerWasInInterior)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.was_player.outside", !playerWasInInterior)
		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.from_location", akOldLoc)
		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.to_location", akNewLoc)
		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.playerLocationKeyword", playerLocationKeyword)
	endif
	return cmdRequestId
EndFunction

int Property kSlotMask30 = 0x00000001 AutoReadOnly ; HEAD
int Property kSlotMask31 = 0x00000002 AutoReadOnly ; Hair
int Property kSlotMask32 = 0x00000004 AutoReadOnly ; BODY
int Property kSlotMask33 = 0x00000008 AutoReadOnly ; Hands
int Property kSlotMask34 = 0x00000010 AutoReadOnly ; Forearms
int Property kSlotMask35 = 0x00000020 AutoReadOnly ; Amulet
int Property kSlotMask36 = 0x00000040 AutoReadOnly ; Ring
int Property kSlotMask37 = 0x00000080 AutoReadOnly ; Feet
int Property kSlotMask38 = 0x00000100 AutoReadOnly ; Calves
int Property kSlotMask39 = 0x00000200 AutoReadOnly ; SHIELD
int Property kSlotMask40 = 0x00000400 AutoReadOnly ; TAIL
int Property kSlotMask41 = 0x00000800 AutoReadOnly ; LongHair
int Property kSlotMask42 = 0x00001000 AutoReadOnly ; Circlet
int Property kSlotMask43 = 0x00002000 AutoReadOnly ; Ears
int Property kSlotMask44 = 0x00004000 AutoReadOnly ; Unnamed
int Property kSlotMask45 = 0x00008000 AutoReadOnly ; Unnamed
int Property kSlotMask46 = 0x00010000 AutoReadOnly ; Unnamed
int Property kSlotMask47 = 0x00020000 AutoReadOnly ; Unnamed
int Property kSlotMask48 = 0x00040000 AutoReadOnly ; Unnamed
int Property kSlotMask49 = 0x00080000 AutoReadOnly ; Unnamed
int Property kSlotMask50 = 0x00100000 AutoReadOnly ; DecapitateHead
int Property kSlotMask51 = 0x00200000 AutoReadOnly ; Decapitate
int Property kSlotMask52 = 0x00400000 AutoReadOnly ; Unnamed
int Property kSlotMask53 = 0x00800000 AutoReadOnly ; Unnamed
int Property kSlotMask54 = 0x01000000 AutoReadOnly ; Unnamed
int Property kSlotMask55 = 0x02000000 AutoReadOnly ; Unnamed
int Property kSlotMask56 = 0x04000000 AutoReadOnly ; Unnamed
int Property kSlotMask57 = 0x08000000 AutoReadOnly ; Unnamed
int Property kSlotMask58 = 0x10000000 AutoReadOnly ; Unnamed
int Property kSlotMask59 = 0x20000000 AutoReadOnly ; Unnamed
int Property kSlotMask60 = 0x40000000 AutoReadOnly ; Unnamed
int Property kSlotMask61 = 0x80000000 AutoReadOnly ; FX01

Function HandleEquipmentChange(Form akBaseObject, ObjectReference akRef, bool is_equipping)
	If (SLT.Debug_Extension_Core)
		SLTDebugMsg("Core.HandleEquipmentChange: akBaseObject(" + akBaseObject + ") akRef(" + akRef + ") is_equipping(" + is_equipping + ")")
	EndIf

	if triggerKeys_equipment_change.Length < 1
		return
	endif

	int cmdRequestId
	int		requestTargetFormId = PlayerRef.GetFormID() ; conveniently so, in this case
	bool  playerWasInInterior = PlayerRef.IsInInterior()
	int i = 0
	int j
	bool[]	flagset_entering = new bool[19]
	
	SLT.GetLocationFlags(PlayerRef.GetCurrentLocation(), flagset_entering)

	bool   	doRun
	string 	triggerKey
	string 	_triggerFile
	string 	command

	int    	ival
	bool 	bval
	
	float chance
	bool is_daytime = DayTime()
	bool is_unique = (akRef != none)
	bool has_enchantments = (is_unique && akRef.GetEnchantment() != none)
	int item_type
	string item_type_str
	
 	if (akBaseObject as Armor) != none
		item_type = 1
		item_type_str = "Armor"
	elseif (akBaseObject as Weapon) != none
		item_type = 2
		item_type_str = "Weapon"
	elseif (akBaseObject as Spell) != none
		item_type = 3
		item_type_str = "Spell"
	elseif (akBaseObject as Potion) != none
		item_type = 4
		item_type_str = "Potion"
	elseif (akBaseObject as Ammo) != none
		item_type = 5
		item_type_str = "Ammo"
	endif

	while i < triggerKeys_equipment_change.Length
		triggerKey = triggerKeys_equipment_change[i]
		_triggerFile = FN_T(triggerKey)

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)
			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DAYTIME)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = DayTime()
				elseIf ival == 2
					doRun = !DayTime()
				endIf
			endIf
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_EQUIPPING)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = is_equipping
				elseIf ival == 2
					doRun = !is_equipping
				endIf
			endIf
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_ITEM_IS_UNIQUE)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = !is_unique
				elseIf ival == 2
					doRun = is_unique
				endIf
			endIf
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_HAS_ENCHANTMENTS)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = has_enchantments
				elseIf ival == 2
					doRun = !has_enchantments
				endIf
			endIf
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_EQUIPPED_ITEM_TYPE)
			if ival != 0
				if ival == item_type
					doRun = true
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_ARMOR_SLOT)
			if ival != 0
				if (akBaseObject as Armor) == none
					doRun = false
				elseif ival == 1
					; only head/body/hands/feet slots
					Armor baseArmor = akBaseObject as Armor
					If (baseArmor)
						int slotMask = baseArmor.GetSlotMask()
						doRun = (Math.LogicalAnd(slotMask, kSlotMask30) || Math.LogicalAnd(slotMask, kSlotMask32) || Math.LogicalAnd(slotMask, kSlotMask33) || Math.LogicalAnd(slotMask, kSlotMask37))
					EndIf
				elseif ival == 2
					; only ring/amulet/circlet slots
					Armor baseArmor = akBaseObject as Armor
					If (baseArmor)
						int slotMask = baseArmor.GetSlotMask()
						doRun = (Math.LogicalAnd(slotMask, kSlotMask36) || Math.LogicalAnd(slotMask, kSlotMask35) || Math.LogicalAnd(slotMask, kSlotMask42))
					EndIf
				else
					; slot = ival - 3 + 30
					Armor baseArmor = akBaseObject as Armor
					If (baseArmor)
						int slotMask = baseArmor.GetSlotMask()
						doRun = Math.LogicalAnd(slotMask, Math.LeftShift(1, ival - 3 + 30))
					EndIf
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_ARMED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedItemType(0) != 0 || PlayerRef.GetEquippedItemType(1) != 0
				elseif ival == 2
					doRun = PlayerRef.GetEquippedItemType(0) == 0 && PlayerRef.GetEquippedItemType(1) == 0
				elseif ival == 3
					doRun = PlayerRef.GetEquippedItemType(1) == 0
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_CLOTHED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedArmorInSlot(32) != none
				elseif ival == 2
					doRun = PlayerRef.GetEquippedArmorInSlot(32) == none
				elseif ival == 3
					Armor bodyItem = PlayerRef.GetEquippedArmorInSlot(32)
					doRun = (bodyItem == none) || bodyItem.HasKeywordString("zad_Lockable")
				endif
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: doRun(" + doRun + ") due to ATTR_IS_CLOTHED/" + ival)
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_WEAPON_DRAWN)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.IsWeaponDrawn()
				elseif ival == 2
					doRun = !PlayerRef.IsWeaponDrawn()
				endif
			endif
		endif
		
		if doRun
			int cmdThreadId
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
			if command
				cmdRequestId = GetNextEquipmentChangeRequestId(requestTargetFormId, cmdRequestId, akBaseObject, akRef, is_equipping, is_unique, has_enchantments, item_type_str)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
			if command
				cmdRequestId = GetNextEquipmentChangeRequestId(requestTargetFormId, cmdRequestId, akBaseObject, akRef, is_equipping, is_unique, has_enchantments, item_type_str)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
			if command
				cmdRequestId = GetNextEquipmentChangeRequestId(requestTargetFormId, cmdRequestId, akBaseObject, akRef, is_equipping, is_unique, has_enchantments, item_type_str)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				cmdRequestId = GetNextEquipmentChangeRequestId(requestTargetFormId, cmdRequestId, akBaseObject, akRef, is_equipping, is_unique, has_enchantments, item_type_str)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
		endif

		i += 1
	endwhile
EndFunction

int Function GetNextEquipmentChangeRequestId(int requestTargetFormId, int cmdRequestId, Form baseForm, ObjectReference objRef, bool is_equipping, bool is_unique, bool has_enchantments, string equipped_item_type)
	if !cmdRequestId
		cmdRequestId = SLT.GetNextInstanceId()

		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.equipped_item.base_form", baseForm)
		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.equipped_item.object_reference", objRef)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.equipped_item.is_equipping", is_equipping)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.equipped_item.is_unique", is_unique)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.equipped_item.has_enchantments", has_enchantments)
		sl_triggersCmd.PrecacheRequestString(SLT, requestTargetFormId, cmdRequestId, "core.equipped_item.type", equipped_item_type)
	endif
	return cmdRequestId
EndFunction

Function HandlePlayerCombatStateChanged(Actor target, bool player_in_combat)
	If (SLT.Debug_Extension_Core)
		SLTDebugMsg("Core.HandlePlayerCombatStateChanged: target (" + target + ") player_in_combat (" + player_in_combat + ")")
	EndIf

	if triggerKeys_player_combat_status.Length < 1
		return
	endif

	int cmdRequestId
	int		requestTargetFormId = PlayerRef.GetFormID() ; conveniently so, in this case
	int i = 0
	int j

	bool   	doRun
	string 	triggerKey
	string 	_triggerFile
	string 	command

	int    	ival
	bool 	bval
	
	float chance

	while i < triggerKeys_player_combat_status.Length
		triggerKey = triggerKeys_player_combat_status[i]
		_triggerFile = FN_T(triggerKey)

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)

			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_COMBAT_STATE)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = player_in_combat
				elseIf ival == 2
					doRun = !player_in_combat
				endIf
			endIf
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_ARMED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedItemType(0) != 0 || PlayerRef.GetEquippedItemType(1) != 0
				elseif ival == 2
					doRun = PlayerRef.GetEquippedItemType(0) == 0 && PlayerRef.GetEquippedItemType(1) == 0
				elseif ival == 3
					doRun = PlayerRef.GetEquippedItemType(1) == 0
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_CLOTHED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedArmorInSlot(32) != none
				elseif ival == 2
					doRun = PlayerRef.GetEquippedArmorInSlot(32) == none
				elseif ival == 3
					Armor bodyItem = PlayerRef.GetEquippedArmorInSlot(32)
					doRun = (bodyItem == none) || bodyItem.HasKeywordString("zad_Lockable")
				endif
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: doRun(" + doRun + ") due to ATTR_IS_CLOTHED/" + ival)
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_WEAPON_DRAWN)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.IsWeaponDrawn()
				elseif ival == 2
					doRun = !PlayerRef.IsWeaponDrawn()
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
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				RequestCommand(PlayerRef, command)
			endIf
		endif

		i += 1
	endwhile
EndFunction

Function HandlePlayerOnHit(Form kattacker, Form ktarget, int ksourceFormID, int kprojectileFormID, bool was_player_attacker, bool kPowerAttack, bool kSneakAttack, bool kBashAttack, bool kHitBlocked)
	If (SLT.Debug_Extension_Core)
		SLTDebugMsg("Core.HandlePlayerOnHit: attacker(" + kattacker + ") target(" + ktarget + ") source(" + ksourceFormID + ") projectile(" + kprojectileFormID + ") was_player_attacker(" + was_player_attacker + ") power(" + kPowerAttack + ") sneak(" + kSneakAttack + ") bash(" + kBashAttack + ") blocked(" + kHitBlocked + ")")
	EndIf

	if triggerKeys_player_on_hit.Length < 1
		return
	endif

	int cmdRequestId
	int		requestTargetFormId = PlayerRef.GetFormID() ; conveniently so, in this case
	int i = 0
	int j

	bool   	doRun
	string 	triggerKey
	string 	_triggerFile
	string 	command

	int    	ival
	bool 	bval
	
	float chance

	while i < triggerKeys_player_on_hit.Length
		triggerKey = triggerKeys_player_on_hit[i]
		_triggerFile = FN_T(triggerKey)

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)

			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_PLAYER_ATTACKING)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = was_player_attacker
				elseIf ival == 2
					doRun = !was_player_attacker
				endIf
			endIf
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_WAS_BLOCKED)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = kHitBlocked
				elseIf ival == 2
					doRun = !kHitBlocked
				endIf
			endIf
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_WAS_POWER_ATTACK)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = kPowerAttack
				elseIf ival == 2
					doRun = !kPowerAttack
				endIf
			endIf
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_WAS_SNEAK_ATTACK)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = kSneakAttack
				elseIf ival == 2
					doRun = !kSneakAttack
				endIf
			endIf
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_WAS_BASH_ATTACK)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = kBashAttack
				elseIf ival == 2
					doRun = !kBashAttack
				endIf
			endIf
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_ARMED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedItemType(0) != 0 || PlayerRef.GetEquippedItemType(1) != 0
				elseif ival == 2
					doRun = PlayerRef.GetEquippedItemType(0) == 0 && PlayerRef.GetEquippedItemType(1) == 0
				elseif ival == 3
					doRun = PlayerRef.GetEquippedItemType(1) == 0
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_CLOTHED)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.GetEquippedArmorInSlot(32) != none
				elseif ival == 2
					doRun = PlayerRef.GetEquippedArmorInSlot(32) == none
				elseif ival == 3
					Armor bodyItem = PlayerRef.GetEquippedArmorInSlot(32)
					doRun = (bodyItem == none) || bodyItem.HasKeywordString("zad_Lockable")
				endif
				if SLT.Debug_Extension_Core_Keymapping
					SLTDebugMsg("Core.HandleOnKeyDown: doRun(" + doRun + ") due to ATTR_IS_CLOTHED/" + ival)
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_IS_WEAPON_DRAWN)
			if ival != 0
				if ival == 1
					doRun = PlayerRef.IsWeaponDrawn()
				elseif ival == 2
					doRun = !PlayerRef.IsWeaponDrawn()
				endif
			endif
		endif
		
		if doRun
			int cmdThreadId
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
			if command
				cmdRequestId = GetNextPlayerOnHitRequestId(requestTargetFormId, cmdRequestId, kattacker, ktarget, ksourceFormID, kprojectileFormID)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
			if command
				cmdRequestId = GetNextPlayerOnHitRequestId(requestTargetFormId, cmdRequestId, kattacker, ktarget, ksourceFormID, kprojectileFormID)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
			if command
				cmdRequestId = GetNextPlayerOnHitRequestId(requestTargetFormId, cmdRequestId, kattacker, ktarget, ksourceFormID, kprojectileFormID)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				cmdRequestId = GetNextPlayerOnHitRequestId(requestTargetFormId, cmdRequestId, kattacker, ktarget, ksourceFormID, kprojectileFormID)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
		endif

		i += 1
	endwhile
EndFunction

int Function GetNextPlayerOnHitRequestId(int requestTargetFormId, int cmdRequestId, Form kattacker, Form ktarget, int ksourceFormID, int kprojectileFormID)
	if !cmdRequestId
		cmdRequestId = SLT.GetNextInstanceId()

		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.player_on_hit.attacker", kattacker)
		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.player_on_hit.target", ktarget)
		sl_triggersCmd.PrecacheRequestInt(SLT, requestTargetFormId, cmdRequestId, "core.player_on_hit.source", ksourceFormID)
		sl_triggersCmd.PrecacheRequestInt(SLT, requestTargetFormId, cmdRequestId, "core.player_on_hit.projectile", kprojectileFormID)
	endif
	return cmdRequestId
EndFunction

Function HandleHarvesting(ObjectReference harvestSource)
	If (SLT.Debug_Extension_Core)
		Form baseObject = harvestSource.GetBaseObject()
		SLTDebugMsg("Core.HandleHarvesting harvestSource(" + harvestSource + ") baseObject(" + baseObject + ")")
	EndIf

	if triggerKeys_harvesting.Length < 1
		return
	endif
	
	int cmdRequestId
	int		requestTargetFormId = PlayerRef.GetFormID() ; conveniently so, in this case
	int i = 0
	int j

	bool   	doRun
	string 	triggerKey
	string 	_triggerFile
	string 	command
	bool  playerWasInInterior = PlayerRef.IsInInterior()
	Keyword playerLocationKeyword = SLT.GetPlayerLocationKeyword()

	int    	ival
	bool 	bval
	
	float chance

	while i < triggerKeys_harvesting.Length
		triggerKey = triggerKeys_harvesting[i]
		_triggerFile = FN_T(triggerKey)

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)

			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DAYTIME)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = DayTime()
				elseIf ival == 2
					doRun = !DayTime()
				endIf
			endIf
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
		endIf
		
		if doRun
			int cmdThreadId
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
			if command
				cmdRequestId = GetNextHarvestingRequestId(requestTargetFormId, cmdRequestId, harvestSource)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
			if command
				cmdRequestId = GetNextHarvestingRequestId(requestTargetFormId, cmdRequestId, harvestSource)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
			if command
				cmdRequestId = GetNextHarvestingRequestId(requestTargetFormId, cmdRequestId, harvestSource)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				cmdRequestId = GetNextHarvestingRequestId(requestTargetFormId, cmdRequestId, harvestSource)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
		endif

		i += 1
	endwhile
EndFunction

int Function GetNextHarvestingRequestId(int requestTargetFormId, int cmdRequestId, ObjectReference harvestSource)
	if !cmdRequestId
		cmdRequestId = SLT.GetNextInstanceId()

		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.harvesting.harvest_objref", harvestSource)
		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.harvesting.harvest_base_object", harvestSource.GetBaseObject())
	endif
	return cmdRequestId
EndFunction

Function HandleFastTravel()
	If (SLT.Debug_Extension_Core)
		SLTDebugMsg("Core.HandleFastTravel")
	EndIf

	if triggerKeys_fast_travel.Length < 1
		return
	endif
	
	int cmdRequestId
	int		requestTargetFormId = PlayerRef.GetFormID() ; conveniently so, in this case
	int i = 0
	int j

	bool   	doRun
	string 	triggerKey
	string 	_triggerFile
	string 	command

	int    	ival
	bool 	bval
	
	float chance

	while i < triggerKeys_fast_travel.Length
		triggerKey = triggerKeys_fast_travel[i]
		_triggerFile = FN_T(triggerKey)

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)

			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
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
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				RequestCommand(PlayerRef, command)
			endIf
		endif

		i += 1
	endwhile
EndFunction

Function HandleVampirism(bool isContracted, bool isCured, bool startVampireLord, bool endVampireLord)
	If (SLT.Debug_Extension_Core)
		SLTDebugMsg("Core.HandleVampirism isContracted(" + isContracted + ") isCured(" + isCured + ") startVampireLord(" + startVampireLord + ") endVampireLord(" + endVampireLord + ")")
	EndIf

	if triggerKeys_vampirism.Length < 1
		return
	endif
	
	int cmdRequestId
	int		requestTargetFormId = PlayerRef.GetFormID() ; conveniently so, in this case
	int i = 0
	int j

	bool   	doRun
	string 	triggerKey
	string 	_triggerFile
	string 	command
	bool  playerWasInInterior = PlayerRef.IsInInterior()
	Keyword playerLocationKeyword = SLT.GetPlayerLocationKeyword()

	int    	ival
	bool 	bval
	
	float chance

	while i < triggerKeys_vampirism.Length
		triggerKey = triggerKeys_vampirism[i]
		_triggerFile = FN_T(triggerKey)

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)

			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_VAMPIRISM)
			if ival != 0
				if ival == 1
					doRun = isCured
				elseif ival == 2
					doRun = isContracted
				elseif ival == 3
					doRun = startVampireLord
				elseif ival == 4
					doRun = endVampireLord
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DAYTIME)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = DayTime()
				elseIf ival == 2
					doRun = !DayTime()
				endIf
			endIf
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
		endIf
		
		if doRun
			int cmdThreadId
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
			if command
				cmdRequestId = GetNextVampirismRequestId(requestTargetFormId, cmdRequestId, isContracted, isCured, startVampireLord, endVampireLord)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
			if command
				cmdRequestId = GetNextVampirismRequestId(requestTargetFormId, cmdRequestId, isContracted, isCured, startVampireLord, endVampireLord)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
			if command
				cmdRequestId = GetNextVampirismRequestId(requestTargetFormId, cmdRequestId, isContracted, isCured, startVampireLord, endVampireLord)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				cmdRequestId = GetNextVampirismRequestId(requestTargetFormId, cmdRequestId, isContracted, isCured, startVampireLord, endVampireLord)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
		endif

		i += 1
	endwhile
EndFunction

int Function GetNextVampirismRequestId(int requestTargetFormId, int cmdRequestId, bool isContracted, bool isCured, bool startVampireLord, bool endVampireLord)
	if !cmdRequestId
		cmdRequestId = SLT.GetNextInstanceId()

		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.vampirism.was_contracted", isContracted)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.vampirism.was_cured", isCured)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.vampirism.started_vampire_lord", startVampireLord)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.vampirism.ended_vampire_lord", endVampireLord)
	endif
	return cmdRequestId
EndFunction

Function HandleLycanthropy(bool isContracted, bool isCured, bool startWerewolf, bool endWerewolf)
	If (SLT.Debug_Extension_Core)
		SLTDebugMsg("Core.HandleLycanthropy isContracted(" + isContracted + ") isCured(" + isCured + ") startWerewolf(" + startWerewolf + ") endWerewolf(" + endWerewolf + ")")
	EndIf

	if triggerKeys_lycanthropy.Length < 1
		return
	endif
	
	int cmdRequestId
	int		requestTargetFormId = PlayerRef.GetFormID() ; conveniently so, in this case
	int i = 0
	int j

	bool   	doRun
	string 	triggerKey
	string 	_triggerFile
	string 	command
	bool  playerWasInInterior = PlayerRef.IsInInterior()
	Keyword playerLocationKeyword = SLT.GetPlayerLocationKeyword()

	int    	ival
	bool 	bval
	
	float chance

	while i < triggerKeys_lycanthropy.Length
		triggerKey = triggerKeys_lycanthropy[i]
		_triggerFile = FN_T(triggerKey)

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)

			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_LYCANTHROPY)
			if ival != 0
				if ival == 1
					doRun = isCured
				elseif ival == 2
					doRun = isContracted
				elseif ival == 3
					doRun = startWerewolf
				elseif ival == 4
					doRun = endWerewolf
				endif
			endif
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DAYTIME)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = DayTime()
				elseIf ival == 2
					doRun = !DayTime()
				endIf
			endIf
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
		endIf
		
		if doRun
			int cmdThreadId
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
			if command
				cmdRequestId = GetNextLycanthropyRequestId(requestTargetFormId, cmdRequestId, isContracted, isCured, startWerewolf, endWerewolf)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
			if command
				cmdRequestId = GetNextLycanthropyRequestId(requestTargetFormId, cmdRequestId, isContracted, isCured, startWerewolf, endWerewolf)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
			if command
				cmdRequestId = GetNextLycanthropyRequestId(requestTargetFormId, cmdRequestId, isContracted, isCured, startWerewolf, endWerewolf)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				cmdRequestId = GetNextLycanthropyRequestId(requestTargetFormId, cmdRequestId, isContracted, isCured, startWerewolf, endWerewolf)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
		endif

		i += 1
	endwhile
EndFunction

int Function GetNextLycanthropyRequestId(int requestTargetFormId, int cmdRequestId, bool isContracted, bool isCured, bool startWerewolf, bool endWerewolf)
	if !cmdRequestId
		cmdRequestId = SLT.GetNextInstanceId()

		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.lycanthropy.was_contracted", isContracted)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.lycanthropy.was_cured", isCured)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.lycanthropy.started_werewolf", startWerewolf)
		sl_triggersCmd.PrecacheRequestBool(SLT, requestTargetFormId, cmdRequestId, "core.lycanthropy.ended_werewolf", endWerewolf)
	endif
	return cmdRequestId
EndFunction

Function HandleVampireFeeding(Actor akTarget)
	If (SLT.Debug_Extension_Core)
		SLTDebugMsg("Core.HandleVampireFeeding")
	EndIf

	if triggerKeys_vampire_feeding.Length < 1
		return
	endif
	
	int cmdRequestId
	int		requestTargetFormId = PlayerRef.GetFormID() ; conveniently so, in this case
	int i = 0
	int j

	bool   	doRun
	string 	triggerKey
	string 	_triggerFile
	string 	command
	bool  playerWasInInterior = PlayerRef.IsInInterior()
	Keyword playerLocationKeyword = SLT.GetPlayerLocationKeyword()

	int    	ival
	bool 	bval
	
	float chance

	while i < triggerKeys_vampire_feeding.Length
		triggerKey = triggerKeys_vampire_feeding[i]
		_triggerFile = FN_T(triggerKey)

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)

			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		endif

		if doRun
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DAYTIME)
			if ival != 0 ; 0 is Any
				if ival == 1
					doRun = DayTime()
				elseIf ival == 2
					doRun = !DayTime()
				endIf
			endIf
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
		endIf
		
		if doRun
			int cmdThreadId
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
			if command
				cmdRequestId = GetNextVampireFeedingRequestId(requestTargetFormId, cmdRequestId, akTarget)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
			if command
				cmdRequestId = GetNextVampireFeedingRequestId(requestTargetFormId, cmdRequestId, akTarget)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
			if command
				cmdRequestId = GetNextVampireFeedingRequestId(requestTargetFormId, cmdRequestId, akTarget)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
			if command
				cmdRequestId = GetNextVampireFeedingRequestId(requestTargetFormId, cmdRequestId, akTarget)
				cmdThreadId = SLT.GetNextInstanceId()
				RequestCommandWithThreadId(PlayerRef, command, cmdRequestId, cmdThreadId)
			endIf
		endif

		i += 1
	endwhile
EndFunction

int Function GetNextVampireFeedingRequestId(int requestTargetFormId, int cmdRequestId, Actor akTarget)
	if !cmdRequestId
		cmdRequestId = SLT.GetNextInstanceId()

		sl_triggersCmd.PrecacheRequestForm(SLT, requestTargetFormId, cmdRequestId, "core.vampire_feeding.target", akTarget)
	endif
	return cmdRequestId
EndFunction
