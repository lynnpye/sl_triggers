Scriptname sl_TriggersCmd extends ActiveMagicEffect

import sl_triggersStatics
import StorageUtil

; SLT
; sl_triggersMain
; SLT API access
sl_triggersMain		Property SLT Auto

; CONSTANTS

; Properties
Actor			Property PlayerRef Auto
Keyword			Property ActorTypeNPC Auto
Keyword			Property ActorTypeUndead Auto

Actor _cmdTA = none
string ktarget_v_prefix
Actor			Property CmdTargetActor Hidden
    Actor Function Get()
        return _cmdTA
    EndFunction
    Function Set(Actor value)
        _cmdTA = value

        if _cmdTA
            CmdTargetFormID             = _cmdTA.GetFormID()

            ktarget_v_prefix = "SLTR:target" + CmdTargetFormID + ":vars:"
        endif
    EndFunction
EndProperty
int             Property CmdTargetFormID Auto Hidden

int Property TOKEN_TYPE_BARE = 1 AutoReadOnly Hidden
int Property TOKEN_TYPE_STRING_LITERAL = 2 AutoReadOnly Hidden
int Property TOKEN_TYPE_STRING_INTERP = 3 AutoReadOnly Hidden

; pre-generated keys for thread context
int _threadid = 0
int         Property threadid Hidden
    int Function Get()
        return _threadid
    EndFunction
    Function Set(int value)
        _threadid = value
    EndFunction
EndProperty



bool        Property runOpPending = false auto hidden
bool        Property isExecuting = false Auto Hidden
int         Property previousFrameId = 0 Auto Hidden

int			Property lastKey = 0 auto  Hidden
bool        Property cleanedup = false auto  hidden

string	    Property MostRecentResult = "" auto Hidden
string      Property CustomResolveResult = "" auto Hidden
Form        Property CustomResolveFormResult = none auto Hidden
Actor       Property iterActor = none auto Hidden
string      Property currentScriptName = "" auto hidden
int         Property currentLine = 0 auto hidden
int         Property totalLines = 0 auto hidden
int         Property lineNum = 1 auto hidden
string[]    Property callargs auto hidden
string      Property command = "" auto hidden



string[] threadVarKeys
string[] threadVarVals

string[] localVarKeys
string[] localVarVals

string[]     gotoLabels = none 
int[]        gotoLines = none
string[]     gosubLabels = none
int[]        gosubLines = none 
int[]        gosubReturns = none 

int[]       scriptlines
int[]       tokencounts
int[]       tokenoffsets
string[]    tokens

; thread values
string      initialScriptName = ""

bool hasValidFrame

;/
Event OnEffectFinish(Actor akTarget, Actor akCaster)
    CleanupAndRemove()
EndEvent
/;

Event OnSLTReset(string eventName, string strArg, float numArg, Form sender)
    CleanupAndRemove()
EndEvent

Event OnEffectStart(Actor akTarget, Actor akCaster)
	CmdTargetActor = akCaster
    
    threadVarKeys = PapyrusUtil.StringArray(0)
    threadVarVals = PapyrusUtil.StringArray(0)

    DoStartup()
EndEvent

Event OnPlayerLoadGame()
    DoStartup()
EndEvent

Function DoStartup()
	SafeRegisterForModEvent_AME(self, EVENT_SLT_RESET(), "OnSLTReset")
    
    if !threadid
        ; need to determine our threadid
        string[] nextThreadInfo = SLT.ClaimNextThread(CmdTargetFormID)
        if nextThreadInfo.Length
            threadid = nextThreadInfo[0] as int
            initialScriptName = nextThreadInfo[1]
        else
            
        endif
        if threadid > 0
            if !slt_Frame_Push(initialScriptName, none)
                CleanupAndRemove()
                return
            endif
        endif
    endif

    if threadid && hasValidFrame
        if !isExecuting
            QueueUpdateLoop(0.01)
        endif
    else
        CleanupAndRemove()
    endif
EndFunction

Event OnUpdate()
    if !self || isExecuting
        return
    endif

    isExecuting = true

    RunScript()
    
    CleanupAndRemove()
EndEvent

Function CleanupAndRemove()
    if cleanedup
        return
    endif

    cleanedup = true
    UnregisterForAllModEvents()
    isExecuting = false

    Self.Dispel()
EndFunction

Function RunOperationOnActor(string[] opCmdLine)
    if !opCmdLine.Length
        return
    endif
    runOpPending = true
    bool success = sl_triggers_internal.RunOperationOnActor(CmdTargetActor, self, opCmdLine)
    if !success
        runOpPending = false
        return
    endif
    float afDelay = 0.0
    while runOpPending && isExecuting
        if afDelay < 1.0
            afDelay += 0.01
        endif
        Utility.Wait(afDelay)
    endwhile
EndFunction

Function CompleteOperationOnActor()
    runOpPending = false
EndFunction

