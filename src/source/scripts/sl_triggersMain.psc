Scriptname sl_TriggersMain extends Quest  

Actor               Property PlayerRef Auto
SexLabFramework     Property SexLab Auto
Faction	            Property SexLabAnimatingFaction Auto
Keyword				Property ActorTypeNPC Auto
Keyword				Property ActorTypeUndead Auto

Spell[]             Property customSpells Auto
MagicEffect[]       Property customEffects Auto

Bool  Property bEnabled = true Auto Hidden
Bool  Property bDebugMsg = false Auto Hidden

string settingsName  = "../sl_triggers/settings"
string commandsPath  = "../sl_triggers/commands"
string commandsPath1 = "../sl_triggers/commands/"

int lastMaxSlot = 80

Event OnInit()
	on_reload()
	RegisterForSingleUpdate(10)
EndEvent

Event OnUpdate()
	if !Self
		Return
	EndIf
	;Debug.Notification("SL Triggers: tick")
	RegisterForSingleUpdate(30)
EndEvent

Function _registerEvents()
    if bDebugMsg
        Debug.Notification("SL Triggers: register events")
    endIf
	
	UnregisterForModEvent("AnimationStart")
	RegisterForModEvent("AnimationStart", "OnSexLabStart")
	
	UnregisterForModEvent("AnimationEnd")
	RegisterForModEvent("AnimationEnd", "OnSexLabEnd")
	
	UnregisterForModEvent("OrgasmStart")
	RegisterForModEvent("OrgasmStart", "OnSexLabOrgasm")
	
	;UnregisterForModEvent("StageStart")
	;RegisterForModEvent("StageStart",     "OnStageStart")
    
	UnregisterForModEvent("SexLabOrgasmSeparate")
	RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmS")

EndFunction

Function on_reload()
	_registerEvents()
	UnRegisterForUpdate()
	RegisterForSingleUpdate(10)
EndFunction

Function setMaxSlots()
    lastMaxSlot = 80
    MiscUtil.PrintConsole("SL_TRIGGERS: reset max slots")
EndFunction

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
    
    checkEvents(tid, "0", none)
    
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
    
    checkEvents(tid, "1", none)
	
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
    
    checkEvents(tid, "2", none)

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
    
    checkEvents(tid, "3", ActorRef as Actor)
	
EndEvent

string Function getSettingsName()
    return settingsName
endFunction

string Function getCommandsPath()
    return commandsPath
EndFunction

Int Function actorRace(Actor _actor)
    if _actor == PlayerRef
        return 1
    endIf
	If _actor.HasKeyword(ActorTypeUndead)
		return 3
	EndIf
	If _actor.HasKeyword(ActorTypeNPC)
		return 2
	EndIf
	return 4
EndFunction

int Function _actorPos(int idx, int count)
    if idx >= count
        return 0
    elseif idx < 0 && count > 0
        return count - 1
    endIf
    return idx
endFunction

Int Function dayTime()
	float dayTime = Utility.GetCurrentGameTime()
 
	dayTime -= Math.Floor(dayTime)
	dayTime *= 24
	If dayTime >= 7 && dayTime <= 19
		return 1
	EndIf
	Return 2
EndFunction

