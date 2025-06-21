scriptname sl_triggersContext

import StorageUtil
import sl_triggersStatics

;;;;
;; Support
sl_triggersMain function SLTHost() global
    sl_triggersMain slm = StorageUtil.GetFormValue(none, "sl_triggersMain") as sl_triggersMain
    if !slm
        DebMsg("\n\n      UNABLE TO RETRIEVE SLTHOST\n\n\n")
    endif
    return slm
endfunction

function SetSLTHost(sl_triggersMain main) global
    StorageUtil.SetFormValue(none, "sl_triggersMain", main)
endfunction

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
    endif
    
    return ""
endfunction

string function GetVarString(sl_triggersCmd cmdPrimary, string scope, string varname, string missing = "") global
    if scope == "default"
        return Frame_GetStringValue(cmdPrimary.kframe_v_prefix, StringUtil.Substring(varname, 1), missing)
    elseif scope == "frame"
        return Frame_GetStringValue(cmdPrimary.kframe_v_prefix, StringUtil.Substring(varname, 6), missing)
    elseif scope == "thread"
        return Thread_GetStringValue(cmdPrimary.threadid, StringUtil.Substring(varname, 7), missing)
    elseif scope == "target"
        return Target_GetStringValue(cmdPrimary.CmdTargetActor, StringUtil.Substring(varname, 7), missing)
    elseif scope == "global"
        return Global_GetStringValue(StringUtil.Substring(varname, 7), missing)
    endif
endfunction

string function SetVarString(sl_triggersCmd cmdPrimary, string scope, string varname, string value) global
    if scope == "default"
        return Frame_SetStringValue(cmdPrimary.kframe_v_prefix, StringUtil.Substring(varname, 1), value)
    elseif scope == "frame"
        return Frame_SetStringValue(cmdPrimary.kframe_v_prefix, StringUtil.Substring(varname, 6), value)
    elseif scope == "thread"
        return Thread_SetStringValue(cmdPrimary.threadid, StringUtil.Substring(varname, 7), value)
    elseif scope == "target"
        return Target_SetStringValue(cmdPrimary.CmdTargetActor, StringUtil.Substring(varname, 7), value)
    elseif scope == "global"
        return Global_SetStringValue(StringUtil.Substring(varname, 7), value)
    endif
endfunction

;;;;
;; Map_StringToInt

function Map_StringToInt(string mapname, string stringkey, int val) global
    string kkeys = mapname + ":keys"
    string kvals = mapname + ":vals"

    sl_triggersMain _slthost = SLTHost()
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

bool function Map_StringToInt_HasKey(string mapname, string stringkey) global
    int foundindex = StringListFind(SLTHost(), mapname + ":keys", stringkey)
    return foundindex > -1
endfunction

int function Map_StringToInt_GetVal(string mapname, string stringkey) global
    sl_triggersMain _slthost = SLTHost()
    int foundindex = StringListFind(_slthost, mapname + ":keys", stringkey)
    if foundindex < 0
        return -1
    endif
    return IntListGet(_slthost, mapname + ":vals", foundindex)
endfunction

;;;;
;; Map_IntToStringList
int function Map_IntToStringList(string mapname, int intkey, string[] stringlist) global
    string kkeys = mapname + ":keys"
    string kvals = mapname + ":vals"

    sl_triggersMain _slthost = SLTHost()
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

bool function Map_IntToStringList_HasKey(string mapname, int intkey) global
    int foundindex = IntListFind(SLTHost(), mapname + ":keys", intkey)
    return foundindex > -1
endfunction

string[] function Map_IntToStringList_GetVal(string mapname, int intkey) global
    sl_triggersMain _slthost = SLTHost()
    int foundindex = IntListFind(_slthost, mapname + ":keys", intkey)
    if foundindex < 0
        return none
    endif
    return StringListToArray(_slthost, mapname + ":vals:" + foundindex)
endfunction

