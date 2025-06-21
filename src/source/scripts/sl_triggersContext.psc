scriptname sl_triggersContext

import StorageUtil
import sl_triggersStatics

;;;;
;; Support
string function GetVarScope(string varname) global
    if "$" != StringUtil.GetNthChar(varname, 0)
        return ""
    endif

    int dotindex = StringUtil.Find(varname, ".", 1)
    if dotindex < 0
        return "default"
    endif

    int varnamelen = StringUtil.GetLength(varname)
    
    if dotindex >= varnamelen - 1
        return ""
    endif

    string scope = StringUtil.Substring(varname, 0, dotindex)
    if scope == "$local"
        return "frame"
    elseif scope == "$thread"
        return "thread"
    elseif scope == "$target"
        return "target"
    elseif scope == "$global"
        return "global"
    elseif scope == "$system"
        return ""
    endif
    
    return ""
endfunction


string function GetVarString(sl_triggersCmd cmdPrimary, string scope, string varname, string missing = "") global
    if scope == "default"
        return Frame_GetStringValue(cmdPrimary.SLT, cmdPrimary.kframe_v_prefix, StringUtil.Substring(varname, 1), missing)
    elseif scope == "frame"
        return Frame_GetStringValue(cmdPrimary.SLT, cmdPrimary.kframe_v_prefix, StringUtil.Substring(varname, 6), missing)
    elseif scope == "thread"
        return Thread_GetStringValue(cmdPrimary.SLT, cmdPrimary.kthread_v_prefix, StringUtil.Substring(varname, 7), missing)
    elseif scope == "target"
        return Target_GetStringValue(cmdPrimary.SLT, cmdPrimary.ktarget_v_prefix, StringUtil.Substring(varname, 7), missing)
    elseif scope == "global"
        return Global_GetStringValue(cmdPrimary.SLT, StringUtil.Substring(varname, 7), missing)
    endif
    return ""
endfunction

string function SetVarString(sl_triggersCmd cmdPrimary, string scope, string varname, string value) global
    if scope == "default"
        return Frame_SetStringValue(cmdPrimary.SLT, cmdPrimary.kframe_v_prefix, StringUtil.Substring(varname, 1), value)
    elseif scope == "frame"
        return Frame_SetStringValue(cmdPrimary.SLT, cmdPrimary.kframe_v_prefix, StringUtil.Substring(varname, 6), value)
    elseif scope == "thread"
        return Thread_SetStringValue(cmdPrimary.SLT, cmdPrimary.kthread_v_prefix, StringUtil.Substring(varname, 7), value)
    elseif scope == "target"
        return Target_SetStringValue(cmdPrimary.SLT, cmdPrimary.ktarget_v_prefix, StringUtil.Substring(varname, 7), value)
    elseif scope == "global"
        return Global_SetStringValue(cmdPrimary.SLT, StringUtil.Substring(varname, 7), value)
    endif
    return ""
endfunction

;;;;
;; Map_StringToInt

function Map_StringToInt(sl_triggersMain _slthost, string mapname, string stringkey, int val) global
    string kkeys = mapname + ":keys"
    string kvals = mapname + ":vals"

    int foundindex = StringListFind(_slthost, kkeys, stringkey)

    if foundindex > -1
        IntListSet(_slthost, kvals, foundindex, val)
    else
        foundindex = StringListAdd(_slthost, kkeys, stringkey)
        int valindex = IntListAdd(_slthost, kvals, val)
        if valindex != foundindex
            DebMsg("Imbalanced map add")
        endif
    endif
endfunction

bool function Map_StringToInt_HasKey(sl_triggersMain _slthost, string mapname, string stringkey) global
    int foundindex = StringListFind(_slthost, mapname + ":keys", stringkey)
    return foundindex > -1
endfunction

int function Map_StringToInt_GetVal(sl_triggersMain _slthost, string mapname, string stringkey) global
    int foundindex = StringListFind(_slthost, mapname + ":keys", stringkey)
    if foundindex < 0
        return -1
    endif
    return IntListGet(_slthost, mapname + ":vals", foundindex)
