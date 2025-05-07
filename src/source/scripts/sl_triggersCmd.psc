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
string		    Property MostRecentResult Auto Hidden

bool            Property CustomResolveReady Auto Hidden
bool            Property CustomResolveHandled Auto Hidden
string _customResolveResult
string          Property CustomResolveResult Hidden
    string Function Get()
        return _customResolveResult
    EndFunction

    Function Set(string value)
        _customResolveResult = value
        CustomResolveHandled = true
    EndFunction
EndProperty

bool            Property CustomResolveActorReady Auto Hidden
bool            Property CustomResolveActorHandled Auto Hidden
Actor _customResolveActorResult
Actor           Property CustomResolveActorResult Hidden
    Actor Function Get()
        return _customResolveActorResult
    EndFunction

    Function Set(Actor value)
        _customResolveActorResult = value
        CustomResolveActorHandled = true
    EndFunction
EndProperty

bool            Property CustomResolveCondReady Auto Hidden
bool            Property CustomResolveCondHandled Auto Hidden
bool _customResolveCondResult
bool            Property CustomResolveCondResult Hidden
    bool Function Get()
        return _customResolveCondResult
    EndFunction

    Function Set(bool value)
        _customResolveCondResult = value
        CustomResolveCondHandled = true
    EndFunction
EndProperty

; Properties
int			Property lastKey Auto Hidden
Actor		Property iterActor Auto Hidden
string      Property cmdName Auto Hidden
int         Property cmdIdx Auto Hidden
int         Property lineNum Auto Hidden


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

String Function GetInstanceId()
	return InstanceId
EndFunction

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
string      VARS_KEY_PREFIX

bool executionNotBegun

string[] currentCmdLine
bool firstPass = true

string[]    _callArgs
float       _maxSeconds = 10.0

string _xn_execute_line
string _xn_actual_oper

; callstack variables
;int			cmdIdx
int			cmdNum
;string		cmdName
string      cmdType
int[]		gotoIdx 
string[]	gotoLabels 
int			gotoCnt 
int[]       gosubIdx
string[]    gosubLabels
int         gosubCnt
int[]       gosubReturnStack
int         gosubReturnIdx
string	    MostRecentResult

; multi-callstack support
string      CallstackId
int         _callstackIdNextUp
string[]    _callstack_stack ; ugh
int[]       _cs_cmdIdx
int[]       _cs_cmdNum
string[]    _cs_cmdType
string[]    _cs_cmdName
int[]       _cs_gotoIdx
string[]    _cs_gotoLabels
int[]       _cs_gotoCnt
int[]       _cs_gosubIdx
string[]    _cs_gosubLabels
int[]       _cs_gosubCnt
int[]       _cs_gosubReturnStack
int[]       _cs_gosubReturnIdx
string[]    _csMostRecentResult

Event OnEffectStart(Actor akTarget, Actor akCaster)
    cmdIdx = 0
    
    gotoCnt = 0
    gotoIdx = new int[127]
    gotoLabels = new string[127]
    gosubCnt = 0
    gosubIdx = new int[127]
    gosubLabels = new string[127]
    gosubReturnStack = new int[127]
    gosubReturnIdx = -1
    
	CmdTargetActor = akCaster
	
	instanceId = Heap_DequeueInstanceIdF(CmdTargetActor)
   	cmdName = Heap_StringGetFK(CmdTargetActor, MakeInstanceKey(instanceId, "cmd"))
	
	SafeRegisterForModEvent_AME(self, EVENT_SLT_HEARTBEAT(), "OnSLTHeartbeat")
	SafeRegisterForModEvent_AME(self, EVENT_SLT_RESET(), "OnSLTReset")

    CallstackId = "Callstack" + _callstackIdNextUp
    _callstackIdNextUp += 1
    VARS_KEY_PREFIX = "sl_triggers:" + InstanceId + ":" + CallstackId + ":vars"

    RegisterForScriptEvents()

	executionNotBegun = true
	QueueUpdateLoop(0.1)
EndEvent

Event OnUpdate()
	If !Self
		Return
	EndIf
    
    if executionNotBegun
        executionNotBegun = false
        
        SetupCallstack()

        Send_X_ExecuteLine()
    endif

    QueueUpdateLoop(5.0)
EndEvent

Event OnKeyDown(Int keyCode)
    lastKey = keyCode
    ;MiscUtil.PrintConsole("KeyDown: " + lastKey)