int function Map_IntToStringList_GetNthKey(string mapname, int nthindex) global
    string kkey = mapname + ":keys"
    sl_triggersMain _slthost = SLTHost()
    if IntListCount(_slthost, kkey) <= nthindex
        return -1
    endif
    return IntListGet(_slthost, kkey, nthindex)
endfunction

string[] function Map_IntToStringList_GetValFromNthKey(string mapname, int nthindex) global
    string kkey = mapname + ":keys"
    sl_triggersMain _slthost = SLTHost()
    if IntListCount(_slthost, kkey) <= nthindex
        return none
    endif
    return StringListToArray(_slthost, mapname + ":vals:" + nthindex)
endfunction

bool function Map_IntToStringList_StringListFirstTokenMatchesString(string mapname, int nthindex, string targetString) global
    string kkey = mapname + ":keys"
    sl_triggersMain _slthost = SLTHost()
    if IntListCount(_slthost, kkey) <= nthindex
        return false
    endif
    return targetString == StringListGet(_slthost, mapname + ":vals:" + nthindex, 0)
endfunction

;;;;
;; Global
string function Global_GetStringValue(string varname, string missing = "") global
    if !varname
        return missing
    endif
    return GetStringValue(SLTHost(), "global:vars:" + varname, missing)
endfunction

string function Global_SetStringValue(string varname, string value) global
    if !varname
        return ""
    endif
    return SetStringValue(SLTHost(), "global:vars:" + varname, value)
endfunction

;;;;
;; Target
string function Target_GetStringValue(Form target, string varname, string missing = "") global
    if !varname || !target
        return missing
    endif
    int targetformid = target.GetFormID()
    return GetStringValue(SLTHost(), "target:" + targetformid + ":vars:" + varname, missing)
endfunction

string function Target_SetStringValue(Form target, string varname, string value) global
    if !varname || !target
        return ""
    endif
    int targetformid = target.GetFormID()
    return SetStringValue(SLTHost(), "target:" + targetformid + ":vars:" + varname, value)
endfunction

function Target_AddThread(Form target, int threadid) global
    if !target || threadid < 1
        return
    endif
    int targetformid = target.GetFormID()
    IntListAdd(SLTHost(), "target:" + targetformid + ":threads:idlist", threadid, false)
endfunction

int function Target_ClaimNextThread(Form target) global
    DebMsg("Target_ClaimNextThread target(" + target + ")")
    if !target
        return 0
    endif
    int currentSessionId = sl_triggers.GetSessionId()
    DebMsg("     currentSessionId(" + currentSessionId + ")")
    int targetformid = target.GetFormID()
    string kkey = "target:" + targetformid + ":threads:idlist"
    sl_triggersMain _slthost = SLTHost()
    int threadcount = IntListCount(_slthost, kkey)
    if threadcount < 1
        DebMsg("No threads on target")
        return 0
    endif
    int i = 0
    int threadid
    int lastsessionid
    int found_threadid_stale = 0
    
    ; first check for !wasClaimed, !isClaimed
    while i < threadcount
        threadid = IntListGet(_slthost, kkey, i)
        lastsessionid = Thread_GetLastSessionId(threadid)

        if lastsessionid == 0
            Thread_SetLastSessionId(threadid, currentSessionId)
            DebMsg("Found pristine and returning threadid(" + threadid + ")")
            return threadid
        endif

        if lastsessionid != currentSessionId && !found_threadid_stale
            found_threadid_stale = threadid
        endif
        
        i += 1
    endwhile

    return found_threadid_stale
endfunction

function Target_FreeThread(Form target, int threadid) global
    DebMsg("Target_FreeThread target(" + target + ") threadid(" + threadid + ")")
    if !target || threadid < 1
        return
    endif
    int i = 0
    int targetformid = target.GetFormID()
    string kkey = "target:" + targetformid + ":threads:idlist"
    sl_triggersMain _slthost = SLTHost()
    int foundindex = IntListFind(_slthost, kkey, threadid)

    if foundindex > -1
        IntListPluck(_slthost, kkey, foundindex, 0)
    else
        DebMsg("threadid (" + threadid + ") not found on cleanup")
    endif
endfunction