; Resolve
; string token - a variable to retrieve the value of e.g. $$, $global.foo, $g3
; returns: the value as a string; token if unable to resolve
string Function Resolve(string token)
    if token == "$$"
        return MostRecentResult
    endif

    int tokenlength
    int[] varscopelist = new int[2]
    string vtok
    int j
    int i = 0
    bool resolved = false
    bool sltChecked = false

    while i < SLT.Extensions.Length
        sl_triggersExtension slext = SLT.Extensions[i] as sl_triggersExtension

        if !sltChecked && slext.GetPriority() >= 0
            sltChecked = true
                
            tokenlength = StringUtil.GetLength(token)
            if StringUtil.GetNthChar(token, tokenlength - 1) == "\""
                if StringUtil.GetNthChar(token, 0) == "\""
                    token = StringUtil.Substring(token, 1, tokenlength - 2)
                    return token
                    
                elseif StringUtil.Substring(token, 0, 2) == "$\""
                    string trimmed = StringUtil.Substring(token, 2, tokenlength - 3)
                    string[] vartoks = sl_triggers.TokenizeForVariableSubstitution(trimmed)
                    j = 0
                    while j < vartoks.Length
                        vartoks[j] = Resolve(vartoks[j])

                        j += 1
                    endwhile
                    return PapyrusUtil.StringJoin(vartoks, "")
                endif
            endif
            
            GetVarScope(token, varscopelist)
            if varscopelist[0]
                return GetVarString(varscopelist, token, "")
            endif
        endif
        
        resolved = slext.CustomResolve(self, token)
        if resolved
            return CustomResolveResult
        endif

        i += 1
    endwhile

    return token
EndFunction

; ResolveActor
; string _code - a variable indicating an Actor e.g. $self, $player
; returns: an Actor representing the specified Actor; none if unable to resolve
Actor Function ResolveActor(string token)
    Actor _resolvedActor = CmdTargetActor
    if token
        _resolvedActor = ResolveForm(token) as Actor
    endif
    return _resolvedActor
EndFunction

Form Function ResolveForm(string token)
    int i = 0
    bool resolved = false
    bool sltChecked = false

    token = Resolve(token)

    while i < SLT.Extensions.Length
        sl_triggersExtension slext = SLT.Extensions[i] as sl_triggersExtension

        if !sltChecked && slext.GetPriority() >= 0
            sltChecked = true
                    
            if token == "$system.self" ;|| token == "$self"
                return CmdTargetActor
            elseif token == "$system.player" ;|| token == "$player"
                return PlayerRef
            elseif token == "$system.actor" ;|| token == "$actor"
                return iterActor
            elseif token == "$system.none" || token == "" ;|| token == "none"
                return none
            endif
        endif
        
        resolved = slext.CustomResolveForm(self, token)
        if resolved
            return CustomResolveFormResult
        endif

        i += 1
    endwhile

    return GetFormById(token)
EndFunction