EndEvent

Event OnSLTHeartbeat(string eventName, string strArg, float numArg, Form sender)
EndEvent

Event OnSLTReset(string eventName, string strArg, float numArg, Form sender)
    PerformDigitalHygiene()
EndEvent

Function RunScript()
    string   code
    string   p1
    string   p2
    string   po
    string[] cmdLine

    while firstPass || (_cs_cmdIdx && _cs_cmdIdx.Length > 0) || cmdidx < cmdNum
        if firstPass
            firstPass = false
        elseif (_cs_cmdIdx && _cs_cmdIdx.Length > 0) && cmdidx >= cmdNum
            _slt_PopCallstack()
            cmdidx += 1
        endif

        while cmdidx < cmdNum
            lineNum = Heap_IntGetX(CmdTargetActor, GetInstanceId(), CallstackId + "[" + cmdIdx + "]:line", -1)
            currentCmdLine = Heap_StringListToArrayX(CmdTargetActor, GetInstanceId(), CallstackId + "[" + cmdidx + "]")
            cmdLine = currentCmdLine

            if cmdLine.Length
                code = resolve(cmdLine[0])

                if (cmdtype == "json" && code == ":") || (cmdtype == "ini" && cmdLine.Length == 1 && StringUtil.GetNthChar(code, 0) == "[" && StringUtil.GetNthChar(code, StringUtil.GetLength(code) - 1) == "]")
                    if cmdtype == "json"
                        _slt_AddGoto(cmdidx, Resolve(cmdLine[1]))
                    elseif cmdtype == "ini"
                        _slt_AddGoto(cmdidx, Resolve(StringUtil.Substring(code, 1, StringUtil.GetLength(code) - 2)))
                    endif
                    cmdidx += 1
                elseIf code == "beginsub"
                    _slt_AddGosub(cmdidx, Resolve(cmdLine[1]))
                    cmdidx = _slt_FindEndsub(cmdidx)
                    cmdidx += 1
                elseIf code == "endsub"
                    cmdidx = _slt_PopSubIdx()
                    cmdidx += 1
                elseIf code == "goto"
                    if cmdLine.Length == 2
                        cmdidx = _slt_FindGoto(Resolve(cmdLine[1]), cmdidx, cmdtype)
                    endif
                    cmdidx += 1
                elseIf code == "gosub"
                    if cmdLine.Length == 2
                        cmdidx = _slt_FindGosub(Resolve(cmdLine[1]), cmdidx)
                    endif
                    cmdidx += 1
                elseIf code == "set"
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
                elseIf code == "inc"
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
                elseIf code == "cat"
                    if cmdLine.Length >= 3
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
                    else
                        ParamLengthLT(self, cmdLine.Length, 3)
                    endif
                    cmdidx += 1
                elseIf code == "if"
                    if cmdLine.Length == 5
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
                elseIf code == "return"
                    if !_cs_cmdIdx || _cs_cmdIdx.Length < 1
                        PerformDigitalHygiene()

                        return
                    endif
                    
                    _slt_PopCallstack()
                    cmdidx += 1
                elseIf code == "call"
                    string callTarget = Resolve(cmdLine[1])
                    if cmdLine.Length == 2 && _slt_IsFileParseable(callTarget)
                        _callArgs = PapyrusUtil.SliceStringArray(cmdLine, 2)
                        int caidx = 0
                        while caidx < _callArgs.Length
                            _callArgs[caidx] = resolve(_callArgs[caidx])
                            caidx += 1
                        endwhile
                        
                        _slt_PushCallstack(callTarget)
                    else
                        cmdidx += 1
                    endif
                elseIf code == "callarg"
                    if cmdLine.Length == 3
                        int argidx = cmdLine[1] as int
                        string arg = cmdLine[2]
                        string newval

                        if argidx < _callArgs.Length
                            newval = _callArgs[argidx]
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
                elseIf !code
                    cmdidx += 1
                else
                    Send_X_ActualOper(code)
                    return
                endIf
            else
                cmdidx += 1
            endif
        endwhile
    endwhile

    if !_cs_cmdIdx || _cs_cmdIdx.Length < 1
        PerformDigitalHygiene()

        return
    endif
    
    DebMsg("this should not be possible")
    _slt_PopCallstack()
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

