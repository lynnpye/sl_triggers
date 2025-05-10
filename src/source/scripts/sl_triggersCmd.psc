Scriptname sl_TriggersCmd extends ActiveMagicEffect


import sl_triggersStatics
import sl_triggersHeap

; SLT
; sl_triggersMain
; SLT API access
sl_triggersMain		Property SLT Auto

; CONSTANTS

; Properties
Actor			Property PlayerRef Auto
Keyword			Property ActorTypeNPC Auto
Keyword			Property ActorTypeUndead Auto

; InstanceId
; string
; DO NOT MODIFY
; This uniquely identifies this specific CmdBase.
string			Property InstanceId Auto Hidden

Actor			Property CmdTargetActor Auto Hidden

string          Property CustomResolveResult Auto Hidden
Actor           Property CustomResolveActorResult Auto Hidden
bool            Property CustomResolveCondResult Auto Hidden

; Properties
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



; Resolve
; string _code - a variable to retrieve the value of e.g. $$, $9, $g3
; returns: the value as a string; none if unable to resolve
string Function Resolve(string _code)
    return _slt_ActualResolve(_code)
EndFunction

; ResolveActor
; string _code - a variable indicating an Actor e.g. $self, $player
; returns: an Actor representing the specified Actor; none if unable to resolve
Actor Function ResolveActor(string _code)
    return _slt_ActualResolveActor(_code)
EndFunction

; ResolveCond
; string _code - a condition to check, e.g. a comparator i.e. '=', '+'
; returns: true if the condition was resolved; false otherwise
bool Function ResolveCond(string _p1, string _p2, string _oper)
    return _slt_ActualResolveCond(_p1, _p2, _oper)
endFunction

String Function ActorName(Actor _person)
	if _person
		return _person.GetLeveledActorBase().GetName()
	EndIf
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

Form Function GetFormId(string _data)
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
        id = HexToInt(sid)
    else
        id = params[1] as int
    endIf
    
    retVal = Game.GetFormFromFile(id, fname)
    if !retVal
        MiscUtil.PrintConsole("Form not found: " + _data)
    endIf
    
    return retVal
EndFunction

Bool Function InSameCell(Actor _actor)
	if _actor.getParentCell() != playerRef.getParentCell()
		return False
	EndIf
	return True
EndFunction

int function IsVarPrefixed(string _code, string _prefix)
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

int function IsVarString(string _code)
	return IsVarPrefixed(_code, "$")
endfunction

int function IsVarStringG(string _code)
	return IsVarPrefixed(_code, "$g")
endfunction

;/
String Function GetInstanceId()
	return InstanceId
EndFunction
/;

Function QueueUpdateLoop(float afDelay = 1.0)
	RegisterForSingleUpdate(afDelay)
EndFunction

string Function vars_get(int varsindex)
	return Heap_StringGetFK(CmdTargetActor, VARS_KEY_PREFIX + varsindex)
EndFunction

string Function vars_set(int varsindex, string value)
	return Heap_StringSetFK(CmdTargetActor, VARS_KEY_PREFIX + varsindex, value)
EndFunction

; simple get handler for infini-globals
string Function globalvars_get(int varsindex)
	return SLT.globalvars_get(varsindex)
EndFunction

; simple set handler for infini-globals
string Function globalvars_set(int varsindex, string value)
	return SLT.globalvars_set(varsindex, value)
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

;
;
;
;
;
;
;
;
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;
;
;
;
;
;
;
;
;



; internal variables

bool executionNotBegun

string[] currentCmdLine

string _xn_execute_line
string _xn_actual_oper

string  kk_callstack_pointer
string  kk_callstack_list_pointer

string  kk_cs_callstackid
string  kk_cs_callstackid_nextup

string  kk_cs_callargs

string  kk_cs_vars_key_prefix

string  kk_cs_cmdidx
string  kk_cs_cmdnum
string  kk_cs_cmdtype
string  kk_cs_cmdname
string  kk_cs_gotoidx
string  kk_cs_gotolabels
string  kk_cs_gotocnt
string  kk_cs_gosubidx
string  kk_cs_gosublabels
string  kk_cs_gosubcnt
string  kk_cs_gosubreturnstack
string  kk_cs_gosubreturnidx
string  kk_cs_mostrecentresult

string  kk_cs_lastkey
string  kk_cs_iteractor

Function _slt_Setup_InstanceKeys()
    _xn_actual_oper     = "_xn_actual_oper:" + InstanceId
    _xn_execute_line    = "_xn_execute_line:" + InstanceId

    kk_callstack_pointer = MakeInstanceKey(InstanceId, "_cs_callstack_pointer")
    kk_callstack_list_pointer = MakeInstanceKey(InstanceId, "_cs_callstack_list_pointer")

    kk_cs_callstackid = MakeInstanceKey(InstanceId, "_cs_callstackid")
    kk_cs_callstackid_nextup = MakeInstanceKey(InstanceId, "_cs_callstackid_nextup")

    kk_cs_callargs = MakeInstanceKey(InstanceId, "_cs_callargs")

    kk_cs_vars_key_prefix = MakeInstanceKey(InstanceId, "_cs_vars_key_prefix")

    kk_cs_cmdidx = MakeInstanceKey(InstanceId, "_cs_cmdidx")
    kk_cs_cmdnum = MakeInstanceKey(InstanceId, "_cs_cmdnum")
    kk_cs_cmdtype = MakeInstanceKey(InstanceId, "_cs_cmdtype")
    kk_cs_cmdname = MakeInstanceKey(InstanceId, "_cs_cmdname")
    kk_cs_gotoidx = MakeInstanceKey(InstanceId, "_cs_gotoidx")
    kk_cs_gotolabels = MakeInstanceKey(InstanceId, "_cs_gotolabels")
    kk_cs_gotocnt = MakeInstanceKey(InstanceId, "_cs_gotocnt")
    kk_cs_gosubidx = MakeInstanceKey(InstanceId, "_cs_gosubidx")
    kk_cs_gosublabels = MakeInstanceKey(InstanceId, "_cs_gosublabels")
    kk_cs_gosubcnt = MakeInstanceKey(InstanceId, "_cs_gosubcnt")
    kk_cs_gosubreturnstack = MakeInstanceKey(InstanceId, "_cs_gosubreturnstack")
    kk_cs_gosubreturnidx = MakeInstanceKey(InstanceId, "_cs_gosubreturnidx")
    kk_cs_mostrecentresult = MakeInstanceKey(InstanceId, "_cs_mostrecentresult")

    kk_cs_lastkey = MakeInstanceKey(InstanceId, "_cs_lastkey")
    kk_cs_iteractor = MakeInstanceKey(InstanceId, "_cs_iteractor")