Function RunScript()
    string   p1
    string   p2
    string   po
    string[] cmdLine
    int[] tokentypes = new int[128]
    int[] varscopelist = new int[2]

    while isExecuting && hasValidFrame
        while currentLine < totalLines
            lineNum = scriptlines[currentLine]
            int startidx = tokenoffsets[currentLine]
            int endidx = tokencounts[currentLine] + startidx - 1
            cmdLine = PapyrusUtil.SliceStringArray(tokens, startidx, endidx)
            
            if cmdLine.Length
                command = Resolve(cmdLine[0])
                cmdLine[0] = command

                If !command
                    currentLine += 1
                elseIf command == "set"
                    if ParamLengthGT(self, cmdLine.Length, 2)
                        GetVarScope(cmdLine[1], varscopelist)

                        if varscopelist[0]
                            string strparm2 = Resolve(cmdLine[2])
                        
                            if cmdLine.Length > 3 && strparm2 == "resultfrom"
                                string subcode = Resolve(cmdLine[3])
                                if subcode
                                    string[] subCmdLine = PapyrusUtil.SliceStringArray(cmdLine, 3)
                                    subCmdLine[0] = subcode
                                    RunOperationOnActor(subCmdLine)
                                    SetVarString(varscopelist, cmdLine[1], MostRecentResult)
                                else
                                    SFE("Unable to resolve function for 'set resultfrom' with (" + cmdLine[3] + ")")
                                endif
                            elseif cmdLine.length == 3
                                SetVarString(varscopelist, cmdLine[1], strparm2)
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
                                SetVarString(varscopelist, cmdLine[1], strresult)
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

                            bool ifTrue = false
                            if po == "=" || po == "==" || po == "&="
                                ifTrue = sl_triggers.SmartEquals(p1, p2)
                            elseIf po == "!=" || po == "&!="
                                ifTrue = !sl_triggers.SmartEquals(p1, p2)
                            elseIf po == ">"
                                if (p1 as float) > (p2 as float)
                                    ifTrue = true
                                endif
                            elseIf po == ">="
                                if (p1 as float) >= (p2 as float)
                                    ifTrue = true
                                endif
                            elseIf po == "<"
                                if (p1 as float) < (p2 as float)
                                    ifTrue = true
                                endif
                            elseIf po == "<="
                                if (p1 as float) <= (p2 as float)
                                    ifTrue = true
                                endif
                            else
                                SFE("unexpected operator, this is likely an error in the SLT script")
                                ifTrue = false
                            endif

                            if ifTrue
                                string resolvedCmdLine = Resolve(cmdLine[4])
                                ;int gotoTargetLine = Frame_FindGoto(SLT, kframe_m_gotolabels, resolvedCmdLine)
                                int gotoTargetLine = slt_FindGoto(resolvedCmdLine)
                                if gotoTargetLine > -1
                                    currentLine = gotoTargetLine
                                else
                                    SFE("Unable to resolve goto label (" + cmdLine[4] + ") resolved to (" + resolvedCmdLine + ")")
                                endif
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
                            incrInt = Resolve(cmdLine[2]) as int
                            incrFloat = Resolve(cmdLine[2]) as float
                            isIncrInt = (incrInt == incrFloat)
                        endif
                            
                        GetVarScope(varstr, varscopelist)
                        if varscopelist[0]
                            string fetchedvar = GetVarString(varscopelist, varstr, "")
                            
                            int varint = fetchedvar as int
                            float varfloat = fetchedvar as float
                            if (varint == varfloat && isIncrInt)
                                SetVarString(varscopelist, varstr, (varint + incrInt) as string)
                            else
                                SetVarString(varscopelist, varstr, (varfloat + incrFloat) as string)
                            endif
                        else
                            SFE("no resolve found for variable parameter (" + cmdLine[1] + ") varstr(" + varstr + ") varscope(" + varscopelist[1] + ")")
                        endif
                    endif
                    currentLine += 1
                elseIf command == "goto"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        string resolvedCmdLine = Resolve(cmdLine[1])
                        ;int gotoTargetLine = Frame_FindGoto(SLT, kframe_m_gotolabels, resolvedCmdLine)
                        int gotoTargetLine = slt_FindGoto(resolvedCmdLine)
                        if gotoTargetLine > -1
                            currentLine = gotoTargetLine
                        else
                            SFE("Unable to resolve goto label (" + cmdLine[1] + ") resolved to (" + resolvedCmdLine + ")")
                        endif
                    endif
                    currentLine += 1
                elseIf command == "cat"
                    if ParamLengthGT(self, cmdLine.Length, 2)
                        string varstr = cmdLine[1]
                        float incrAmount = Resolve(cmdLine[2]) as float
                            
                        GetVarScope(varstr, varscopelist)
                        if varscopelist[0]
                            SetVarString(varscopelist, varstr, (GetVarString(varscopelist, varstr, "") + Resolve(cmdLine[2])) as string)
                            
                        else
                            SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                        endif
                    endif
                    currentLine += 1
                elseIf command == "gosub"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        string resolvedCmdLine = Resolve(cmdLine[1])
                        ;int gosubTargetLine = Frame_FindGosub(SLT, kframe_m_gosublabels, resolvedCmdLine)
                        int gosubTargetLine = slt_FindGosub(resolvedCmdLine)
                        if gosubTargetLine > -1
                            ;Frame_PushGosubReturn(SLT, kframe_d_gosubreturns, currentLine)
                            slt_PushGosubReturn(currentLine)
                            currentLine = gosubTargetLine
                        else
                            SFE("Unable to resolve gosub label (" + cmdLine[1] + ") resolved to (" + resolvedCmdLine + ")")
                        endif
                    endif
                    currentLine += 1
                elseIf command == "call"
                    if ParamLengthGT(self, cmdLine.Length, 1)
                        string calledScriptname = Resolve(cmdLine[1])

                        string[] targetCallArgs
                        if cmdLine.Length > 2
                            targetCallArgs = PapyrusUtil.SliceStringArray(cmdLine, 2)
                            int caidx = 0
                            while caidx < targetCallArgs.Length
                                targetCallArgs[caidx] = Resolve(targetCallArgs[caidx])
                                caidx += 1
                            endwhile
                        endif

                        if !slt_Frame_Push(calledScriptname, targetCallArgs)
                            SFE("call target file not parseable(" + calledScriptname + ") resolved from (" + cmdLine[1] + ")")
                            currentLine += 1
                        endif
                    else
                        currentLine += 1
                    endif
                elseIf command == "endsub"
                    if ParamLengthEQ(self, cmdLine.Length, 1)
                        ;int endsubTargetLine = Frame_PopGosubReturn(SLT, kframe_d_gosubreturns)
                        int endsubTargetLine = slt_PopGosubReturn()
                        if endsubTargetLine > -1
                            currentLine = endsubTargetLine
                        endif
                    endif
                    currentLine += 1
                elseIf command == "beginsub"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        ;Frame_AddGosub(SLT, kframe_m_gosublabels, Resolve(cmdLine[1]), currentLine)
                        slt_AddGosub(Resolve(cmdLine[1]), currentLine)
                    endif
                    ; still try to go through with finding the end
                    int i = currentLine
                    while i < totalLines
                        startidx = tokenoffsets[i]
                        if tokens[startidx] == "endsub"
                            currentLine = i
                            i = totalLines
                        endif
                        i += 1
                    endwhile
                    currentLine += 1
                elseIf command == "callarg"
                    if ParamLengthEQ(self, cmdLine.Length, 3)
                        int argidx = cmdLine[1] as int
                        string arg = cmdLine[2]
                        string newval

                        if argidx < callargs.Length
                            newval = callargs[argidx]
                        else
                            SFE("maximum index for callarg is " + callargs.Length)
                        endif
                            
                        GetVarScope(arg, varscopelist)
                        if varscopelist[0]
                            SetVarString(varscopelist, arg, newval)
                            
                        else
                            SFE("unable to resolve variable name (" + arg + ")")
                        endif
                    endif
                    currentLine += 1
                elseIf command == "return"
                    if !slt_Frame_Pop()
                        return
                    endif
                    
                    currentLine += 1
                else
                    string _slt_mightBeLabel = _slt_IsLabel(cmdLine)
                    if _slt_mightBeLabel
                        slt_AddGoto(_slt_mightBeLabel, currentLine)
                        ;Frame_AddGoto(SLT, kframe_m_gotolabels, _slt_mightBeLabel, currentLine)
                    else
                        RunOperationOnActor(cmdLine)
                    endif

                    currentLine += 1
                endif
            else
                currentLine += 1
            endif
        endwhile

        if slt_Frame_Pop()
            currentLine += 1
        endif

    endwhile
EndFunction

