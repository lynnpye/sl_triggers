scriptname sl_triggersExtensionSexLab extends sl_triggersExtension

import sl_triggersStatics

;SexLabFramework     Property SexLab						Auto Hidden
Form				Property SexLabForm					Auto Hidden
Faction	            Property SexLabAnimatingFaction 	Auto Hidden

int		EVENT_ID_START 						= 1
int		EVENT_ID_ORGASM						= 2
int		EVENT_ID_STOP						= 3
int		EVENT_ID_ORGASM_SLSO				= 4
int		EVENT_ID_STAGE_START				= 5
int		EVENT_ID_STAGE_END					= 6

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
string[]	triggerKeys_Orgasm_S
string[]	triggerKeys_Stage_Start
string[]	triggerKeys_Stage_End

bool Function IsMCMConfigurable()
	if SexLabForm != none
		return true
	endif
	
	SexLabForm = GetForm_SexLab_Framework()
	return SexLabForm != none
EndFunction

Event OnInit()
	if SLT.Debug_Extension || SLT.Debug_Extension_SexLab
		SLTDebugMsg("SexLab.OnInit")
	endif

	if !self
		return
	endif

	UpdateSexLabStatus()
	SLTInit()
	; REQUIRED CALL
	UnregisterForUpdate()
	RegisterForSingleUpdate(0.01)
EndEvent

Function DoPlayerLoadGame()
	if SLT.Debug_Extension || SLT.Debug_Extension_SexLab
		SLTDebugMsg("SexLab.DoPlayerLoadGame")
	endif
	SLTInit()
EndFunction

Event OnUpdate()
	if SLT.Debug_Extension || SLT.Debug_Extension_SexLab
		SLTDebugMsg("SexLab.OnUpdate")
	endif
	QueueUpdateLoop(60)
EndEvent

; SLTReady
; OPTIONAL
Function SLTReady()
	if SLT.Debug_Extension || SLT.Debug_Extension_SexLab
		SLTDebugMsg("SexLab.SLTReady")
	endif
	UpdateSexLabStatus()
	RefreshData()
EndFunction

Function RefreshData()
	if SLT.Debug_Extension || SLT.Debug_Extension_SexLab
		SLTDebugMsg("SexLab.RefreshData")
	endif
	RegisterEvents()
EndFunction

bool Function _slt_AdditionalRequirementsSatisfied()
	return SexLabForm != none
EndFunction

sslThreadController Function GetThreadForActor(Actor theActor)
    return (SexLabForm as SexLabFramework).GetActorController(theActor)
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
						SLTInfoMsg("SexLab.HandleVersionUpdate: updating triggerFile(" + _triggerFile + ") to migrate RACE filter Partner value to PARTNER_RACE; original RACE filter cleared")
					else
						SLTInfoMsg("SexLab.HandleVersionUpdate: updating triggerFile(" + _triggerFile + ") to migrate RACE filter Partner value to PARTNER_RACE; PARTNER_RACE already set, clearing conflicting RACE value")
					EndIf
				EndIf
			endif

			JsonUtil.Save(_triggerFile)
		endif
	EndIf
EndFunction

Function HandleVersionUpdate(int oldVersion, int newVersion)
	If (SLT.Debug_Extension || SLT.Debug_Setup || SLT.Debug_Extension_Core)
		SLTDebugMsg("SexLab.HandleVersionUpdate: oldVersion(" + SLTRVersion + ") newVersion(" + newVersion + ")")
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
							SLTDebugMsg("SexLab.CustomResolveScoped: requested scope(" + scope + ") token(" + token + ") 0-based thread.Position[i](" + i + "): skip == 0; matched other(" + other + "): setting CmdPrimary.CustomResolveFormResult to (" + other + ") and CmdPrimary.CustomResolveResult to (" + other.GetFormID() + ")")
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