EndFunction


Event OnPlayerLoadGame()
	instanceId = Heap_DequeueInstanceIdF(CmdTargetActor)

    currentCmdLine = Heap_StringListToArrayX(CmdTargetActor, InstanceId, CallstackId + "[" + cmdidx + "]")

    DoWhatYouShouldHaveDoneInTheFirstPlace()
EndEvent

Function DoWhatYouShouldHaveDoneInTheFirstPlace()
	SafeRegisterForModEvent_AME(self, EVENT_SLT_HEARTBEAT(), "OnSLTHeartbeat")
	SafeRegisterForModEvent_AME(self, EVENT_SLT_RESET(), "OnSLTReset")

    _slt_Setup_InstanceKeys()
    RegisterForScriptEvents()

	executionNotBegun = true
	QueueUpdateLoop(0.1)
EndFunction


Event OnEffectStart(Actor akTarget, Actor akCaster)
	CmdTargetActor = akCaster
	
	instanceId = Heap_DequeueInstanceIdF(CmdTargetActor)

    if !instanceId
        return
    endif

    DoWhatYouShouldHaveDoneInTheFirstPlace()
EndEvent

Event OnUpdate()
	If !Self
		Return
	EndIf
    
    if executionNotBegun
        executionNotBegun = false

        Send_X_ExecuteLine()
    endif

    QueueUpdateLoop()
EndEvent

Event OnKeyDown(Int keyCode)
    lastKey = keyCode
EndEvent

Event OnSLTHeartbeat(string eventName, string strArg, float numArg, Form sender)
EndEvent

Event OnSLTReset(string eventName, string strArg, float numArg, Form sender)
    PerformDigitalHygiene()
EndEvent

string Property command auto hidden