;;;;
;; Thread
string function Thread_Create_kt_id(int threadid) global
    return "thread:" + threadid + ":"
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

string function Thread_Create_kt_v_prefix(int threadid) global
    return Thread_Create_kt_id(threadid) + "vars:"
endfunction

string function Thread_GetStringValue(int threadid, string varname, string missing = "") global
    if !varname || threadid < 1
        return missing
    endif
    return GetStringValue(SLTHost(), "thread:" + threadid + ":vars:" + varname, missing)
endfunction

string function Thread_SetStringValue(int threadid, string varname, string value) global
    if !varname || threadid < 1
        return ""
    endif
    return SetStringValue(SLTHost(), "thread:" + threadid + ":vars:" + varname, value)
endfunction

Form function Thread_GetTarget(int threadid) global
    if threadid < 1
        return none
    endif
    return GetFormValue(SLTHost(), "thread:" + threadid + ":detail:target")
endfunction

function Thread_SetTarget(int threadid, Form target) global
    if threadid < 1
        return
    endif
    SetFormValue(SLTHost(), "thread:" + threadid + ":detail:target", target)
endfunction

int function Thread_GetLastSessionId(int threadid) global
    if threadid < 1
        return 0
    endif
    return GetIntValue(SLTHost(), "thread:" + threadid + ":detail:lastsessionid")
endfunction

function Thread_SetLastSessionId(int threadid, int sessionid) global
    if threadid < 1
        return
    endif
    SetIntValue(SLTHost(), "thread:" + threadid + ":detail:lastsessionid", sessionid)
endfunction

string function Thread_GetInitialScriptName(int threadid) global
    if threadid < 1
        return ""
    endif
    return GetStringValue(SLTHost(), "thread:" + threadid + ":detail:initialScriptName")
endfunction

function Thread_SetInitialScriptName(int threadid, string initialScriptName) global
    if threadid < 1 || !initialScriptName
        return
    endif
    SetStringValue(SLTHost(), "thread:" + threadid + ":detail:initialScriptName", initialScriptName)
endfunction

int function Thread_GetCurrentFrameId(int threadid) global
    if threadid < 1
        return 0
    endif
    return GetIntValue(SLTHost(), "thread:" + threadid + ":detail:currentframeid")
endfunction

function Thread_SetCurrentFrameId(int threadid, int frameid) global
    if threadid < 1
        return
    endif
    SetIntValue(SLTHost(), "thread:" + threadid + ":detail:currentframeid", frameid)
endfunction

function Thread_Cleanup(int threadid) global
    if threadid < 1
        return
    endif
    Form target = Thread_GetTarget(threadid)
    if !target
        DebMsg("can't get target for target free thread")
    endif
    Target_FreeThread(target, threadid)

    ClearAllObjPrefix(SLTHost(), "thread:" + threadid + ":")
endfunction

;;;;
;; Frame
string function Frame_Create_kf_id(int frameid) global
    return "frame:" + frameid + ":"
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

string function Frame_GetStringValue(string kframe_v_prefix, string varname, string missing = "") global
    if !varname || !kframe_v_prefix
        return missing
    endif
    return GetStringValue(SLTHost(), kframe_v_prefix + varname, missing)
endfunction

string function Frame_SetStringValue(string kframe_v_prefix, string varname, string value) global
    if !varname || !kframe_v_prefix
        return ""
    endif
    return SetStringValue(SLTHost(), kframe_v_prefix + varname, value)
endfunction

