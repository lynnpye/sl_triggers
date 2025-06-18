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
    if "$" != StringUtil.GetNthChar(varname, 0) || StringUtil.GetLength(varname) < 2
        return ""
    endif
    int hasdot = StringUtil.Find(varname, ".", 1)
    if hasdot < 0
        return "default"
    endif
    string[] varparts = StringUtil.Split(varname, ".")
    if varparts[0] == "$local"
        return "frame"
    elseif varparts[0] == "$thread"
        return "thread"
    elseif varparts[0] == "$target"
        return "target"
    elseif varparts[0] == "$global"
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

;/
int function Global_GetIntValue(string varname, int missing = 0) global
    if !varname
        return missing
    endif
    return GetIntValue(SLTHost(), "global:vars:" + varname, missing)
endfunction

int function Global_SetIntValue(string varname, int value) global
    if !varname
        return 0
    endif
    return SetIntValue(SLTHost(), "global:vars:" + varname, value)
endfunction

float function Global_GetFloatValue(string varname, float missing = 0.0) global
    if !varname
        return missing
    endif
    return GetFloatValue(SLTHost(), "global:vars:" + varname, missing)
endfunction

float function Global_SetFloatValue(string varname, float value) global
    if !varname
        return 0.0
    endif
    return SetFloatValue(SLTHost(), "global:vars:" + varname, value)
endfunction

Form function Global_GetFormValue(string varname, Form missing = none) global
    if !varname
        return missing
    endif
    return GetFormValue(SLTHost(), "global:vars:" + varname, missing)
endfunction

Form function Global_SetFormValue(string varname, Form value) global
    if !varname
        return none
    endif
    return SetFormValue(SLTHost(), "global:vars:" + varname, value)
endfunction
/;

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

;/
int function Target_GetIntValue(Form target, string varname, int missing = 0) global
    if !varname || !target
        return missing
    endif
    int targetformid = target.GetFormID()
    return GetIntValue(SLTHost(), "target:" + targetformid + ":vars:" + varname, missing)
endfunction

int function Target_SetIntValue(Form target, string varname, int value) global
    if !varname || !target
        return 0
    endif
    int targetformid = target.GetFormID()
    return SetIntValue(SLTHost(), "target:" + targetformid + ":vars:" + varname, value)
endfunction

float function Target_GetFloatValue(Form target, string varname, float missing = 0.0) global
    if !varname || !target
        return missing
    endif
    int targetformid = target.GetFormID()
    return GetFloatValue(SLTHost(), "target:" + targetformid + ":vars:" + varname, missing)
endfunction

float function Target_SetFloatValue(Form target, string varname, float value) global
    if !varname || !target
        return 0.0
    endif
    int targetformid = target.GetFormID()
    return SetFloatValue(SLTHost(), "target:" + targetformid + ":vars:" + varname, value)
endfunction

Form function Target_GetFormValue(Form target, string varname, Form missing = none) global
    if !varname || !target
        return missing
    endif
    int targetformid = target.GetFormID()
    return GetFormValue(SLTHost(), "target:" + targetformid + ":vars:" + varname, missing)
endfunction

Form function Target_SetFormValue(Form target, string varname, Form value) global
    if !varname || !target
        return none
    endif
    int targetformid = target.GetFormID()
    return SetFormValue(SLTHost(), "target:" + targetformid + ":vars:" + varname, value)
endfunction
/;

function Target_AddThread(Form target, int threadid) global
    if !target || threadid < 1
        return
    endif
    int targetformid = target.GetFormID()
    IntListAdd(SLTHost(), "target:" + targetformid + ":threads:idlist", threadid, false)
endfunction

int function Target_ClaimNextThread(Form target) global
    if !target
        return 0
    endif
    int currentSessionId = sl_triggers.GetSessionId()
    int targetformid = target.GetFormID()
    string kkey = "target:" + targetformid + ":threads:idlist"
    sl_triggersMain _slthost = SLTHost()
    int threadcount = IntListCount(_slthost, kkey)
    if threadcount < 1
        return 0
    endif
    int i = 0
    int threadid = 0
    int[] threadSessionIds = PapyrusUtil.IntArray(threadcount)
    ; first check for !wasClaimed, !isClaimed
    while i < threadcount
        threadid = IntListGet(_slthost, kkey, i)
        threadSessionIds[i] = Thread_GetLastSessionId(threadid)
        if threadSessionIds[i] == 0
            ; claim it
            Thread_SetLastSessionId(threadid, currentSessionId)
            return threadid
        endif
        i += 1
    endwhile
    
    ; no? okay, now check for wasClaimed, !isClaimed
    while i < threadcount
        threadid = IntListGet(_slthost, kkey, i)
        if threadSessionIds[i] != currentSessionId
            ; claim it
            Thread_SetLastSessionId(threadid, currentSessionId)
            return threadid
        endif
        i += 1
    endwhile

    return 0
endfunction

function Target_FreeThread(Form target, int threadid) global
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

;/
int function Thread_GetIntValue(int threadid, string varname, int missing = 0) global
    if !varname || threadid < 1
        return missing
    endif
    return GetIntValue(SLTHost(), "thread:" + threadid + ":vars:" + varname, missing)
endfunction

int function Thread_SetIntValue(int threadid, string varname, int value) global
    if !varname || threadid < 1
        return 0
    endif
    return SetIntValue(SLTHost(), "thread:" + threadid + ":vars:" + varname, value)
endfunction

