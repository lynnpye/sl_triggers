Scriptname sl_TriggersCmdBase extends ActiveMagicEffect

import sl_triggersStatics
import sl_triggersHeap

; SLT
; sl_triggersMain
; SLT API access
; REQUIRED
sl_triggersMain		Property SLT Auto

; CONSTANTS

; Properties
; REQUIRED
Actor			Property PlayerRef Auto
; REQUIRED
Keyword			Property ActorTypeNPC Auto
; REQUIRED
Keyword			Property ActorTypeUndead Auto

; CmdExtension
; sl_triggersExtension
; REQUIRED
; This should be a reference to the extension to which the Cmd belongs.
sl_triggersExtension	Property CmdExtension Auto

; CmdPrimary
; sl_triggersCmd
; DO NOT MODIFY
; This will be set to the sl_triggersCmd associated with the cluster
; of AMEs this Cmd will be supporting. returns none if this is a
; sl_triggersCmd
sl_triggersCmd			Property CmdPrimary Auto Hidden

; InstanceId
; string
; DO NOT MODIFY
; This uniquely identifies this specific CmdBase.
string					Property InstanceId Auto Hidden

;
Actor			Property aCaster Auto Hidden
string[]		Property stack Auto Hidden


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;; The following section represents functions you either are
;; REQUIRED to override or that you are allowed to override if
;; you want custom functionality.
;;
;; Function names are "normal" here (no underscores or anything).
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; oper
; string[] param - operands passed as arguments to your operation
; returns: true if the command was recognized (even if it was not able to function correctly); false if not recognized
;
; REQUIRED
; You MUST override this in your extension Cmd script and it MUST return false in the default/Empty state.
; Generally it should be a simple 'return false' as with the base, but technically that is not required.
; Be creative but not destructive please.
; All other oper() variants should return true
bool function oper(string[] param)
	return false
endFunction

; CustomResolve
; string _code - a variable to retrieve the value of e.g. $$, $9, $g3
; returns: the value as a string; none if unable to resolve
; OPTIONAL
; Only override this in your Cmd extension if you are expanding or overriding
; Resolve() behavior.
string Function CustomResolve(string _code)
	return none
EndFunction

; CustomResolveActor
; string _code - a variable indicating an Actor e.g. $self, $player
; returns: an Actor representing the specified Actor; none if unable to resolve
; OPTIONAL
; Only override this in your Cmd extension if you are expanding or overriding
; ResolveActor() behavior.
Actor Function CustomResolveActor(string _code)
	return none
EndFunction

; CustomResolveCond
; string _code - a condition to check, e.g. a comparator i.e. '=', '+'
; returns: true if the condition was resolved; false otherwise
; OPTIONAL
; Only override this in your Cmd extension if you are expanding or overriding
; ResolveActor() behavior.
bool Function CustomResolveCond(string _p1, string _p2, string _oper)
	return false
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;; The following section represents functions you either are
;; REQUIRED to call at some point during lifecycle or that
;; you are likely to call while implementing your commands.
;;
;; Function names are "normal" here (no underscores or anything).
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; SLTOnEffectStart
; Performs essential setup at the beginning of an AME application
;
; REQUIRED CALL
; It MUST be called during OnEffectStart(), the earlier the better.
Function SLTOnEffectStart(Actor akCaster)
	aCaster = akCaster ;"sl_triggersCmd(" + SLT.NextOneUp() + ")"
	
	SafeRegisterForModEvent_AME(self, _slt_GetHeartbeatEvent(), "OnSLTHeartbeat")
	
	SendModEvent(EVENT_SLT_AME_HEARTBEAT_UPDATE(), _slt_GetHeartbeatEvent(), 1.0)
	
	; we are a Cmd extension; we need to find our primary AME and report in
	if CmdExtension
		_isSupportCmdVal = true
		string coreInstanceId = Heap_StringListShiftFK(aCaster, MakeExtensionInstanceId(CmdExtension.GetExtensionKey()))
		; something has gone wrong
		if !coreInstanceId
			Debug.Trace("sl_triggers: CmdBase: Effect dispatched but extension queue is empty on Actor, extension key: " + CmdExtension.GetExtensionKey())
			return
		endif
		
		int CmdPrimaryMailbox = Heap_IntGetFK(aCaster, MakeInstanceKey(coreInstanceId, "CmdPrimaryMailbox"))
		CmdPrimary = SLT.GetCoreCmdFromMailbox(CmdPrimaryMailbox)
		CmdPrimary.SupportCheckin(self)
	Endif
	
	SafeRegisterForModEvent_AME(self, _slt_GetClusterEvent(), "OnSLTAMEClusterEvent")
