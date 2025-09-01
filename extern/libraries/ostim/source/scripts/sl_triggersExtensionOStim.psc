scriptname sl_triggersExtensionOStim extends sl_triggersExtension

import sl_triggersStatics

Form				Property OStimForm					Auto Hidden

int		EVENT_ID_START 						= 1
int		EVENT_ID_ORGASM						= 2
int		EVENT_ID_STOP						= 3

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
string ATTR_DO_4							= "do_4"
string ATTR_DEEPLOCATION					= "deeplocation"
string ATTR_IS_ARMED						= "is_armed"
string ATTR_IS_CLOTHED						= "is_clothed"
string ATTR_IS_WEAPON_DRAWN					= "is_weapon_drawn"
string ATTR_PARTNER_RACE					= "partner_race"
string ATTR_PARTNER_ROLE					= "partner_role"
string ATTR_PARTNER_GENDER					= "partner_gender"


string[]	triggerKeys_Start
string[]	triggerKeys_Orgasm
string[]	triggerKeys_Stop

string[]	actions_vaginal
string[]	actions_anal
string[]	actions_oral

bool Function IsMCMConfigurable()
	if OStimForm != none
		return true
	endif
	
	OStimForm = GetForm_OStim_Integration_Main()
	return OStimForm != none
EndFunction

Event OnInit()
	If (SLT.Debug_Extension || SLT.Debug_Extension_OStim)
		SLTDebugMsg("OStim.OnInit")
	EndIf

	if !self
		return
	endif

	UpdateActionLists()

	UpdateOStimStatus()
	SLTInit()

	; REQUIRED CALL
	UnregisterForUpdate()
	RegisterForSingleUpdate(0.01)
EndEvent

string Function FN_OStimConfigurationJSON() global
	return "../sl_triggers/ostim-configuration.json"
EndFunction

Function UpdateActionLists()
	actions_vaginal = JsonUtil.StringListToArray(FN_OStimConfigurationJSON(), "actions_vaginal")
	actions_anal = JsonUtil.StringListToArray(FN_OStimConfigurationJSON(), "actions_anal")
	actions_oral = JsonUtil.StringListToArray(FN_OStimConfigurationJSON(), "actions_oral")

	if actions_vaginal.Length < 1
		SLTErrMsg("OStim.UpdateActionLists: actions_vaginal.Length == 0; this is wrong, correct 'ostim-configuration.json' or reinstall")
	endif
	if actions_anal.Length < 1
		SLTErrMsg("OStim.UpdateActionLists: actions_anal.Length == 0; this is wrong, correct 'ostim-configuration.json' or reinstall")
	endif
	if actions_oral.Length < 1
		SLTErrMsg("OStim.UpdateActionLists: actions_oral.Length == 0; this is wrong, correct 'ostim-configuration.json' or reinstall")
	endif
EndFunction

bool Function SceneHasVaginalAction(string sceneId)
	int i = actions_vaginal.Length
	while i
		i -= 1
		if OMetadata.FindAction(sceneId, actions_vaginal[i]) != -1
			return true
		endif
	endwhile
	return false
EndFunction

bool Function SceneHasAnalAction(string sceneId)
	int i = actions_anal.Length
	while i
		i -= 1
		if OMetadata.FindAction(sceneId, actions_anal[i]) != -1
			return true
		endif
	endwhile
	return false
EndFunction

bool Function SceneHasOralAction(string sceneId)
	int i = actions_oral.Length
	while i
		i -= 1
		if OMetadata.FindAction(sceneId, actions_oral[i]) != -1
			return true
		endif
	endwhile
	return false
EndFunction

Function DoPlayerLoadGame()
	If (SLT.Debug_Extension || SLT.Debug_Extension_OStim)
		SLTDebugMsg("OStim.DoPlayerLoadGame")
	EndIf

	UpdateActionLists()

	SLTInit()
EndFunction

Event OnUpdate()
	If (SLT.Debug_Extension || SLT.Debug_Extension_OStim)
		SLTDebugMsg("OStim.OnUpdate")
	EndIf
	QueueUpdateLoop(60)
EndEvent