string Function _slt_IsLabel(string[] _tokens = none)
    string isLabel
    
    if _tokens.Length == 1
        int _labelLen = StringUtil.GetLength(_tokens[0])

        if _labelLen > 2 && StringUtil.GetNthChar(_tokens[0], 0) == "[" && StringUtil.GetNthChar(_tokens[0], _labelLen - 1) == "]"
            isLabel = Resolve(StringUtil.Substring(_tokens[0], 1, _labelLen - 2))
        endif
    endif

    return isLabel
EndFunction

Function SFE(string msg)
	SquawkFunctionError(self, msg)
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


; frame store
int[]       frame_var_count
string[]    frame_var_key_store
string[]    frame_var_val_store

int[]       frame_goto_label_count
string[]    frame_goto_labels
int[]       frame_goto_lines

int[]       frame_gosub_label_count
string[]    frame_gosub_labels
int[]       frame_gosub_lines

int[]       frame_gosub_return_count
int[]       frame_gosub_returns

int[]       frame_callargs_count
string[]    frame_callargs

int[]       frame_token_count
string[]    frame_tokens

int[]       frame_scriptline_count
int[]       frame_scriptlines
int[]       frame_tokencounts
int[]       frame_tokenoffsets

;
int[]       pushed_currentLine
int[]       pushed_totalLines
int[]       pushed_lastKey
string[]    pushed_command
string[]    pushed_mostrecentresult
Actor[]     pushed_iteractor
string[]    pushed_customresolveresult
Form[]      pushed_customresolveformresult
string[]    pushed_currentscriptname