; EXTERNAL EVENT HANDLERS
Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	If (SLT.Debug_Extension || SLT.Debug_Extension_SexLab)
		SLTDebugMsg("SexLab.SexLabStart: _eventName(" + _eventName + ") _args(" + _args + ") _argc(" + _argc + ") _sender(" + _sender + ")")
	EndIf

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
	If (SLT.Debug_Extension || SLT.Debug_Extension_SexLab)
		SLTDebugMsg("SexLab.SexLabOrgasm: _eventName(" + _eventName + ") _args(" + _args + ") _argc(" + _argc + ") _sender(" + _sender + ")")
	EndIf

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
	If (SLT.Debug_Extension || SLT.Debug_Extension_SexLab)
		SLTDebugMsg("SexLab.SexLabEnd: _eventName(" + _eventName + ") _args(" + _args + ") _argc(" + _argc + ") _sender(" + _sender + ")")
	EndIf

	if !Self || !SexLabForm
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
    int tid = _args as int
    
	HandleSexLabCheckEvents(tid, none, triggerKeys_Stop)
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int Thread)
	If (SLT.Debug_Extension || SLT.Debug_Extension_SexLab)
		SLTDebugMsg("SexLab.SexLabOrgasmSeparate: ActorRef(" + ActorRef + ") Thread(" + Thread + ")")
	EndIf

	if !Self || !SexLabForm
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
    int tid = Thread
    
	HandleSexLabCheckEvents(tid, ActorRef as Actor, triggerKeys_Orgasm_S)
EndEvent

Event OnStageStart(String _eventName, String _args, Float _argc, Form _sender)
	If (SLT.Debug_Extension || SLT.Debug_Extension_SexLab)
		SLTDebugMsg("SexLab.StageStart: _eventName(" + _eventName + ") _args(" + _args + ") _argc(" + _argc + ") _sender(" + _sender + ")")
	EndIf

	if !Self || !SexLabForm
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
    int tid = _args as int
    
	HandleSexLabCheckEvents(tid, none, triggerKeys_Stage_Start)
EndEvent

Event OnStageEnd(String _eventName, String _args, Float _argc, Form _sender)
	If (SLT.Debug_Extension || SLT.Debug_Extension_SexLab)
		SLTDebugMsg("SexLab.StageEnded: _eventName(" + _eventName + ") _args(" + _args + ") _argc(" + _argc + ") _sender(" + _sender + ")")
	EndIf

	if !Self || !SexLabForm
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
    int tid = _args as int
    
	HandleSexLabCheckEvents(tid, none, triggerKeys_Stage_End)
EndEvent

Function RefreshTriggerCache()
	if SLT.Debug_Extension || SLT.Debug_Extension_SexLab
		SLTDebugMsg("SexLab.RefreshTriggerCache")
	endif
	triggerKeys_Start = PapyrusUtil.StringArray(0)
	triggerKeys_Orgasm = PapyrusUtil.StringArray(0)
	triggerKeys_Stop = PapyrusUtil.StringArray(0)
	triggerKeys_Orgasm_S = PapyrusUtil.StringArray(0)
	triggerKeys_Stage_Start = PapyrusUtil.StringArray(0)
	triggerKeys_Stage_End = PapyrusUtil.StringArray(0)
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
			elseif eventCode == EVENT_ID_ORGASM_SLSO
				triggerKeys_Orgasm_S = PapyrusUtil.PushString(triggerKeys_Orgasm_S, TriggerKeys[i])
			elseif eventCode == EVENT_ID_STAGE_START
				triggerKeys_Stage_Start = PapyrusUtil.PushString(triggerKeys_Stage_Start, TriggerKeys[i])
			elseif eventCode == EVENT_ID_STAGE_END
				triggerKeys_Stage_End = PapyrusUtil.PushString(triggerKeys_Stage_End, TriggerKeys[i])
			else
				If (SLT.Debug_Extension_SexLab)
					SLTDebugMsg("SexLab.RefreshTriggerCache: _triggerFile(" + _triggerFile + ") has unknown eventCode(" + eventCode + "); skipping")
				EndIf
			endif
		else
			If (SLT.Debug_Extension_SexLab)
				SLTDebugMsg("SexLab.RefreshTriggerCache: _triggerFile(" + _triggerFile + ") has DELETED_ATTRIBUTE; skipping")
			EndIf
		endif
		
		i += 1
	endwhile
	
	If (SLT.Debug_Extension_SexLab)
		string inmsg
		int inside = 0
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
		inmsg += "===========\n\n"

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

		inmsg = "\n\n===========\ntriggerKeys_Orgasm_S(eparate):\n"
		inside = triggerKeys_Orgasm_S.Length
		while inside
			inside -= 1
			t_key = triggerKeys_Orgasm_S[inside]
			t_file = FN_T(t_key)
			inmsg += "key(" + t_key + ") file(" + t_file +")\n"
		endwhile

		inmsg = "\n\n===========\ntriggerKeys_Stage_Start:\n"
		inside = triggerKeys_Stage_Start.Length
		while inside
			inside -= 1
			t_key = triggerKeys_Stage_Start[inside]
			t_file = FN_T(t_key)
			inmsg += "key(" + t_key + ") file(" + t_file +")\n"
		endwhile

		inmsg = "\n\n===========\ntriggerKeys_Stage_End:\n"
		inside = triggerKeys_Stage_End.Length
		while inside
			inside -= 1
			t_key = triggerKeys_Stage_End[inside]
			t_file = FN_T(t_key)
			inmsg += "key(" + t_key + ") file(" + t_file +")\n"
		endwhile

		SLTDebugMsg(inmsg)
	EndIf
