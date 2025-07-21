scriptname sl_triggersExtensionSexLab extends sl_triggersExtension

import sl_triggersStatics

;SexLabFramework     Property SexLab						Auto Hidden
Form				Property SexLabForm					Auto Hidden
Faction	            Property SexLabAnimatingFaction 	Auto Hidden

string	EVENT_SEXLAB_START					= "AnimationStart"
string	EVENT_SEXLAB_END					= "AnimationEnd"
string	EVENT_SEXLAB_ORGASM					= "OrgasmStart"
string	EVENT_SEXLAB_ORGASM_SLSO			= "SexLabOrgasmSeparate"
string	EVENT_SEXLAB_START_HANDLER			= "OnSexLabStart"
string	EVENT_SEXLAB_END_HANDLER			= "OnSexLabEnd"
string	EVENT_SEXLAB_ORGASM_HANDLER			= "OnSexLabOrgasm"
string	EVENT_SEXLAB_ORGASM_SLSO_HANDLER	= "OnSexLabOrgasmS"
int		EVENT_ID_START 						= 1
int		EVENT_ID_ORGASM						= 2
int		EVENT_ID_STOP						= 3
int		EVENT_ID_ORGASM_SLSO				= 4

string ATTR_MOD_VERSION						= "__slt_mod_version__"
string ATTR_EVENT							= "event"
string ATTR_CHANCE							= "chance"
string ATTR_RACE							= "race"
string ATTR_ROLE							= "role"
string ATTR_PLAYER							= "player"
string ATTR_GENDER							= "gender"
string ATTR_TAG								= "tag"
string ATTR_DAYTIME							= "daytime"
string ATTR_LOCATION						= "location"
string ATTR_POSITION						= "position"
string ATTR_DO_1							= "do_1"
string ATTR_DO_2							= "do_2"
string ATTR_DO_3							= "do_3"
string ATTR_DEEPLOCATION					= "deeplocation"
string ATTR_IS_ARMED						= "is_armed"
string ATTR_IS_CLOTHED						= "is_clothed"
string ATTR_IS_WEAPON_DRAWN					= "is_weapon_drawn"


string[]	triggerKeys_Start
string[]	triggerKeys_Orgasm
string[]	triggerKeys_Stop
string[]	triggerKeys_Orgasm_S

Event OnInit()
	if !self
		return
	endif
	UpdateSexLabStatus()
	; REQUIRED CALL
	UnregisterForUpdate()
	RegisterForSingleUpdate(0.01)
EndEvent

Event OnUpdate()
	SLTInit()
EndEvent

; SLTReady
; OPTIONAL
Function SLTReady()
	UpdateSexLabStatus()
	RefreshData()
EndFunction

Function RefreshData()
	RegisterEvents()
EndFunction

bool Function _slt_AdditionalRequirementsSatisfied()
	return SexLabForm != none
EndFunction

sslThreadController Function GetThreadForActor(Actor theActor)
    return (SexLabForm as SexLabFramework).GetActorController(theActor)
EndFunction

Function HandleVersionUpdate(int oldVersion, int newVersion)
	If (SLT.Debug_Extension || SLT.Debug_Setup || SLT.Debug_Extension_Core)
		SLTDebugMsg("SexLab.HandleVersionUpdate: oldVersion(" + SLTRVersion + ") newVersion(" + newVersion + ")")
	EndIf
	If (SLT.FF_VersionUpdate_SexLab_Migrate_LOCATION_to_DEEPLOCATION)
		; version 128: migrated LOCATION filter to DEEPLOCATION
		int i = 0
		string[] updateKeys = sl_triggers_internal.GetTriggerKeys(SLTExtensionKey)
		while i < updateKeys.Length
			string _triggerFile = FN_T(updateKeys[i])
			
			int triggerVersion = JsonUtil.GetIntValue(_triggerFile, ATTR_MOD_VERSION)
			if (triggerVersion < 128)
				JsonUtil.SetIntValue(_triggerFile, ATTR_MOD_VERSION, GetModVersion())

				if (JsonUtil.HasIntValue(_triggerFile, ATTR_LOCATION))
					int ival = JsonUtil.GetIntValue(_triggerFile, ATTR_LOCATION)
					JsonUtil.UnsetIntValue(_triggerFile, ATTR_LOCATION)
					if ival > 0
						JsonUtil.SetIntValue(_triggerFile, ATTR_DEEPLOCATION, ival)
						SLTInfoMsg("SexLab.HandleVersionUpdate: updating triggerFile(" + _triggerFile + ") to migrate LOCATION filter to DEEPLOCATION")
					else
						SLTInfoMsg("SexLab.HandleVersionUpdate: updating triggerFile(" + _triggerFile + ") to migrate LOCATION filter to DEEPLOCATION; clearing due to value 0")
					endif
				endif

				JsonUtil.Save(_triggerFile)
			endif

			i += 1
		endwhile
	EndIf