; SLTReady
; OPTIONAL
Function SLTReady()
	If (SLT.Debug_Extension || SLT.Debug_Extension_OStim)
		SLTDebugMsg("OStim.SLTReady")
	EndIf
	UpdateOStimStatus()
	RefreshData()
EndFunction

Function RefreshData()
	If (SLT.Debug_Extension || SLT.Debug_Extension_OStim)
		SLTDebugMsg("OStim.RefreshData")
	EndIf
	RegisterEvents()
EndFunction

bool Function _slt_AdditionalRequirementsSatisfied()
	return OStimForm != none
EndFunction

Function VersionUpdateTriggerFile(string _triggerFile)
	If (SLT.FF_VersionUpdate_Remove_Race_Partner_Types)
		; version 0.901 removed RACE values for "Partner Humanoid", "Partner Creature", or "Partner Undead"
		; PARTNER_RACE exists
		int triggerVersion = JsonUtil.GetIntValue(_triggerFile, ATTR_MOD_VERSION)
		if (triggerVersion < 901)
			JsonUtil.SetIntValue(_triggerFile, ATTR_MOD_VERSION, GetModVersion())

			if (JsonUtil.HasIntValue(_triggerFile, ATTR_RACE))
				int ival = JsonUtil.GetIntValue(_triggerFile, ATTR_RACE)

				If (ival > 3)
					JsonUtil.UnsetIntValue(_triggerFile, ATTR_RACE)
					If (!JsonUtil.HasIntValue(_triggerFile, ATTR_PARTNER_RACE))
						; only replace it if it wasn't already set
						JsonUtil.SetIntValue(_triggerFile, ATTR_PARTNER_RACE, ival - 3)
						SLTInfoMsg("OStim.HandleVersionUpdate: updating triggerFile(" + _triggerFile + ") to migrate RACE filter Partner value to PARTNER_RACE; original RACE filter cleared")
					else
						SLTInfoMsg("OStim.HandleVersionUpdate: updating triggerFile(" + _triggerFile + ") to migrate RACE filter Partner value to PARTNER_RACE; PARTNER_RACE already set, clearing conflicting RACE value")
					EndIf
				EndIf
			endif

			JsonUtil.Save(_triggerFile)
		endif
	EndIf
EndFunction

Function HandleVersionUpdate(int oldVersion, int newVersion)
	If (SLT.Debug_Extension || SLT.Debug_Setup || SLT.Debug_Extension_Core)
		SLTDebugMsg("OStim.HandleVersionUpdate: oldVersion(" + SLTRVersion + ") newVersion(" + newVersion + ")")
	EndIf
	int i = 0
	string[] updateKeys = sl_triggers_internal.GetTriggerKeys(SLTExtensionKey)
	while i < updateKeys.Length
		string _triggerFile = FN_T(updateKeys[i])

		VersionUpdateTriggerFile(_triggerFile)

		i += 1
	endwhile
EndFunction

bool Function CustomResolveScoped(sl_triggersCmd CmdPrimary, string scope, string token)
	if scope == "system"
		int skip = -1
		if token == "ostim.partner" || token == "ostim.partner1"
			skip = 1
		elseif token == "ostim.partner2"
			skip = 2
		elseif token == "ostim.partner3"
			skip = 3
		elseif token == "ostim.partner4"
			skip = 4
		elseif token == "is_available.ostim"
			CmdPrimary.CustomResolveBoolResult = (IsEnabled && OStimForm)
			return true
		endif

		if skip > 0
            int actorCount = 0

            ; need to find the threadid
            int tid = OActor.GetSceneID(CmdPrimary.CmdTargetActor)

            If (tid < 0)
                SLTWarnMsg("OStim.CustomResolveScoped: requested partner, but unable to resolve OStim ThreadID for actor (" + CmdPrimary.CmdTargetActor + ")")
                return false
            EndIf

            Actor[] threadActors = OThread.GetActors(tid)
            actorCount = threadActors.Length
            
			skip -= 1

			int i = 0
			while i < actorCount
				Actor other = threadActors[i]

				if other != CmdPrimary.CmdTargetActor
					if skip == 0
						if SLT.Debug_Extension_CustomResolveScoped
							SLTDebugMsg("OStim.CustomResolveScoped: requested scope(" + scope + ") token(" + token + ") 0-based thread.Position[i](" + i + "): skip == 0; matched other(" + other + "): setting CmdPrimary.CustomResolveFormResult to (" + other + ") and CmdPrimary.CustomResolveResult to (" + other.GetFormID() + ")")
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