EndFunction

Event OnSLTAMEClusterEvent(string eventName, string strArg, float numArg, Form sender)
	if strArg == "DISPEL"
		UnregisterForAllModEvents()
		self.Dispel()
	elseif strArg == "EXECUTE"
		_slt_ExecuteCmd()
	endif
EndEvent

; vars_get
; int varsindex: integer representing which variable to fetch
; returns: value as a string
; DO NOT OVERRIDE
; This function is designed to interact with the Core AME.
; If you override this your AME will not behave as expected.
;
; This function is not expected to operate correctly until
; all AMEs have synced and execution has begun.
string Function vars_get(int varsindex)
	return Heap_StringGetFK(aCaster, MakeInstanceKey(_slt_getActualInstanceId(), "vars" + varsindex))
EndFunction

; vars_set
; int varsindex: integer representing which variable to set
; returns: value as a string
; DO NOT OVERRIDE
; This function is designed to interact with the Core AME.
; If you override this your AME will not behave as expected.
;
; This function is not expected to operate correctly until
; all AMEs have synced and execution has begun.
string Function vars_set(int varsindex, string value)
	return Heap_StringSetFK(aCaster, MakeInstanceKey(_slt_getActualInstanceId(), "vars" + varsindex), value)
EndFunction

; Resolve
; string _code - a variable to retrieve the value of e.g. $$, $9, $g3
; returns: the value as a string; none if unable to resolve
; DO NOT OVERRIDE
string Function Resolve(string _code)
	if _slt_isSupportCmd()
		return CmdPrimary.ActualResolve(_code)
	else
		return (self as sl_triggersCmd).ActualResolve(_code)
	endif
EndFunction

; ResolveActor
; string _code - a variable indicating an Actor e.g. $self, $player
; returns: an Actor representing the specified Actor; none if unable to resolve
; DO NOT OVERRIDE
Actor Function ResolveActor(string _code)
	if _slt_isSupportCmd()
		return CmdPrimary.ActualResolveActor(_code)
	else
		return (self as sl_triggersCmd).ActualResolveActor(_code)
	endif
EndFunction

; ResolveCond
; string _code - a condition to check, e.g. a comparator i.e. '=', '+'
; returns: true if the condition was resolved; false otherwise
; DO NOT OVERRIDE
bool Function ResolveCond(string _p1, string _p2, string _oper)
	if _slt_isSupportCmd()
		return CmdPrimary.ActualResolveCond(_p1, _p2, _oper)
	else
		return (self as sl_triggersCmd).ActualResolveCond(_p1, _p2, _oper)
	endif
endFunction

String Function actorName(Actor _person)
	if _person
		return _person.GetLeveledActorBase().GetName()
	EndIf
	return "[Null actor]"
EndFunction

Int Function actorGender(Actor _actor)
	int rank
    
	ActorBase _actorBase = _actor.GetActorBase()
	if _actorBase
		rank = _actorBase.GetSex()
	else
		rank = -1
	endif
    
	return rank
EndFunction

int Function hexToInt(string _value)
    int retVal
    int idx
    int iDigit
    int pos
    string sChar
    string hexChars = "0123456789ABCDEF"
    
    idx = StringUtil.GetLength(_value) - 1
    while idx >= 0
        sChar = StringUtil.GetNthChar(_value, idx)
        iDigit = StringUtil.Find(hexChars, sChar, 0)
        if iDigit >= 0
            iDigit = Math.LeftShift(iDigit, 4 * pos)
            retVal = Math.LogicalOr(retVal, iDigit)
            idx -= 1
            pos += 1
        else 
            idx = -1
        endIf
    endWhile
    
    return retVal