EndFunction

Function UpdateSexLabStatus()
	if SLT.Debug_Extension || SLT.Debug_Extension_SexLab
		SLTDebugMsg("SexLab.UpdateSexLabStatus")
	endif
	SexLabAnimatingFaction = none
	SexLabForm = none
	
	SexLabForm = GetForm_SexLab_Framework()
	if SexLabForm
		SexLabAnimatingFaction = GetForm_SexLab_AnimatingFaction() as Faction
	endif
EndFunction

; selectively enables only events with triggers
Function RegisterEvents()
	if SLT.Debug_Extension || SLT.Debug_Extension_SexLab
		SLTDebugMsg("SexLab.RegisterEvents")
	endif
	UnregisterForModEvent("AnimationStart")
	if IsEnabled && triggerKeys_Start.Length > 0 && SexLabForm
		SafeRegisterForModEvent_Quest(self, "AnimationStart", 		"OnSexLabStart")
	endif
	
	UnregisterForModEvent("AnimationEnd")
	if IsEnabled && triggerKeys_Stop.Length > 0 && SexLabForm
		SafeRegisterForModEvent_Quest(self, "AnimationEnd", 		"OnSexLabEnd")
	endif
	
	UnregisterForModEvent("OrgasmStart")
	if IsEnabled && triggerKeys_Orgasm.Length > 0 && SexLabForm
		SafeRegisterForModEvent_Quest(self, "OrgasmStart", 			"OnSexLabOrgasm")
	endif
    
	UnregisterForModEvent("SexLabOrgasmSeparate")
	if IsEnabled && triggerKeys_Orgasm_S.Length > 0 && SexLabForm
		SafeRegisterForModEvent_Quest(self, "SexLabOrgasmSeparate",	"OnSexLabOrgasmSeparate")
	endif

	UnregisterForModEvent("StageStart")
	if IsEnabled && triggerKeys_Stage_Start.Length > 0 && SexLabForm
		SafeRegisterForModEvent_Quest(self, "StageStart", 			"OnStageStart")
	endif

	UnregisterForModEvent("StageEnd")
	if IsEnabled && triggerKeys_Stage_End.Length > 0 && SexLabForm
		SafeRegisterForModEvent_Quest(self, "StageEnd", 			"OnStageEnd")
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
	
	int z = actorCount
	bool playerFound
	while z > 0
		z -= 1
		if thread.positions[z] == PlayerRef
			playerFound = true
			z = 0
		endif
	endwhile

	while i < _eventTriggerKeys.Length
		triggerKey = _eventTriggerKeys[i]
		_triggerFile = FN_T(triggerKey)

		If (SLT.Debug_Extension_SexLab)
			SLTDebugMsg("SexLab: checking trigger(" + triggerKey + ")")
		EndIf

		doRun = !JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())

		If (SLT.Debug_Extension_SexLab && !doRun)
			SLTDebugMsg("SexLab: doRun(" + doRun + ") due to DELETED")
		EndIf

		if doRun
			chance = JsonUtil.GetFloatValue(_triggerFile, ATTR_CHANCE, 100.0)
			doRun = chance >= 100.0 || chance >= Utility.RandomFloat(0.0, 100.0)

			If (SLT.Debug_Extension_SexLab && !doRun)
				SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_CHANCE")
			EndIf
		endif
		
		int    actorIdx = 0

		if doRun
			int otherAggressors
			int otherVictims
			int otherHumanoids
			int otherCreatures
			int otherUndead
			int otherMales
			int otherFemales
			int otherFuta
			int otherCreatureMale
			int otherCreatureFemale
			while actorIdx < actorCount
				Actor theSelf = thread.Positions[actorIdx]
				;/
				Actor theOther = none
				
				if actorCount > 1
					theOther = thread.Positions[ActorPos(actorIdx + 1, actorCount)]
				endIf
				/;
	
				otherAggressors = 0
				otherVictims = 0
				otherHumanoids = 0
				otherCreatures = 0
				otherUndead = 0
				otherMales = 0
				otherFemales = 0
				otherFuta = 0
				otherCreatureMale = 0
				otherCreatureFemale = 0

				z = actorCount
				while z > 0
					z -= 1
					if z != actorIdx
						Actor aPartner = thread.positions[z]
						if thread.IsAggressor(aPartner)
							If (SLT.Debug_Extension_SexLab)
								SLTDebugMsg("SexLab: for self(" + theSelf + "): aggressor(" + aPartner + ")")
							EndIf
							otherAggressors += 1
						endif
						if thread.IsVictim(aPartner)
							If (SLT.Debug_Extension_SexLab)
								SLTDebugMsg("SexLab: for self(" + theSelf + "): victim(" + aPartner + ")")
							EndIf
							otherVictims += 1
						endif
						int otherRaceType = ActorRaceType(aPartner)
						if (otherRaceType == 2 || otherRaceType == 1)
							If (SLT.Debug_Extension_SexLab)
								SLTDebugMsg("SexLab: for self(" + theSelf + "): humanoid(" + aPartner + ")")
							EndIf
							otherHumanoids += 1
						elseif otherRaceType == 3
							If (SLT.Debug_Extension_SexLab)
								SLTDebugMsg("SexLab: for self(" + theSelf + "): undead(" + aPartner + ")")
							EndIf
							otherUndead += 1
						elseif otherRaceType == 4
							If (SLT.Debug_Extension_SexLab)
								SLTDebugMsg("SexLab: for self(" + theSelf + "): creature(" + aPartner + ")")
							EndIf
							otherCreatures += 1
						endif
						int otherGender = (SexLabForm as SexLabFramework).GetGender(aPartner)
						if otherGender == 0
							If (SLT.Debug_Extension_SexLab)
								SLTDebugMsg("SexLab: for self(" + theSelf + "): male(" + aPartner + ")")
							EndIf
							otherMales += 1
						elseif otherGender == 1
							If (SLT.Debug_Extension_SexLab)
								SLTDebugMsg("SexLab: for self(" + theSelf + "): female(" + aPartner + ")")
							EndIf
							otherFemales += 1
						elseif otherGender == 2
							If (SLT.Debug_Extension_SexLab)
								SLTDebugMsg("SexLab: for self(" + theSelf + "): futa(" + aPartner + ")")
							EndIf
							otherFuta += 1
						elseif otherGender == 3
							If (SLT.Debug_Extension_SexLab)
								SLTDebugMsg("SexLab: for self(" + theSelf + "): creature male(" + aPartner + ")")
							EndIf
							otherCreatureMale += 1
						elseif otherGender == 4
							If (SLT.Debug_Extension_SexLab)
								SLTDebugMsg("SexLab: for self(" + theSelf + "): creature female(" + aPartner + ")")
							EndIf
							otherCreatureFemale += 1
						endif
					endif
				endwhile
				
				If (SLT.Debug_Extension_SexLab)
					;SLTDebugMsg("SexLab: actorCount(" + actorCount + ") / theSelf(" + theSelf + ") actorRaceType(theSelf)=>(" + ActorRaceType(theSelf) + ") / theOther(" + theOther + ") actorRaceType(theOther)=>(" + ActorRaceType(theOther) + ") / playerFound(" + playerFound + ")")
					SLTDebugMsg("SexLab: actorCount(" + actorCount + ") / theSelf(" + theSelf + ") actorRaceType(theSelf)=>(" + ActorRaceType(theSelf) + ") / playerFound(" + playerFound + ") / otherAggressors(" + otherAggressors + ") / otherVictims(" + otherVictims + ") / otherHumanoids(" + otherHumanoids + ") / otherCreatures(" + otherCreatures + ") / otherUndead(" + otherUndead + ") / otherMales(" + otherMales + ") / otherFemales(" + otherFemales + ") / otherFuta(" + otherFuta + ") / otherCreatureMale(" + otherCreatureMale + ") / otherCreatureFemale(" + otherCreatureFemale + ")")
				EndIf

				doRun = true
				
				if doRun
					;if eventId == 3 ; spec check for separate orgasm
						; no need for the eventId, if you use 'specActor' it will only operate for that
						; actor in the scene
						if specActor && theSelf != specActor
							doRun = false

							If (SLT.Debug_Extension_SexLab && !doRun)
								SLTDebugMsg("SexLab: doRun(" + doRun + ") due to specActor")
							EndIf
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

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_IS_ARMED")
						EndIf
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

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_IS_CLOTHED")
						EndIf
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

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_IS_WEAPON_DRAWN")
						EndIf
					endif
				endif
				
				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_RACE)
					if ival != 0 ; 0 is Any
						int actor_race_type = ActorRaceType(theSelf)
						if ival == 1 && (actor_race_type != 2 && actor_race_type != 1) ; should be humanoid
							doRun = false
						elseIf ival == 2 && actor_race_type != 4 ; should be creature
							doRun = false
						elseIf ival == 3 && actor_race_type != 3 ; should be undead
							doRun = false
							;/
						else
							;check other
							if actorCount <= 1 ; is solo, Partner is auto-false
								doRun = false
							else
								if ival == 4 && otherHumanoids == 0 ; should be humanoid
									doRun = false
								elseIf ival == 5 && otherCreatures == 0 ; should be creature
									doRun = false
								elseIf ival == 6 && otherUndead == 0 ; should be undead
									doRun = false
								endIf
							endIf
							/;
						endIf

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_RACE")
						EndIf
					endIf
				endIf
				
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

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_PARTNER_RACE")
						EndIf
					endIf
				endIf

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
								if ival == 3 && (!playerFound || ActorRaceType(theSelf) == 1) ; partner should be player
									doRun = false
								elseIf ival == 4 && playerFound ; partner should be not-player
									doRun = false
								endIf
							endIf
						endIf

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_PLAYER")
						EndIf
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

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_ROLE")
						EndIf
					endIf
				endIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_PARTNER_ROLE)
					if ival != 0 ; 0 is Any
						if ival == 1 && otherAggressors == 0 ; aggresor
							doRun = false
						elseIf ival == 2 && otherVictims == 0 ; victim
							doRun = false
						elseIf ival == 3 && thread.IsAggressive ; not
							doRun = false
						endIf

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_PARTNER_ROLE")
						EndIf
					endIf
				endIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_GENDER)
					if ival != 0 ; 0 is Any
						if (ival - 1) != (SexLabForm as SexLabFramework).GetGender(theSelf)
							doRun = false
						endif
						;/
						if ival == 1 && (SexLabForm as SexLabFramework).GetGender(theSelf) != 0
							doRun = false
						elseIf ival == 2 && (SexLabForm as SexLabFramework).GetGender(theSelf) != 1
							doRun = false
						endIf
						/;

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_GENDER")
						EndIf
					endIf
				endIf

				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_PARTNER_GENDER)
					if ival != 0 ; 0 is Any
						if ival == 1 && otherMales == 0
							doRun = false
						elseIf ival == 2 && otherFemales == 0
							doRun = false
						elseIf ival == 3 && otherFuta == 0
							doRun = false
						elseIf ival == 4 && otherCreatureMale == 0
							doRun = false
						elseIf ival == 5 && otherCreatureFemale == 0
							doRun = false
						endIf

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_PARTNER_GENDER")
						EndIf
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

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_TAG")
						EndIf
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

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_DAYTIME")
						EndIf
					endIf
				endIf

				;/
				if doRun
					ival = JsonUtil.GetIntValue(_triggerFile, ATTR_LOCATION)
					if ival != 0 ; 0 is Any
						if ival == 1 && !theSelf.IsInInterior()
							doRun = false
						elseIf ival == 2 && theSelf.IsInInterior()
							doRun = false
						endIf

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_LOCATION")
						EndIf
					endIf
				endIf
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

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_DEEPLOCATION")
						EndIf
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

						If (SLT.Debug_Extension_SexLab && !doRun)
							SLTDebugMsg("SexLab: doRun(" + doRun + ") due to ATTR_POSITION")
						EndIf
					endIf
				endIf
				
				if doRun ;do doRun
					If (SLT.Debug_Extension_SexLab)
						SLTDebugMsg("SexLab: doRun(" + doRun + ") running scripts")
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
		endif
		i += 1
	endwhile
EndFunction