Function RefreshTriggerCache()
	If (SLT.Debug_Extension || SLT.Debug_Extension_OStim)
		SLTDebugMsg("OStim.RefreshTriggerCache")
	EndIf
	triggerKeys_Start = PapyrusUtil.StringArray(0)
	triggerKeys_Orgasm = PapyrusUtil.StringArray(0)
	triggerKeys_Stop = PapyrusUtil.StringArray(0)
	int i = 0
	while i < TriggerKeys.Length
		string _triggerFile = FN_T(TriggerKeys[i])

		VersionUpdateTriggerFile(_triggerFile)

		if !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
			int eventCode = JsonUtil.GetIntValue(_triggerFile, ATTR_EVENT)
			if eventCode == EVENT_ID_START
				triggerKeys_Start = PapyrusUtil.PushString(triggerKeys_Start, TriggerKeys[i])
			elseif eventCode == EVENT_ID_ORGASM
				triggerKeys_Orgasm = PapyrusUtil.PushString(triggerKeys_Orgasm, TriggerKeys[i])
			elseif eventCode == EVENT_ID_STOP
				triggerKeys_Stop = PapyrusUtil.PushString(triggerKeys_Stop, TriggerKeys[i])
			else
				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim.RefreshTriggerCache: _triggerFile(" + _triggerFile + ") has unknown eventCode(" + eventCode + "); skipping")
				EndIf
			endif
		else
			If (SLT.Debug_Extension_OStim)
				SLTDebugMsg("OStim.RefreshTriggerCache: _triggerFile(" + _triggerFile + ") has DELETED_ATTRIBUTE; skipping")
			EndIf
		endif
		
		i += 1
	endwhile
	
	If (SLT.Debug_Extension_OStim)
		string inmsg
		int inside
		string t_key
		string t_file

		inmsg = "\n\n===========\ntriggerKeys_Start:\n"
		inside = triggerKeys_Start.Length
		while inside
			inside -= 1
			t_key = triggerKeys_Start[inside]
			t_file = FN_T(t_key)
			inmsg += "key(" + t_key + ") file(" + t_file +")\n"
		endwhile

		inmsg = "\n\n===========\ntriggerKeys_Orgasm:\n"
		inside = triggerKeys_Orgasm.Length
		while inside
			inside -= 1
			t_key = triggerKeys_Orgasm[inside]
			t_file = FN_T(t_key)
			inmsg += "key(" + t_key + ") file(" + t_file +")\n"
		endwhile

		inmsg = "\n\n===========\ntriggerKeys_Stop:\n"
		inside = triggerKeys_Stop.Length
		while inside
			inside -= 1
			t_key = triggerKeys_Stop[inside]
			t_file = FN_T(t_key)
			inmsg += "key(" + t_key + ") file(" + t_file +")\n"
		endwhile

		inmsg += "===========\n\n"
		SLTDebugMsg(inmsg)
	EndIf
EndFunction

Function UpdateOStimStatus()
	OStimForm = GetForm_OStim_Integration_Main()
EndFunction

; selectively enables only events with triggers
Function RegisterEvents()
	If (SLT.Debug_Extension || SLT.Debug_Extension_OStim)
		SLTDebugMsg("OStim.RegisterEvents")
	EndIf
	UnregisterForModEvent("ostim_thread_start")
	if IsEnabled && triggerKeys_Start.Length > 0 && OStimForm
		SafeRegisterForModEvent_Quest(self, "ostim_thread_start", "OnSexStart")
	endif
	
	UnregisterForModEvent("ostim_thread_end")
	if IsEnabled && triggerKeys_Stop.Length > 0 && OStimForm
		SafeRegisterForModEvent_Quest(self, "ostim_thread_end", "OnSexEnd")
	endif
	
	UnregisterForModEvent("ostim_actor_orgasm")
	if IsEnabled && triggerKeys_Orgasm.Length > 0 && OStimForm
		SafeRegisterForModEvent_Quest(self, "ostim_actor_orgasm", "OnOrgasm")
	endif