endfunction

;;;;
;; Map_IntToStringList
int function Map_IntToStringList(sl_triggersMain _slthost, string mapname, int intkey, string[] stringlist) global
    string kkeys = mapname + ":keys"
    string kvals = mapname + ":vals"

    int foundindex = IntListFind(_slthost, kkeys, intkey)

    if foundindex < 0
        foundindex = IntListAdd(_slthost, kkeys, intkey)
    endif

    if foundindex < 0
        return -1
    endif

    StringListCopy(_slthost, mapname + ":vals:" + foundindex, stringlist)

    return foundindex
endfunction

bool function Map_IntToStringList_HasKey(sl_triggersMain _slthost, string mapname, int intkey) global
    int foundindex = IntListFind(_slthost, mapname + ":keys", intkey)
    return foundindex > -1
endfunction

string[] function Map_IntToStringList_GetVal(sl_triggersMain _slthost, string mapname, int intkey) global
    int foundindex = IntListFind(_slthost, mapname + ":keys", intkey)
    if foundindex < 0
        return none
    endif
    return StringListToArray(_slthost, mapname + ":vals:" + foundindex)
endfunction

int function Map_IntToStringList_GetNthKey(sl_triggersMain _slthost, string mapname, int nthindex) global
    string kkey = mapname + ":keys"
    if IntListCount(_slthost, kkey) <= nthindex
        return -1
    endif
    return IntListGet(_slthost, kkey, nthindex)
endfunction

string[] function Map_IntToStringList_GetValFromNthKey(sl_triggersMain _slthost, string mapname, int nthindex) global
    string kkey = mapname + ":keys"
    if IntListCount(_slthost, kkey) <= nthindex
        return none
    endif
    return StringListToArray(_slthost, mapname + ":vals:" + nthindex)
endfunction

bool function Map_IntToStringList_StringListFirstTokenMatchesString(sl_triggersMain _slthost, string mapname, int nthindex, string targetString) global
    string kkey = mapname + ":keys"
    if IntListCount(_slthost, kkey) <= nthindex
        return false
    endif
    return targetString == StringListGet(_slthost, mapname + ":vals:" + nthindex, 0)
endfunction

;;;;
;; Global
string function Global_GetStringValue(sl_triggersMain _slthost, string varname, string missing = "") global
    if !varname
        return missing
    endif
    return GetStringValue(_slthost, "SLTR:global:vars:" + varname, missing)
endfunction

string function Global_SetStringValue(sl_triggersMain _slthost, string varname, string value) global
    if !varname
        return ""
    endif
    return SetStringValue(_slthost, "SLTR:global:vars:" + varname, value)
endfunction

;;;;
;; Target
string function Target_Create_ktgt_id(int targetformid) global
    return "SLTR:target:" + targetformid + ":"
endfunction

string function Target_Create_ktgt_v_prefix(int targetformid) global
    return Target_Create_ktgt_id(targetformid) + "vars:"
endfunction

string function Target_Create_ktgt_threads_idlist(int targetformid) global
    return Target_Create_ktgt_id(targetformid) + "threads:idlist"
endfunction

string function Target_GetStringValue(sl_triggersMain _slthost, string ktarget_v_prefix, string varname, string missing = "") global
    if !varname || !ktarget_v_prefix
        return missing
    endif
    return GetStringValue(_slthost, ktarget_v_prefix + varname, missing)
endfunction

string function Target_SetStringValue(sl_triggersMain _slthost, string ktarget_v_prefix, string varname, string value) global
    if !varname || !ktarget_v_prefix
        return ""
    endif
    return SetStringValue(_slthost, ktarget_v_prefix + varname, value)
endfunction

function Target_AddThread(sl_triggersMain _slthost, string ktarget_threads_idlist, int threadid) global
    if !ktarget_threads_idlist || threadid < 1
        return
    endif
    IntListAdd(_slthost, ktarget_threads_idlist, threadid, false)
endfunction

