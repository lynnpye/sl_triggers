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

Actor _cmdTA = none
Actor			Property CmdTargetActor Hidden
    Actor Function Get()
        return _cmdTA
    EndFunction
    Function Set(Actor value)
        _cmdTA = value

        if _cmdTA
            CmdTargetFormID             = _cmdTA.GetFormID()
            ktarget_id                  = Target_Create_ktgt_id(CmdTargetFormID)
            ktarget_v_prefix            = Target_Create_ktgt_v_prefix(CmdTargetFormID)
            ktarget_threads_idlist      = Target_Create_ktgt_threads_idlist(CmdTargetFormID)
        endif
    EndFunction
EndProperty
int             Property CmdTargetFormID Auto Hidden

int Property TOKEN_TYPE_BARE = 1 AutoReadOnly Hidden
int Property TOKEN_TYPE_STRING_LITERAL = 2 AutoReadOnly Hidden
int Property TOKEN_TYPE_STRING_INTERP = 3 AutoReadOnly Hidden

; pre-generated keys for target context
string Property ktarget_id auto hidden
string Property ktarget_v_prefix auto hidden
string Property ktarget_threads_idlist auto hidden

; pre-generated keys for thread context
int _threadid = 0
string Property kthread_id auto hidden
string Property kthread_d_target auto hidden
string Property kthread_d_lastsessionid auto hidden
string Property kthread_d_initialScriptName auto hidden
string Property kthread_d_currentframeid auto hidden
string Property kthread_v_prefix auto hidden
int         Property threadid Hidden
    int Function Get()
        return _threadid
    EndFunction
    Function Set(int value)
        _threadid = value

        kthread_id                  = Thread_Create_kt_id(_threadid)
        kthread_d_target            = Thread_Create_kt_d_target(_threadid)
        kthread_d_lastsessionid     = Thread_Create_kt_d_lastsessiond(_threadid)
        kthread_d_initialScriptName = Thread_Create_kt_d_initialScriptName(_threadid)
        kthread_d_currentframeid    = Thread_Create_kt_d_currentframeid(_threadid)
        kthread_v_prefix            = Thread_Create_kt_v_prefix(_threadid)
    EndFunction
EndProperty

; pre-generated keys for frame context
int _frameid = 0
string Property kframe_id auto hidden
string Property kframe_d_scriptname auto hidden
string Property kframe_d_lines auto hidden
string Property kframe_d_lines_keys auto hidden
string Property kframe_d_gosubreturns auto hidden
string Property kframe_m_gotolabels auto hidden
string Property kframe_m_gosublabels auto hidden
string Property kframe_v_prefix auto hidden
int         Property frameid Hidden
    int Function Get()
        return _frameid
    EndFunction
    Function Set(int value)
        _frameid = value

        kframe_id               = Frame_Create_kf_id(_frameid)
        kframe_d_scriptname     = Frame_Create_kf_d_scriptname(_frameid)
        kframe_d_lines          = Frame_Create_kf_d_lines(_frameid)
        kframe_d_lines_keys     = Frame_Create_kf_d_lines_keys(_frameid)
        kframe_d_gosubreturns   = Frame_Create_kf_d_gosubreturns(_frameid)
        kframe_m_gotolabels     = Frame_Create_kf_m_gotolabels(_frameid)
        kframe_m_gosublabels    = Frame_Create_kf_m_gosublabels(_frameid)
        kframe_v_prefix         = Frame_Create_kf_v_prefix(_frameid)
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
    
    DoStartup()
EndEvent

Event OnPlayerLoadGame()
    DoStartup()
EndEvent