Function SetupCallstack()
    Heap_IntSetX(CmdTargetActor, GetInstanceId(), CallstackId, 0)

    cmdType = _slt_ParseCommandFile()

    cmdNum = Heap_IntGetX(CmdTargetActor, GetInstanceId(), CallstackId)
    
    cmdidx = 0
EndFunction

Function PerformDigitalHygiene()
    Heap_ClearPrefixF(CmdTargetActor, MakeInstanceKeyPrefix(instanceId))
    
    UnregisterForAllModEvents()
    Self.Dispel()
EndFunction

Function RegisterForScriptEvents()
    if !_xn_execute_line
        _xn_actual_oper     = "_xn_actual_oper:" + InstanceId
        _xn_execute_line    = "_xn_execute_line:" + InstanceId
    endif
    SafeRegisterForModEvent_AME(self, _xn_actual_oper,      "On_X_ActualOper")
    SafeRegisterForModEvent_AME(self, _xn_execute_line,     "On_X_ExecuteLine")
EndFunction

Function _slt_PushCallstack(string newcommand)
    if !_cs_cmdIdx
        _callstack_stack = PapyrusUtil.StringArray(0)
        _cs_cmdIdx = PapyrusUtil.IntArray(0)
        _cs_cmdNum = PapyrusUtil.IntArray(0)
        _cs_cmdType = PapyrusUtil.StringArray(0)
        _cs_cmdName = PapyrusUtil.StringArray(0)
        _cs_gotoIdx = PapyrusUtil.IntArray(0)
        _cs_gotoLabels = PapyrusUtil.StringArray(0)
        _cs_gotoCnt = PapyrusUtil.IntArray(0)
        _cs_gosubIdx = PapyrusUtil.IntArray(0)
        _cs_gosubLabels = PapyrusUtil.StringArray(0)
        _cs_gosubCnt = PapyrusUtil.IntArray(0)
        _cs_gosubReturnStack = PapyrusUtil.IntArray(0)
        _cs_gosubReturnIdx = PapyrusUtil.IntArray(0)
        _csMostRecentResult = PapyrusUtil.StringArray(0)
    endif

    _callstack_stack = PapyrusUtil.PushString(_callstack_stack, CallstackId)

    CallstackId = "Callstack" + _callstackIdNextUp
    _callstackIdNextUp += 1
    VARS_KEY_PREFIX = "sl_triggers:" + InstanceId + ":" + CallstackId + ":vars"

    int i
    int offset = 127 * _cs_cmdIdx.Length
    _cs_cmdIdx = PapyrusUtil.PushInt(_cs_cmdIdx, cmdIdx)

    _cs_cmdNum = PapyrusUtil.PushInt(_cs_cmdNum, cmdNum)
    _cs_cmdName = PapyrusUtil.PushString(_cs_cmdName, cmdName)
    _cs_cmdType = PapyrusUtil.PushString(_cs_cmdType, cmdType)

    _cs_gotoIdx = PapyrusUtil.ResizeIntArray(_cs_gotoIdx, _cs_gotoIdx.Length + 127)
    i = 0
    while i < 127
        _cs_gotoIdx[i + offset] = gotoIdx[i]
        i += 1
    endwhile

    _cs_gotoLabels = PapyrusUtil.ResizeStringArray(_cs_gotoLabels, _cs_gotoLabels.Length + 127)
    i = 0
    while i < 127
        _cs_gotoLabels[i + offset] = gotoLabels[i]
        i += 1
    endwhile

    _cs_gotoCnt = PapyrusUtil.PushInt(_cs_gotoCnt, gotoCnt)

    _cs_gosubIdx = PapyrusUtil.ResizeIntArray(_cs_gosubIdx, _cs_gosubIdx.Length + 127)
    i = 0
    while i < 127
        _cs_gosubIdx[i + offset] = gosubIdx[i]
        i += 1
    endwhile

    _cs_gosubLabels = PapyrusUtil.ResizeStringArray(_cs_gosubLabels, _cs_gosubLabels.Length + 127)
    i = 0
    while i < 127
        _cs_gosubLabels[i + offset] = gosubLabels[i]
        i += 1
    endwhile

    _cs_gosubCnt = PapyrusUtil.PushInt(_cs_gosubCnt, gosubCnt)

    _cs_gosubReturnStack = PapyrusUtil.ResizeIntArray(_cs_gosubReturnStack, _cs_gosubReturnStack.Length + 127)
    i = 0
    while i < 127
        _cs_gosubReturnStack[i + offset] = gosubReturnStack[i]
        i += 1
    endwhile

    _cs_gosubReturnIdx = PapyrusUtil.PushInt(_cs_gosubReturnIdx, gosubReturnIdx)
    _csMostRecentResult = PapyrusUtil.PushString(_csMostRecentResult, MostRecentResult)

    ; and reset for the new callstack
    gotoIdx = new int[127]
    gotoLabels = new string[127]
    gotoCnt = 0
    gosubIdx = new int[127]
    gosubLabels = new string[127]
    gosubCnt = 0
    gosubReturnStack = new int[127]
    gosubReturnIdx = -1
    MostRecentResult = ""
    
    cmdName = newcommand

    SetupCallstack()