Function RunScript()
    ;string   command
    string   p1
    string   p2
    string   po
    string[] cmdLine

    if !cmdtype && !cmdNum && !cmdidx
        cmdType = _slt_ParseCommandFile()
        if !cmdType
            PerformDigitalHygiene()
            return
        endif
        cmdNum = Heap_IntGetX(CmdTargetActor, InstanceId, CallstackId)
        cmdidx = 0
    endif

    while cmdidx < cmdNum || callstackPointer

        if callstackPointer && cmdidx >= cmdNum
            sl_triggersCmd._slt_RemoveCallstack(CmdTargetActor, InstanceId)
            cmdidx += 1
        endif

        while cmdidx < cmdNum
            currentCmdLine = Heap_StringListToArrayX(CmdTargetActor, InstanceId, CallstackId + "[" + cmdidx + "]")
            cmdLine = currentCmdLine

            if cmdLine.Length
                command = resolve(cmdLine[0])
                cmdLine[0] = command

                If !command
                    cmdidx += 1
                elseIf command == "set"
                    if cmdLine.Length == 3 || cmdLine.Length == 5
                        int varindex = IsVarString(cmdLine[1])
                        int g_varindex = IsVarStringG(cmdLine[1])
                    
                        if (varindex > 0) || (g_varindex > 0)
                            if g_varindex > -1
                                varindex = g_varindex
                            endif
                        
                            string strparm2 = resolve(cmdLine[2])
                        
                            if cmdLine.length == 3
                                if g_varindex > -1
                                    globalvars_set(varindex, strparm2)
                                else
                                    vars_set(varindex, strparm2)
                                endif
                            elseif cmdLine.length == 5
                                string strparm4 = Resolve(cmdLine[4])
                                float op1 = strparm2 as float
                                float op2 = strparm4 as float
                                string operat = cmdLine[3]
                        
                                string strresult
                        
                                if operat == "+"
                                    strresult = (op1 + op2) as string
                                elseIf operat == "-"
                                    strresult = (op1 - op2) as string
                                elseIf operat == "*"
                                    strresult = (op1 * op2) as string
                                elseIf operat == "/"
                                    strresult = (op1 / op2) as string
                                elseIf operat == "&"
                                    strresult = strparm2 + strparm4
                                else
                                    DebMsg("SLT: [" + cmdName + "][lineNum:" + lineNum + "] unexpected operator for 'set' (" + operat + ")")
                                endif
                                if g_varindex > -1
                                    globalvars_set(varindex, strresult)
                                else
                                    vars_set(varindex, strresult)
                                endif
                            endif
                        endif
                    else
                        DebMsg("SLT: [" + cmdName + "][lineNum:" + lineNum + "] unexpected number of arguments for 'set' got " + cmdLine.length + " expected 3 or 5")
                    endif
                    cmdidx += 1
                elseIf command == "if"
                    if ParamLengthEQ(self, cmdLine.Length, 5)
                        ; ["if", "$$", "=", "0", "end"],
                        p1 = resolve(cmdLine[1])
                        p2 = resolve(cmdLine[3])
                        po = cmdLine[2]
                        
                        bool ifTrue = resolveCond(p1, p2, po)
                        if ifTrue
                            cmdidx = _slt_FindGoto(Resolve(cmdLine[4]), cmdidx, cmdtype)
                        endIf
                    endif
                    cmdidx += 1
                elseIf command == "inc"
                    if ParamLengthGT(self, cmdLine.Length, 1)
                        string varstr = cmdLine[1]
                        int incrInt = 1
                        float incrFloat = 1.0
                        bool isIncrInt = true
                        if cmdLine.Length > 2
                            incrInt = resolve(cmdLine[2]) as int
                            incrFloat = resolve(cmdLine[2]) as float
                            isIncrInt = (incrInt == incrFloat)
                        endif
                    
                        int varindex = IsVarStringG(varstr)
                        if varindex >= 0
                            int varint = globalvars_get(varindex) as int
                            float varfloat = globalvars_get(varindex) as float
                            if (varint == varfloat && isIncrInt)
                                globalvars_set(varindex, (varint + incrInt) as string)
                            else
                                globalvars_set(varindex, (varfloat + incrFloat) as string)
                            endif
                        else
                            varindex = IsVarString(varstr)
                            if varindex >= 0
                                int varint = vars_get(varindex) as int
                                float varfloat = vars_get(varindex) as float
                                if (varint == varfloat && isIncrInt)
                                    vars_set(varindex, (varint + incrInt) as string)
                                else
                                    vars_set(varindex, (varfloat + incrFloat) as string)
                                endif
                            else
                                DebMsg("SLT: [" + cmdName + "][lineNum:" + lineNum + "] no resolve found for variable parameter (" + cmdLine[1] + ")")
                            endif
                        endif
                    endif
                    cmdidx += 1
                elseIf command == "goto"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        cmdidx = _slt_FindGoto(Resolve(cmdLine[1]), cmdidx, cmdtype)
                    endif
                    cmdidx += 1
                elseIf command == "cat"
                    if ParamLengthGT(self, cmdLine.Length, 2)
                        string varstr = cmdLine[1]
                        float incrAmount = resolve(cmdLine[2]) as float
                    
                        int varindex = IsVarStringG(varstr)
                        if varindex >= 0
                            globalvars_set(varindex, (globalvars_get(varindex) + resolve(cmdLine[2])) as string)
                        else
                            varindex = IsVarString(varstr)
                            if varindex >= 0
                                vars_set(varindex, (vars_get(varindex) + resolve(cmdLine[2])) as string)
                            else
                                MiscUtil.PrintConsole("SLT: [" + cmdName + "][lineNum:" + lineNum + "] no resolve found for variable parameter (" + cmdLine[1] + ")")
                            endif
                        endif
                    endif
                    cmdidx += 1
                elseIf command == "gosub"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        cmdidx = _slt_FindGosub(Resolve(cmdLine[1]), cmdidx)
                    endif
                    cmdidx += 1
                elseIf command == "call"
                    if ParamLengthGT(self, cmdLine.Length, 1)
                        string callTarget = Resolve(cmdLine[1])
                        if _slt_IsFileParseable(callTarget)

                            sl_triggersCmd._slt_AddCallstack(CmdTargetActor, InstanceId, callTarget)

                            if cmdLine.Length > 2
                                string[] _callArgs = PapyrusUtil.SliceStringArray(cmdLine, 2)
                                int caidx = 0
                                while caidx < _callArgs.Length
                                    callargs_set(caidx, Resolve(_callargs[caidx]))
                                    caidx += 1
                                endwhile
                            endif
                        else
                            cmdidx += 1
                        endif
                    else
                        cmdidx += 1
                    endif
                elseIf command == "endsub"
                    if ParamLengthEQ(self, cmdLine.Length, 1)
                        cmdidx = _slt_PopSubIdx()
                    endif
                    cmdidx += 1
                elseIf command == "beginsub"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        _slt_AddGosub(cmdidx, Resolve(cmdLine[1]))
                    endif
                    ; still try to go through with finding the end
                    cmdidx = _slt_FindEndsub(cmdidx)
                    cmdidx += 1
                elseIf command == "callarg"
                    if ParamLengthEQ(self, cmdLine.Length, 3)
                        int argidx = cmdLine[1] as int
                        string arg = cmdLine[2]
                        string newval

                        if argidx < 128
                            newval = callargs_get(argidx) 
                        endif

                        int vidx = IsVarStringG(arg)
                        if vidx > 0
                            SLT.globalvars_set(vidx, newval)
                        else
                            vidx = IsVarString(arg)
                            if vidx > 0
                                vars_set(vidx, newval)
                            endif
                        endif
                    endif
                    cmdidx += 1
                elseIf command == "return"
                    if !callstackPointer
                        PerformDigitalHygiene()

                        return
                    endif
                    
                    sl_triggersCmd._slt_RemoveCallstack(CmdTargetActor, InstanceId)
                    cmdidx += 1
                else
                    string _slt_mightBeLabel = _slt_IsLabel(cmdType, cmdLine)
                    if _slt_mightBeLabel
                        _slt_AddGoto(cmdidx, _slt_mightBeLabel)
                    else
                        Send_X_ActualOper(command)
                        return
                    endif

                    cmdidx += 1
                endif
            else
                cmdidx += 1
            endif
        endwhile
    endwhile

    if !callstackPointer
        PerformDigitalHygiene()

        return
    endif
    
    DebMsg("this should not be possible")
    sl_triggersCmd._slt_RemoveCallstack(CmdTargetActor, InstanceId)
    cmdidx += 1
    
    Send_X_ExecuteLine()
EndFunction

Event OnSetOperationCompleted()
    cmdidx += 1
    RunScript()
EndEvent

Event On_X_ExecuteLine()
    RunScript()
EndEvent

Event On_X_ActualOper(string _code)
    _slt_ActualOper(currentCmdLine, _code)
EndEvent


Function Send_X_ExecuteLine()
    int handle = ModEvent.Create(_xn_execute_line)
    if handle
        ModEvent.Send(handle)
    endif
EndFunction