float function Thread_GetFloatValue(int threadid, string varname, float missing = 0.0) global
    if !varname || threadid < 1
        return missing
    endif
    return GetFloatValue(SLTHost(), "thread:" + threadid + ":vars:" + varname, missing)
endfunction

float function Thread_SetFloatValue(int threadid, string varname, float value) global
    if !varname || threadid < 1
        return 0.0
    endif
    return SetFloatValue(SLTHost(), "thread:" + threadid + ":vars:" + varname, value)
endfunction

Form function Thread_GetFormValue(int threadid, string varname, Form missing = none) global
    if !varname || threadid < 1
        return missing
    endif
    return GetFormValue(SLTHost(), "thread:" + threadid + ":vars:" + varname, missing)
endfunction

Form function Thread_SetFormValue(int threadid, string varname, Form value) global
    if !varname || threadid < 1
        return none
    endif
    return SetFormValue(SLTHost(), "thread:" + threadid + ":vars:" + varname, value)
endfunction
/;

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

;/
int function Frame_GetIntValue(int frameid, string varname, int missing = 0) global
    if !varname || frameid < 1
        return missing
    endif
    return GetIntValue(SLTHost(), "frame:" + frameid + ":vars:" + varname, missing)
endfunction

int function Frame_SetIntValue(int frameid, string varname, int value) global
    if !varname || frameid < 1
        return 0
    endif
    return SetIntValue(SLTHost(), "frame:" + frameid + ":vars:" + varname, value)
endfunction

float function Frame_GetFloatValue(int frameid, string varname, float missing = 0.0) global
    if !varname || frameid < 1
        return missing
    endif
    return GetFloatValue(SLTHost(), "frame:" + frameid + ":vars:" + varname, missing)
endfunction

float function Frame_SetFloatValue(int frameid, string varname, float value) global
    if !varname || frameid < 1
        return 0.0
    endif
    return SetFloatValue(SLTHost(), "frame:" + frameid + ":vars:" + varname, value)
endfunction

Form function Frame_GetFormValue(int frameid, string varname, Form missing = None) global
    if !varname || frameid < 1
        return missing
    endif
    return GetFormValue(SLTHost(), "frame:" + frameid + ":vars:" + varname, missing)
endfunction

Form function Frame_SetFormValue(int frameid, string varname, Form value) global
    if !varname || frameid < 1
        return None
    endif
    return SetFormValue(SLTHost(), "frame:" + frameid + ":vars:" + varname, value)
endfunction
/;

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

        return true
    endif

    return false
endfunction

bool Function Frame_CompareLineForCommand(int frameid, int targetLine, string targetCommand) global
    return Map_IntToStringList_StringListFirstTokenMatchesString("frame:" + frameid + ":detail:lines", targetLine, targetCommand)
endfunction

bool Function Frame_ParseScriptFile(int frameid, string scriptfilename) global
    Frame_SetScriptName(frameid, scriptfilename)

    string _myCmdName = scriptfilename
    string _last = StringUtil.Substring(_myCmdName, StringUtil.GetLength(_myCmdName) - 4)
    
    string[] cmdLine
    if _last != "json" && _last != ".ini"
        _myCmdName = scriptfilename + ".ini"
        if !MiscUtil.FileExists(FullCommandsFolder() + _myCmdName)
            _myCmdName = scriptfilename + "json"
            if !JsonUtil.JsonExists(CommandsFolder() + _myCmdName)
                DebMsg("SLT: attempted to parse an unknown file type(" + _myCmdName + ")")
                return false
            else
                _last = "json"
            endif
        else
            _last = ".ini"
        endif
    endif

    int lineno = 0
    int cmdNum = 0
    int cmdIdx = 0
    if _last == "json"
        _myCmdName = CommandsFolder() + _myCmdName
        cmdNum = JsonUtil.PathCount(_myCmdName, ".cmd")
        cmdIdx = 0
        while cmdIdx < cmdNum
            lineno += 1
            ; this does NOT account for comments
            cmdLine = JsonUtil.PathStringElements(_myCmdName, ".cmd[" + cmdIdx + "]")
            if cmdLine.Length
                if ":" == cmdLine[0] && cmdLine.Length >= 2 && cmdLine[1]
                    string[] newCmdLine = new string[1]
                    newCmdLine[0] = "[" + cmdLine[1] + "]"
                    cmdLine = newCmdLine
                endif
                Frame_AddScriptLine(frameid, lineno, cmdLine)
            endif
            cmdIdx += 1
        endwhile
        return true
    elseif _last == ".ini"
        string cmdpath = FullCommandsFolder() + _myCmdName
        string cmdstring = MiscUtil.ReadFromFile(cmdpath)
        string[] cmdlines = sl_triggers.SplitFileContents(cmdstring)

        cmdNum = cmdlines.Length
        cmdIdx = 0
        while cmdIdx < cmdNum
            lineno += 1
            ; this accounts for comments
            cmdLine = sl_triggers.Tokenizev2(cmdlines[cmdIdx])
            if cmdLine.Length
                Frame_AddScriptLine(frameid, lineno, cmdLine)
            endif
            cmdIdx += 1
        endwhile
        return true
    endif

    return false
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

function Frame_SetScriptName(int frameid, string scriptfilename) global
    SetStringValue(SLTHost(), "frame:" + frameid + ":detail:scriptname", scriptfilename)
endfunction

string function Frame_GetScriptName(int frameid) global
    return GetStringValue(SLTHost(), "frame:" + frameid + ":detail:scriptname")
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