bool Function slt_Frame_Push(string scriptfilename, string[] parm_callargs)
    if !scriptfilename
        return false
    endif
    
    string[] cmdLine
    string cmdLineJoined
    int lineno = 0
    int cmdNum = 0
    int cmdIdx = 0
    ;int cmdLineIterIdx = 0
    ;int commentFoundIndex = 0
    string[] cmdlines

    ; 0 - unknown
    ; 1 - json explicit
    ; 2 - ini explicit
    ; 10 - json implicit
    ; 20 - ini implicit
    int scrtype = sl_triggers.NormalizeScriptfilename(scriptfilename)
    string _myCmdName
    if scrtype == 1
        _myCmdName = CommandsFolder() + scriptfilename
        cmdNum = JsonUtil.PathCount(_myCmdName, ".cmd")
    elseif scrtype == 2
        _myCmdName = scriptfilename
        cmdlines = sl_triggers.SplitScriptContents(_myCmdName)
        cmdNum = cmdlines.Length
    elseif scrtype == 10
        scrtype = 1
        _myCmdName = CommandsFolder() + scriptfilename + ".json"
        cmdNum = JsonUtil.PathCount(_myCmdName, ".cmd")
    elseif scrtype == 20
        scrtype = 2
        _myCmdName = scriptfilename + ".ini"
        cmdlines = sl_triggers.SplitScriptContents(_myCmdName)
        cmdNum = cmdlines.Length
    else
        DebMsg("SLT: (unusual here) attempted to parse an unknown file type(" + _myCmdName + ") for scrtype (" + scrtype + ")")
        return false
    endif

    if hasValidFrame
        if !pushed_currentLine
            pushed_currentLine = PapyrusUtil.IntArray(0)
            pushed_totalLines = PapyrusUtil.IntArray(0)
            pushed_lastKey = PapyrusUtil.IntArray(0)
            pushed_command = PapyrusUtil.StringArray(0)
            pushed_mostrecentresult = PapyrusUtil.StringArray(0)
            pushed_iteractor = new Actor[1]
            pushed_iteractor = PapyrusUtil.ResizeActorArray(pushed_iteractor, 0)
            pushed_customresolveresult = PapyrusUtil.StringArray(0)
            pushed_customresolveformresult = PapyrusUtil.FormArray(0)
            pushed_currentscriptname = PapyrusUtil.StringArray(0)
        endif

        pushed_currentLine = PapyrusUtil.PushInt(pushed_currentLine, currentLine)
        pushed_totalLines = PapyrusUtil.PushInt(pushed_totalLines, totalLines)
        pushed_lastKey = PapyrusUtil.PushInt(pushed_lastKey, lastKey)
        pushed_command = PapyrusUtil.PushString(pushed_command, command)
        pushed_mostrecentresult = PapyrusUtil.PushString(pushed_mostrecentresult, MostRecentResult)
        pushed_iteractor = PapyrusUtil.PushActor(pushed_iteractor, iterActor)
        pushed_customresolveresult = PapyrusUtil.PushString(pushed_customresolveresult, CustomResolveResult)
        pushed_customresolveformresult = PapyrusUtil.PushForm(pushed_customresolveformresult, CustomResolveFormResult)
        pushed_currentscriptname = PapyrusUtil.PushString(pushed_currentscriptname, currentScriptName)

        int varcount
        int varstoresize
        int i
        int j

        ; vars
        varcount = localVarKeys.Length
        varstoresize = frame_var_key_store.Length
        if !frame_var_count
            frame_var_count = new int[1]
            frame_var_count[0] = varcount
            frame_var_key_store = PapyrusUtil.StringArray(varcount)
            frame_var_val_store = PapyrusUtil.StringArray(varcount)
        else
            frame_var_count = PapyrusUtil.PushInt(frame_var_count, varcount)
            frame_var_key_store = PapyrusUtil.ResizeStringArray(frame_var_key_store, varstoresize + varcount)
            frame_var_val_store = PapyrusUtil.ResizeStringArray(frame_var_val_store, varstoresize + varcount)
        endif

        if varcount
            i = 0
            while i < varcount
                j = i + varstoresize
                frame_var_key_store[j] = localVarKeys[i]
                frame_var_val_store[j] = localVarVals[i]

                i += 1
            endwhile
        endif

        localVarKeys = PapyrusUtil.StringArray(0)
        localVarVals = PapyrusUtil.StringArray(0)

        ; goto labels
        varcount        = gotoLabels.Length
        varstoresize    = frame_goto_labels.Length
        if !frame_goto_label_count
            frame_goto_label_count = new int[1]
            frame_goto_label_count[0] = varcount
            frame_goto_labels = PapyrusUtil.StringArray(varcount)
            frame_goto_lines = PapyrusUtil.IntArray(varcount)
        else
            frame_goto_label_count = PapyrusUtil.PushInt(frame_goto_label_count, varcount)
            frame_goto_labels = PapyrusUtil.ResizeStringArray(frame_goto_labels, varstoresize + varcount)
            frame_goto_lines = PapyrusUtil.ResizeIntArray(frame_goto_lines, varstoresize + varcount)
        endif

        if varcount
            i = 0
            while i < varcount
                j = i + varstoresize
                frame_goto_labels[j] = gotoLabels[i]
                frame_goto_lines[j] = gotoLines[i]

                i += 1
            endwhile
        endif

        gotoLabels = PapyrusUtil.StringArray(0)
        gotoLines = PapyrusUtil.IntArray(0)

        ; gosub labels
        varcount        = gosubLabels.Length
        varstoresize    = frame_gosub_labels.Length
        if !frame_gosub_label_count
            frame_gosub_label_count = new int[1]
            frame_gosub_label_count[0] = varcount
            frame_gosub_labels = PapyrusUtil.StringArray(varcount)
            frame_gosub_lines = PapyrusUtil.IntArray(varcount)
        else
            frame_gosub_label_count = PapyrusUtil.PushInt(frame_gosub_label_count, varcount)
            frame_gosub_labels = PapyrusUtil.ResizeStringArray(frame_gosub_labels, varstoresize + varcount)
            frame_gosub_lines = PapyrusUtil.ResizeIntArray(frame_gosub_lines, varstoresize + varcount)
        endif

        if varcount
            i = 0
            while i < varcount
                j = i + varstoresize
                frame_gosub_labels[j] = gosubLabels[i]
                frame_gosub_lines[j] = gosubLines[i]

                i += 1
            endwhile
        endif

        gosubLabels = PapyrusUtil.StringArray(0)
        gosubLines = PapyrusUtil.IntArray(0)

        ; gosub returns
        varcount        = gosubReturns.Length
        varstoresize    = frame_gosub_returns.Length
        if !frame_gosub_return_count
            frame_gosub_return_count = new int[1]
            frame_gosub_return_count[0] = varcount
            frame_gosub_returns = PapyrusUtil.IntArray(varcount)
        else
            frame_gosub_return_count = PapyrusUtil.PushInt(frame_gosub_return_count, varcount)
            frame_gosub_returns = PapyrusUtil.ResizeIntArray(frame_gosub_returns, varstoresize + varcount)
        endif

        if varcount
            i = 0
            while i < varcount
                j = i + varstoresize
                frame_gosub_returns[j] = gosubReturns[i]

                i += 1
            endwhile
        endif

        gosubReturns = PapyrusUtil.IntArray(0)

        ; callargs
        varcount        = callargs.Length
        varstoresize    = frame_callargs.Length
        if !frame_callargs_count
            frame_callargs_count = new int[1]
            frame_callargs_count[0] = varcount
            frame_callargs = PapyrusUtil.StringArray(varcount)
        else
            frame_callargs_count = PapyrusUtil.PushInt(frame_callargs_count, varcount)
            frame_callargs = PapyrusUtil.ResizeStringArray(frame_callargs, varstoresize + varcount)
        endif

        if varcount
            i = 0
            while i < varcount
                j = i + varstoresize
                frame_callargs[j] = callargs[i]

                i += 1
            endwhile
        endif

        callargs = PapyrusUtil.StringArray(0)

        ; tokens
        varcount        = tokens.Length
        varstoresize    = frame_tokens.Length
        if !frame_token_count
            frame_token_count = new int[1]
            frame_token_count[0] = varcount
            frame_tokens = PapyrusUtil.StringArray(varcount)
        else
            frame_token_count = PapyrusUtil.PushInt(frame_token_count, varcount)
            frame_tokens = PapyrusUtil.ResizeStringArray(frame_tokens, varstoresize + varcount)
        endif

        if varcount
            i = 0
            while i < varcount
                j = i + varstoresize
                frame_tokens[j] = tokens[i]

                i += 1
            endwhile
        endif

        tokens = PapyrusUtil.StringArray(0)

        ; token data
        varcount        = scriptlines.Length
        varstoresize    = frame_scriptlines.Length
        if !frame_scriptline_count
            frame_scriptline_count = new int[1]
            frame_scriptline_count[0] = varcount
            frame_scriptlines = PapyrusUtil.IntArray(varcount)
            frame_tokencounts = PapyrusUtil.IntArray(varcount)
            frame_tokenoffsets = PapyrusUtil.IntArray(varcount)
        else
            frame_scriptline_count = PapyrusUtil.PushInt(frame_scriptline_count, varcount)
            frame_scriptlines = PapyrusUtil.ResizeIntArray(frame_scriptlines, varstoresize + varcount)
            frame_tokencounts = PapyrusUtil.ResizeIntArray(frame_tokencounts, varstoresize + varcount)
            frame_tokenoffsets = PapyrusUtil.ResizeIntArray(frame_tokenoffsets, varstoresize + varcount)
        endif

        if varcount
            i = 0
            while i < varcount
                j = i + varstoresize
                frame_scriptlines[j] = scriptlines[i]
                frame_tokencounts[j] = tokencounts[i]
                frame_tokenoffsets[j] = tokenoffsets[i]

                i += 1
            endwhile
        endif

        scriptlines = PapyrusUtil.IntArray(0)
        tokencounts = PapyrusUtil.IntArray(0)
        tokenoffsets = PapyrusUtil.IntArray(0)
    else
        ; no prior frames, just set up initializations
        callargs = PapyrusUtil.StringArray(0)
        localVarKeys = PapyrusUtil.StringArray(0)
        localVarVals = PapyrusUtil.StringArray(0)
        gotoLabels = PapyrusUtil.StringArray(0)
        gotoLines = PapyrusUtil.IntArray(0)
        gosubLabels = PapyrusUtil.StringArray(0)
        gosubLines = PapyrusUtil.IntArray(0)
        gosubReturns = PapyrusUtil.IntArray(0)

        scriptlines = PapyrusUtil.IntArray(0)
        tokencounts = PapyrusUtil.IntArray(0)
        tokenoffsets = PapyrusUtil.IntArray(0)
        tokens = PapyrusUtil.StringArray(0)
    endif

    cmdIdx = 0
    while cmdIdx < cmdNum
        lineno += 1
        
        ; this accounts for comments
        if scrtype == 1
            cmdLine = JsonUtil.PathStringElements(_myCmdName, ".cmd[" + cmdIdx + "]")
            if cmdLine.Length && cmdLine[0]
                if cmdLine.Length >= 2 && cmdLine[1] && ":" == cmdLine[0]
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
            slt_AddLineData(lineno, cmdLine)
        
            if cmdLine.Length == 1
                int tlen = StringUtil.GetLength(cmdLine[0])
                int tlenm1 = tlen - 1
                int tlenm2 = tlenm1 - 1
                if tlen > 2 && StringUtil.GetNthChar(cmdLine[0], 0) == "[" && StringUtil.GetNthChar(cmdLine[0], tlenm1) == "]"
                    string lbl = sl_triggers.Trim(StringUtil.Substring(cmdLine[0], 1, tlenm2))
                    if lbl
                        slt_AddGoto(lbl, scriptlines.Length - 1)
                    endif
                endif
            elseif cmdLine.Length == 2 && cmdLine[0] == "beginsub"
                slt_AddGosub(cmdLine[1], scriptlines.Length - 1)
            endif
            
        endif
        cmdIdx += 1
    endwhile

    lastKey = 0
    MostRecentResult = ""
    CustomResolveResult = ""
    CustomResolveFormResult = none
    iterActor = none
    currentScriptName = ""
    currentLine = 0
    lineNum = scriptlines[0]
    command = ""

    totalLines = scriptlines.Length

    hasValidFrame = true

    return true