Function Send_X_ActualOper(string _code)
    int handle = ModEvent.Create(_xn_actual_oper)
    if handle
        ModEvent.PushString(handle, _code)
        ModEvent.Send(handle)
    endif
EndFunction

Function PerformDigitalHygiene()
    Heap_ClearPrefixF(CmdTargetActor, MakeInstanceKeyPrefix(instanceId))
    Heap_CompleteScript(CmdTargetActor, InstanceId)
    
    UnregisterForAllModEvents()
    Self.Dispel()
EndFunction

Function RegisterForScriptEvents()
    SafeRegisterForModEvent_AME(self, _xn_actual_oper,      "On_X_ActualOper")
    SafeRegisterForModEvent_AME(self, _xn_execute_line,     "On_X_ExecuteLine")
EndFunction

Function _slt_AddCallstack(Form _theForm, string _instanceId, string newscriptnm, int _forceCallstackPointer = 1) global
    int newcallstackpointer = StorageUtil.AdjustIntValue(_theForm, MakeInstanceKey(_instanceId, "_cs_callstack_pointer"), _forceCallstackPointer)
    
    StorageUtil.AdjustIntValue(_theForm, MakeInstanceKey(_instanceId, "_cs_callstack_list_pointer"), _forceCallstackPointer * 127)

    int nextup = StorageUtil.AdjustIntValue(_theForm, MakeInstanceKey(_instanceId, "_cs_callstackid_nextup"), 1)
    string _callstackId = "Callstack" + nextup
    StorageUtil.StringListAdd(_theForm, MakeInstanceKey(_instanceId, "_cs_callstackid"), _callstackId)

    StorageUtil.StringListAdd(_theForm, MakeInstanceKey(_instanceId, "_cs_vars_key_prefix"), "sl_triggers:" + _instanceId + ":" + _callstackId + ":vars")

    StorageUtil.IntListAdd(_theForm, MakeInstanceKey(_instanceId, "_cs_cmdidx"), 0)
    StorageUtil.IntListAdd(_theForm, MakeInstanceKey(_instanceId, "_cs_cmdnum"), 0)
    StorageUtil.StringListAdd(_theForm, MakeInstanceKey(_instanceId, "_cs_cmdtype"), "")
    StorageUtil.StringListAdd(_theForm, MakeInstanceKey(_instanceId, "_cs_cmdname"), newscriptnm)

    int newlen = StorageUtil.IntListCount(_theForm, MakeInstanceKey(_instanceId, "_cs_cmdidx")) * 127

    StorageUtil.StringListResize(_theForm, MakeInstanceKey(_instanceId, "_cs_callargs"), newlen)

    StorageUtil.IntListResize(_theForm, MakeInstanceKey(_instanceId, "_cs_gotoidx"), newlen)
    StorageUtil.StringListResize(_theForm, MakeInstanceKey(_instanceId, "_cs_gotolabels"), newlen)
    StorageUtil.IntListAdd(_theForm, MakeInstanceKey(_instanceId, "_cs_gotocnt"), 0)

    StorageUtil.IntListResize(_theForm, MakeInstanceKey(_instanceId, "_cs_gosubidx"), newlen)
    StorageUtil.StringListResize(_theForm, MakeInstanceKey(_instanceId, "_cs_gosublabels"), newlen)
    StorageUtil.IntListAdd(_theForm, MakeInstanceKey(_instanceId, "_cs_gosubcnt"), 0)

    StorageUtil.IntListResize(_theForm, MakeInstanceKey(_instanceId, "_cs_gosubreturnstack"), newlen)
    StorageUtil.IntListAdd(_theForm, MakeInstanceKey(_instanceId, "_cs_gosubreturnidx"), -1)

    StorageUtil.StringListAdd(_theForm, MakeInstanceKey(_instanceId, "_cs_mostrecentresult"), "")

    StorageUtil.IntListAdd(_theForm, MakeInstanceKey(_instanceId, "_cs_lastkey"), 0)

    StorageUtil.FormListAdd(_theForm, MakeInstanceKey(_instanceId, "_cs_iteractor"), none)

EndFunction

Function _slt_RemoveCallstack(Form _theForm, string _instanceId) global
    StorageUtil.AdjustIntValue(_theForm, MakeInstanceKey(_instanceId, "_cs_callstack_pointer"), -1)
    StorageUtil.AdjustIntValue(_theForm, MakeInstanceKey(_instanceId, "_cs_callstack_list_pointer"), -127)

    StorageUtil.StringListPop(_theForm, MakeInstanceKey(_instanceId, "_cs_callstackid"))

    StorageUtil.StringListPop(_theForm, MakeInstanceKey(_instanceId, "_cs_vars_key_prefix"))

    StorageUtil.IntListPop(_theForm, MakeInstanceKey(_instanceId, "_cs_cmdidx"))
    StorageUtil.IntListPop(_theForm, MakeInstanceKey(_instanceId, "_cs_cmdnum"))
    StorageUtil.StringListPop(_theForm, MakeInstanceKey(_instanceId, "_cs_cmdtype"))
    StorageUtil.StringListPop(_theForm, MakeInstanceKey(_instanceId, "_cs_cmdname"))

    int newlen = StorageUtil.IntListCount(_theForm, MakeInstanceKey(_instanceId, "_cs_cmdidx")) * 127

    StorageUtil.StringListResize(_theForm, MakeInstanceKey(_instanceId, "_cs_callargs"), newlen)

    StorageUtil.IntListResize(_theForm, MakeInstanceKey(_instanceId, "_cs_gotoidx"), newlen)
    StorageUtil.StringListResize(_theForm, MakeInstanceKey(_instanceId, "_cs_gotolabels"), newlen)
    StorageUtil.IntListAdd(_theForm, MakeInstanceKey(_instanceId, "_cs_gotocnt"), 0)

    StorageUtil.IntListResize(_theForm, MakeInstanceKey(_instanceId, "_cs_gosubidx"), newlen)
    StorageUtil.StringListResize(_theForm, MakeInstanceKey(_instanceId, "_cs_gosublabels"), newlen)
    StorageUtil.IntListPop(_theForm, MakeInstanceKey(_instanceId, "_cs_gosubcnt"))

    StorageUtil.IntListResize(_theForm, MakeInstanceKey(_instanceId, "_cs_gosubreturnstack"), newlen)
    StorageUtil.IntListPop(_theForm, MakeInstanceKey(_instanceId, "_cs_gosubreturnidx"))

    StorageUtil.StringListPop(_theForm, MakeInstanceKey(_instanceId, "_cs_mostrecentresult"))

    StorageUtil.IntListPop(_theForm, MakeInstanceKey(_instanceId, "_cs_lastkey"))

    StorageUtil.FormListPop(_theForm, MakeInstanceKey(_instanceId, "_cs_iteractor"))