;; returns frameid
int function Frame_Push(sl_triggersCmd cmdPrimary, string scriptfilename, string[] callargs = none) global
    sl_triggersMain _slthost = SLTHost()
    if cmdPrimary.frameid
        ; store for pop
        int oldframeid = cmdPrimary.frameid
        SetIntValue(_slthost, "frame:" + oldframeid + ":pushed:previousFrameId", cmdPrimary.previousFrameId)
        SetIntValue(_slthost, "frame:" + oldframeid + ":pushed:currentLine", cmdPrimary.currentLine)
        SetIntValue(_slthost, "frame:" + oldframeid + ":pushed:totalLines", cmdPrimary.totalLines)
        SetStringValue(_slthost, "frame:" + oldframeid + ":pushed:command", cmdPrimary.command)
        SetStringValue(_slthost, "frame:" + oldframeid + ":pushed:mostrecentresult", cmdPrimary.MostRecentResult)
        SetFormValue(_slthost, "frame:" + oldframeid + ":pushed:iteractor", cmdPrimary.iterActor)
        SetIntValue(_slthost, "frame:" + oldframeid + ":pushed:lastkey", cmdPrimary.lastKey)

        StringListCopy(_slthost, "frame:" + oldframeid + ":pushed:callargs", cmdPrimary.callargs)
    endif

    int frameid = _slthost.GetNextInstanceId()

    if !Frame_ParseScriptFile(frameid, scriptfilename)
        Frame_Cleanup(frameid)
        return 0
    endif

    cmdPrimary.previousFrameId = cmdPrimary.frameid
    cmdPrimary.currentScriptName = scriptfilename
    cmdPrimary.frameid = frameid

    cmdPrimary.currentLine = 0
    cmdPrimary.lineNum = Frame_GetLineNum(frameid, 0)
    cmdPrimary.totalLines = Frame_GetScriptLineCount(frameid)
    cmdPrimary.command = ""
    cmdPrimary.MostRecentResult = ""
    cmdPrimary.iterActor = none
    cmdPrimary.lastKey = 0

    if callargs.length
        cmdPrimary.callargs = callargs
    else
        cmdPrimary.callargs = PapyrusUtil.StringArray(0)
    endif

    Thread_SetCurrentFrameId(cmdPrimary.threadid, frameid)

    return frameid
endfunction

bool function Frame_Pop(sl_triggersCmd cmdPrimary) global
    sl_triggersMain _slthost = SLTHost()

    if !cmdPrimary || !_slthost || cmdPrimary.frameid < 1
        return false
    endif

    Frame_Cleanup(cmdPrimary.frameid)

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

        cmdPrimary.frameid = frameid

        cmdPrimary.previousFrameId = PluckIntValue(_slthost, "frame:" + frameid + ":pushed:previousFrameId")
        cmdPrimary.currentLine = PluckIntValue(_slthost, "frame:" + frameid + ":pushed:currentLine")
        cmdPrimary.lineNum = Frame_GetLineNum(frameid, cmdPrimary.currentLine)
        cmdPrimary.totalLines = PluckIntValue(_slthost, "frame:" + frameid + ":pushed:totalLines")
        cmdPrimary.command = PluckStringValue(_slthost, "frame:" + frameid + ":pushed:command")
        cmdPrimary.MostRecentResult = PluckStringValue(_slthost, "frame:" + frameid + ":pushed:mostrecentresult")
        cmdPrimary.iterActor = PluckFormValue(_slthost, "frame:" + frameid + ":pushed:iteractor") as Actor
        cmdPrimary.lastKey = PluckIntValue(_slthost, "frame:" + frameid + ":pushed:lastkey")
        cmdPrimary.callargs = StringListToArray(_slthost, "frame:" + frameid + ":pushed:callargs")
        StringListClear(_slthost, "frame:" + frameid + ":pushed:callargs")

        Thread_SetCurrentFrameId(cmdPrimary.threadid, frameid)

        return true
    endif

    return false
endfunction

bool Function Frame_CompareLineForCommand(int frameid, int targetLine, string targetCommand) global
    return Map_IntToStringList_StringListFirstTokenMatchesString("frame:" + frameid + ":detail:lines", targetLine, targetCommand)
endfunction

