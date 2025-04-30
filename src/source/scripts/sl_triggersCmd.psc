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
string          Property CustomResolveResult Auto Hidden
bool            Property CustomResolveActorReady Auto Hidden
Actor           Property CustomResolveActorResult Auto Hidden
bool            Property CustomResolveCondReady Auto Hidden
bool            Property CustomResolveCondResult Auto Hidden
bool            Property OperationCompleted Auto Hidden

; Properties
int			Property lastKey Auto Hidden
Actor		Property iterActor Auto Hidden
string      Property cmdName Auto Hidden
int         Property cmdIdx Auto Hidden


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
bool		deferredInitNeeded
;/
bool		clusterDispelSent

ActiveMagicEffect[]		supportCmds

int			expectedSupportCmds
int			supportCmdsCheckedIn
/;
string      VARS_KEY_PREFIX


; callstack variables
;int			cmdIdx 
int			cmdNum 
;string		cmdName
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
	deferredInitNeeded = true
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
	
	QueueUpdateLoop(0.1)
EndEvent

Event OnUpdate()
	If !Self
		Return
	EndIf
    
    _slt_ExecuteScript()
	
	Heap_ClearPrefixF(CmdTargetActor, MakeInstanceKeyPrefix(instanceId))
    
    UnregisterForAllModEvents()
    Self.Dispel()
EndEvent

Event OnKeyDown(Int keyCode)
    lastKey = keyCode
    ;MiscUtil.PrintConsole("KeyDown: " + lastKey)
EndEvent

Event OnSLTHeartbeat(string eventName, string strArg, float numArg, Form sender)
EndEvent

Event OnSLTReset(string eventName, string strArg, float numArg, Form sender)
	UnregisterForAllModEvents()
	self.Dispel()
EndEvent

Function _slt_PushCallstack(string newcommand)
    if !_cs_cmdIdx
        _callstack_stack = PapyrusUtil.StringArray(0)
        _cs_cmdIdx = PapyrusUtil.IntArray(0)
        _cs_cmdNum = PapyrusUtil.IntArray(0)
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
    cmdIdx = 0
    cmdNum = 0
    cmdName = newcommand
    gotoIdx = new int[127]
    gotoLabels = new string[127]
    gotoCnt = 0
    gosubIdx = new int[127]
    gosubLabels = new string[127]
    gosubCnt = 0
    gosubReturnStack = new int[127]
    gosubReturnIdx = -1
    MostRecentResult = ""
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
        ;cmdLine1 = JsonUtil.PathStringElements(cmdName, ".cmd[" + idx + "]")
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
        ;cmdLine1 = JsonUtil.PathStringElements(cmdName, ".cmd[" + idx + "]")
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
        ;cmdLine1 = JsonUtil.PathStringElements(cmdName, ".cmd[" + idx + "]")
        if cmdLine1.Length
            if cmdLine1[0] == "endsub"
                return idx
            endIf
        endIf
        idx += 1
    endWhile
    
    return cmdNum
EndFunction

string Function _slt_ParseCommandFile()
    string _myCmdName = cmdName
    string _last = StringUtil.Substring(_myCmdName, StringUtil.GetLength(_myCmdName) - 4)
    string[] cmdLine
    if _last != "json" && _last != ".ini"
        _myCmdName = cmdName + ".ini"
        if !MiscUtil.FileExists(FullCommandsFolder() + _myCmdName)
            _myCmdName = cmdName + ".json"
            if !JsonUtil.IsGood(CommandsFolder() + _myCmdName)
                return ""
            else
                _last = "json"
            endif
        else
            _last = ".ini"
        endif
    endif

    if _last == "json"
        _myCmdName = CommandsFolder() + _myCmdName
        cmdNum = JsonUtil.PathCount(_myCmdName, ".cmd")
        cmdIdx = 0
        while cmdIdx < cmdNum
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
            cmdLine = sl_triggers_internal.SafeTokenize(cmdlines[cmdIdx])
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
        return "ini"
    endif
EndFunction