EndFunction

bool Function _slt_PushSubIdx(int index)
    int newidx = gosubReturnIdx + 1

    if newidx >= 127
        return false
    endif
    gosubReturnStack_set(newidx, index)
    gosubReturnIdx = newidx
EndFunction

int Function _slt_PopSubIdx()
    if gosubReturnIdx < 0
        return -1
    endif
    int value = gosubReturnStack_get(gosubReturnIdx)
    gosubReturnIdx -= 1
    return value
EndFunction

; _slt_IsLabel
; _cmdtype:string: "ini" | "json"
; _tokens:string[]: the current token list being considered
;     assumptions:
;       currently only called as part of processing goto labels
;       assumes that the first token in the list (_tokens[0]) has already been resolved
;       assumes this is a probe, so no errors are squawked even if it is a "bad" label
;          unless you give me a stupid cmdtype, seriously
;       returns the resolve of the result, so in a json, second item could be a variable... we resolve that
;          yes, in an ini, you can have [$32]  and I will happily go find the value of $32 and use it as a label
;              yes, dynamic labels... so... I think you would have to:
;/
bloody hell, so much easier, so I think you would have to:

script.ini
----

; I am going to be fancy here
; what I ultimately want is a block of code that I can repeatedly call
; to let me configure that label... problem is, how can you do that
; easily? conventionally, you can set up some labels but
; I added subroutines and I want to show what you can do

; this is the start of a subroutine definition...at the top of the script
; initially the executor is going to ignore this block, noting the label
; for later use, 'config32'
[beginsub config32]


; here is our weird little label
[$32]



; when the executor hits the matching 'beginsub', meaning it's not trying to run it, it will scan for endsub and drop out
; we can take advantage of that... because it means there is nothing magical about subroutines
; they are just convenient markers in the scripts you can take advantage of
[endsub]


; now let's do something funny
; behind the scenes, if you put a regular label in the script, like so:
[a regular label]
; I just make a note of the line number so I can know where to pick up execution
; that is it... it is a label and a line number... nothing suspicious about that
; except since I resolve the $32 we can do this:

set $32 "first label"
gosub config32
set $32 "second label"
gosub config32


It means you can dynamically define different points that your script might jump to.
Yes, you would have to know the points to allow injection, but it does afford a little more flexibility.
I'll keep it. It doesn't hurt me, but use it at your own risk. I mean.. it's not dangerous, just saying
don't be surprised if you hurt yourself in your own confusion. :)


/;
string Function _slt_IsLabel(string _cmdtype, string[] _tokens = none)
    string isLabel
    
    if "ini" == _cmdtype
        if _tokens.Length == 1
            int _labelLen = StringUtil.GetLength(_tokens[0])

            if _labelLen > 2 && StringUtil.GetNthChar(_tokens[0], 0) == "[" && StringUtil.GetNthChar(_tokens[0], _labelLen - 1) == "]"
                isLabel = Resolve(StringUtil.Substring(_tokens[0], 1, _labelLen - 2))
            endif
        endif
    elseif "json" == _cmdtype
        if ":" == _tokens[0] && _tokens.Length >= 2 && _tokens[1]
            isLabel = Resolve(_tokens[1])
        endif
    else
        SquawkFunctionError(self, "label: unimplemented cmdtype provided (" + _cmdtype + ")")
    endif

    return isLabel
EndFunction

Function _slt_AddGoto(int _idx, string _label)
    int idx = 0
    while idx < gotoCnt
        if gotoLabels_get(idx) == _label
            return 
        endIf    
        idx += 1
    endWhile
    
    gotoIdx_set(gotoCnt, _idx)
    gotoLabels_set(gotoCnt, _label)
    gotoCnt += 1
EndFunction

Int Function _slt_FindGoto(string _label, int _cmdIdx, string _cmdtype)
    int idx = 0
    string[] cmdLine1
    string callstackIdxKey
    
    while !idx
        idx = gotoLabels_find(_label)
        if idx >= 0
            return gotoIdx_get(idx)
        elseif callstackIdxKey ; had to have been set once in the loop below
            return cmdNum
        else
            idx = _cmdIdx + 1

            callstackIdxKey = "[]" ; just to keep my promise above in case idx == cmdNum
            
            while idx < cmdNum
                callstackIdxKey = CallstackId + "[" + idx + "]"
                if Heap_StringListCountX(CmdTargetActor, InstanceId, callstackIdxKey) > 0
                    cmdLine1 = Heap_StringListToArrayX(CmdTargetActor, InstanceId, callstackIdxKey)
                    string _builtLabel = _slt_IsLabel(_cmdtype, cmdLine1)
                    if _builtLabel
                        _slt_AddGoto(idx, _builtLabel)
                    endIf
                endIf
                idx += 1
            endWhile

            idx = 0
        endIf
    endwhile

    DebMsg("again, another presumably impossible to reach line of code")

    return cmdNum
EndFunction