EndFunction

bool Function CustomResolveScoped(sl_triggersCmd CmdPrimary, string scope, string token)
	if scope == "system"
		int skip = -1
		if token == "partner" || token == "partner1"
			skip = 1
		elseif token == "partner2"
			skip = 2
		elseif token == "partner3"
			skip = 3
		elseif token == "partner4"
			skip = 4
		elseif token == "is_available.sexlab"
			CmdPrimary.CustomResolveBoolResult = (IsEnabled && SexLabForm)
			return true
		endif

		if skip > 0
			skip -= 1
			
			sslThreadController thread = (SexLabForm as SexLabFramework).GetActorController(CmdPrimary.CmdTargetActor)
			if !thread
				CmdPrimary.CustomResolveFormResult = none
				return true
			endif

			int i = 0
			while i < thread.Positions.Length
				Actor other = thread.Positions[i]

				if other != CmdPrimary.CmdTargetActor
					if skip == 0
						if SLT.Debug_Extension_CustomResolveScoped
							SLTDebugMsg("sl_triggersExtensionSexLab.CustomResolveScoped: requested scope(" + scope + ") token(" + token + ") 0-based thread.Position[i](" + i + "): skip == 0; matched other(" + other + "): setting CmdPrimary.CustomResolveFormResult to (" + other + ") and CmdPrimary.CustomResolveResult to (" + other.GetFormID() + ")")
						endif
						CmdPrimary.CustomResolveFormResult = other
						return true
					else
						skip -= 1
					endif
				endif

				i += 1
			endwhile

			CmdPrimary.CustomResolveFormResult = none
			return true
		endif
	endif

	return false
EndFunction

;/
bool Function CustomResolveForm(sl_triggersCmd CmdPrimary, string token)
    if !self || !IsEnabled || !SexLabForm
        return false
    endif

    int skip = -1
    if "$system.partner" == token || "$system.partner1" == token ;|| "$partner" == token
        skip = 0
    elseif "$system.partner2" == token ;|| "$partner2" == token
        skip = 1
    elseif "$system.partner3" == token ;|| "$partner3" == token
        skip = 2
    elseif "$system.partner4" == token ;|| "$partner4" == token
        skip = 3
    else
        return false
    endif

    sslThreadController thread = (SexLabForm as SexLabFramework).GetActorController(CmdPrimary.CmdTargetActor)
    if !thread
		CmdPrimary.CustomResolveFormResult = none
		CmdPrimary.CustomResolveResult = ""
        return true
    endif

    int i = 0
    while i < thread.Positions.Length
        Actor other = thread.Positions[i]

        if other != CmdPrimary.CmdTargetActor
            if skip == 0
				CmdPrimary.CustomResolveFormResult = other
				CmdPrimary.CustomResolveResult = other.GetFormID()
                return true
            else
                skip -= 1
            endif
        endif

        i += 1
    endwhile

	CmdPrimary.CustomResolveFormResult = none
	CmdPrimary.CustomResolveResult = ""
    return true
EndFunction
/;

; EXTERNAL EVENT HANDLERS
Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLabForm
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
    int tid = _args as int
	
	HandleSexLabCheckEvents(tid, none, triggerKeys_Start)
EndEvent

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLabForm
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
    int tid = _args as int
    
	HandleSexLabCheckEvents(tid, none, triggerKeys_Orgasm)
EndEvent

