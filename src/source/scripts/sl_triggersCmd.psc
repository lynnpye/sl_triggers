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
bool        Property cleanedup = false auto  hidden

Function SFE(string msg)
	SquawkFunctionError(self, msg)
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	CmdTargetActor = akCaster
    DoStartup()
EndEvent

Event OnPlayerLoadGame()
    DoStartup()
EndEvent

Function DoStartup()
    sl_triggers_internal.Pung()
	SafeRegisterForModEvent_AME(self, EVENT_SLT_RESET(), "OnSLTReset")
    
    if threadContextHandle
        isExecuting = true
        QueueUpdateLoop(0.1)
    endif
EndFunction

Event OnUpdate()
    bool keepProcessing = self && !cleanedup && threadContextHandle && isExecuting
    while keepProcessing
        keepProcessing = self && !cleanedup && threadContextHandle && isExecuting
        DebMsg("calling sl_triggers_internal.ExecuteAndPending")
        bool ep = sl_triggers_internal.ExecuteAndPending()
        DebMsg("sl_triggers_internal.ExecuteAndPending returned ep(" + ep + ")")
        keepProcessing = keepProcessing && ep
    endwhile
    
    CleanupAndRemove()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    CleanupAndRemove()
EndEvent

Function CleanupAndRemove()
    if cleanedup
        return
    endif
    cleanedup = true
    UnregisterForAllModEvents()
    isExecuting = false

    if threadContextHandle
        sl_triggers_internal.CleanupThreadContext()
    endif

    Self.Dispel()
EndFunction

Event OnSLTReset(string eventName, string strArg, float numArg, Form sender)
    CleanupAndRemove()
EndEvent

Event OnKeyDown(Int keyCode)
    lastKey = keyCode
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
    return sl_triggers_internal.ResolveValueVariable(_code)
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
    return sl_triggers_internal.ResolveFormVariable(_code)
EndFunction