Function _slt_AddGosub(int _idx, string _label)
    int idx = 0
    while idx < gosubCnt
        if _label == gosubLabels_get(idx)
            return 
        endIf    
        idx += 1
    endWhile
    
    gosubIdx_set(gosubCnt, _idx)
    gosubLabels_set(gosubCnt, _label)
    gosubCnt += 1
EndFunction

Int Function _slt_FindGosub(string _label, int _cmdIdx)
    int idx
    
    idx = gosubLabels_find(_label)
    if idx >= 0
        _slt_PushSubIdx(_cmdIdx)
        return gosubIdx_get(idx)
    endIf
    
    string[] cmdLine1
    string   code
    
    idx = _cmdIdx + 1
    while idx < cmdNum
        cmdLine1 = Heap_StringListToArrayX(CmdTargetActor, InstanceId, CallstackId + "[" + idx + "]")
        if cmdLine1.Length
            if cmdLine1[0] == "beginsub"
                _slt_AddGosub(idx, cmdLine1[1])
            endIf
        endIf
        idx += 1
    endWhile

    idx = gosubLabels_find(_label)
    if idx >= 0
        _slt_PushSubIdx(_cmdIdx)
        return gosubIdx_get(idx)
    endIf
    return cmdNum
EndFunction

int Function _slt_FindEndsub(int _cmdIdx)
    int idx
    
    string[] cmdLine1
    string   code
    
    idx = _cmdIdx + 1
    while idx < cmdNum
        cmdLine1 = Heap_StringListToArrayX(CmdTargetActor, InstanceId, CallstackId + "[" + idx + "]")
        if cmdLine1.Length
            if cmdLine1[0] == "endsub"
                return idx
            endIf
        endIf
        idx += 1
    endWhile
    
    return cmdNum
EndFunction

bool Function _slt_IsFileParseable(string _theCmdName)
    string _myCmdName = _theCmdName
    string _last = StringUtil.Substring(_myCmdName, StringUtil.GetLength(_myCmdName) - 4)
    string[] cmdLine
    if _last != "json" && _last != ".ini"
        _myCmdName = _theCmdName + ".ini"
        if !MiscUtil.FileExists(FullCommandsFolder() + _myCmdName)
            _myCmdName = _theCmdName + "json"
            if !JsonUtil.JsonExists(CommandsFolder() + _myCmdName)
                return false
            else
                return true
            endif
        else
            return true
        endif
    endif
    return true
EndFunction

string Function _slt_ParseCommandFile()
    string _myCmdName = cmdName
    string _last = StringUtil.Substring(_myCmdName, StringUtil.GetLength(_myCmdName) - 4)
    
    string[] cmdLine
    if _last != "json" && _last != ".ini"
        _myCmdName = cmdName + ".ini"
        if !MiscUtil.FileExists(FullCommandsFolder() + _myCmdName)
            _myCmdName = cmdName + "json"
            if !JsonUtil.JsonExists(CommandsFolder() + _myCmdName)
                return ""
            else
                _last = "json"
            endif
        else
            _last = ".ini"
        endif
    endif

    int lineno = 0
    if _last == "json"
        _myCmdName = CommandsFolder() + _myCmdName
        cmdNum = JsonUtil.PathCount(_myCmdName, ".cmd")
        cmdIdx = 0
        while cmdIdx < cmdNum
            lineno += 1
            Heap_IntSetX(CmdTargetActor, InstanceId, CallstackId + "[" + cmdIdx + "]:line", lineno)
            cmdLine = JsonUtil.PathStringElements(_myCmdName, ".cmd[" + cmdIdx + "]")
            if cmdLine.Length
                Heap_IntAdjustX(CmdTargetActor, InstanceId, CallstackId, 1)
                int idx = 0
                while idx < cmdLine.Length
                    Heap_StringListAddX(CmdTargetActor, InstanceId, CallstackId + "[" + cmdIdx + "]", cmdLine[idx])
                    idx += 1
                endwhile
            endif
            cmdIdx += 1
        endwhile
        return "json"
    elseif _last == ".ini"
        string cmdpath = FullCommandsFolder() + _myCmdName
        string cmdstring = MiscUtil.ReadFromFile(cmdpath)
        string[] cmdlines = sl_triggers_internal.SafeSplitLinesTrimmed(cmdstring)

        cmdNum = cmdlines.Length
        cmdIdx = 0
        while cmdIdx < cmdNum
            lineno += 1
            Heap_IntSetX(CmdTargetActor, InstanceId, CallstackId + "[" + cmdIdx + "]:line", lineno)
            cmdLine = sl_triggers_internal.SafeTokenize(cmdlines[cmdIdx])
            if cmdLine.Length
                int idx = 0
                while idx < cmdLine.Length
                    Heap_StringListAddX(CmdTargetActor, InstanceId, CallstackId + "[" + cmdIdx + "]", cmdLine[idx])
                    idx += 1
                endwhile
            endif
            cmdIdx += 1
        endwhile
        Heap_IntSetX(CmdTargetActor, InstanceId, CallstackId, cmdNum)
        return "ini"
    endif
EndFunction

bool Function _slt_SLTResolve(string _code)
	int varindex = -1
    if StringUtil.getNthChar(_code, 0) == "$"
        if _code == "$$"
            CustomResolveResult = MostRecentResult
            return true
        else
			varindex = IsVarStringG(_code)
			if varindex >= 0
                CustomResolveResult = globalvars_get(varindex)
                return true
            else
                varindex = IsVarString(_code)
                if varindex >= 0
                    CustomResolveResult = vars_get(varindex)
                    return true
                endif
			endif
        endIf
    endIf
    return false
EndFunction

string Function _slt_ActualResolve(string _code)
    int i = 0
    
    bool _resolved = false
    bool _needSLT = true
    while i < SLT.Extensions.Length
        sl_triggersExtension slext = SLT.Extensions[i] as sl_triggersExtension

        if _needSLT && slext.GetPriority() >= 0
            _needSLT = false
            _resolved = _slt_SLTResolve(_code)
            if _resolved
                return CustomResolveResult
            endif
        endif
        
        _resolved = slext.CustomResolve(self, _code)
        if _resolved
            return CustomResolveResult
        endif

        i += 1
    endwhile
    
	return _code