EndFunction

Function _slt_PopCallstack()
    if !_cs_cmdIdx || _cs_cmdIdx.Length < 1
        return
    endif

    int i
    int len = _cs_cmdIdx.Length - 1
    int offset = 127 * len
    
    CallstackId = _callstack_stack[len]
    _callstack_stack = PapyrusUtil.ResizeStringArray(_callstack_stack, len)
    VARS_KEY_PREFIX = "sl_triggers:" + InstanceId + ":" + CallstackId + ":vars"

    cmdIdx = _cs_cmdIdx[len]
    _cs_cmdIdx = PapyrusUtil.ResizeIntArray(_cs_cmdIdx, len)

    cmdNum = _cs_cmdNum[len]
    _cs_cmdNum = PapyrusUtil.ResizeIntArray(_cs_cmdNum, len)

    cmdName = _cs_cmdName[len]
    _cs_cmdName = PapyrusUtil.ResizeStringArray(_cs_cmdName, len)

    cmdType = _cs_cmdType[len]
    _cs_cmdType = PapyrusUtil.ResizeStringArray(_cs_cmdType, len)

    i = 0
    while i < 127
        gotoIdx[i] = _cs_gotoIdx[i + offset]
        i += 1
    endwhile
    _cs_gotoIdx = PapyrusUtil.ResizeIntArray(_cs_gotoIdx, len)

    i = 0
    while i < 127
        gotoLabels[i] = _cs_gotoLabels[i + offset]
        i += 1
    endwhile
    _cs_gotoLabels = PapyrusUtil.ResizeStringArray(_cs_gotoLabels, len)

    gotoCnt = _cs_gotoCnt[len]
    _cs_gotoCnt = PapyrusUtil.ResizeIntArray(_cs_gotoCnt, len)

    i = 0
    while i < 127
        gosubIdx[i] = _cs_gosubIdx[i + offset]
        i += 1
    endwhile
    _cs_gosubIdx = PapyrusUtil.ResizeIntArray(_cs_gosubIdx, len)

    i = 0
    while i < 127
        gosubLabels[i] = _cs_gosubLabels[i + offset]
        i += 1
    endwhile
    _cs_gosubLabels = PapyrusUtil.ResizeStringArray(_cs_gosubLabels, len)

    gosubCnt = _cs_gosubCnt[len]
    _cs_gosubCnt = PapyrusUtil.ResizeIntArray(_cs_gosubCnt, len)

    i = 0
    while i < 127
        gosubReturnStack[i] = _cs_gosubReturnStack[i + offset]
        i += 1
    endwhile
    _cs_gosubReturnStack = PapyrusUtil.ResizeIntArray(_cs_gosubReturnStack, len)

    gosubReturnIdx = _cs_gosubReturnIdx[len]
    _cs_gosubReturnIdx = PapyrusUtil.ResizeIntArray(_cs_gosubReturnIdx, len)
    MostRecentResult = _csMostRecentResult[len]
    _csMostRecentResult = PapyrusUtil.ResizeStringArray(_csMostRecentResult, len)
EndFunction

bool Function _slt_PushSubIdx(int index)
    int newidx = gosubReturnIdx + 1

    if newidx >= gosubReturnStack.Length
        return false
    endif
    gosubReturnStack[newidx] = index
    gosubReturnIdx = newidx
EndFunction

int Function _slt_PopSubIdx()
    if gosubReturnIdx < 0
        return -1
    endif
    int value = gosubReturnStack[gosubReturnIdx]
    gosubReturnIdx -= 1
    return value
EndFunction

Function _slt_AddGoto(int _idx, string _label)
    int idx
    
    idx = 0
    while idx < gotoCnt
        if gotoLabels[idx] == _label
            return 
        endIf    
        idx += 1
    endWhile
    
    gotoIdx[gotoCnt] = _idx
    gotoLabels[gotoCnt] = _label
    gotoCnt += 1