Function checkEvents(int tid, string eventId, Actor specActor)
    ;for all slots
    int slotNo
    string slotPre
    string value
    float  chance
    bool   doRun
    int    actorIdx
    int    actorCount
    int    slotMax
    int    currMax
    sslThreadController thread = Sexlab.GetController(tid)
    
    slotMax = lastMaxSlot
    currMax = 0
    slotNo = 1
    ;MiscUtil.PrintConsole("Start:" + tid + "," + eventId + ", max: " + slotMax)
    while slotNo <= slotMax
        slotPre = "slot" + slotNo as string + "."
        
        ;MiscUtil.PrintConsole("Slot:" + slotPre)
        
        chance = JsonUtil.GetStringValue(settingsName, slotPre + "if_chance") as float
        ;MiscUtil.PrintConsole(" Chance:" + chance)
        if chance > 0.0
            currMax = slotNo
        endIf
        if chance > 0.0 && Utility.RandomFloat(1.0, 100.0) <= chance
            ;MiscUtil.PrintConsole("Chance:" + slotPre)
            actorCount = thread.Positions.Length
            actorIdx = 0
            while actorIdx < actorCount
                Actor theSelf = thread.Positions[actorIdx]
                Actor theOther = none
                
                if actorCount > 1
                    theOther = thread.Positions[_actorPos(actorIdx + 1, actorCount)]
                endIf
                
                ;MiscUtil.PrintConsole("Actor:" + theSelf)
                doRun = true
                if doRun
                    if eventId == "3" ; spec check for separate orgasm
                        if theSelf != specActor
                            doRun = false
                        endIf
                    endIf
                endIf
                
                if doRun
                    value = JsonUtil.GetStringValue(settingsName, slotPre + "if_event")
                    if !value
                        value = "0"
                    endIf
                    if value != eventId
                        doRun = false
                    endIf
                endIf
                
                if doRun
                    value = JsonUtil.GetStringValue(settingsName, slotPre + "if_race")
                    if value && value != "0" ; 0 is Any
                        if value == "1" && actorRace(theSelf) != 2 ; should be humanoid
                            doRun = false
                        elseIf value == "2" && actorRace(theSelf) != 4 ; should be creature
                            doRun = false
                        elseIf value == "3" && actorRace(theSelf) != 1 ; should be player
                            doRun = false
                        elseIf value == "4" && actorRace(theSelf) == 1 ; should be not-player
                            doRun = false
                        elseIf value == "5" && actorRace(theSelf) != 3 ; should be undead
                            doRun = false
                        else
                            ;check other
                            if actorCount <= 1 ; is solo, Partner is auto-false
                                doRun = false
                            else
                                if value == "6" && actorRace(theOther) != 2 ; should be humanoid
                                    doRun = false
                                elseIf value == "7" && actorRace(theOther) != 4 ; should be creature
                                    doRun = false
                                elseIf value == "8" && actorRace(theOther) != 1 ; should be player
                                    doRun = false
                                elseIf value == "9" && actorRace(theOther) == 1 ; should be not-player
                                    doRun = false
                                elseIf value == "10" && actorRace(theOther) != 3 ; should be undead
                                    doRun = false
                                endIf
                            endIf
                        endIf
                    endIf
                endIf
                
                if doRun
                    value = JsonUtil.GetStringValue(settingsName, slotPre + "if_role")
                    ;MiscUtil.PrintConsole("Role: " + slotPre + ", " + value)
                    if value && value != "0" ; 0 is Any
                        if value == "1" && !thread.IsAggressor(theSelf) ; aggresor
                            doRun = false
                        elseIf value == "2" && !thread.IsVictim(theSelf) ; victim
                            doRun = false
                        elseIf value == "3" && thread.IsAggressive ; not
                            doRun = false
                        endIf
                    endIf
                endIf
                
                if doRun
                    value = JsonUtil.GetStringValue(settingsName, slotPre + "if_gender")
                    if value && value != "0" ; 0 is Any
                        if value == "1" && Sexlab.GetGender(theSelf) != 0
                            doRun = false
                        elseIf value == "2" && Sexlab.GetGender(theSelf) != 1
                            doRun = false
                        endIf
                    endIf
                endIf
                if doRun
                    value = JsonUtil.GetStringValue(settingsName, slotPre + "if_tag")
                    if value && value != "0" ; 0 is Any
                        if value == "1" && !thread.IsVaginal
                            doRun = false
                        elseIf value == "2" && !thread.IsAnal
                            doRun = false
                        elseIf value == "3" && !thread.IsOral
                            doRun = false
                        endIf
                    endIf
                endIf
                if doRun
                    value = JsonUtil.GetStringValue(settingsName, slotPre + "if_daytime")
                    if value && value != "0" ; 0 is Any
                        if value == "1" && dayTime() != 1
                            doRun = false
                        elseIf value == "2" && dayTime() != 2
                            doRun = false
                        endIf
                    endIf
                endIf
                if doRun
                    value = JsonUtil.GetStringValue(settingsName, slotPre + "if_location")
                    if value && value != "0" ; 0 is Any
                        if value == "1" && !theSelf.IsInInterior()
                            doRun = false
                        elseIf value == "2" && theSelf.IsInInterior()
                            doRun = false
                        endIf
                    endIf
                endIf
                
                if doRun ;do doRun
                    value = JsonUtil.GetStringValue(settingsName, slotPre + "do_1")
                    if value
                        startCommand(theSelf, tid, value)
                    endIf
                    value = JsonUtil.GetStringValue(settingsName, slotPre + "do_2")
                    if value
                        startCommand(theSelf, tid, value)
                    endIf
                    value = JsonUtil.GetStringValue(settingsName, slotPre + "do_3")
                    if value
                        startCommand(theSelf, tid, value)
                    endIf
                endIf
                    
                actorIdx += 1
            endWhile
        endIf
        
        slotNo += 1
    endWhile
    
    lastMaxSlot = currMax
    ;MiscUtil.PrintConsole("SL_TRIGGERS: last slot=" + lastMaxSlot as string)
    
EndFunction

Int Function getNextCSpell(Actor _actor)
	Int idx
	
	idx = 0
	While idx < customEffects.Length
		If !_actor.HasMagicEffect(customEffects[idx])
			Return idx
		EndIf
		idx += 1
	EndWhile
	
	Return -1
EndFunction

Function startCommand(Actor _actor, int tid, string cmdName)
    ;MiscUtil.PrintConsole("Run: " + _actor + ", " + tid + ", " + cmdName)
    
    int idxSpell = getNextCSpell(_actor)
    
    if idxSpell < 0
        MiscUtil.PrintConsole("To many effects on: " + _actor)
    endIf
    
    ;MiscUtil.PrintConsole("Run: spell: " + idxSpell)
    
   	StorageUtil.SetIntValue   (_actor, "slt:tid", tid)
   	StorageUtil.SetStringValue(_actor, "slt:cmd", commandsPath1 + cmdName)
	customSpells[idxSpell].RemoteCast(_actor, _actor, _actor)
    
	;wait for effect to start. but not for too long
    ;MiscUtil.PrintConsole("Wait: ")
	int iWaitCount = 0
	While iWaitCount < 20 && StorageUtil.HasIntValue(_actor, "slu:tid")
		Utility.Wait(0.2)
		iWaitCount += 1
        ;MiscUtil.PrintConsole("Wait: " + iWaitCount)
	EndWhile

EndFunction
