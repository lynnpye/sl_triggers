scriptname sl_triggersExtensionSexLab extends sl_triggersExtension

import sl_triggersStatics
import sl_triggersHeap
import sl_triggersFile


string EVENT_SEXLAB_START				= "AnimationStart"
string EVENT_SEXLAB_END					= "AnimationEnd"
string EVENT_SEXLAB_ORGASM				= "OrgasmStart"
string EVENT_SEXLAB_ORGASM_SLSO			= "SexLabOrgasmSeparate"
string EVENT_SEXLAB_START_HANDLER		= "OnSexLabStart"
string EVENT_SEXLAB_END_HANDLER			= "OnSexLabEnd"
string EVENT_SEXLAB_ORGASM_HANDLER		= "OnSexLabOrgasm"
string EVENT_SEXLAB_ORGASM_SLSO_HANDLER	= "OnSexLabOrgasmS"


SexLabFramework     Property SexLab						Auto Hidden
Faction	            Property SexLabAnimatingFaction 	Auto Hidden


string[]	triggerKeys_Start
string[]	triggerKeys_Orgasm
string[]	triggerKeys_Stop
string[]	triggerKeys_Orgasm_S


string	EVENT_ID_START 			= "1"
string	EVENT_ID_ORGASM			= "2"
string	EVENT_ID_STOP			= "3"
string	EVENT_ID_ORGASM_SLSO	= "4"
string	ATTR_EVENT				= "event"
string	ATTR_CHANCE				= "chance"
string	ATTR_RACE				= "race"
string	ATTR_ROLE				= "role"
string	ATTR_PLAYER				= "player"
string	ATTR_GENDER				= "gender"
string	ATTR_TAG				= "tag"
string	ATTR_DAYTIME			= "daytime"
string	ATTR_LOCATION			= "location"
string	ATTR_POSITION			= "position"
string	ATTR_DO_1				= "do_1"
string	ATTR_DO_2				= "do_2"
string	ATTR_DO_3				= "do_3"

Event OnInit()
	if !self
		return
	endif
	DebMsg("SexLab.OnInit")
	SLTInit()
EndEvent

Function SLTReady()
	DebMsg("SexLab.SLTReady")
	UpdateSexLabStatus()
	RefreshData()
EndFunction

Function RefreshData()
	RefreshTriggerCache()
	RegisterEvents()
EndFunction

; configuration was updated mid-game
Event OnSLTSettingsUpdated(string eventName, string strArg, float numArg, Form sender)
	if !self
		return
	endif
	RefreshData()
EndEvent