int function Target_ClaimNextThread(sl_triggersMain _slthost, Form target) global
    if !target
        return 0
    endif
    int currentSessionId = sl_triggers.GetSessionId()
    int targetformid = target.GetFormID()
    string kkey = Target_Create_ktgt_threads_idlist(targetformid)
    int threadcount = IntListCount(_slthost, kkey)
    if threadcount < 1
        DebMsg("No threads on target")
        return 0
    endif
    int i = 0
    int threadid
    int lastsessionid
    int found_threadid_stale = 0
    string tmp_kt_d_lastsessionid
    ; first check for !wasClaimed, !isClaimed
    while i < threadcount
        threadid = IntListGet(_slthost, kkey, i)
        tmp_kt_d_lastsessionid = Thread_Create_kt_d_lastsessiond(threadid)
        lastsessionid = Thread_GetLastSessionId(_slthost, tmp_kt_d_lastsessionid)

        if lastsessionid == 0
            Thread_SetLastSessionId(_slthost, tmp_kt_d_lastsessionid, currentSessionId)
            return threadid
        endif

        if lastsessionid != currentSessionId && !found_threadid_stale
            found_threadid_stale = threadid
        endif
        
        i += 1
    endwhile

    return found_threadid_stale
endfunction

function Target_FreeThread(sl_triggersMain _slthost, string ktarget_threads_idlist, int threadid) global
    if !ktarget_threads_idlist || threadid < 1
        return
    endif
    int i = 0
    int foundindex = IntListFind(_slthost, ktarget_threads_idlist, threadid)

    if foundindex > -1
        IntListPluck(_slthost, ktarget_threads_idlist, foundindex, 0)
    else
        DebMsg("threadid (" + threadid + ") not found on cleanup")
    endif
endfunction

;;;;
;; Thread
string function Thread_Create_kt_id(int threadid) global
    return "SLTR:thread:" + threadid + ":"
endfunction

string function Thread_Create_kt_d_target(int threadid) global
    return Thread_Create_kt_id(threadid) + "detail:target"
endfunction

string function Thread_Create_kt_d_lastsessiond(int threadid) global
    return Thread_Create_kt_id(threadid) + "detail:lastsessionid"
endfunction

string function Thread_Create_kt_d_initialScriptName(int threadid) global
    return Thread_Create_kt_id(threadid) + "detail:initialScriptName"
endfunction

string function Thread_Create_kt_d_currentframeid(int threadid) global
    return Thread_Create_kt_id(threadid) + "detail:currentframeid"
endfunction

string function Thread_Create_kt_v_prefix(int threadid) global
    return Thread_Create_kt_id(threadid) + "vars:"
endfunction

string function Thread_GetStringValue(sl_triggersMain _slthost, string kthread_v_prefix, string varname, string missing = "") global
    if !varname
        return missing
    endif
    return GetStringValue(_slthost, kthread_v_prefix + varname, missing)
endfunction

string function Thread_SetStringValue(sl_triggersMain _slthost, string kthread_v_prefix, string varname, string value) global
    if !varname
        return ""
    endif
    return SetStringValue(_slthost, kthread_v_prefix + varname, value)
endfunction

Form function Thread_GetTarget(sl_triggersMain _slthost, string kthread_d_target) global
    return GetFormValue(_slthost, kthread_d_target)
endfunction

function Thread_SetTarget(sl_triggersMain _slthost, string kthread_d_target, Form target) global
    if !kthread_d_target
        return
    endif
    SetFormValue(_slthost, kthread_d_target, target)
endfunction

int function Thread_GetLastSessionId(sl_triggersMain _slthost, string kthread_d_lastsessionid) global
    return GetIntValue(_slthost, kthread_d_lastsessionid)
endfunction

function Thread_SetLastSessionId(sl_triggersMain _slthost, string kthread_d_lastsessionid, int sessionid) global
    if !kthread_d_lastsessionid
        return
    endif
    SetIntValue(_slthost, kthread_d_lastsessionid, sessionid)
endfunction

string function Thread_GetInitialScriptName(sl_triggersMain _slthost, string kthread_d_initialScriptName) global
    return GetStringValue(_slthost, kthread_d_initialScriptName)
