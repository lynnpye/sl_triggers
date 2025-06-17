Scriptname sl_TriggersCmd extends ActiveMagicEffect

import sl_triggersStatics
import sl_triggersContext

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

bool        Property isExecuting = false Auto Hidden
int         Property threadid = 0 Auto Hidden
int         Property frameid = 0 Auto Hidden
int         Property previousFrameId = 0 Auto Hidden

int			Property lastKey = 0 auto  Hidden
bool        Property cleanedup = false auto  hidden

string	    Property MostRecentResult = "" auto Hidden
Actor       Property iterActor = none auto Hidden
string      Property currentScriptName = "" auto hidden
int         Property currentLine = 0 auto hidden
int         Property totalLines = 0 auto hidden
int         Property lineNum = 1 auto hidden
int[]       Property returnstack  auto hidden
string[]    Property callargs auto hidden
string      Property command = "" auto hidden

Function SFE(string msg)
	SquawkFunctionError(self, msg)
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	CmdTargetActor = akCaster
    ; do one time things here, maybe setting up an instanceid if necessary
    DoStartup()
EndEvent

Event OnPlayerLoadGame()
    DoStartup()
EndEvent

Function DoStartup()
	SafeRegisterForModEvent_AME(self, EVENT_SLT_RESET(), "OnSLTReset")
    
    if !threadid
        ; need to determine our threadid
        threadid = Target_ClaimNextThread(SLT)
        returnstack = PapyrusUtil.IntArray(0)
        callargs = PapyrusUtil.StringArray(0)
        if threadid
            Frame_Push(self, Thread_GetInitialScriptName(threadid))
        endif
    endif

    if threadid && frameid
        isExecuting = true
        QueueUpdateLoop(0.1)
    else
        CleanupAndRemove()
    endif
EndFunction

Event OnUpdate()
    if !self
        return
    endif
    
    CleanupAndRemove()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    CleanupAndRemove()
EndEvent

Event OnSLTReset(string eventName, string strArg, float numArg, Form sender)
    CleanupAndRemove()
EndEvent

Function CleanupAndRemove()
    if cleanedup
        return
    endif
    cleanedup = true
    UnregisterForAllModEvents()
    isExecuting = false

    if frameid
        Frame_Cleanup(frameid)
    endif

    if threadid
        ; clean up StorageUtil?
        Thread_Cleanup(threadid)
    endif

    Self.Dispel()
EndFunction

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
    return sl_triggers_internal.ResolveValueVariable(threadid, _code)
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
    return sl_triggers_internal.ResolveFormVariable(threadid, _code)
EndFunction