EndFunction

bool Function _slt_SLTResolveActor(string _code)
    if _code == "$self"
        CustomResolveActorResult = CmdTargetActor
        return true
    elseIf _code == "$player"
        CustomResolveActorResult = PlayerRef
        return true
    elseIf _code == "$actor"
        CustomResolveActorResult = iterActor
        return true
    endif
    return false
EndFunction

Actor Function _slt_ActualResolveActor(string _code)
    int i = 0
    bool _resolved = false
    bool _needSLT = true
    while i < SLT.Extensions.Length
        sl_triggersExtension slext = SLT.Extensions[i] as sl_triggersExtension

        if _needSLT && slext.GetPriority() >= 0
            _needSLT = false
            _resolved = _slt_SLTResolveActor(_code)
            if _resolved
                return CustomResolveActorResult
            endif
        endif
        
        _resolved = slext.CustomResolveActor(self, _code)
        if _resolved
            return CustomResolveActorResult
        endif

        i += 1
    endwhile
	return CmdTargetActor
EndFunction

bool Function _slt_SLTResolveCond(string _p1, string _p2, string _oper)
    bool outcome = false
    if _oper == "="
        if (_p1 as float) == (_p2 as float)
            outcome = true
        endif
    elseIf _oper == "!="
        if (_p1 as float) != (_p2 as float)
            outcome = true
        endif
    elseIf _oper == ">"
        if (_p1 as float) > (_p2 as float)
            outcome = true
        endif
    elseIf _oper == ">="
        if (_p1 as float) >= (_p2 as float)
            outcome = true
        endif
    elseIf _oper == "<"
        if (_p1 as float) < (_p2 as float)
            outcome = true
        endif
    elseIf _oper == "<="
        if (_p1 as float) <= (_p2 as float)
            outcome = true
        endif
    elseIf _oper == "&="
        if _p1 == _p2
            outcome = true
        endif
    elseIf _oper == "&!="
        if _p1 != _p2
            outcome = true
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + cmdName + "][lineNum:" + lineNum + "] unexpected operator, this is likely an error in the SLT script")
        return false
    endif

    CustomResolveCondResult = outcome
    return true
EndFunction

bool Function _slt_ActualResolveCond(string _p1, string _p2, string _oper)
    int i = 0
    bool _resolved = false
    bool _needSLT = true
    while i < SLT.Extensions.Length
        sl_triggersExtension slext = SLT.Extensions[i] as sl_triggersExtension

        if _needSLT && slext.GetPriority() >= 0
            _needSLT = false
            _resolved = _slt_SLTResolveCond(_p1, _p2, _oper)
            if _resolved
                return CustomResolveCondResult
            endif
        endif
        
        _resolved = slext.CustomResolveCond(self, _p1, _p2, _oper)
        if _resolved
            return CustomResolveCondResult
        endif

        i += 1
    endwhile
	return false
EndFunction

bool Function _slt_ActualOper(string[] param, string code)
    string[] opsParam = PapyrusUtil.StringArray(param.Length)
    int i = 1
    opsParam[0] = code
    while i < opsParam.Length
        opsParam[i] = param[i]
        i += 1
    endwhile
    
    return sl_triggers_internal.SafeRunOperationOnActor(CmdTargetActor, self, opsParam)
EndFunction




; just the index into the StorageUtil lists
int Property callstackPointer Hidden
    int Function Get()
        return StorageUtil.GetIntValue(CmdTargetActor, kk_callstack_pointer, 0)
    EndFunction

    Function Set(int value)
        StorageUtil.SetIntValue(CmdTargetActor, kk_callstack_pointer, value)
    EndFunction
EndProperty

; * 127
int Property callstackListPointer Hidden
    int Function Get()
        return StorageUtil.GetIntValue(CmdTargetActor, kk_callstack_list_pointer, 0)
    EndFunction

    Function Set(int value)
        StorageUtil.SetIntValue(CmdTargetActor, kk_callstack_list_pointer, value)
    EndFunction
EndProperty

string Property CallstackId Hidden
    string Function Get()
        return StorageUtil.StringListGet(CmdTargetActor, kk_cs_callstackid, callstackPointer)
    EndFunction

    Function Set(string value)
        StorageUtil.StringListSet(CmdTargetActor, kk_cs_callstackid, callstackPointer, value)
    EndFunction
EndProperty

string Property VARS_KEY_PREFIX Hidden
    string Function Get()
        return StorageUtil.StringListGet(CmdTargetActor, kk_cs_vars_key_prefix, callstackPointer)
    EndFunction

    Function Set(string value)
        StorageUtil.StringListSet(CmdTargetActor, kk_cs_vars_key_prefix, callstackPointer, value)
    EndFunction
EndProperty

int			Property lastKey Hidden
    int Function Get()
        return StorageUtil.IntListGet(CmdTargetActor, kk_cs_lastkey, callstackPointer)
    EndFunction

    Function Set(int value)
        StorageUtil.IntListSet(CmdTargetActor, kk_cs_lastkey, callstackPointer, value)
    EndFunction
EndProperty

Actor		Property iterActor Hidden
    Actor Function Get()
        return StorageUtil.FormListGet(CmdTargetActor, kk_cs_iteractor, callstackPointer) as Actor
    EndFunction

    Function Set(Actor value)
        StorageUtil.FormListSet(CmdTargetActor, kk_cs_iteractor, callstackPointer, value)
    EndFunction
EndProperty