endfunction

function Thread_SetInitialScriptName(sl_triggersMain _slthost, string kthread_d_initialScriptName, string initialScriptName) global
    if !kthread_d_initialScriptName || !initialScriptName
        return
    endif
    SetStringValue(_slthost, kthread_d_initialScriptName, initialScriptName)
endfunction

int function Thread_GetCurrentFrameId(sl_triggersMain _slthost, string kthread_d_currentframeid) global
    return GetIntValue(_slthost, kthread_d_currentframeid)
endfunction

function Thread_SetCurrentFrameId(sl_triggersMain _slthost, string kthread_d_currentframeid, int frameid) global
    if !kthread_d_currentframeid
        return
    endif
    SetIntValue(_slthost, kthread_d_currentframeid, frameid)
endfunction

function Thread_Cleanup(sl_triggersMain _slthost, int threadid, string kthread_d_target, string ktarget_threads_idlist, string kthread_id) global
    if threadid < 1
        return
    endif

    if ktarget_threads_idlist && kthread_d_target
        Form target = Thread_GetTarget(_slthost, kthread_d_target)
        if !target
            DebMsg("can't get target for target free thread")
        else
            Target_FreeThread(_slthost, ktarget_threads_idlist, threadid)
        endif
    endif

    if kthread_id
        ClearAllObjPrefix(_slthost, kthread_id)
    endif
endfunction

;;;;
;; Frame
string function Frame_Create_kf_id(int frameid) global
    return "SLTR:frame:" + frameid + ":"
endfunction

string function Frame_Create_kf_d_scriptname(int frameid) global
    return Frame_Create_kf_id(frameid) + "detail:scriptname"
endfunction

string function Frame_Create_kf_d_lines(int frameid) global
    return Frame_Create_kf_id(frameid) + "detail:lines"
endfunction

string function Frame_Create_kf_d_lines_keys(int frameid) global
    return Frame_Create_kf_id(frameid) + "detail:lines:keys"
endfunction

string function Frame_Create_kf_d_gosubreturns(int frameid) global
    return Frame_Create_kf_id(frameid) + "detail:gosubreturns"
endfunction

string function Frame_Create_kf_m_gotolabels(int frameid) global
    return Frame_Create_kf_id(frameid) + "maps:gotolabels"
endfunction

string function Frame_Create_kf_m_gosublabels(int frameid) global
    return Frame_Create_kf_id(frameid) + "maps:gosublabels"
endfunction

string function Frame_Create_kf_v_prefix(int frameid) global
    return Frame_Create_kf_id(frameid) + "vars:"
endfunction

string function Frame_Create_kf_push_prefix(int frameid) global
    return Frame_Create_kf_id(frameid) + "pushed:"
endfunction

string function Frame_GetStringValue(sl_triggersMain _slthost, string kframe_v_prefix, string varname, string missing = "") global
    if !varname || !kframe_v_prefix
        return missing
    endif
    return GetStringValue(_slthost, kframe_v_prefix + varname, missing)
endfunction

string function Frame_SetStringValue(sl_triggersMain _slthost, string kframe_v_prefix, string varname, string value) global
    if !varname || !kframe_v_prefix
        return ""
    endif
    return SetStringValue(_slthost, kframe_v_prefix + varname, value)
endfunction