Function RunScript()
    ;string   command
    string   p1
    string   p2
    string   po
    string[] cmdLine

    while frameid
        while currentLine < totalLines
            lineNum = Frame_GetLineNum(frameid, currentLine)
            cmdLine = Frame_GetTokens(frameid, currentLine)

            if cmdLine.Length
                command = resolve(cmdLine[0])
                cmdLine[0] = command

                If !command
                    currentLine += 1
                elseIf command == "set"
                    if ParamLengthGT(self, cmdLine.Length, 2)
                        string varindex = IsVarString(cmdLine[1])
                        string g_varindex = IsVarStringG(cmdLine[1])
                    
                        if varindex || g_varindex
                            if g_varindex
                                varindex = g_varindex
                            endif
                        
                            string strparm2 = resolve(cmdLine[2])
                        
                            if cmdLine.Length > 3 && strparm2 == "resultfrom"
                                string subcode = Resolve(cmdLine[3])
                                if subcode
                                    srf_pending = true
                                    srf_varindex = varindex
                                    srf_varindex_g = g_varindex
                                    Send_X_ActualOper(subcode)
                                    return
                                else
                                    SFE("Unable to resolve function for 'set resultfrom' with (" + cmdLine[3] + ")")
                                endif
                            elseif cmdLine.length == 3
                                if g_varindex
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
                                    SFE("unexpected operator for 'set' (" + operat + ")")
                                endif
                                if g_varindex
                                    globalvars_set(varindex, strresult)
                                else
                                    vars_set(varindex, strresult)
                                endif
                            endif
                        else
                            SFE("invalid variable name, not resolvable (" + cmdLine[1] + ")")
                        endif
                    else
                        SFE("unexpected number of arguments for 'set' got " + cmdLine.length + " expected 3 or 5")
                    endif
                    currentLine += 1
                elseIf command == "if"
                    if ParamLengthEQ(self, cmdLine.Length, 5)
                        ; ["if", "$$", "=", "0", "end"],
                        p1 = Resolve(cmdLine[1])
                        p2 = Resolve(cmdLine[3])
                        po = Resolve(cmdLine[2])
                        
                        if po
                            bool ifTrue = resolveCond(p1, p2, po)
                            if ifTrue
                                currentLine = _slt_FindGoto(Resolve(cmdLine[4]), cmdidx, cmdtype)
                            endIf
                        else
                            SFE("unable to resolve operator (" + cmdLine[2] + ") po(" + po + ")")
                        endif
                    endif
                    currentLine += 1
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
                    
                        string varindex = IsVarStringG(varstr)
                        if varindex
                            int varint = globalvars_get(varindex) as int
                            float varfloat = globalvars_get(varindex) as float
                            if (varint == varfloat && isIncrInt)
                                globalvars_set(varindex, (varint + incrInt) as string)
                            else
                                globalvars_set(varindex, (varfloat + incrFloat) as string)
                            endif
                        else
                            varindex = IsVarString(varstr)
                            if varindex
                                int varint = vars_get(varindex) as int
                                float varfloat = vars_get(varindex) as float
                                if (varint == varfloat && isIncrInt)
                                    vars_set(varindex, (varint + incrInt) as string)
                                else
                                    vars_set(varindex, (varfloat + incrFloat) as string)
                                endif
                            else
                                SFE("no resolve found for variable parameter (" + cmdLine[1] + ") varstr(" + varstr + ") varindex(" + varindex + ")")
                            endif
                        endif
                    endif
                    currentLine += 1
                elseIf command == "goto"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        currentLine = _slt_FindGoto(Resolve(cmdLine[1]), cmdidx, cmdtype)
                    endif
                    currentLine += 1
                elseIf command == "cat"
                    if ParamLengthGT(self, cmdLine.Length, 2)
                        string varstr = cmdLine[1]
                        float incrAmount = resolve(cmdLine[2]) as float
                    
                        string varindex = IsVarStringG(varstr)
                        if varindex
                            globalvars_set(varindex, (globalvars_get(varindex) + resolve(cmdLine[2])) as string)
                        else
                            varindex = IsVarString(varstr)
                            if varindex >= 0
                                vars_set(varindex, (vars_get(varindex) + resolve(cmdLine[2])) as string)
                            else
                                SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                            endif
                        endif
                    endif
                    currentLine += 1
                elseIf command == "gosub"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        currentLine = _slt_FindGosub(Resolve(cmdLine[1]), cmdidx)
                    endif
                    currentLine += 1
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
                            
                            cmdType = _slt_ParseCommandFile()
                            if !cmdType
                                sl_triggersCmd._slt_RemoveCallstack(CmdTargetActor, InstanceId)
                            else
                                ;cmdNum = Heap_IntGetX(CmdTargetActor, InstanceId, CallstackId)
                                currentLine = 0
                            endif
                        else
                            SFE("call target file not parseable(" + callTarget + ") resolved from (" + cmdLine[1] + ")")
                            currentLine += 1
                        endif
                    else
                        currentLine += 1
                    endif
                elseIf command == "endsub"
                    if ParamLengthEQ(self, cmdLine.Length, 1)
                        currentLine = _slt_PopSubIdx()
                    endif
                    currentLine += 1
                elseIf command == "beginsub"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        _slt_AddGosub(cmdidx, Resolve(cmdLine[1]))
                    endif
                    ; still try to go through with finding the end
                    currentLine = _slt_FindEndsub(cmdidx)
                    currentLine += 1
                elseIf command == "callarg"
                    if ParamLengthEQ(self, cmdLine.Length, 3)
                        int argidx = cmdLine[1] as int
                        string arg = cmdLine[2]
                        string newval

                        if argidx < 128
                            newval = callargs_get(argidx)
                        else
                            SFE("maximum index for callarg is 127")
                        endif

                        string vidx = IsVarStringG(arg)
                        if vidx
                            globalvars_set(vidx, newval)
                        else
                            vidx = IsVarString(arg)
                            if vidx
                                vars_set(vidx, newval)
                            else
                                SFE("unable to resolve variable name (" + arg + ")")
                            endif
                        endif
                    endif
                    currentLine += 1
                elseIf command == "return"
                    if !callstackPointer
                        PerformDigitalHygiene()

                        return
                    endif
                    
                    sl_triggersCmd._slt_RemoveCallstack(CmdTargetActor, InstanceId)
                    currentLine += 1
                else
                    string _slt_mightBeLabel = _slt_IsLabel(cmdType, cmdLine)
                    if _slt_mightBeLabel
                        _slt_AddGoto(cmdidx, _slt_mightBeLabel)
                    else
                        Send_X_ActualOper(command)
                        return
                    endif

                    currentLine += 1
                endif
            else
                currentLine += 1
            endif
        endwhile

        Frame_Pop(self)

    endwhile
    
    CleanupAndRemove()
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
        cmdLine1 = PapyrusUtil.StringArray(0);Heap_StringListToArrayX(CmdTargetActor, InstanceId, CallstackId + "[" + idx + "]")
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
        cmdLine1 = PapyrusUtil.StringArray(0);Heap_StringListToArrayX(CmdTargetActor, InstanceId, CallstackId + "[" + idx + "]")
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
        if !MiscUtil.FileExists("" ;/FullCommandsFolder()/; + _myCmdName)
            _myCmdName = _theCmdName + "json"
            if !JsonUtil.JsonExists("" ;/CommandsFolder()/; + _myCmdName)
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
        if !MiscUtil.FileExists("" ;/FullCommandsFolder()/; + _myCmdName)
            _myCmdName = cmdName + "json"
            if !JsonUtil.JsonExists("" ;/CommandsFolder()/; + _myCmdName)
                SFE("attempted to parse an unknown file type(" + cmdName + ")")
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
        _myCmdName = "" ;/CommandsFolder()/; + _myCmdName
        cmdNum = JsonUtil.PathCount(_myCmdName, ".cmd")
        cmdIdx = 0
        while cmdIdx < cmdNum
            lineno += 1
            ;Heap_IntSetX(CmdTargetActor, InstanceId, CallstackId + "[" + cmdIdx + "]:line", lineno)
            cmdLine = JsonUtil.PathStringElements(_myCmdName, ".cmd[" + cmdIdx + "]")
            if cmdLine.Length
             ;   Heap_IntAdjustX(CmdTargetActor, InstanceId, CallstackId, 1)
                int idx = 0
                while idx < cmdLine.Length
              ;      Heap_StringListAddX(CmdTargetActor, InstanceId, CallstackId + "[" + cmdIdx + "]", cmdLine[idx])
                    idx += 1
                endwhile
            endif
            cmdIdx += 1
        endwhile
        return "json"
    elseif _last == ".ini"
        string cmdpath = "" ;/FullCommandsFolder()/; + _myCmdName
        string cmdstring = MiscUtil.ReadFromFile(cmdpath)
        string[] cmdlines = PapyrusUtil.StringArray(0); sl_triggers_internal.SafeSplitLinesTrimmed(cmdstring)

        cmdNum = cmdlines.Length
        cmdIdx = 0
        while cmdIdx < cmdNum
            lineno += 1
            ;Heap_IntSetX(CmdTargetActor, InstanceId, CallstackId + "[" + cmdIdx + "]:line", lineno)
            cmdLine = PapyrusUtil.StringArray(0);sl_triggers_internal.SafeTokenize(cmdlines[cmdIdx])
            if cmdLine.Length
                int idx = 0
                while idx < cmdLine.Length
                    ;Heap_StringListAddX(CmdTargetActor, InstanceId, CallstackId + "[" + cmdIdx + "]", cmdLine[idx])
                    idx += 1
                endwhile
            endif
            cmdIdx += 1
        endwhile
        ;Heap_IntSetX(CmdTargetActor, InstanceId, CallstackId, cmdNum)
        return "ini"
    endif