bool Function Frame_ParseScriptFile(int frameid, string scriptfilename) global
    string _myCmdName = scriptfilename
    int nmlen = StringUtil.GetLength(_myCmdName)
    ; 1 - json
    ; 2 - ini
    int scrtype = 0
    if nmlen < 5
        ; not even capable of
        ; a.ini - requires 5 characters
        return false
    endif
    string scriptextension = StringUtil.Substring(_myCmdName, nmlen - 4)
    if scriptextension != ".ini"
        if nmlen < 6
            ; not event capable of
            ; a.json - requires 6 characters
            return false
        endif
        scriptextension = StringUtil.SubString(_myCmdName, nmlen - 5)
        if scriptextension != ".json"
            _myCmdName = scriptfilename + ".ini"
            if !MiscUtil.FileExists(FullCommandsFolder() + _myCmdName)
                _myCmdName = scriptfilename + ".json"
                if !JsonUtil.JsonExists(CommandsFolder() + _myCmdName)
                    DebMsg("SLT: attempted to parse an unknown file type(" + _myCmdName + ")")
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
            Frame_AddScriptLine(frameid, lineno, cmdLine)
        endif
        cmdIdx += 1
    endwhile
    return true
EndFunction

function Frame_AddScriptLine(int frameid, int linenum, string[] tokens) global
    int foundindex = Map_IntToStringList("frame:" + frameid + ":detail:lines", linenum, tokens)
    if foundindex < 0
        return
    endif
    if tokens[0] == "beginsub" && tokens.Length == 2
        Frame_AddGosub(frameid, tokens[1], foundindex)
    elseif tokens.Length == 1
        int tlen = StringUtil.GetLength(tokens[0])
        int tlenm1 = tlen - 1
        int tlenm2 = tlenm1 - 1
        if tlen > 2 && StringUtil.GetNthChar(tokens[0], 0) == "[" && StringUtil.GetNthChar(tokens[0], tlenm1) == "]"
            string lbl = sl_triggers.Trim(StringUtil.Substring(tokens[0], 1, tlenm2))
            if lbl
                Frame_AddGoto(frameid, lbl, foundindex)
            endif
        endif
    endif
endfunction

int function Frame_GetScriptLineCount(int frameid) global
    return IntListCount(SLTHost(), "frame:" + frameid + ":detail:lines:keys")
endfunction

int function Frame_GetLineNum(int frameid, int currentLine) global
    return Map_IntToStringList_GetNthKey("frame:" + frameid + ":detail:lines", currentLine)
endfunction

string[] function Frame_GetTokens(int frameid, int currentLine) global
    return Map_IntToStringList_GetValFromNthKey("frame:" + frameid + ":detail:lines", currentLine)
endfunction

function Frame_AddGoto(int frameid, string label, int targetLine) global
    Map_StringToInt("frame:" + frameid + ":maps:gotolabels", label, targetLine)
endfunction

int function Frame_FindGoto(int frameid, string label) global
    return Map_StringToInt_GetVal("frame:" + frameid + ":maps:gotolabels", label)
endfunction

function Frame_AddGosub(int frameid, string label, int targetLine) global
    Map_StringToInt("frame:" + frameid + ":maps:gosublabels", label, targetLine)
endfunction

int function Frame_FindGosub(int frameid, string label) global
    return Map_StringToInt_GetVal("frame:" + frameid + ":maps:gosublabels", label)
endfunction

function Frame_PushGosubReturn(int frameid, int targetLine) global
    IntListAdd(SLTHost(), "frame:" + frameid + ":detail:gosubreturns", targetLine)
endfunction

int function Frame_PopGosubReturn(int frameid) global
    string kkey = "frame:" + frameid + ":detail:gosubreturns"
    sl_triggersMain _slthost = SLTHost()
    if IntListCount(_slthost, kkey) < 1
        return -1
    endif
    return IntListPop(_slthost, kkey)
endfunction

bool function Frame_IsDone(sl_triggersCmd cmdPrimary) global
    if !cmdPrimary || cmdPrimary.frameid < 1 || !cmdPrimary.currentLine || !cmdPrimary.totalLines || cmdPrimary.currentLine >= cmdPrimary.totalLines 
        return true
    endif

    return false
endfunction

function Frame_Cleanup(int frameid) global
    if frameid < 1
        return
    endif
    ClearAllObjPrefix(SLTHost(), "frame:" + frameid + ":")
endfunction