;; returns frameid
int function Frame_Push(sl_triggersCmd cmdPrimary, string scriptfilename, string[] callargs = none) global
    sl_triggersMain _slthost = cmdPrimary.SLT
    if cmdPrimary.frameid
        ; store for pop
        int oldframeid = cmdPrimary.frameid
        string push_prefix = Frame_Create_kf_push_prefix(oldframeid)

        SetIntValue(_slthost,       push_prefix + "previousFrameId", cmdPrimary.previousFrameId)
        SetIntValue(_slthost,       push_prefix + "currentLine", cmdPrimary.currentLine)
        SetIntValue(_slthost,       push_prefix + "totalLines", cmdPrimary.totalLines)
        SetIntValue(_slthost,       push_prefix + "lastkey", cmdPrimary.lastKey)
        SetStringValue(_slthost,    push_prefix + "command", cmdPrimary.command)
        SetStringValue(_slthost,    push_prefix + "mostrecentresult", cmdPrimary.MostRecentResult)
        SetFormValue(_slthost,      push_prefix + "iteractor", cmdPrimary.iterActor)

        StringListCopy(_slthost,    push_prefix + "callargs", cmdPrimary.callargs)
    endif

    int frameid = _slthost.GetNextInstanceId()

    string tmp_kf_id            = Frame_Create_kf_id(frameid)
    string tmp_kf_d_lines       = Frame_Create_kf_d_lines(frameid)
    string tmp_kf_m_gosublabels = Frame_Create_kf_m_gosublabels(frameid)
    string tmp_kf_m_gotolabels  = Frame_Create_kf_m_gotolabels(frameid)

    if !Frame_ParseScriptFile(_slthost, tmp_kf_d_lines, tmp_kf_m_gosublabels, tmp_kf_m_gotolabels, scriptfilename)
        DebMsg("Parsing failed: scriptfilename(" + scriptfilename + ")")
        Frame_Cleanup(_slthost, tmp_kf_id)
        return 0
    endif

    cmdPrimary.previousFrameId = cmdPrimary.frameid
    ; this should set cmdPrimary.kframe_d_lines...
    cmdPrimary.frameid = frameid
    cmdPrimary.currentScriptName = scriptfilename

    cmdPrimary.currentLine = 0
    ; ... which we need here
    cmdPrimary.lineNum = Frame_GetLineNum(_slthost, cmdPrimary.kframe_d_lines, 0)
    cmdPrimary.totalLines = Frame_GetScriptLineCount(_slthost, cmdPrimary.kframe_d_lines_keys)
    cmdPrimary.command = ""
    cmdPrimary.MostRecentResult = ""
    cmdPrimary.iterActor = none
    cmdPrimary.lastKey = 0

    if callargs.length
        cmdPrimary.callargs = callargs
    else
        cmdPrimary.callargs = PapyrusUtil.StringArray(0)
    endif

    Thread_SetCurrentFrameId(_slthost, cmdPrimary.kthread_d_currentframeid, frameid)

    return frameid
endfunction

bool function Frame_Pop(sl_triggersCmd cmdPrimary) global
    sl_triggersMain _slthost = cmdPrimary.SLT

    if !cmdPrimary || !_slthost || cmdPrimary.frameid < 1
        return false
    endif

    Frame_Cleanup(_slthost, cmdPrimary.kframe_id)

    int previousFrameId = cmdPrimary.previousFrameId

    cmdPrimary.frameid = 0
    cmdPrimary.previousFrameId = 0
    cmdPrimary.currentLine = 0
    cmdPrimary.lineNum = 0
    cmdPrimary.totalLines = 0
    cmdPrimary.command = ""
    cmdPrimary.MostRecentResult = ""
    cmdPrimary.iterActor = none
    cmdPrimary.lastKey = 0
    cmdPrimary.callargs = PapyrusUtil.StringArray(0)

    if previousFrameId > 0
        int frameid = previousFrameId

        ; this should set cmdPrimary.kframe_d_lines...
        cmdPrimary.frameid = frameid

        string push_prefix = Frame_Create_kf_push_prefix(frameid)

        cmdPrimary.previousFrameId      = PluckIntValue(_slthost,       push_prefix + "previousFrameId")
        cmdPrimary.currentLine          = PluckIntValue(_slthost,       push_prefix + "currentLine")
        cmdPrimary.totalLines           = PluckIntValue(_slthost,       push_prefix + "totalLines")
        cmdPrimary.lastKey              = PluckIntValue(_slthost,       push_prefix + "lastkey")
        cmdPrimary.command              = PluckStringValue(_slthost,    push_prefix + "command")
        cmdPrimary.MostRecentResult     = PluckStringValue(_slthost,    push_prefix + "mostrecentresult")
        cmdPrimary.iterActor            = PluckFormValue(_slthost,      push_prefix + "iteractor") as Actor

        cmdPrimary.callargs             = StringListToArray(_slthost,   push_prefix + "callargs")
                                          StringListClear(_slthost,     push_prefix + "callargs")
        
        ; ... which we need here
        cmdPrimary.lineNum              = Frame_GetLineNum(_slthost, cmdPrimary.kframe_d_lines, cmdPrimary.currentLine)

        Thread_SetCurrentFrameId(_slthost, cmdPrimary.kthread_d_currentframeid, frameid)

        return true
    endif

    return false