EndFunction

bool Function _slt_SLTResolve(string _code)
    if _code == "$$"
        CustomResolveResult = MostRecentResult
        return true
    endif

	string varindex = IsVarString(_code)

    if varindex
        CustomResolveResult = vars_get(varindex)
        return true
    else
        varindex = IsVarStringG(_code)
        if varindex
            CustomResolveResult = globalvars_get(varindex)
            return true
        endif
    endif
    
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
        
        _resolved = false ;slext.CustomResolve(self, _code)
        if _resolved
            return CustomResolveResult
        endif

        i += 1
    endwhile
    
	return _code
EndFunction

bool Function _slt_SLTResolveForm(string _code)
    if "#SELF" == _code || "$self" == _code
        CustomResolveFormResult = CmdTargetActor
        return true
    elseIf "#PLAYER" == _code || "$player" == _code
        CustomResolveFormResult = PlayerRef
        return true
    elseIf "#ACTOR" == _code || "$actor" == _code
        CustomResolveFormResult = iterActor
        return true
    elseIf "#NONE" == _code || "none" == _code || "" == _code
        CustomResolveFormResult = none
        return true
    endif

    _code = Resolve(_code)

    Form _form = GetFormById(_code)
    if _form
        CustomResolveFormResult = _form
        return true
    endif

    return false