Function PopulateMCM()
	if !self
		return
	endif
	DebMsg("SexLab.PopulateMCM")
	string[] triggerIfEventNames	= PapyrusUtil.StringArray(5)
	triggerIfEventNames[0]			= "- Select an Event -"
	triggerIfEventNames[1]			= "Begin"
	triggerIfEventNames[2]			= "Orgasm"
	triggerIfEventNames[3]			= "End"
	triggerIfEventNames[4]			= "Orgasm(SLSO)"
	DescribeMenuAttribute(ATTR_EVENT, PTYPE_INT(), "Event:", 0, triggerIfEventNames)
	SetHighlightText(ATTR_EVENT, "Choose which type of event this trigger will use.")
	
	DescribeSliderAttribute(ATTR_CHANCE, PTYPE_FLOAT(), "Chance: ", 0.0, 100.0, 1.0, "{0}")
	SetHighlightText(ATTR_CHANCE, "The chance the trigger will run when all prerequisites are met.")
	
	string[] triggerIfRaceNames = new string[7]
	triggerIfRaceNames[0] = "Any"
	triggerIfRaceNames[1] = "Humanoid"
	triggerIfRaceNames[2] = "Creature"
	triggerIfRaceNames[3] = "Undead"
	triggerIfRaceNames[4] = "Partner Humanoid"
	triggerIfRaceNames[5] = "Partner Creature"
	triggerIfRaceNames[6] = "Partner Undead"
	DescribeMenuAttribute(ATTR_RACE, PTYPE_INT(), "Race:", 0, triggerIfRaceNames)
	
	string[] triggerIfRoleNames = new string[4]
	triggerIfRoleNames[0] = "Any"
	triggerIfRoleNames[1] = "Aggressor"
	triggerIfRoleNames[2] = "Victim"
	triggerIfRoleNames[3] = "Not part of rape"
	DescribeMenuAttribute(ATTR_ROLE, PTYPE_INT(), "Role:", 0, triggerIfRoleNames)
	
	string[] triggerIfPlayerNames = new string[5]
	triggerIfPlayerNames[0] = "Any"
	triggerIfPlayerNames[1] = "Player"
	triggerIfPlayerNames[2] = "Not Player"
	triggerIfPlayerNames[3] = "Partner Player"
	triggerIfPlayerNames[4] = "Partner Not Player"
	DescribeMenuAttribute(ATTR_PLAYER, PTYPE_INT(), "Player Status:", 0, triggerIfPlayerNames)
	
	string[] triggerIfGenderNames = new string[3]
	triggerIfGenderNames[0] = "Any"
	triggerIfGenderNames[1] = "Male"
	triggerIfGenderNames[2] = "Female"
	DescribeMenuAttribute(ATTR_GENDER, PTYPE_INT(), "Gender:", 0, triggerIfGenderNames)
	
	string[] triggerIfTagNames = new String[4]
	triggerIfTagNames[0] = "Any"
	triggerIfTagNames[1] = "Vaginal"
	triggerIfTagNames[2] = "Anal"
	triggerIfTagNames[3] = "Oral"
	DescribeMenuAttribute(ATTR_TAG, PTYPE_INT(), "SL Tag:", 0, triggerIfTagNames)
	
	string[] triggerIfDaytimeNames = new String[3]
	triggerIfDaytimeNames[0] = "Any"
	triggerIfDaytimeNames[1] = "Day"
	triggerIfDaytimeNames[2] = "Night"
	DescribeMenuAttribute(ATTR_DAYTIME, PTYPE_INT(), "Time of Day:", 0, triggerIfDaytimeNames)
	
	string[] triggerIfLocationNames = new String[3]
	triggerIfLocationNames[0] = "Any"
	triggerIfLocationNames[1] = "Inside"
	triggerIfLocationNames[2] = "Outside"
	DescribeMenuAttribute(ATTR_LOCATION, PTYPE_INT(), "Location:", 0, triggerIfLocationNames)
	
	string[] triggerIfPosition = new string[6]
	triggerIfPosition[0] = "Any"
	triggerIfPosition[1] = "1"
	triggerIfPosition[2] = "2"
	triggerIfPosition[3] = "3"
	triggerIfPosition[4] = "4"
	triggerIfPosition[5] = "5"
	DescribeMenuAttribute(ATTR_POSITION, PTYPE_INT(), "SL Position:", 0, triggerIfPosition)
	
	; technically you could add as many as you wanted here but of course
	; that could cause performance issues
	AddCommandList(ATTR_DO_1, "Command 1:")
	AddCommandList(ATTR_DO_2, "Command 2:")
	AddCommandList(ATTR_DO_3, "Command 3:")
EndFunction




; EXTERNAL EVENT HANDLERS
Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLab
		Debug.Notification("Triggers: Critical error")
		Return
	EndIf
	
	If !bEnabled
		Return
	EndIf
	
    int tid = _args as int
    ;sslThreadController thread = Sexlab.GetController(tid)
	
	HandleSexLabCheckEvents(tid, none, triggerKeys_Start)
    ;checkEvents(tid, 0, none)
    
EndEvent

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLab
		Debug.Notification("Triggers: Critical error")
		Return
	EndIf
	
	If !bEnabled
		Return
	EndIf
	
    int tid = _args as int
    ;sslThreadController thread = Sexlab.GetController(tid)
    
	HandleSexLabCheckEvents(tid, none, triggerKeys_Orgasm)
    ;checkEvents(tid, 1, none)
	
EndEvent

