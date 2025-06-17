scriptname sl_triggersContext

import StorageUtil
import sl_triggersStatics

;;;;
;; Support
sl_triggersMain function SLTHost() global
    return StorageUtil.GetFormValue(none, "sl_triggersMain") as sl_triggersMain
endfunction

function SetSLTHost(sl_triggersMain main) global
    StorageUtil.SetFormValue(none, "sl_triggersMain", main)
endfunction

;;;;
;; Map_StringToInt

function Map_StringToInt(string mapname, string stringkey, int val) global
    string kkeys = mapname + ":keys"
    string kvals = mapname + ":vals"

    int foundindex = StringListFind(SLTHost(), kkeys, stringkey)

    if foundindex > -1
        IntListSet(SLTHost(), kvals, foundindex, val)
    else
        foundindex = StringListAdd(SLTHost(), kkeys, stringkey)
        int valindex = IntListAdd(SLTHost(), kvals, val)
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
    int foundindex = StringListFind(SLTHost(), mapname + ":keys", stringkey)
    if foundindex < 0
        return -1
    endif
    return IntListGet(SLTHost(), mapname + ":vals", foundindex)
endfunction

;;;;
;; Map_IntToStringList
function Map_IntToStringList(string mapname, int intkey, string[] stringlist) global
    string kkeys = mapname + ":keys"
    string kvals = mapname + ":vals"

    int foundindex = IntListFind(SLTHost(), kkeys, intkey)

    if foundindex < 0
        foundindex = IntListAdd(SLTHost(), kkeys, intkey)
    endif

    if foundindex < 0
        return
    endif

    StringListCopy(SLTHost(), mapname + ":vals:" + foundindex, stringlist)
endfunction

bool function Map_IntToStringList_HasKey(string mapname, int intkey) global
    int foundindex = IntListFind(SLTHost(), mapname + ":keys", intkey)
    return foundindex > -1
endfunction

string[] function Map_IntToStringList_GetVal(string mapname, int intkey) global
    int foundindex = IntListFind(SLTHost(), mapname + ":keys", intkey)
    if foundindex < 0
        return none
    endif
    return StringListToArray(SLTHost(), mapname + ":vals:" + foundindex)
endfunction

int function Map_IntToStringList_GetNthKey(string mapname, int nthindex) global
    string kkey = mapname + ":keys"
    if IntListCount(SLTHost(), kkey) >= nthindex
        return -1
    endif
    return IntListGet(SLTHost(), kkey, nthindex)
endfunction

string[] function Map_IntToStringList_GetValFromNthKey(string mapname, int nthindex) global
    string kkey = mapname + ":keys"
    if IntListCount(SLTHost(), kkey) >= nthindex
        return none
    endif
    return StringListToArray(SLTHost(), mapname + ":vals:" + nthindex)
endfunction

;;;;
;; Global


;;;;
;; Target
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
    int threadcount = IntListCount(SLTHost(), kkey)
    if threadcount < 1
        return 0
    endif
    int i = 0
    int threadid = 0
    int[] threadSessionIds = PapyrusUtil.IntArray(threadcount)
    ; first check for !wasClaimed, !isClaimed
    while i < threadcount
        threadid = IntListGet(SLTHost(), kkey, i)
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
        threadid = IntListGet(SLTHost(), kkey, i)
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
    int targetformid = target.GetFormID()
    string kkey = "target:" + targetformid + ":threads:idlist"
    int foundindex = IntListFind(SLTHost(), kkey, threadid)
    if foundindex > -1
        IntListPluck(SLTHost(), kkey, foundindex, 0)
    endif
endfunction

;;;;
;; Thread
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
    ClearAllObjPrefix(SLTHost(), "thread:" + threadid + ":")
    Target_FreeThread(Thread_GetTarget(threadid), threadid)
endfunction

;;;;
;; Frame
;; returns frameid
function Frame_Push(sl_triggersCmd cmdPrimary, string scriptfilename) global
    sl_triggersMain sltmain = SLTHost()
    int oldframeid = cmdPrimary.frameid
    if oldframeid
        ; store for pop
        SetIntValue(SLTHost(), "frame:" + oldframeid + ":pushed:previousFrameId", cmdPrimary.previousFrameId)
        cmdPrimary.previousFrameId = oldframeid

        IntListCopy(SLTHost(), "frame:" + oldframeid + ":pushed:returnstack", cmdPrimary.returnstack)
        SetIntValue(SLTHost(), "frame:" + oldframeid + ":pushed:currentLine", cmdPrimary.currentLine)
        SetIntValue(SLTHost(), "frame:" + oldframeid + ":pushed:totalLines", cmdPrimary.totalLines)
        SetStringValue(SLTHost(), "frame:" + oldframeid + ":pushed:command", cmdPrimary.command)
        SetStringValue(SLTHost(), "frame:" + oldframeid + ":pushed:mostrecentresult", cmdPrimary.MostRecentResult)
        SetFormValue(SLTHost(), "frame:" + oldframeid + ":pushed:iteractor", cmdPrimary.iterActor)
        SetIntValue(SLTHost(), "frame:" + oldframeid + ":pushed:lastkey", cmdPrimary.lastKey)
        StringListCopy(SLTHost(), "frame:" + oldframeid + ":pushed:callargs", cmdPrimary.callargs)
    endif

    int frameid = sltmain.GetNextInstanceId()

    if !Frame_ParseScriptFile(frameid, scriptfilename)
        Frame_Cleanup(frameid)
        return
    endif

    cmdPrimary.currentScriptName = scriptfilename
    cmdPrimary.frameid = frameid

    cmdPrimary.returnstack = PapyrusUtil.IntArray(0)
    cmdPrimary.currentLine = 0
    cmdPrimary.lineNum = Frame_GetLineNum(frameid, 0)
    cmdPrimary.totalLines = Frame_GetScriptLineCount(frameid)
    cmdPrimary.command = ""
    cmdPrimary.MostRecentResult = ""
    cmdPrimary.iterActor = none
    cmdPrimary.lastKey = 0
    cmdPrimary.callargs = PapyrusUtil.StringArray(0)