endfunction

bool Function Frame_CompareLineForCommand(sl_triggersMain _slthost, string kframe_d_lines, int targetLine, string targetCommand) global
    return Map_IntToStringList_StringListFirstTokenMatchesString(_slthost, kframe_d_lines, targetLine, targetCommand)
endfunction

bool Function Frame_ParseScriptFile(sl_triggersMain _slthost, string kframe_d_lines, string kframe_d_gosublabels, string kframe_d_gotolabels, string scriptfilename) global
    string _myCmdName = scriptfilename
    int nmlen = StringUtil.GetLength(_myCmdName)
    ; 1 - json
    ; 2 - ini
    int scrtype = 0
    if nmlen < 5
        ; not even capable of
        ; a.ini - requires 5 characters
        DebMsg("SLT: attempted to parse an unknown file type(" + _myCmdName + "):1")
        return false
    endif
    string scriptextension = StringUtil.Substring(_myCmdName, nmlen - 4)
    if scriptextension != ".ini"
        if nmlen < 6
            ; not even capable of
            ; a.json - requires 6 characters
            DebMsg("SLT: attempted to parse an unknown file type(" + _myCmdName + "):2")
            return false
        endif
        scriptextension = StringUtil.SubString(_myCmdName, nmlen - 5)
        if scriptextension != ".json"
            _myCmdName = scriptfilename + ".ini"
            if !MiscUtil.FileExists(FullCommandsFolder() + _myCmdName)
                _myCmdName = scriptfilename + ".json"
                if !JsonUtil.JsonExists(CommandsFolder() + _myCmdName)
                    DebMsg("SLT: attempted to parse an unknown file type(" + _myCmdName + "):3")
                    return false
                else
                    scrtype = 1
                endif
            else
                scrtype = 2
            endif
        else
            scrtype = 1
        endif
    else
        scrtype = 2
    endif
    
    string[] cmdLine
    string cmdLineJoined
    int lineno = 0
    int cmdNum = 0
    int cmdIdx = 0
    int cmdLineIterIdx = 0
    int commentFoundIndex = 0
    string[] cmdlines

    if scrtype == 1
        _myCmdName = CommandsFolder() + _myCmdName
        cmdNum = JsonUtil.PathCount(_myCmdName, ".cmd")
    elseif scrtype == 2
        cmdlines = sl_triggers.SplitScriptContents(_myCmdName)
        cmdNum = cmdlines.Length
    else
        DebMsg("SLT: (unusual here) attempted to parse an unknown file type(" + _myCmdName + ") for scrtype (" + scrtype + ")")
        return false
    endif

    cmdIdx = 0
    while cmdIdx < cmdNum
        lineno += 1
        ; this accounts for comments
        if scrtype == 1
            cmdLine = JsonUtil.PathStringElements(_myCmdName, ".cmd[" + cmdIdx + "]")
            if cmdLine.Length && cmdLine[0]
                if cmdLine.Length >= 2 && ":" == cmdLine[0] && cmdLine[1]
                    int newclen = cmdLine.Length - 1
                    string[] newCmdLine = new string[1]
                    newCmdLine[0] = "[" + PapyrusUtil.StringJoin(PapyrusUtil.SliceStringArray(cmdLine, 1), " ") + "]"
                    cmdLine = newCmdLine
                endif
                cmdLineJoined = PapyrusUtil.StringJoin(cmdLine, " ")
                cmdLine = sl_triggers.Tokenizev2(cmdLineJoined)
            endif
        elseif scrtype == 2
            cmdLine = sl_triggers.Tokenizev2(cmdlines[cmdIdx])
        endif
        if cmdLine.Length && cmdLine[0]
            Frame_AddScriptLine(_slthost, kframe_d_lines, kframe_d_gosublabels, kframe_d_gotolabels, lineno, cmdLine)
        endif
        cmdIdx += 1
    endwhile
    return true