Event OnSexLabEnd(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLab
		Debug.Notification("Triggers: Critical error")
		Return
	EndIf
	
	If !bEnabled
		Return
	EndIf
	
    int tid = _args as int
    ;sslThreadController thread = Sexlab.GetController(tid)
    
	HandleSexLabCheckEvents(tid, none, triggerKeys_Stop)
    ;checkEvents(tid, 2, none)

EndEvent

Event OnSexLabOrgasmS(Form ActorRef, Int Thread)
;(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLab
		Debug.Notification("Triggers: Critical error")
		Return
	EndIf
	
	If !bEnabled
		Return
	EndIf
	
    int tid = Thread
    ;sslThreadController thread = Sexlab.GetController(tid)
    
	HandleSexLabCheckEvents(tid, ActorRef as Actor, triggerKeys_Orgasm_S)
    ;checkEvents(tid, 3, ActorRef as Actor)
	
EndEvent

Function RefreshTriggerCache()
	triggerKeys_Start = PapyrusUtil.StringArray(0)
	triggerKeys_Orgasm = PapyrusUtil.StringArray(0)
	triggerKeys_Stop = PapyrusUtil.StringArray(0)
	triggerKeys_Orgasm_S = PapyrusUtil.StringArray(0)
	int i = 0
	while i < TriggerKeys.Length
		int eventCode = GetEventCode(TriggerKeys[i])
		if eventCode == 0
			triggerKeys_Start = PapyrusUtil.PushString(triggerKeys_Start, TriggerKeys[i])
		elseif eventCode == 1
			triggerKeys_Orgasm = PapyrusUtil.PushString(triggerKeys_Orgasm, TriggerKeys[i])
		elseif eventCode == 2
			triggerKeys_Stop = PapyrusUtil.PushString(triggerKeys_Stop, TriggerKeys[i])
		elseif eventCode == 3
			triggerKeys_Orgasm_S = PapyrusUtil.PushString(triggerKeys_Orgasm_S, TriggerKeys[i])
		endif
		
		i += 1
	endwhile
EndFunction

; GetExtensionKey
; OVERRIDE REQUIRED
; returns: the unique string identifier for this extension
string Function GetExtensionKey()
	return "sl_triggersExtensionSexLab"
EndFunction

string Function GetFriendlyName()
	return "SLT SexLab"
EndFunction

Function UpdateSexLabStatus()
	SexLabAnimatingFaction = none
	SexLab = none
	
	SexLab = Game.GetFormFromFile(0xD62, "SexLab.esm") as SexLabFramework
	if SexLab
		SexLabAnimatingFaction = Game.GetFormFromFile(0xE50F, "SexLab.esm") as Faction
	endif
EndFunction

;/
we have a negative priority here because we are going to be overriding
some core functions, to expand them in the case when SexLab is present
/;
int Function GetPriority()
	return -500
EndFunction

; selectively enables only events with triggers
Function RegisterEvents()
    if bDebugMsg
        Debug.Notification("SL Triggers SL: register events")
    endIf
	
	UnregisterForModEvent(EVENT_SEXLAB_START)
	if bEnabled && triggerKeys_Start.Length > 0 && SexLab
		SafeRegisterForModEvent_Quest(self, EVENT_SEXLAB_START, EVENT_SEXLAB_START_HANDLER)
	endif
	
	UnregisterForModEvent(EVENT_SEXLAB_END)
	if bEnabled && triggerKeys_Stop.Length > 0 && SexLab
		SafeRegisterForModEvent_Quest(self, EVENT_SEXLAB_END, EVENT_SEXLAB_END_HANDLER)
	endif
	
	UnregisterForModEvent(EVENT_SEXLAB_ORGASM)
	if bEnabled && triggerKeys_Orgasm.Length > 0 && SexLab
		SafeRegisterForModEvent_Quest(self, EVENT_SEXLAB_ORGASM, EVENT_SEXLAB_ORGASM_HANDLER)
	endif
    
	UnregisterForModEvent(EVENT_SEXLAB_ORGASM_SLSO)
	if bEnabled && triggerKeys_Orgasm_S.Length > 0 && SexLab
		SafeRegisterForModEvent_Quest(self, EVENT_SEXLAB_ORGASM_SLSO, EVENT_SEXLAB_ORGASM_SLSO_HANDLER)
	endif
EndFunction


Function HandleSexLabCheckEvents(int tid, Actor specActor, string [] _eventTriggerKeys)
	sslThreadController thread = Sexlab.GetController(tid)
	;MiscUtil.PrintConsole("Chance:" + slotPre)
	int actorCount = thread.Positions.Length
	
	int i = 0
	string triggerKey
	string command
	while i < _eventTriggerKeys.Length
		triggerKey = _eventTriggerKeys[i]
		
		string value
		int    ival
		bool   doRun
		int    actorIdx = 0
		
		while actorIdx < actorCount
			Actor theSelf = thread.Positions[actorIdx]
			Actor theOther = none
			
			if actorCount > 1
				theOther = thread.Positions[ActorPos(actorIdx + 1, actorCount)]
			endIf
			
			;MiscUtil.PrintConsole("Actor:" + theSelf)
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
				ival = GetRace(triggerKey)
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
				ival = GetPlayer(triggerKey)
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
				ival = GetRole(triggerKey)
				;MiscUtil.PrintConsole("Role: " + slotPre + ", " + value)
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
				ival = GetGender(triggerKey)
				if ival != 0 ; 0 is Any
					if ival == 1 && Sexlab.GetGender(theSelf) != 0
						doRun = false
					elseIf ival == 2 && Sexlab.GetGender(theSelf) != 1
						doRun = false
					endIf
				endIf
			endIf
			if doRun
				ival = GetTag(triggerKey)
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
				ival = GetDaytime(triggerKey)
				if ival != 0 ; 0 is Any
					if ival == 1 && dayTime() != 1
						doRun = false
					elseIf ival == 2 && dayTime() != 2
						doRun = false
					endIf
				endIf
			endIf
			if doRun
				ival = GetLocation(triggerKey)
				if ival != 0 ; 0 is Any
					if ival == 1 && !theSelf.IsInInterior()
						doRun = false
					elseIf ival == 2 && theSelf.IsInInterior()
						doRun = false
					endIf
				endIf
			endIf
			if doRun
				ival = GetPosition(triggerKey)
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
				command = GetCommand1(triggerKey)
				string _instanceId
				if command
					_instanceId = RequestCommand(theSelf, command)
					if _instanceId
						Heap_IntSetFK(theSelf, MakeInstanceKey(_instanceId, "tid"), tid)
					endif
				endIf
				command = GetCommand2(triggerKey)
				if command
					_instanceId = RequestCommand(theSelf, command)
					if _instanceId
						Heap_IntSetFK(theSelf, MakeInstanceKey(_instanceId, "tid"), tid)
					endif
				endIf
				command = GetCommand3(triggerKey)
				if command
					_instanceId = RequestCommand(theSelf, command)
					if _instanceId
						Heap_IntSetFK(theSelf, MakeInstanceKey(_instanceId, "tid"), tid)
					endif
				endIf
			endIf
				
			actorIdx += 1
		endWhile
		
		i += 1
	endwhile
EndFunction


float Function GetChance(string _triggerKey)
	return Trigger_FloatGetT(_triggerKey, ATTR_CHANCE)
EndFunction

Function SetChance(string _triggerKey, float value)
	Trigger_FloatSetT(_triggerKey, ATTR_CHANCE, value)
EndFunction

int Function GetEventCode(string _triggerKey)
	return Trigger_IntGetT(_triggerKey, ATTR_EVENT)
EndFunction

int Function SetEventCode(string _triggerKey, int value)
	return Trigger_IntSetT(_triggerKey, ATTR_EVENT, value)
EndFunction

int Function GetRace(string _triggerKey)
	return Trigger_IntGetT(_triggerKey, ATTR_RACE)
EndFunction

int Function SetRace(string _triggerKey, int value)
	return Trigger_IntSetT(_triggerKey, ATTR_RACE, value)
EndFunction

int Function GetRole(string _triggerKey)
	return Trigger_IntGetT(_triggerKey, ATTR_ROLE)
EndFunction

int Function SetRole(string _triggerKey, int value)
	return Trigger_IntSetT(_triggerKey, ATTR_ROLE, value)
EndFunction

int Function GetGender(string _triggerKey)
	return Trigger_IntGetT(_triggerKey, ATTR_GENDER)
EndFunction

int Function SetGender(string _triggerKey, int value)
	return Trigger_IntSetT(_triggerKey, ATTR_GENDER, value)
EndFunction

int Function GetTag(string _triggerKey)
	return Trigger_IntGetT(_triggerKey, ATTR_TAG)
EndFunction

int Function SetTag(string _triggerKey, int value)
	return Trigger_IntSetT(_triggerKey, ATTR_TAG, value)
EndFunction

int Function GetDaytime(string _triggerKey)
	return Trigger_IntGetT(_triggerKey, ATTR_DAYTIME)
EndFunction

int Function SetDaytime(string _triggerKey, int value)
	return Trigger_IntSetT(_triggerKey, ATTR_DAYTIME, value)
EndFunction

int Function GetLocation(string _triggerKey)
	return Trigger_IntGetT(_triggerKey, ATTR_LOCATION)
EndFunction

int Function SetLocation(string _triggerKey, int value)
	return Trigger_IntSetT(_triggerKey, ATTR_LOCATION, value)
EndFunction

int Function GetPlayer(string _triggerKey)
	return Trigger_IntGetT(_triggerKey, ATTR_PLAYER)
EndFunction

int Function SetPlayer(string _triggerKey, int value)
	return Trigger_IntSetT(_triggerKey, ATTR_PLAYER, value)
EndFunction

int Function GetPosition(string _triggerKey)
	return Trigger_IntGetT(_triggerKey, ATTR_POSITION)
EndFunction

int Function SetPosition(string _triggerKey, int value)
	return Trigger_IntSetT(_triggerKey, ATTR_POSITION, value)
EndFunction

string Function GetCommand1(string _triggerKey)
	return Trigger_StringGetT(_triggerKey, ATTR_DO_1)
EndFunction

Function SetCommand1(string _triggerKey, string _command)
	Trigger_StringSetT(_triggerKey, ATTR_DO_1, _command)
EndFunction

string Function GetCommand2(string _triggerKey)
	return Trigger_StringGetT(_triggerKey, ATTR_DO_2)
EndFunction

Function SetCommand2(string _triggerKey, string _command)
	Trigger_StringSetT(_triggerKey, ATTR_DO_2, _command)
EndFunction

string Function GetCommand3(string _triggerKey)
	return Trigger_StringGetT(_triggerKey, ATTR_DO_3)
EndFunction

Function SetCommand3(string _triggerKey, string _command)
	Trigger_StringSetT(_triggerKey, ATTR_DO_3, _command)
EndFunction