EndFunction

Form Function getFormId(string _data)
    Form retVal
    string[] params
    string fname
    string sid
    int  id
    
    params = StringUtil.Split(_data, ":")
    fname = params[0]
    sid = params[1]
    ; check if hex or dec
    if sid && (StringUtil.GetNthChar(sid, 0) == "0")
        id = hexToInt(sid)
    else
        id = params[1] as int
    endIf
    
    retVal = Game.GetFormFromFile(id, fname)
    if !retVal
        MiscUtil.PrintConsole("Form not found: " + _data)
    endIf
    
    return retVal
EndFunction

Bool Function inSameCell(Actor _actor)
	if _actor.getParentCell() != playerRef.getParentCell()
		return False
	EndIf
	return True
EndFunction

int function isVarPrefixed(string _code, string _prefix)
	if !_code || !_prefix || StringUtil.SubString(_code, 0, StringUtil.GetLength(_prefix)) != _prefix
		return -1
	endif
	
	string numchunk = StringUtil.Substring(_code, StringUtil.GetLength(_prefix))
	int num = numchunk as int
	
	if (num as string) == numchunk
		return num
	else
		return -1
	endif
endfunction

int function isVarString(string _code)
	return isVarPrefixed(_code, "$")
endfunction

int function isVarStringG(string _code)
	return isVarPrefixed(_code, "$g")
endfunction

String Function GetInstanceId()
	return InstanceId
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;;
;; Pay no attention to the main behind the curtain...
;; Function names below are prefixed with _slt_ to avoid naming collisions
;;
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; internal variables
string _actualInstanceId ; cache copy
bool _apfetched
int _actualPriority ; cache copy
bool _isSupportCmdVal
string	heartbeatEvent
string clusterEvent

Event OnSLTHeartbeat(string eventName, string strArg, float numArg, Form sender)
EndEvent

Function _slt_ExecuteCmd()
EndFunction

string Function _slt_GetHeartbeatEvent()
	if !heartbeatEvent
		heartbeatEvent = "sl_triggers_SLT_HEARTBEAT_" + (Utility.RandomInt(100000, 999999) as string)
	endif
	return heartbeatEvent
EndFunction

string Function _slt_GetClusterEvent()
	if !clusterEvent
		clusterEvent = "sl_triggers_SLT_CLUSTER_" + _slt_getActualInstanceId()
	endif
	return clusterEvent
EndFunction

; _isSupportCmd
; returns: true if this is a support Cmd from an extension; false if this is an sl_triggersCmd
; DO NOT OVERRIDE
bool Function _slt_isSupportCmd()
	return _isSupportCmdVal
EndFunction

; GetActualInstanceId
; returns: the instanceId of the cmdPrimary (sl_triggersCmd) if this is a support Cmd, and the instanceId of self if this is a sl_triggersCmd
; DO NOT OVERRIDE
string Function _slt_getActualInstanceId()
	if !_actualInstanceId
		if _slt_isSupportCmd()
			_actualInstanceId = CmdPrimary.GetInstanceId()
		else
			_actualInstanceId = instanceId
		endif
	endif
	return _actualInstanceId
EndFunction

; _GetActualPriority
; returns: the priority of the extension this Cmd is associated with
; DO NOT OVERRIDE
int Function _slt_getActualPriority()
	if !_apfetched
		_apfetched = true
		if _slt_isSupportCmd()
			_actualPriority = CmdExtension.GetPriority()
		else
			_actualPriority = 0
		endif
	endif
	return _actualPriority
EndFunction

bool Function _slt_oper_driver(string[] param, string code)
	GotoState("cmd_" + code)
	bool oresult = oper(param)
	GotoState("")
	return oresult
EndFunction