EndFunction

; EXTERNAL EVENT HANDLERS
Event OnSexStart(String _eventName, String _args, Float threadID, Form _sender)
	If (SLT.Debug_Extension || SLT.Debug_Extension_OStim)
		SLTDebugMsg("OStim.OnSexStart: eventName(" + _eventName + ") args(" + _args + ") threadID(" + threadID + ") sender(" + _sender + ")")
	EndIf

	if !Self || !OStimForm
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
	HandleCheckEvents(threadID as int, none, triggerKeys_Start, OThread.GetActors(threadID as int))
EndEvent

Event OnOrgasm(String _eventName, String sceneID, Float threadID, Form _sender)
	If (SLT.Debug_Extension || SLT.Debug_Extension_OStim)
		SLTDebugMsg("OStim.OnOrgasm: eventName(" + _eventName + ") sceneID(" + sceneID + ") threadID(" + threadID + ") sender(" + _sender + ")")
	EndIf

	if !Self || !OStimForm
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
	HandleCheckEvents(threadID as int, _sender as Actor, triggerKeys_Orgasm, OThread.GetActors(threadID as int))
EndEvent

Event OnSexEnd(String _eventName, String actorJSON, Float threadID, Form _sender)
	If (SLT.Debug_Extension || SLT.Debug_Extension_OStim)
		SLTDebugMsg("OStim.OnSexEnd: eventName(" + _eventName + ") actorJSON(" + actorJSON + ") threadID(" + threadID + ") sender(" + _sender + ")")
	EndIf

	if !Self || !OStimForm
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
	HandleCheckEvents(threadID as int, none, triggerKeys_Stop, OJSON.GetActors(actorJSON))
EndEvent