Function DoStartup()
	SafeRegisterForModEvent_AME(self, EVENT_SLT_RESET(), "OnSLTReset")
    
    if !threadid
        ; need to determine our threadid
        threadid = Target_ClaimNextThread(SLT, CmdTargetActor)
        callargs = PapyrusUtil.StringArray(0)
        if threadid > 0
            int thread_current_frameid = Thread_GetCurrentFrameId(SLT, kthread_d_currentframeid)
            if thread_current_frameid > 0
                frameid = thread_current_frameid
            else
                if !Frame_Push(self, Thread_GetInitialScriptName(SLT, kthread_d_initialScriptName))
                    CleanupAndRemove()
                    return
                endif
            endif
        endif
    else
        Thread_SetLastSessionId(SLT, kthread_d_lastsessionid, sl_triggers.GetSessionId())
    endif

    if threadid && frameid
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

    if frameid > 0
        Frame_Cleanup(SLT, kframe_id)
    endif

    if threadid > 0
        Thread_Cleanup(SLT, threadid, kthread_d_target, ktarget_threads_idlist, kthread_id)
    endif

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
    string varscope
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

            varscope = GetVarScope(token)
            if varscope
                return GetVarString(self, varscope, token)
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

    while isExecuting && frameid
        while currentLine < totalLines
            lineNum = Frame_GetLineNum(SLT, kframe_d_lines, currentLine)
            cmdLine = Frame_GetTokens(SLT, kframe_d_lines, currentLine)

            if cmdLine.Length
                command = Resolve(cmdLine[0])
                cmdLine[0] = command

                If !command
                    currentLine += 1
                elseIf command == "set"
                    if ParamLengthGT(self, cmdLine.Length, 2)
                        string varscope = GetVarScope(cmdLine[1])
                    
                        if varscope
                        
                            string strparm2 = Resolve(cmdLine[2])
                        
                            if cmdLine.Length > 3 && strparm2 == "resultfrom"
                                string subcode = Resolve(cmdLine[3])
                                if subcode
                                    string[] subCmdLine = PapyrusUtil.SliceStringArray(cmdLine, 3)
                                    subCmdLine[0] = subcode
                                    RunOperationOnActor(subCmdLine)
                                    SetVarString(self, varscope, cmdLine[1], MostRecentResult)
                                else
                                    SFE("Unable to resolve function for 'set resultfrom' with (" + cmdLine[3] + ")")
                                endif
                            elseif cmdLine.length == 3
                                SetVarString(self, varscope, cmdLine[1], strparm2)
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
                                SetVarString(self, varscope, cmdLine[1], strresult)
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
                            ;bool ifTrue = resolveCond(p1, p2, po)

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
                                int gotoTargetLine = Frame_FindGoto(SLT, kframe_m_gotolabels, resolvedCmdLine)
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

                        string varscope = GetVarScope(varstr)
                        if varscope
                            string fetchedvar = GetVarString(self, varscope, varstr)
                            int varint = fetchedvar as int
                            float varfloat = fetchedvar as float
                            if (varint == varfloat && isIncrInt)
                                SetVarString(self, varscope, varstr, (varint + incrInt) as string)
                            else
                                SetVarString(self, varscope, varstr, (varfloat + incrFloat) as string)
                            endif
                        else
                            SFE("no resolve found for variable parameter (" + cmdLine[1] + ") varstr(" + varstr + ") varscope(" + varscope + ")")
                        endif
                    endif
                    currentLine += 1
                elseIf command == "goto"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        string resolvedCmdLine = Resolve(cmdLine[1])
                        int gotoTargetLine = Frame_FindGoto(SLT, kframe_m_gotolabels, resolvedCmdLine)
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

                        string varscope = GetVarScope(varstr)
                        if varscope
                            SetVarString(self, varscope, varstr, (GetVarString(self, varscope, varstr) + Resolve(cmdLine[2])) as string)
                        else
                            SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                        endif
                    endif
                    currentLine += 1
                elseIf command == "gosub"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        string resolvedCmdLine = Resolve(cmdLine[1])
                        int gosubTargetLine = Frame_FindGosub(SLT, kframe_m_gosublabels, resolvedCmdLine)
                        if gosubTargetLine > -1
                            Frame_PushGosubReturn(SLT, kframe_d_gosubreturns, currentLine)
                            currentLine = gosubTargetLine
                        else
                            SFE("Unable to resolve gosub label (" + cmdLine[1] + ") resolved to (" + resolvedCmdLine + ")")
                        endif
                    endif
                    currentLine += 1
                elseIf command == "call"
                    if ParamLengthGT(self, cmdLine.Length, 1)
                        string callTarget = Resolve(cmdLine[1])

                        string[] targetCallArgs
                        if cmdLine.Length > 2
                            targetCallArgs = PapyrusUtil.SliceStringArray(cmdLine, 2)
                            int caidx = 0
                            while caidx < targetCallArgs.Length
                                targetCallArgs[caidx] = Resolve(targetCallArgs[caidx])
                                caidx += 1
                            endwhile
                        endif

                        if !Frame_Push(self, callTarget, targetCallArgs)
                            SFE("call target file not parseable(" + callTarget + ") resolved from (" + cmdLine[1] + ")")
                            currentLine += 1
                        endif
                    else
                        currentLine += 1
                    endif
                elseIf command == "endsub"
                    if ParamLengthEQ(self, cmdLine.Length, 1)
                        int endsubTargetLine = Frame_PopGosubReturn(SLT, kframe_d_gosubreturns)
                        if endsubTargetLine > -1
                            currentLine = endsubTargetLine
                        endif
                    endif
                    currentLine += 1
                elseIf command == "beginsub"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        Frame_AddGosub(SLT, kframe_m_gosublabels, Resolve(cmdLine[1]), currentLine)
                    endif
                    ; still try to go through with finding the end
                    int i = currentLine
                    while i < totalLines
                        if Frame_CompareLineForCommand(SLT, kframe_d_lines, i, "endsub")
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

                        string varscope = GetVarScope(arg)
                        if varscope
                            SetVarString(self, varscope, arg, newval)
                        else
                            SFE("unable to resolve variable name (" + arg + ")")
                        endif
                    endif
                    currentLine += 1
                elseIf command == "return"
                    if !Frame_Pop(self)
                        return
                    endif
                    
                    currentLine += 1
                else
                    string _slt_mightBeLabel = _slt_IsLabel(cmdLine)
                    if _slt_mightBeLabel
                        Frame_AddGoto(SLT, kframe_m_gotolabels, _slt_mightBeLabel, currentLine)
                    else
                        RunOperationOnActor(cmdLine)
                    endif

                    currentLine += 1
                endif
            else
                currentLine += 1
            endif
        endwhile

        if Frame_Pop(self)
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