Event OnSexLabEnd(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLabForm
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
    int tid = _args as int
    
	HandleSexLabCheckEvents(tid, none, triggerKeys_Stop)
EndEvent

Event OnSexLabOrgasmS(Form ActorRef, Int Thread)
	if !Self || !SexLabForm
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
    int tid = Thread
    
	HandleSexLabCheckEvents(tid, ActorRef as Actor, triggerKeys_Orgasm_S)
EndEvent

Function RefreshTriggerCache()
	triggerKeys_Start = PapyrusUtil.StringArray(0)
	triggerKeys_Orgasm = PapyrusUtil.StringArray(0)
	triggerKeys_Stop = PapyrusUtil.StringArray(0)
	triggerKeys_Orgasm_S = PapyrusUtil.StringArray(0)
	int i = 0
	while i < TriggerKeys.Length
		string _triggerFile = FN_T(TriggerKeys[i])

		If (SLT.FF_VersionUpdate_SexLab_Migrate_LOCATION_to_DEEPLOCATION)
			; version 128: migrated LOCATION filter to DEEPLOCATION
			int triggerVersion = JsonUtil.GetIntValue(_triggerFile, ATTR_MOD_VERSION)
			if (triggerVersion < 128)
				JsonUtil.SetIntValue(_triggerFile, ATTR_MOD_VERSION, GetModVersion())

				if (JsonUtil.HasIntValue(_triggerFile, ATTR_LOCATION))
					int ival = JsonUtil.GetIntValue(_triggerFile, ATTR_LOCATION)
					JsonUtil.UnsetIntValue(_triggerFile, ATTR_LOCATION)
					if ival > 0
						JsonUtil.SetIntValue(_triggerFile, ATTR_DEEPLOCATION, ival)
					endif
					SLTInfoMsg("SexLab.RefreshTriggerCache: updating triggerFile(" + _triggerFile + ") to migrate LOCATION filter to DEEPLOCATION")
				endif

				JsonUtil.Save(_triggerFile)
			endif
		EndIf

		if !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
			int eventCode = JsonUtil.GetIntValue(_triggerFile, ATTR_EVENT)
			if eventCode == EVENT_ID_START
				triggerKeys_Start = PapyrusUtil.PushString(triggerKeys_Start, TriggerKeys[i])
			elseif eventCode == EVENT_ID_ORGASM
				triggerKeys_Orgasm = PapyrusUtil.PushString(triggerKeys_Orgasm, TriggerKeys[i])
			elseif eventCode == EVENT_ID_STOP
				triggerKeys_Stop = PapyrusUtil.PushString(triggerKeys_Stop, TriggerKeys[i])
			elseif eventCode == EVENT_ID_ORGASM_SLSO
				triggerKeys_Orgasm_S = PapyrusUtil.PushString(triggerKeys_Orgasm_S, TriggerKeys[i])
			endif
		endif
		
		i += 1
	endwhile
EndFunction

Function UpdateSexLabStatus()
	SexLabAnimatingFaction = none
	SexLabForm = none
	
	SexLabForm = GetForm_SexLab_Framework()
	if SexLabForm
		SexLabAnimatingFaction = GetForm_SexLab_AnimatingFaction() as Faction
	endif
EndFunction

; selectively enables only events with triggers
Function RegisterEvents()
	UnregisterForModEvent(EVENT_SEXLAB_START)
	if IsEnabled && triggerKeys_Start.Length > 0 && SexLabForm
		SafeRegisterForModEvent_Quest(self, EVENT_SEXLAB_START, EVENT_SEXLAB_START_HANDLER)
	endif
	
	UnregisterForModEvent(EVENT_SEXLAB_END)
	if IsEnabled && triggerKeys_Stop.Length > 0 && SexLabForm
		SafeRegisterForModEvent_Quest(self, EVENT_SEXLAB_END, EVENT_SEXLAB_END_HANDLER)
	endif
	
	UnregisterForModEvent(EVENT_SEXLAB_ORGASM)
	if IsEnabled && triggerKeys_Orgasm.Length > 0 && SexLabForm
		SafeRegisterForModEvent_Quest(self, EVENT_SEXLAB_ORGASM, EVENT_SEXLAB_ORGASM_HANDLER)
	endif
    
	UnregisterForModEvent(EVENT_SEXLAB_ORGASM_SLSO)
	if IsEnabled && triggerKeys_Orgasm_S.Length > 0 && SexLabForm
		SafeRegisterForModEvent_Quest(self, EVENT_SEXLAB_ORGASM_SLSO, EVENT_SEXLAB_ORGASM_SLSO_HANDLER)
	endif
EndFunction


Function HandleSexLabCheckEvents(int tid, Actor specActor, string[] _eventTriggerKeys)
	sslThreadController thread = (SexLabForm as SexLabFramework).GetController(tid)
	int actorCount = thread.Positions.Length
	
	int i = 0
	string triggerKey
	string command
	string _triggerFile
	string value
	int    ival
	bool   doRun
	float chance

	bool playerWasInInterior = PlayerRef.IsInInterior()
	Keyword playerLocationKeyword = SLT.GetPlayerLocationKeyword()

	while i < _eventTriggerKeys.Length
		triggerKey = _eventTriggerKeys[i]
		_triggerFile = FN_T(triggerKey)

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)
			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		endif
		
		int    actorIdx = 0

		if doRun
			while actorIdx < actorCount
				Actor theSelf = thread.Positions[actorIdx]
				Actor theOther = none
				
				if actorCount > 1
					theOther = thread.Positions[ActorPos(actorIdx + 1, actorCount)]
				endIf
				
				if doRun
					;if eventId == 3 ; spec check for separate orgasm
						; no need for the eventId, if you use 'specActor' it will only operate for that
						; actor in the scene
						if specActor && theSelf != specActor
							doRun = false
						endIf
					;endIf
				endIf

				;/
				; no longer necessary as a) we isolate only SexLab events here 
				; and b) the only event specific check is right above us, go read the note
				if doRun
					ival = JsonUtil.GetStringValue(SettingsName, _makeSlotIdFromPrefix(slotNoPrefixList[i], 2)) as int
					if ival != eventId
						doRun = false
					endIf
				endIf
				/;
					
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
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_RACE)
					if ival != 0 ; 0 is Any
						if ival == 1 && actorRace(theSelf) != 2 ; should be humanoid
							doRun = false
						elseIf ival == 2 && actorRace(theSelf) != 4 ; should be creature
							doRun = false
						elseIf ival == 3 && actorRace(theSelf) != 3 ; should be undead
							doRun = false
						else
							;check other
							if actorCount <= 1 ; is solo, Partner is auto-false
								doRun = false
							else
								if ival == 4 && actorRace(theOther) != 2 ; should be humanoid
									doRun = false
								elseIf ival == 5 && actorRace(theOther) != 4 ; should be creature
									doRun = false
								elseIf ival == 6 && actorRace(theOther) != 3 ; should be undead
									doRun = false
								endIf
							endIf
						endIf
					endIf
				endIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_PLAYER)
					if ival != 0 ; 0 is Any
						if ival == 1 && actorRace(theSelf) != 1 ; should be player
							doRun = false
						elseIf ival == 2 && actorRace(theSelf) == 1 ; should be not-player
							doRun = false
						else
							; check other
							if actorCount <= 1
								doRun = false
							else
								if ival == 3 && actorRace(theOther) != 1 ; should be player
									doRun = false
								elseIf ival == 4 && actorRace(theOther) == 1 ; should be not-player
									doRun = false
								endIf
							endIf
						endIf
					endIf
				endIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_ROLE)
					if ival != 0 ; 0 is Any
						if ival == 1 && !thread.IsAggressor(theSelf) ; aggresor
							doRun = false
						elseIf ival == 2 && !thread.IsVictim(theSelf) ; victim
							doRun = false
						elseIf ival == 3 && thread.IsAggressive ; not
							doRun = false
						endIf
					endIf
				endIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_GENDER)
					if ival != 0 ; 0 is Any
						if ival == 1 && (SexLabForm as SexLabFramework).GetGender(theSelf) != 0
							doRun = false
						elseIf ival == 2 && (SexLabForm as SexLabFramework).GetGender(theSelf) != 1
							doRun = false
						endIf
					endIf
				endIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_TAG)
					if ival != 0 ; 0 is Any
						if ival == 1 && !thread.IsVaginal
							doRun = false
						elseIf ival == 2 && !thread.IsAnal
							doRun = false
						elseIf ival == 3 && !thread.IsOral
							doRun = false
						endIf
					endIf
				endIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_DAYTIME)
					if ival != 0 ; 0 is Any
						if ival == 1 && !dayTime()
							doRun = false
						elseIf ival == 2 && dayTime()
							doRun = false
						endIf
					endIf
				endIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_LOCATION)
					if ival != 0 ; 0 is Any
						if ival == 1 && !theSelf.IsInInterior()
							doRun = false
						elseIf ival == 2 && theSelf.IsInInterior()
							doRun = false
						endIf
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
							doRun = playerLocationKeyword == SLT.LocationKeywords[ival - 7]
						endif
					endif
				endIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_POSITION)
					if ival != 0 ; 0 is Any
						int _slposition = 0
						while doRun && _slposition < thread.Positions.Length
							if (_slposition + 1) > ival
								doRun = false
							else
								Actor slActor = thread.Positions[_slposition]
								; the assumption is that ival is 1-based and _slposition is 0-based
								if slActor == theSelf
									if (_slposition + 1) != ival
										doRun = false
									endif
								endif
							endif
							_slposition += 1
						endwhile
					endIf
				endIf
				
				if doRun ;do doRun
					command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
					string _instanceId
					if command
						RequestCommand(theSelf, command)
					endIf
					command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
					if command
						RequestCommand(theSelf, command)
					endIf
					command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
					if command
						RequestCommand(theSelf, command)
					endIf
				endIf
					
				actorIdx += 1
			endWhile
		endif
		i += 1
	endwhile
EndFunction