;/
opens the command file, loops through the commands, and runs them
/;
string Function _slt_ExecuteScript()
    string[] cmdLine
    string   code
    string   p1
    string   p2
    string   po
    bool     ifTrue

    Heap_IntSetX(CmdTargetActor, GetInstanceId(), CallstackId, 0)

    string cmdtype = _slt_ParseCommandFile()

    cmdNum = Heap_IntGetX(CmdTargetActor, GetInstanceId(), CallstackId)
    cmdidx = 0
    
    while cmdidx < cmdNum
        cmdLine = Heap_StringListToArrayX(CmdTargetActor, GetInstanceId(), CallstackId + "[" + cmdidx + "]")

        if cmdLine.Length
            code = resolve(cmdLine[0])

            if (cmdtype == "json" && code == ":") || (cmdtype == "ini" && cmdLine.Length == 1 && StringUtil.GetNthChar(cmdLine[0], 0) == "[" && StringUtil.GetNthChar(cmdLine[0], StringUtil.GetLength(cmdLine[0]) - 1) == "]")
                if cmdtype == "json"
                    _slt_AddGoto(cmdidx, cmdLine[1])
                elseif cmdtype == "ini"
                    _slt_AddGoto(cmdidx, StringUtil.Substring(cmdLine[0], 1, StringUtil.GetLength(cmdLine[0]) - 2))
                endif
                cmdidx += 1
            elseIf code == "beginsub"
                _slt_AddGosub(cmdidx, cmdLine[1])
                cmdidx = _slt_FindEndsub(cmdidx)
                cmdidx += 1
            elseIf code == "endsub"
                cmdidx = _slt_PopSubIdx()
                cmdidx += 1
            elseIf code == "goto"
                cmdidx = _slt_FindGoto(cmdLine[1], cmdidx, cmdtype)
                cmdidx += 1
            elseIf code == "gosub"
                cmdidx = _slt_FindGosub(cmdLine[1], cmdidx)
                cmdidx += 1
            elseIf code == "if"
                ; ["if", "$$", "=", "0", "end"],
                p1 = resolve(cmdLine[1])
                p2 = resolve(cmdLine[3])
                po = cmdLine[2]
                ifTrue = resolveCond(p1, p2, po)
                if ifTrue
                    cmdidx = _slt_FindGoto(cmdLine[4], cmdidx, cmdtype)
                endIf
                cmdidx += 1
            elseIf code == "return"
                return ""
            elseIf code == "call"
                _callArgs = PapyrusUtil.SliceStringArray(cmdLine, 2)
                int caidx = 0
                while caidx < _callArgs.Length
                    _callArgs[caidx] = resolve(_callArgs[caidx])
                    caidx += 1
                endwhile
                _slt_PushCallstack(cmdLine[1])
                _slt_ExecuteScript()
                _slt_PopCallstack()
                cmdidx += 1
            elseIf code == "callarg"
                int argidx = cmdLine[1] as int
                string arg = cmdLine[2]
                int vidx = IsVarStringG(arg)
                if vidx > 0
                    SLT.globalvars_set(vidx, _callArgs[argidx])
                else
                    vidx = IsVarString(arg)
                    if vidx > 0
                        vars_set(vidx, _callArgs[argidx])
                    endif
                endif
                cmdidx += 1
            elseIf !code
                cmdidx += 1
            else
				_slt_ActualOper(cmdLine, code)
                cmdidx += 1
            endIf
        else
            cmdidx += 1
        endif
    endwhile
    
    return ""
EndFunction

string[]        _callArgs
float           _maxSeconds = 2.0

string Function _slt_ActualResolve(string _code)
    CustomResolveReady = false
    CustomResolveResult = ""
    bool success = sl_triggers_internal.SafeCustomResolve(SLT.Libraries, CmdTargetActor, self, _code)
    if success
        float _baseTime = Utility.GetCurrentRealTime()
        float _elapsed = 0.0
        while _elapsed < _maxSeconds && !CustomResolveReady
            UtilityWaitButLessStupid()
            _elapsed = Utility.GetCurrentRealTime() - _baseTime
        endwhile
        if CustomResolveResult
            return CustomResolveResult
        endif
    endif
	return _code
EndFunction

Actor Function _slt_ActualResolveActor(string _code)
    CustomResolveActorReady = false
    CustomResolveActorResult = none
	bool success = sl_triggers_internal.SafeCustomResolveActor(SLT.Libraries, CmdTargetActor, self, _code)
    if success
        float _baseTime = Utility.GetCurrentRealTime()
        float _elapsed = 0.0
        while _elapsed < _maxSeconds && !CustomResolveActorReady
            UtilityWaitButLessStupid()
            _elapsed = Utility.GetCurrentRealTime() - _baseTime
        endwhile
        if CustomResolveActorResult
            return CustomResolveActorResult
        endif
    endif
    return CmdTargetActor
EndFunction

bool Function _slt_ActualResolveCond(string _p1, string _p2, string _oper)
    CustomResolveCondReady = false
    CustomResolveCondResult = false
    bool success = sl_triggers_internal.SafeCustomResolveCond(SLT.Libraries, CmdTargetActor, self, _p1, _p2, _oper)
    if success
        float _baseTime = Utility.GetCurrentRealTime()
        float _elapsed = 0.0
        while _elapsed < _maxSeconds && !CustomResolveCondReady
            UtilityWaitButLessStupid()
            _elapsed = Utility.GetCurrentRealTime() - _baseTime
        endwhile
    endif
    return CustomResolveCondResult
EndFunction

bool Function _slt_ActualOper(string[] param, string code)
    OperationCompleted = false
    bool success = sl_triggers_internal.SafeRunOperationOnActor(SLT.Libraries, CmdTargetActor, self, param)
    if success
        float _baseTime = Utility.GetCurrentRealTime()
        ; technically this could run forever, but realistically only if one of the
        ; operations being executed takes a long time (forever), but that would
        ; be a problem anyway, plus there are some long-running operations
        ; (like the various wait functions)
        while !OperationCompleted && (cmdidx < cmdNum || _cs_cmdIdx.Length > 0)
            UtilityWaitButLessStupid()
        endwhile
    endif
    OperationCompleted = false
    return success
EndFunction

Function _slt_SetCustomResolveResult(string _result)
    CustomResolveResult = _result
    CustomResolveReady = true
EndFunction

Function _slt_SetCustomResolveActorResult(Actor _result)
    CustomResolveActorResult = _result
    CustomResolveActorReady = true
EndFunction

Function _slt_SetCustomResolveCondResult(bool _result)
    CustomResolveCondResult = _result
    CustomResolveCondReady = true
EndFunction

Function _slt_SetOperationCompleted(bool _result)
    OperationCompleted = true
EndFunction