EndFunction

bool Function slt_Frame_Pop()
    if !hasValidFrame
        return false
    endif

    if !frame_var_count.Length
        hasValidFrame = false
        return false
    endif

    currentLine                 = pushed_currentLine[pushed_currentLine.Length - 1]
    totalLines                  = pushed_totalLines[pushed_totalLines.Length - 1]
    lastKey                     = pushed_lastKey[pushed_lastKey.Length - 1]
    command                     = pushed_command[pushed_command.Length - 1]
    MostRecentResult            = pushed_mostrecentresult[pushed_mostrecentresult.Length - 1]
    CustomResolveResult         = pushed_customresolveresult[pushed_customresolveresult.Length - 1]
    currentScriptName           = pushed_currentscriptname[pushed_currentscriptname.Length - 1]
    CustomResolveFormResult     = pushed_customresolveformresult[pushed_customresolveformresult.Length - 1]
    iterActor                   = pushed_iteractor[pushed_iteractor.Length - 1]

    pushed_currentLine          = PapyrusUtil.ResizeIntArray(pushed_currentLine, pushed_currentLine.Length - 1)
    pushed_totalLines           = PapyrusUtil.ResizeIntArray(pushed_totalLines, pushed_totalLines.Length - 1)
    pushed_lastKey              = PapyrusUtil.ResizeIntArray(pushed_lastKey, pushed_lastKey.Length - 1)
    pushed_command              = PapyrusUtil.ResizeStringArray(pushed_command, pushed_command.Length - 1)
    pushed_mostrecentresult     = PapyrusUtil.ResizeStringArray(pushed_mostrecentresult, pushed_mostrecentresult.Length - 1)
    pushed_customresolveresult  = PapyrusUtil.ResizeStringArray(pushed_customresolveresult, pushed_customresolveresult.Length - 1)
    pushed_currentscriptname    = PapyrusUtil.ResizeStringArray(pushed_currentscriptname, pushed_currentscriptname.Length - 1)
    pushed_iteractor            = PapyrusUtil.ResizeActorArray(pushed_iteractor, pushed_iteractor.Length - 1)
    pushed_customresolveformresult = PapyrusUtil.ResizeFormArray(pushed_customresolveformresult, pushed_customresolveformresult.Length - 1)

    int varcount
    int newvarstoresize
    int i
    int j

    ; vars
    varcount = frame_var_count[frame_var_count.Length - 1]
    newvarstoresize = frame_var_key_store.Length - varcount

    localVarKeys = PapyrusUtil.StringArray(varcount)
    localVarVals = PapyrusUtil.StringArray(varcount)

    if varcount
        i = 0
        while i < varcount
            j = newvarstoresize + i
            localVarKeys[i] = frame_var_key_store[j]
            localVarVals[i] = frame_var_val_store[j]

            i += 1
        endwhile
    endif

    frame_var_count = PapyrusUtil.ResizeIntArray(frame_var_count, frame_var_count.Length - 1)
    frame_var_key_store = PapyrusUtil.ResizeStringArray(frame_var_key_store, newvarstoresize)
    frame_var_val_store = PapyrusUtil.ResizeStringArray(frame_var_val_store, newvarstoresize)

    ; goto labels
    varcount        = frame_goto_label_count[frame_goto_label_count.Length - 1]
    newvarstoresize = frame_goto_labels.Length - varcount

    gotoLabels = PapyrusUtil.StringArray(varcount)
    gotoLines = PapyrusUtil.IntArray(varcount)

    if varcount
        i = 0
        while i < varcount
            j = newvarstoresize + i
            gotoLabels[i] = frame_goto_labels[j]
            gotoLines[i] = frame_goto_lines[j]

            i += 1
        endwhile
    endif

    frame_goto_label_count = PapyrusUtil.ResizeIntArray(frame_goto_label_count, frame_goto_label_count.Length - 1)
    frame_goto_labels = PapyrusUtil.ResizeStringArray(frame_goto_labels, newvarstoresize)
    frame_goto_lines = PapyrusUtil.ResizeIntArray(frame_goto_lines, newvarstoresize)

    ; gosub labels
    varcount        = frame_gosub_label_count[frame_gosub_label_count.Length - 1]
    newvarstoresize = frame_gosub_labels.Length - varcount

    gosubLabels = PapyrusUtil.StringArray(varcount)
    gosubLines = PapyrusUtil.IntArray(varcount)

    if varcount
        i = 0
        while i < varcount
            j = newvarstoresize + i
            gosubLabels[i] = frame_gosub_labels[j]
            gosubLines[i] = frame_gosub_lines[j]

            i += 1
        endwhile
    endif

    frame_gosub_label_count = PapyrusUtil.ResizeIntArray(frame_gosub_label_count, frame_gosub_label_count.Length - 1)
    frame_gosub_labels = PapyrusUtil.ResizeStringArray(frame_gosub_labels, newvarstoresize)
    frame_gosub_lines = PapyrusUtil.ResizeIntArray(frame_gosub_lines, newvarstoresize)

    ; gosub returns
    varcount        = frame_gosub_return_count[frame_gosub_return_count.Length - 1]
    newvarstoresize = frame_gosub_returns.Length - varcount

    gosubReturns = PapyrusUtil.IntArray(varcount)

    if varcount
        i = 0
        while i < varcount
            j = newvarstoresize + i
            gosubReturns[i] = frame_gosub_returns[j]

            i += 1
        endwhile
    endif

    frame_gosub_return_count = PapyrusUtil.ResizeIntArray(frame_gosub_return_count, frame_gosub_return_count.Length - 1)
    frame_gosub_returns = PapyrusUtil.ResizeIntArray(frame_gosub_returns, newvarstoresize)

    ; callargs
    varcount        = frame_callargs_count[frame_callargs_count.Length - 1]
    newvarstoresize = frame_callargs.Length - varcount

    callargs = PapyrusUtil.StringArray(varcount)

    if varcount
        i = 0
        while i < varcount
            j = newvarstoresize + i
            callargs[i] = frame_callargs[j]

            i += 1
        endwhile
    endif

    frame_callargs_count = PapyrusUtil.ResizeIntArray(frame_callargs_count, frame_callargs_count.Length - 1)
    frame_callargs = PapyrusUtil.ResizeStringArray(frame_callargs, newvarstoresize)

    ; tokens
    varcount        = frame_token_count[frame_token_count.Length - 1]
    newvarstoresize = frame_tokens.Length - varcount

    tokens = PapyrusUtil.StringArray(varcount)

    if varcount
        i = 0
        while i < varcount
            j = newvarstoresize + i
            tokens[i] = frame_tokens[j]

            i += 1
        endwhile
    endif

    frame_token_count = PapyrusUtil.ResizeIntArray(frame_token_count, frame_token_count.Length - 1)
    frame_tokens = PapyrusUtil.ResizeStringArray(frame_tokens, newvarstoresize)

    ; token data
    varcount        = frame_scriptline_count[frame_scriptline_count.Length - 1]
    newvarstoresize = frame_scriptlines.Length - varcount

    scriptlines = PapyrusUtil.IntArray(varcount)
    tokencounts = PapyrusUtil.IntArray(varcount)
    tokenoffsets = PapyrusUtil.IntArray(varcount)

    if varcount
        i = 0
        while i < varcount
            j = newvarstoresize + i
            scriptlines[i] = frame_scriptlines[j]
            tokencounts[i] = frame_tokencounts[j]
            tokenoffsets[i] = frame_tokenoffsets[j]

            i += 1
        endwhile
    endif

    frame_scriptline_count = PapyrusUtil.ResizeIntArray(frame_scriptline_count, frame_scriptline_count.Length - 1)
    frame_scriptlines = PapyrusUtil.ResizeIntArray(frame_scriptlines, newvarstoresize)
    frame_tokencounts = PapyrusUtil.ResizeIntArray(frame_tokencounts, newvarstoresize)
    frame_tokenoffsets = PapyrusUtil.ResizeIntArray(frame_tokenoffsets, newvarstoresize)

    return true