EndFunction

Form Function _slt_ActualResolveForm(string _code)
    int i = 0
    bool _resolved = false
    bool _needSLT = true
    while i < SLT.Extensions.Length
        sl_triggersExtension slext = SLT.Extensions[i] as sl_triggersExtension

        if _needSLT && slext.GetPriority() >= 0
            _needSLT = false
            _resolved = _slt_SLTResolveForm(_code)
            if _resolved
                return CustomResolveFormResult
            endif
        endif
        
        _resolved = false ;slext.CustomResolveForm(self, _code)
        if _resolved
            return CustomResolveFormResult
        endif

        i += 1
    endwhile
	return none
EndFunction

bool Function _slt_SLTResolveCond(string _p1, string _p2, string _oper)
    bool outcome = false
    if _oper == "=" || _oper == "==" || _oper == "&="
        outcome = false ;sl_triggers_internal.SafeSmartEquals(_p1, _p2)
    elseIf _oper == "!=" || _oper == "&!="
        outcome = false ;!sl_triggers_internal.SafeSmartEquals(_p1, _p2)
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
    else
        SFE("unexpected operator, this is likely an error in the SLT script")
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
        
        _resolved = false;slext.CustomResolveCond(self, _p1, _p2, _oper)
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
    
    return false;sl_triggers_internal.SafeRunOperationOnActor(CmdTargetActor, self, opsParam)
EndFunction

Function SFE(string msg)
	SquawkFunctionError(self, msg)
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
        return 0;Heap_IntGetX(CmdTargetActor, InstanceId, CallstackId + "[" + cmdIdx + "]:line", -1)
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
    int i = callstackListPointer
    int maxi = i + 127
    while i < maxi
        if StorageUtil.StringListGet(CmdTargetActor, kk_cs_callargs, i) == value
            return i - callstackListPointer
        endif
        i += 1
    endwhile
    return -1
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
    int i = callstackListPointer
    int maxi = i + 127
    while i < maxi
        if StorageUtil.StringListGet(CmdTargetActor, kk_cs_gotolabels, i) == value
            return i - callstackListPointer
        endif
        i += 1
    endwhile
    return -1
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
    int i = callstackListPointer
    int maxi = i + 127
    while i < maxi
        if StorageUtil.StringListGet(CmdTargetActor, kk_cs_gosublabels, i) == value
            return i - callstackListPointer
        endif
        i += 1
    endwhile
    return -1
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