endfunction

bool function Frame_Pop(sl_triggersCmd cmdPrimary) global
    sl_triggersMain sltmain = SLTHost()

    if !cmdPrimary || !sltmain || cmdPrimary.frameid < 1
        return false
    endif

    Frame_Cleanup(cmdPrimary.frameid)

    cmdPrimary.frameid = 0
    cmdPrimary.previousFrameId = 0
    cmdPrimary.returnstack = PapyrusUtil.IntArray(0)
    cmdPrimary.currentLine = 0
    cmdPrimary.lineNum = 0
    cmdPrimary.totalLines = 0
    cmdPrimary.command = ""
    cmdPrimary.MostRecentResult = ""
    cmdPrimary.iterActor = none
    cmdPrimary.lastKey = 0
    cmdPrimary.callargs = PapyrusUtil.StringArray(0)

    if cmdPrimary.previousFrameId > 0
        int frameid = cmdPrimary.previousFrameId

        cmdPrimary.frameid = frameid

        cmdPrimary.previousFrameId = PluckIntValue(SLTHost(), "frame:" + frameid + ":pushed:previousFrameId")
        cmdPrimary.returnstack = IntListToArray(SLTHost(), "frame:" + frameid + ":pushed:returnstack")
        IntListClear(SLTHost(), "frame:" + frameid + ":pushed:returnstack")
        cmdPrimary.currentLine = PluckIntValue(SLTHost(), "frame:" + frameid + ":pushed:currentLine")
        cmdPrimary.lineNum = Frame_GetLineNum(frameid, cmdPrimary.currentLine)
        cmdPrimary.totalLines = PluckIntValue(SLTHost(), "frame:" + frameid + ":pushed:totalLines")
        cmdPrimary.command = PluckStringValue(SLTHost(), "frame:" + frameid + ":pushed:command")
        cmdPrimary.MostRecentResult = PluckStringValue(SLTHost(), "frame:" + frameid + ":pushed:mostrecentresult")
        cmdPrimary.iterActor = PluckFormValue(SLTHost(), "frame:" + frameid + ":pushed:iteractor") as Actor
        cmdPrimary.lastKey = PluckIntValue(SLTHost(), "frame:" + frameid + ":pushed:lastkey")
        cmdPrimary.callargs = StringListToArray(SLTHost(), "frame:" + frameid + ":pushed:callargs")
        StringListClear(SLTHost(), "frame:" + frameid + ":pushed:callargs")

        return true
    endif

    return false
endfunction

function Frame_SetScriptName(int frameid, string scriptfilename) global
    SetStringValue(SLTHost(), "frame:" + frameid + ":detail:scriptname", scriptfilename)
endfunction

string function Frame_GetScriptName(int frameid) global
    return GetStringValue(SLTHost(), "frame:" + frameid + ":detail:scriptname")
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
                Frame_AddScriptLine(frameid, lineno, cmdLine)
            endif
            cmdIdx += 1
        endwhile
        Frame_SetScriptType(frameid, "json")
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
            cmdLine = sl_triggers.Tokenize(cmdlines[cmdIdx])
            if cmdLine.Length
                Frame_AddScriptLine(frameid, lineno, cmdLine)
            endif
            cmdIdx += 1
        endwhile
        Frame_SetScriptType(frameid, "ini")
        return true
    endif

    return false
EndFunction

function Frame_AddScriptLine(int frameid, int linenum, string[] tokens) global
    Map_IntToStringList("frame:" + frameid + ":detail:lines", linenum, tokens)
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

function Frame_SetScriptType(int frameid, string scripttype) global
    SetStringValue(SLTHost(), "frame:" + frameid + ":detail:scripttype", scripttype)
endfunction

string function Frame_GetScriptType(int frameid) global
    return GetStringValue(SLTHost(), "frame:" + frameid + ":detail:scripttype")
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