EndFunction

Function slt_AddLineData(int scriptlineno, string[] cmdtokens)
    scriptlines = PapyrusUtil.PushInt(scriptlines, scriptlineno)
    int newoffset = 0
    if tokenoffsets.Length
        newoffset = tokenoffsets[tokenoffsets.Length - 1] + tokencounts[tokencounts.Length - 1]
    endif
    tokencounts = PapyrusUtil.PushInt(tokencounts, cmdtokens.Length)
    tokenoffsets = PapyrusUtil.PushInt(tokenoffsets, newoffset)
    tokens = PapyrusUtil.MergeStringArray(tokens, cmdtokens)
EndFunction

Function slt_AddGoto(string label, int targetline)
    int i = gotoLabels.Find(label)
    if i > -1
        gotoLines[i] = targetline
    else
        gotoLabels = PapyrusUtil.PushString(gotoLabels, label)
        gotoLines = PapyrusUtil.PushInt(gotoLines, targetline)
        i = gotoLabels.Length - 1
    endif
EndFunction

int Function slt_FindGoto(string label)
    int i = gotoLabels.Find(label)
    if i > -1
        return gotoLines[i]
    endif
    return -1
EndFunction

Function slt_AddGosub(string label, int targetline)
    int i = gosubLabels.Find(label)
    if i > -1
        gosubLines[i] = targetline
    else
        gosubLabels = PapyrusUtil.PushString(gosubLabels, label)
        gosubLines = PapyrusUtil.PushInt(gosubLines, targetline)
        i = gosubLabels.Length - 1
    endif