EndFunction

Int Function _slt_FindGoto(string _label, int _cmdIdx, string _cmdtype)
    int idx
    
    idx = gotoLabels.find(_label)
    if idx >= 0
        return gotoIdx[idx]
    endIf
    
    string[] cmdLine1
    string   code
    
    idx = _cmdIdx + 1
    while idx < cmdNum
        cmdLine1 = Heap_StringListToArrayX(CmdTargetActor, GetInstanceId(), CallstackId + "[" + idx + "]")
        if cmdLine1.Length
            if (_cmdtype == "json" && cmdLine1[0] == ":") || (_cmdtype == "ini" && cmdLine1.Length == 1 && StringUtil.GetNthChar(cmdLine1[0], 0) == "[" && StringUtil.GetNthChar(cmdLine1[0], StringUtil.GetLength(cmdLine1[0]) - 1) == "]")
                if _cmdtype == "json"
                    _slt_AddGoto(idx, cmdLine1[1])
                elseif _cmdtype == "ini"
                    _slt_AddGoto(idx, StringUtil.Substring(cmdLine1[0], 1, StringUtil.GetLength(cmdLine1[0]) - 2))
                endif
            endIf
        endIf
        idx += 1
    endWhile

    idx = gotoLabels.find(_label)
    if idx >= 0
        return gotoIdx[idx]
    endIf
    return cmdNum
EndFunction

Function _slt_AddGosub(int _idx, string _label)
    int idx
    
    idx = 0
    while idx < gosubCnt
        if gosubLabels[idx] == _label
            return 
        endIf    
        idx += 1
    endWhile
    
    gosubIdx[gosubCnt] = _idx
    gosubLabels[gosubCnt] = _label
    gosubCnt += 1
EndFunction

Int Function _slt_FindGosub(string _label, int _cmdIdx)
    int idx
    
    idx = gosubLabels.find(_label)
    if idx >= 0
        _slt_PushSubIdx(_cmdIdx)
        return gosubIdx[idx]
    endIf
    
    string[] cmdLine1
    string   code
    
    idx = _cmdIdx + 1
    while idx < cmdNum
        cmdLine1 = Heap_StringListToArrayX(CmdTargetActor, GetInstanceId(), CallstackId + "[" + idx + "]")
        if cmdLine1.Length
            if cmdLine1[0] == "beginsub"
                _slt_AddGosub(idx, cmdLine1[1])
            endIf
        endIf
        idx += 1
    endWhile

    idx = gosubLabels.find(_label)
    if idx >= 0
        _slt_PushSubIdx(_cmdIdx)
        return gosubIdx[idx]
    endIf
    return cmdNum
EndFunction

int Function _slt_FindEndsub(int _cmdIdx)
    int idx
    
    string[] cmdLine1
    string   code
    
    idx = _cmdIdx + 1
    while idx < cmdNum
        cmdLine1 = Heap_StringListToArrayX(CmdTargetActor, GetInstanceId(), CallstackId + "[" + idx + "]")
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
            Heap_IntSetX(CmdTargetActor, GetInstanceId(), CallstackId + "[" + cmdIdx + "]:line", lineno)
            cmdLine = JsonUtil.PathStringElements(_myCmdName, ".cmd[" + cmdIdx + "]")
            if cmdLine.Length
                Heap_IntAdjustX(CmdTargetActor, GetInstanceId(), CallstackId, 1)
                int idx = 0
                while idx < cmdLine.Length
                    Heap_StringListAddX(CmdTargetActor, GetInstanceId(), CallstackId + "[" + cmdIdx + "]", cmdLine[idx])
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
            Heap_IntSetX(CmdTargetActor, GetInstanceId(), CallstackId + "[" + cmdIdx + "]:line", lineno)
            cmdLine = sl_triggers_internal.SafeTokenize(cmdlines[cmdIdx])
            if cmdLine.Length
                int idx = 0
                while idx < cmdLine.Length
                    Heap_StringListAddX(CmdTargetActor, GetInstanceId(), CallstackId + "[" + cmdIdx + "]", cmdLine[idx])
                    idx += 1
                endwhile
            endif
            cmdIdx += 1
        endwhile
        Heap_IntSetX(CmdTargetActor, GetInstanceId(), CallstackId, cmdNum)
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
