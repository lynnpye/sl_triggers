scriptname sl_triggersExtensionSexLab extends sl_triggersExtension

import sl_triggersStatics
import sl_triggersHeap

SexLabFramework     Property SexLab						Auto Hidden
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
string	ATTR_EVENT							= "event"
string	ATTR_CHANCE							= "chance"
string	ATTR_RACE							= "race"
string	ATTR_ROLE							= "role"
string	ATTR_PLAYER							= "player"
string	ATTR_GENDER							= "gender"
string	ATTR_TAG							= "tag"
string	ATTR_DAYTIME						= "daytime"
string	ATTR_LOCATION						= "location"
string	ATTR_POSITION						= "position"
string	ATTR_DO_1							= "do_1"
string	ATTR_DO_2							= "do_2"
string	ATTR_DO_3							= "do_3"


string[]	triggerKeys_Start
string[]	triggerKeys_Orgasm
string[]	triggerKeys_Stop
string[]	triggerKeys_Orgasm_S

; GetExtensionKey
; OVERRIDE REQUIRED
; returns: the unique string identifier for this extension
string Function GetExtensionKey()
	return "sl_triggersExtensionSexLab"
EndFunction

; GetFriendlyName
; OVERRIDE RECOMMENDED
string Function GetFriendlyName()
	return "SLT SexLab"
EndFunction

;/
we have a negative priority here because we are going to be overriding
some core functions, to expand them in the case when SexLab is present
/;
; GetPriority
; OPTIONAL
; 0 is roughly "built-in"
; <0 has higher priority (think first in line to take a crack at the operation)
int Function GetPriority()
	return -500
EndFunction

Event OnInit()
	if !self
		return
	endif
	; REQUIRED CALL
	SLTInit()
EndEvent

; SLTReady
; OPTIONAL
Function SLTReady()
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


; EXTERNAL EVENT HANDLERS
Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLab
		Debug.Notification("Triggers: Critical error")
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
    int tid = _args as int
	
	HandleSexLabCheckEvents(tid, none, triggerKeys_Start)
EndEvent

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLab
		Debug.Notification("Triggers: Critical error")
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
    int tid = _args as int
    
	HandleSexLabCheckEvents(tid, none, triggerKeys_Orgasm)
EndEvent

Event OnSexLabEnd(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLab
		Debug.Notification("Triggers: Critical error")
		Return
	EndIf
	
	If !IsEnabled
		Return
	EndIf
	
    int tid = _args as int
    
	HandleSexLabCheckEvents(tid, none, triggerKeys_Stop)
EndEvent

Event OnSexLabOrgasmS(Form ActorRef, Int Thread)
;(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLab
		Debug.Notification("Triggers: Critical error")
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
		
		i += 1
	endwhile
EndFunction

Function UpdateSexLabStatus()
	SexLabAnimatingFaction = none
	SexLab = none
	
	SexLab = Game.GetFormFromFile(0xD62, "SexLab.esm") as SexLabFramework
	if SexLab
		SexLabAnimatingFaction = Game.GetFormFromFile(0xE50F, "SexLab.esm") as Faction
	endif
EndFunction

; selectively enables only events with triggers
Function RegisterEvents()
    if IsDebugMsg
        Debug.Notification("SL Triggers SL: register events")
    endIf
	
	UnregisterForModEvent(EVENT_SEXLAB_START)
	if IsEnabled && triggerKeys_Start.Length > 0 && SexLab
		SafeRegisterForModEvent_Quest(self, EVENT_SEXLAB_START, EVENT_SEXLAB_START_HANDLER)
	endif
	
	UnregisterForModEvent(EVENT_SEXLAB_END)
	if IsEnabled && triggerKeys_Stop.Length > 0 && SexLab
		SafeRegisterForModEvent_Quest(self, EVENT_SEXLAB_END, EVENT_SEXLAB_END_HANDLER)
	endif
	
	UnregisterForModEvent(EVENT_SEXLAB_ORGASM)
	if IsEnabled && triggerKeys_Orgasm.Length > 0 && SexLab
		SafeRegisterForModEvent_Quest(self, EVENT_SEXLAB_ORGASM, EVENT_SEXLAB_ORGASM_HANDLER)
	endif
    
	UnregisterForModEvent(EVENT_SEXLAB_ORGASM_SLSO)
	if IsEnabled && triggerKeys_Orgasm_S.Length > 0 && SexLab
		SafeRegisterForModEvent_Quest(self, EVENT_SEXLAB_ORGASM_SLSO, EVENT_SEXLAB_ORGASM_SLSO_HANDLER)
	endif
EndFunction


Function HandleSexLabCheckEvents(int tid, Actor specActor, string [] _eventTriggerKeys)
	sslThreadController thread = Sexlab.GetController(tid)
	int actorCount = thread.Positions.Length
	
	int i = 0
	string triggerKey
	string command
	while i < _eventTriggerKeys.Length
		triggerKey = _eventTriggerKeys[i]
		string _triggerFile = FN_T(triggerKey)
		
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
					if ival == 1 && Sexlab.GetGender(theSelf) != 0
						doRun = false
					elseIf ival == 2 && Sexlab.GetGender(theSelf) != 1
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
					if ival == 1 && dayTime() != 1
						doRun = false
					elseIf ival == 2 && dayTime() != 2
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
				command = JsonUtil.GetIntValue(_triggerFile, ATTR_DO_1)
				string _instanceId
				if command
					_instanceId = RequestCommand(theSelf, command)
					if _instanceId
						Heap_IntSetFK(theSelf, MakeInstanceKey(_instanceId, "tid"), tid)
					endif
				endIf
				command = JsonUtil.GetIntValue(_triggerFile, ATTR_DO_2)
				if command
					_instanceId = RequestCommand(theSelf, command)
					if _instanceId
						Heap_IntSetFK(theSelf, MakeInstanceKey(_instanceId, "tid"), tid)
					endif
				endIf
				command = JsonUtil.GetIntValue(_triggerFile, ATTR_DO_3)
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