string      Property cmdName Hidden
    string Function Get()
        return StorageUtil.StringListGet(CmdTargetActor, kk_cs_cmdname, callstackPointer)
    EndFunction

    Function Set(string value)
        StorageUtil.StringListSet(CmdTargetActor, kk_cs_cmdname, callstackPointer, value)
    EndFunction
EndProperty

int         Property cmdIdx Hidden
    int Function Get()
        return StorageUtil.IntListGet(CmdTargetActor, kk_cs_cmdidx, callstackPointer)
    EndFunction

    Function Set(int value)
        StorageUtil.IntListSet(CmdTargetActor, kk_cs_cmdidx, callstackPointer, value)
    EndFunction
EndProperty

int         Property lineNum Hidden
    int Function Get()
        return Heap_IntGetX(CmdTargetActor, InstanceId, CallstackId + "[" + cmdIdx + "]:line", -1)
    EndFunction
EndProperty

int			Property cmdNum Hidden
    int Function Get()
        return StorageUtil.IntListGet(CmdTargetActor, kk_cs_cmdnum, callstackPointer)
    EndFunction

    Function Set(int value)
        StorageUtil.IntListSet(CmdTargetActor, kk_cs_cmdnum, callstackPointer, value)
    EndFunction
EndProperty

string      Property cmdType Hidden
    string Function Get()
        return StorageUtil.StringListGet(CmdTargetActor, kk_cs_cmdtype, callstackPointer)
    EndFunction

    Function Set(string value)
        StorageUtil.StringListSet(CmdTargetActor, kk_cs_cmdtype, callstackPointer, value)
    EndFunction
EndProperty

;string[]   _callargs
string Function callargs_get(int idx)
    return StorageUtil.StringListGet(CmdTargetActor, kk_cs_callargs, callstackListPointer + idx)
EndFunction
Function callargs_set(int idx, string value)
    StorageUtil.StringListSet(CmdTargetActor, kk_cs_callargs, callstackListPointer + idx, value)
EndFunction
int Function callargs_find(string value)
    return StorageUtil.StringListFind(CmdTargetActor, kk_cs_callargs, value)
EndFunction

;int[]		gotoIdx 
int Function gotoIdx_get(int idx)
    return StorageUtil.IntListGet(CmdTargetActor, kk_cs_gotoidx, callstackListPointer + idx)
EndFunction
Function gotoIdx_set(int idx, int value)
    StorageUtil.IntListSet(CmdTargetActor, kk_cs_gotoidx, callstackListPointer + idx, value)
EndFunction

;string[]	gotoLabels 
string Function gotoLabels_get(int idx)
    return StorageUtil.StringListGet(CmdTargetActor, kk_cs_gotolabels, callstackListPointer + idx)
EndFunction
Function gotoLabels_set(int idx, string value)
    StorageUtil.StringListSet(CmdTargetActor, kk_cs_gotolabels, callstackListPointer + idx, value)
EndFunction
int Function gotoLabels_find(string value)
    return StorageUtil.StringListFind(CmdTargetActor, kk_cs_gotolabels, value)
EndFunction

int			Property gotoCnt Hidden
    int Function Get()
        return StorageUtil.IntListGet(CmdTargetActor, kk_cs_gotocnt, callstackPointer)
    EndFunction

    Function Set(int value)
        StorageUtil.IntListSet(CmdTargetActor, kk_cs_gotocnt, callstackPointer, value)
    EndFunction
EndProperty

;int[]       gosubIdx
int Function gosubIdx_get(int idx)
    return StorageUtil.IntListGet(CmdTargetActor, kk_cs_gosubidx, callstackListPointer + idx)
EndFunction
Function gosubIdx_set(int idx, int value)
    StorageUtil.IntListSet(CmdTargetActor, kk_cs_gosubidx, callstackListPointer + idx, value)
EndFunction

;string[]    gosubLabels
string Function gosubLabels_get(int idx)
    return StorageUtil.StringListGet(CmdTargetActor, kk_cs_gosublabels, callstackListPointer + idx)
EndFunction
Function gosubLabels_set(int idx, string value)
    StorageUtil.StringListSet(CmdTargetActor, kk_cs_gosublabels, callstackListPointer + idx, value)
EndFunction
int Function gosubLabels_find(string value)
    return StorageUtil.StringListFind(CmdTargetActor, kk_cs_gosublabels, value)
EndFunction

int         Property gosubCnt Hidden
    int Function Get()
        return StorageUtil.IntListGet(CmdTargetActor, kk_cs_gosubcnt, callstackPointer)
    EndFunction

    Function Set(int value)
        StorageUtil.IntListSet(CmdTargetActor, kk_cs_gosubcnt, callstackPointer, value)
    EndFunction
EndProperty

;int[]       gosubReturnStack
int Function gosubReturnStack_get(int idx)
    return StorageUtil.IntListGet(CmdTargetActor, kk_cs_gosubreturnstack, callstackListPointer + idx)
EndFunction
Function gosubReturnStack_set(int idx, int value)
    StorageUtil.IntListSet(CmdTargetActor, kk_cs_gosubreturnstack, callstackListPointer + idx, value)
EndFunction
int Function gosubReturnStack_size()
    return StorageUtil.IntListCount(CmdTargetActor, kk_cs_gosubreturnstack)
EndFunction

int         Property gosubReturnIdx Hidden
    int Function Get()
        return StorageUtil.IntListGet(CmdTargetActor, kk_cs_gosubreturnidx, callstackPointer)
    EndFunction

    Function Set(int value)
        StorageUtil.IntListSet(CmdTargetActor, kk_cs_gosubreturnidx, callstackPointer, value)
    EndFunction
EndProperty

string	    Property MostRecentResult Hidden
    string Function Get()
        return StorageUtil.StringListGet(CmdTargetActor, kk_cs_mostrecentresult, callstackPointer)
    EndFunction

    Function Set(string value)
        StorageUtil.StringListSet(CmdTargetActor, kk_cs_mostrecentresult, callstackPointer, value)
    EndFunction
EndProperty