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

bool        Property runOpPending = false auto hidden
bool        Property isExecuting = false Auto Hidden
int         Property threadid = 0 Auto Hidden
int         Property frameid = 0 Auto Hidden
int         Property previousFrameId = 0 Auto Hidden

int			Property lastKey = 0 auto  Hidden
bool        Property cleanedup = false auto  hidden

string	    Property MostRecentResult = "" auto Hidden
Form        Property CustomResolveFormResult = none auto Hidden
Actor       Property iterActor = none auto Hidden
string      Property currentScriptName = "" auto hidden
int         Property currentLine = 0 auto hidden
int         Property totalLines = 0 auto hidden
int         Property lineNum = 1 auto hidden
string[]    Property callargs auto hidden
string      Property command = "" auto hidden

Function SFE(string msg)
	SquawkFunctionError(self, msg)
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	CmdTargetActor = akCaster
    DebMsg("Cmd.OnEffectStart")
    ; do one time things here, maybe setting up an instanceid if necessary
    DoStartup()
EndEvent

Event OnPlayerLoadGame()
    DebMsg("Cmd.OnPlayerLoadGame")
    DoStartup()
EndEvent

Function DoStartup()
    DebMsg("Cmd.DoStartup")
	SafeRegisterForModEvent_AME(self, EVENT_SLT_RESET(), "OnSLTReset")
    
    if !threadid
        ; need to determine our threadid
        DebMsg("Obtaining threadid")
        threadid = Target_ClaimNextThread(SLT)
        callargs = PapyrusUtil.StringArray(0)
        if threadid
            if !Frame_Push(self, Thread_GetInitialScriptName(threadid))
                DebMsg("Unable to push frame, cleaning up and going home")
                CleanupAndRemove()
                return
            endif
            DebMsg("got thread and frame")
        endif
        DebMsg("failed to claim thread")
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

    RunScript()
    
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
    if _code == "$$"
        return MostRecentResult
    endif

    string varscope = GetVarScope(_code)
    if varscope
        return GetVarString(self, varscope, _code)
    endif

    return _code
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
    if _code == "#self" || _code == "$self"
        return CmdTargetActor
    elseif _code == "#player" || _code == "$player"
        return PlayerRef
    elseif _code == "#actor" || _code == "$actor"
        return iterActor
    elseif _code == "#none" || _code == "none" || _code == ""
        return none
    endif

    ; pass to extensions
    ;; if nothing, then...

    _code = Resolve(_code)

    return GetFormById(_code)
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
                        string varscope = GetVarScope(cmdLine[1])
                    
                        if varscope
                        
                            string strparm2 = resolve(cmdLine[2])
                        
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
                                int gotoTargetLine = Frame_FindGoto(frameid, resolvedCmdLine)
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
                            incrInt = resolve(cmdLine[2]) as int
                            incrFloat = resolve(cmdLine[2]) as float
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
                        int gotoTargetLine = Frame_FindGoto(frameid, resolvedCmdLine)
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
                        float incrAmount = resolve(cmdLine[2]) as float

                        string varscope = GetVarScope(varstr)
                        if varscope
                            SetVarString(self, varscope, varstr, (GetVarString(self, varscope, varstr) + resolve(cmdLine[2])) as string)
                        else
                            SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                        endif
                    endif
                    currentLine += 1
                elseIf command == "gosub"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        string resolvedCmdLine = Resolve(cmdLine[1])
                        int gosubTargetLine = Frame_FindGosub(frameid, resolvedCmdLine)
                        if gosubTargetLine > -1
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
                        int endsubTargetLine = Frame_PopGosubReturn(frameid)
                        if endsubTargetLine > -1
                            currentLine = endsubTargetLine
                        endif
                    endif
                    currentLine += 1
                elseIf command == "beginsub"
                    if ParamLengthEQ(self, cmdLine.Length, 2)
                        Frame_AddGosub(frameid, Resolve(cmdLine[1]), currentLine)
                    endif
                    ; still try to go through with finding the end
                    int i = currentLine
                    while i < totalLines
                        if Frame_CompareLineForCommand(frameid, i, "endsub")
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
                            SFE("maximum index for callarg is 127")
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
                        CleanupAndRemove()
                        return
                    endif
                    
                    currentLine += 1
                else
                    string _slt_mightBeLabel = _slt_IsLabel(cmdLine)
                    if _slt_mightBeLabel
                        Frame_AddGoto(frameid, _slt_mightBeLabel, currentLine)
                    else
                        RunOperationOnActor(cmdLine)
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

Event OnRunOperationOnActorCompleted()
    DebMsg("Cmd.OnRunOperationOnActorCompleted")
    runOpPending = false
EndEvent

Function RunOperationOnActor(string[] opCmdLine)
    DebMsg("Cmd.RunOperationOnActor")
    if !opCmdLine.Length
        return
    endif
    runOpPending = true
    if !sl_triggers_internal.RunOperationOnActor(CmdTargetActor, self, opCmdLine)
        return
    endif
    while runOpPending && isExecuting
        SLT.Nop()
    endwhile
EndFunction
