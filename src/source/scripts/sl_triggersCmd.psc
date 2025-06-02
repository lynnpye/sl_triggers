Scriptname sl_TriggersCmd extends ActiveMagicEffect

; BEGIN PROPERTIES MANAGED BY PLUGIN - READ BUT DO NOT MODIFY
int Property threadContextHandle Auto
string Property initialScriptName Auto
bool isExecuting = false
; END PROPERTIES MANAGED BY PLUGIN - READ BUT DO NOT MODIFY

import sl_triggersStatics

; SLT
; sl_triggersMain
; SLT API access
sl_triggersMain		Property SLT Auto

; CONSTANTS

; Properties
Actor			Property PlayerRef Auto
Keyword			Property ActorTypeNPC Auto
Keyword			Property ActorTypeUndead Auto

Actor			Property CmdTargetActor Auto Hidden


string property cmdname auto hidden
int property linenum auto hidden
string          Property CustomResolveResult Auto Hidden
;Actor           Property CustomResolveActorResult Auto Hidden
Form            Property CustomResolveFormResult Auto Hidden
string	    Property MostRecentResult auto Hidden
int			Property lastKey auto  Hidden
Actor		Property iterActor auto Hidden 

Function SFE(string msg)
	SquawkFunctionError(self, msg)
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	CmdTargetActor = akCaster
    DoWhatYouShouldHaveDoneInTheFirstPlace()
EndEvent

Event OnPlayerLoadGame()
    DoWhatYouShouldHaveDoneInTheFirstPlace()
EndEvent

Function DoWhatYouShouldHaveDoneInTheFirstPlace()
    sl_triggers.Pung()
    DebMsg("sl_triggersCmd :" + threadContextHandle + ":  :" + initialScriptName + ":")
	SafeRegisterForModEvent_AME(self, EVENT_SLT_HEARTBEAT(), "OnSLTHeartbeat")
	SafeRegisterForModEvent_AME(self, EVENT_SLT_RESET(), "OnSLTReset")
    
    DebMsg("Executor.OnPlayerLoadGame :" + threadContextHandle + ":  :" + initialScriptName + ":")
    if threadContextHandle
        isExecuting = true
        QueueUpdateLoop(0.1)
    endif
EndFunction

Event OnUpdate()
    DebMsg("Executor.OnUpdate :" + threadContextHandle + ":  :" + initialScriptName + ":")
    bool keepProcessing = threadContextHandle && isExecuting
    while keepProcessing
        DebMsg("Executor.OnUpdate loop :" + threadContextHandle + ":  :" + initialScriptName + ":")
        keepProcessing = sl_triggers.ExecuteAndPending()
    endwhile
    
    CleanupAndRemove()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    DebMsg("Executor.OnEffectFinish :" + threadContextHandle + ":  :" + initialScriptName + ":")
    CleanupAndRemove()
EndEvent

bool cleanedup = false
Function CleanupAndRemove()
    if cleanedup
        return
    endif
    cleanedup = true
    DebMsg("Executor.CleanupAndRemove :" + threadContextHandle + ":  :" + initialScriptName + ":")
    UnregisterForAllModEvents()
    isExecuting = false

    if threadContextHandle
        sl_triggers.CleanupThreadContext() ; maybe with VMStackID auto-detection instead?
    endif

    Self.Dispel()
EndFunction

Event OnSLTReset(string eventName, string strArg, float numArg, Form sender)
    CleanupAndRemove()
EndEvent

Event OnKeyDown(Int keyCode)
    lastKey = keyCode
EndEvent

Event OnSLTHeartbeat(string eventName, string strArg, float numArg, Form sender)
EndEvent

Function QueueUpdateLoop(float afDelay = 1.0)
	RegisterForSingleUpdate(afDelay)
EndFunction

String Function ActorName(Actor _person)
	if _person
		return _person.GetLeveledActorBase().GetName()
	EndIf
	return "[Null actor]"
EndFunction

String Function ActorDisplayName(Actor _person)
    if _person
        return _person.GetDisplayName()
    Endif
    return "[Null actor]"
EndFunction

Int Function ActorGender(Actor _actor)
	int rank
    
	ActorBase _actorBase = _actor.GetActorBase()
	if _actorBase
		rank = _actorBase.GetSex()
	else
		rank = -1
	endif
    
	return rank
EndFunction

int Function HexToInt(string _value)
	return GlobalHexToInt(_value)
EndFunction

Bool Function InSameCell(Actor _actor)
	if _actor.getParentCell() != playerRef.getParentCell()
		return False
	EndIf
	return True
EndFunction

Form Function GetFormById(string _data)
    Form retVal = sl_triggers.GetForm(_data)

    if !retVal
        SFE("Form not found (" + _data + ")")
    endif
    
    return retVal
EndFunction

; Resolve
; string _code - a variable to retrieve the value of e.g. $$, $9, $g3
; returns: the value as a string; none if unable to resolve
string Function Resolve(string _code)
    return sl_triggers.ResolveValueVariable(_code)
EndFunction

; ResolveActor
; string _code - a variable indicating an Actor e.g. $self, $player
; returns: an Actor representing the specified Actor; none if unable to resolve
Actor Function ResolveActor(string _code)
    Actor _resolvedActor = CmdTargetActor
    if _code
        _resolvedActor = ResolveForm(_code) as Actor
    endif
    return _resolvedActor
EndFunction


Form Function ResolveForm(string _code)
    return sl_triggers.ResolveFormVariable(_code)
EndFunction