EndFunction

function Frame_AddScriptLine(sl_triggersMain _slthost, string kframe_d_lines, string kframe_d_gosublabels, string kframe_d_gotolabels, int linenum, string[] tokens) global
    int foundindex = Map_IntToStringList(_slthost, kframe_d_lines, linenum, tokens)
    if foundindex < 0
        return
    endif
    if tokens[0] == "beginsub" && tokens.Length == 2
        Frame_AddGosub(_slthost, kframe_d_gosublabels, tokens[1], foundindex)
    elseif tokens.Length == 1
        int tlen = StringUtil.GetLength(tokens[0])
        int tlenm1 = tlen - 1
        int tlenm2 = tlenm1 - 1
        if tlen > 2 && StringUtil.GetNthChar(tokens[0], 0) == "[" && StringUtil.GetNthChar(tokens[0], tlenm1) == "]"
            string lbl = sl_triggers.Trim(StringUtil.Substring(tokens[0], 1, tlenm2))
            if lbl
                Frame_AddGoto(_slthost, kframe_d_gotolabels, lbl, foundindex)
            endif
        endif
    endif
endfunction

int function Frame_GetScriptLineCount(sl_triggersMain _slthost, string kframe_d_lines_keys) global
    return IntListCount(_slthost, kframe_d_lines_keys)
endfunction

int function Frame_GetLineNum(sl_triggersMain _slthost, string kframe_d_lines, int currentLine) global
    return Map_IntToStringList_GetNthKey(_slthost, kframe_d_lines, currentLine)
endfunction

string[] function Frame_GetTokens(sl_triggersMain _slthost, string kframe_d_lines, int currentLine) global
    return Map_IntToStringList_GetValFromNthKey(_slthost, kframe_d_lines, currentLine)
endfunction

function Frame_AddGoto(sl_triggersMain _slthost, string kframe_d_gotolabels, string label, int targetLine) global
    Map_StringToInt(_slthost, kframe_d_gotolabels, label, targetLine)
endfunction

int function Frame_FindGoto(sl_triggersMain _slthost, string kframe_d_gotolabels, string label) global
    return Map_StringToInt_GetVal(_slthost, kframe_d_gotolabels, label)
endfunction

function Frame_AddGosub(sl_triggersMain _slthost, string kframe_d_gosublabels, string label, int targetLine) global
    Map_StringToInt(_slthost, kframe_d_gosublabels, label, targetLine)
endfunction

int function Frame_FindGosub(sl_triggersMain _slthost, string kframe_d_gosublabels, string label) global
    return Map_StringToInt_GetVal(_slthost, kframe_d_gosublabels, label)
endfunction

function Frame_PushGosubReturn(sl_triggersMain _slthost, string kframe_d_gosubreturns, int targetLine) global
    IntListAdd(_slthost, kframe_d_gosubreturns, targetLine)
endfunction

int function Frame_PopGosubReturn(sl_triggersMain _slthost, string kframe_d_gosubreturns) global
    if IntListCount(_slthost, kframe_d_gosubreturns) < 1
        return -1
    endif
    return IntListPop(_slthost, kframe_d_gosubreturns)
endfunction

bool function Frame_IsDone(sl_triggersCmd cmdPrimary) global
    if !cmdPrimary || cmdPrimary.frameid < 1 || !cmdPrimary.currentLine || !cmdPrimary.totalLines || cmdPrimary.currentLine >= cmdPrimary.totalLines 
        return true
    endif

    return false
endfunction

function Frame_Cleanup(sl_triggersMain _slthost, string kf_id) global
    if kf_id
        return
    endif
    ClearAllObjPrefix(_slthost, kf_id)
endfunction