EndFunction

int Function slt_FindGosub(string label)
    int i = gosubLabels.Find(label)
    if i > -1
        return gosubLines[i]
    endif
    return -1
EndFunction

Function slt_PushGosubReturn(int targetline)
    if !gosubReturns
        gosubReturns = new int[1]
        gosubReturns[0] = targetline
    else
        gosubReturns = PapyrusUtil.PushInt(gosubReturns, targetline)
    endif
EndFunction

int Function slt_PopGosubReturn()
    if !gosubReturns.Length
        return -1
    endif
    int r = gosubReturns[gosubReturns.Length - 1]
    gosubReturns = PapyrusUtil.ResizeIntArray(gosubReturns, gosubReturns.Length - 1)
    return r
EndFunction

string Function GetFrameVar(string _key, string missing)
	int i = localVarKeys.Find(_key, 0)
	if i > -1
		return localVarVals[i]
	endif
	return missing
EndFunction

string Function SetFrameVar(string _key, string value)
	int i = localVarKeys.Find(_key, 0)
	if i < 0
		localVarKeys = PapyrusUtil.PushString(localVarKeys, _key)
        localVarVals = PapyrusUtil.PushString(localVarVals, value)
    else
		localVarVals[i] = value
	endif
	return value
EndFunction

string Function GetThreadVar(string _key, string missing)
	int i = threadVarKeys.Find(_key, 0)
	if i > -1
		return threadVarVals[i]
	endif
	return missing
EndFunction

string Function SetThreadVar(string _key, string value)
	int i = threadVarKeys.Find(_key, 0)
	if i < 0
		threadVarKeys = PapyrusUtil.PushString(threadVarKeys, _key)
        threadVarVals = PapyrusUtil.PushString(threadVarVals, value)
    else
		threadVarVals[i] = value
	endif
    return value
EndFunction


;;;;
;; Support
function GetVarScope(string varname, int[] varscope)
    if "$" == StringUtil.GetNthChar(varname, 0)
        int dotindex = StringUtil.Find(varname, ".", 1)
        if dotindex < 0
            varscope[0] = 1
            varscope[1] = 1
        else
            int varnamelen = StringUtil.GetLength(varname)
            
            if dotindex >= varnamelen - 1
                varscope[0] = 0
                varscope[1] = 0
            else
                string scope = StringUtil.Substring(varname, 0, dotindex)
                if scope == "$local"
                    varscope[0] = 1
                    varscope[1] = 6
                elseif scope == "$thread"
                    varscope[0] = 2
                    varscope[1] = 7
                elseif scope == "$target"
                    varscope[0] = 3
                    varscope[1] = 7
                elseif scope == "$global"
                    varscope[0] = 4
                    varscope[1] = 7
                elseif scope == "$system"
                    varscope[0] = 0
                    varscope[1] = 0
                endif
            endif
        endif
    else
        varscope[0] = 0
        varscope[1] = 0
    endif
endfunction

string function GetVarString(int[] varscope, string token, string missing)
    if varscope[0] == 1
        return GetFrameVar(StringUtil.Substring(token, varscope[1]), missing)
    elseif varscope[0] == 2
        return GetThreadVar(StringUtil.Substring(token, varscope[1]), missing)
    elseif varscope[0] == 3
        return GetStringValue(SLT, ktarget_v_prefix + StringUtil.Substring(token, varscope[1]), missing)
    elseif varscope[0] == 4
        return SLT.GetGlobalVar(StringUtil.Substring(token, varscope[1]), missing)
    endif
    return ""
endfunction

string function SetVarString(int[] varscope, string token, string value)
    if varscope[0] == 1
        return SetFrameVar(StringUtil.Substring(token, varscope[1]), value)
    elseif varscope[0] == 2
        return SetThreadVar(StringUtil.Substring(token, varscope[1]), value)
    elseif varscope[0] == 3
        return SetStringValue(SLT, ktarget_v_prefix + StringUtil.Substring(token, varscope[1]), value)
    elseif varscope[0] == 4
        return SLT.SetGlobalVar(StringUtil.Substring(token, varscope[1]), value)
    endif
    return ""
endfunction