Function HandleCheckEvents(int tid, Actor specActor, string[] _eventTriggerKeys, Actor[] threadActors)
    OSexIntegrationMain ostim = OStimForm as OSexIntegrationMain
    If (!ostim)
        SLTWarnMsg("OStim.HandleCheckEvents: unable to obtain OSexIntegrationMain; check your OStim installation")
        return
    EndIf

    int actorCount = 0

	if !threadActors.Length
		SLTErrMsg("OStim.HandleCheckEvents: threadActors.Length is zero; returning")
		return
	endif

	actorCount = threadActors.Length
    string sceneId = OThread.GetScene(tid)

	If (SLT.Debug_Extension_OStim)
		SLTDebugMsg("\n====\n"\
		+ "tid(" + tid + ") specActor(" + specActor + ") threadActors.Length(" + threadActors.Length + ") actorCount(" + actorCount + ") sceneId(" + sceneId + ")\n" \
		+ "EndNPCSceneOnOrgasm (" + ostim.EndNPCSceneOnOrgasm as bool + ")\n" \
		+ "EndOnPlayerOrgasm (" + ostim.EndOnPlayerOrgasm as bool + ")\n" \
		+ "EndOnMaleOrgasm (" + ostim.EndOnMaleOrgasm as bool + ")\n" \
		+ "EndOnFemaleOrgasm (" + ostim.EndOnFemaleOrgasm as bool + ")\n" \
		+ "EndOnAllOrgasm (" + ostim.EndOnAllOrgasm as bool + ")\n" \
		+ "\n===="\
		)
	EndIf
	
	int i = 0
	string triggerKey
	string command
	string _triggerFile
	string value
	int    ival
	bool   doRun
	float chance
    int     idx_Self
    int     idx_Other

	bool playerWasInInterior = PlayerRef.IsInInterior()
	Keyword playerLocationKeyword = SLT.GetPlayerLocationKeyword()
	
	int z = actorCount
	bool playerFound
	while z > 0
		z -= 1
		if threadActors[z] == PlayerRef
			playerFound = true
			z = 0
		endif
	endwhile

	while i < _eventTriggerKeys.Length
		triggerKey = _eventTriggerKeys[i]
		_triggerFile = FN_T(triggerKey)

		If (SLT.Debug_Extension_OStim)
			SLTDebugMsg("OStim: checking trigger(" + triggerKey + ")")
		EndIf

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		If (SLT.Debug_Extension_OStim)
			SLTDebugMsg("OStim: doRun(" + doRun + ") after DELETED")
		EndIf

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)
			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)
		endif

		If (SLT.Debug_Extension_OStim)
			SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_CHANCE")
		EndIf
		
		int    actorIdx = 0

		if doRun
			If (SLT.Debug_Extension_OStim)
				SLTDebugMsg("OStim: starting actor loop; actorCount(" + actorCount + ")")
			EndIf

			while actorIdx < actorCount
				Actor theSelf = threadActors[actorIdx]
                idx_Self = actorIdx

				;/
				Actor theOther = none
				
				if actorCount > 1
                    idx_Other = ActorPos(actorIdx + 1, actorCount)
					theOther = threadActors[idx_Other]
				endIf
				/;
	
				z = actorCount
				bool otherAggressors
				bool otherVictims
				int otherHumanoids
				int otherCreatures
				int otherUndead
				int otherMales
				int otherFemales
				bool hasDominance
				while z > 0
					z -= 1
					if theSelf != threadActors[z]
						Actor aPartner = threadActors[z]
						if !otherAggressors && OMetadata.HasActorTag(sceneId, z, "dominant")
							otherAggressors = true
						endif
						if !otherVictims && !OMetadata.HasActorTag(sceneId, z, "dominant")
							otherVictims = true
						endif
						int otherRaceType = ActorRaceType(aPartner)
						if otherRaceType == 2
							otherHumanoids += 1
						elseif otherRaceType == 3
							otherUndead += 1
						elseif otherRaceType == 4
							otherCreatures += 1
						endif
						if OStim.IsFemale(aPartner)
							otherFemales += 1
						else
							otherMales += 1
						endif
					endif
				endwhile
				if !otherAggressors && otherVictims
					otherVictims = false ; no aggressors => no victims
				endif
				
				If (SLT.Debug_Extension_OStim)
					;SLTDebugMsg("OStim: actorCount(" + actorCount + ") / theSelf(" + theSelf + ") actorRaceType(theSelf)=>(" + ActorRaceType(theSelf) + ") / theOther(" + theOther + ") actorRaceType(theOther)=>(" + ActorRaceType(theOther) + ")")
					SLTDebugMsg("OStim: actorCount(" + actorCount + ") / theSelf(" + theSelf + ") actorRaceType(theSelf)=>(" + ActorRaceType(theSelf) + ") / playerFound(" + playerFound + ") / otherAggressors(" + otherAggressors + ") / otherVictims(" + otherVictims + ") / otherHumanoids(" + otherHumanoids + ") / otherCreatures(" + otherCreatures + ") / otherUndead(" + otherUndead + ") / otherMales(" + otherMales + ") / otherFemales(" + otherFemales + ")")
				EndIf

				doRun = true
				
				if doRun
					;if eventId == 3 ; spec check for separate orgasm
						; no need for the eventId, if you use 'specActor' it will only operate for that
						; actor in the scene
						if specActor && theSelf != specActor
							doRun = false
						endIf
					;endIf
				endIf

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after specActor")
				EndIf

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

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_IS_ARMED")
				EndIf

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

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_IS_CLOTHED")
				EndIf

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

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_IS_WEAPON_DRAWN")
				EndIf
				
				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_RACE)
					if ival != 0 ; 0 is Any
						if ival == 1 && ActorRaceType(theSelf) != 2 ; should be humanoid
							doRun = false
						elseIf ival == 2 && ActorRaceType(theSelf) != 4 ; should be creature
							doRun = false
						elseIf ival == 3 && ActorRaceType(theSelf) != 3 ; should be undead
							doRun = false
							;/
						else
							;check other
							if actorCount <= 1 ; is solo, Partner is auto-false
								doRun = false
							else
								if ival == 4 && ActorRaceType(theOther) != 2 ; should be humanoid
									doRun = false
								elseIf ival == 5 && ActorRaceType(theOther) != 4 ; should be creature
									doRun = false
								elseIf ival == 6 && ActorRaceType(theOther) != 3 ; should be undead
									doRun = false
								endIf
							endIf
							/;
						endIf
					endIf
				endIf

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_RACE")
				EndIf
				
				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_PARTNER_RACE)
					if ival != 0 ; 0 is Any
						if ival == 1 && otherHumanoids == 0 ; should be humanoid
							doRun = false
						elseIf ival == 2 && otherCreatures == 0 ; should be creature
							doRun = false
						elseIf ival == 3 && otherUndead == 0 ; should be undead
							doRun = false
						endIf
					endIf
				endIf

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_PARTNER_RACE")
				EndIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_PLAYER)

					if ival != 0 ; 0 is Any
						if ival == 1 && ActorRaceType(theSelf) != 1 ; should be player
							doRun = false
						elseIf ival == 2 && ActorRaceType(theSelf) == 1 ; should be not-player
							doRun = false
						else
							; check other
							if actorCount <= 1
								doRun = false
							else
								if ival == 3 &&  (!playerFound || ActorRaceType(theSelf) == 1) ; should be player
									doRun = false
								elseIf ival == 4 && playerFound ; should be not-player
									doRun = false
								endIf
							endIf
						endIf
					endIf
				endIf

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_PLAYER")
				EndIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_ROLE)
					if ival != 0 ; 0 is Any
						if ival == 1 && !OMetadata.HasActorTag(sceneId, idx_Self, "dominant") ; aggresor
							doRun = false
						elseIf ival == 2 && (!hasDominance || OMetadata.HasActorTag(sceneId, idx_Self, "dominant")) ; victim
							doRun = false
						elseIf ival == 3 && !hasDominance
							doRun = false
						endIf
					endIf
				endIf

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_ROLE")
				EndIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_PARTNER_ROLE)
					if ival != 0 ; 0 is Any
						if ival == 1 && !otherAggressors ; aggresor
							doRun = false
						elseIf ival == 2 && !otherVictims
							doRun = false
						elseIf ival == 3 && hasDominance
							doRun = false
						endIf
					endIf
				endIf

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_PARTNER_ROLE")
				EndIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_GENDER)
					if ival != 0 ; 0 is Any
						if ival == 1 && ostim.IsFemale(theSelf)
							doRun = false
						elseIf ival == 2 && !ostim.IsFemale(theSelf)
							doRun = false
						endIf
					endIf
				endIf

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_GENDER")
				EndIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_PARTNER_GENDER)
					if ival != 0 ; 0 is Any
						if ival == 1 && otherMales == 0
							doRun = false
						elseIf ival == 2 && !otherFemales == 0
							doRun = false
						endIf
					endIf
				endIf

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_PARTNER_GENDER")
				EndIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_TAG)
					if ival != 0 ; 0 is Any
						if ival == 1 && !SceneHasVaginalAction(sceneId)
							doRun = false
						elseIf ival == 2 && !SceneHasAnalAction(sceneId)
							doRun = false
						elseIf ival == 3 && !SceneHasOralAction(sceneId)
							doRun = false
						endIf
					endIf
				endIf

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_TAG")
				EndIf

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

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_DAYTIME")
				EndIf

				;/
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

				If (SLT.Debug_Extension_OStim)
					SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_LOCATION")
				EndIf
				/;

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

						If (SLT.Debug_Extension_OStim && !doRun)
							SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_DEEPLOCATION")
						EndIf
					endif
				endIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_POSITION)
					if ival != 0 ; 0 is Any
						If (idx_Self != (ival - 1))
                            doRun = false
                        EndIf

						If (SLT.Debug_Extension_OStim && !doRun)
							SLTDebugMsg("OStim: doRun(" + doRun + ") after ATTR_POSITION")
						EndIf
					endIf
				endIf
				
				if doRun ;do doRun
					If (SLT.Debug_Extension_OStim)
						SLTDebugMsg("OStim: doRun(" + doRun + ") running scripts")
					EndIf

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
					command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_4)
					if command
						RequestCommand(theSelf, command)
					endIf
				endIf
					
				actorIdx += 1
			endWhile
		else
			If (SLT.Debug_Extension_OStim)
				SLTDebugMsg("OStim: doRun(" + doRun + ") negating actor loop and script execution")
			EndIf
		endif
		i += 1
	endwhile
EndFunction
