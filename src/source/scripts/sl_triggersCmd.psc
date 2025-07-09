Scriptname sl_TriggersCmd extends ActiveMagicEffect

import sl_triggersStatics
import StorageUtil

; SLT
; sl_triggersMain
; SLT API access
sl_triggersMain		Property SLT Auto

; Properties
Actor			Property PlayerRef Auto
Keyword			Property ActorTypeNPC Auto
Keyword			Property ActorTypeUndead Auto

Actor _cmdTA = none
string ktarget_v_prefix
string krequest_v_prefix
Function Set_krequest_v_prefix()
    krequest_v_prefix = "SLTR:target:" + CmdTargetFormID + ":request:" + CmdRequestId + ":vars:"
EndFunction

Actor			Property CmdTargetActor Hidden
    Actor Function Get()
        return _cmdTA
    EndFunction
    Function Set(Actor value)
        _cmdTA = value

        if _cmdTA
            CmdTargetFormID             = _cmdTA.GetFormID()

            ktarget_v_prefix = "SLTR:target:" + CmdTargetFormID + ":vars:"
            Set_krequest_v_prefix()
        endif
    EndFunction
EndProperty
int             Property CmdTargetFormID Auto Hidden

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

int _cmdRequestId = 0
int         Property CmdRequestId Hidden
    int Function Get()
        return _cmdRequestId
    EndFunction
    Function Set(int value)
        _cmdRequestId = value

        Set_krequest_v_prefix()
    EndFunction
EndProperty

; local cache to speed up access
bool Debug_Cmd
bool Property Debug_Cmd_Functions Auto Hidden
bool Debug_Cmd_InternalResolve
bool Debug_Cmd_ResolveForm
bool Debug_Cmd_RunScript 
bool Debug_Cmd_RunScript_Blocks
bool Debug_Cmd_RunScript_Set 
bool Debug_Extension 

Function RefreshDebugFlagsFromSLT()
    Debug_Cmd                   = SLT.Debug_Cmd
    Debug_Cmd_Functions         = SLT.Debug_Cmd_Functions
    Debug_Cmd_InternalResolve   = SLT.Debug_Cmd_InternalResolve
    Debug_Cmd_ResolveForm       = SLT.Debug_Cmd_ResolveForm
    Debug_Cmd_RunScript         = SLT.Debug_Cmd_RunScript
    Debug_Cmd_RunScript_Blocks  = SLT.Debug_Cmd_RunScript_Blocks
    Debug_Cmd_RunScript_Set     = SLT.Debug_Cmd_RunScript_Set
    Debug_Extension             = SLT.Debug_Extension
EndFunction


bool        Property runOpPending = false auto hidden
bool        Property isExecuting = false Auto Hidden
int         Property previousFrameId = 0 Auto Hidden

int			Property lastKey = 0 auto  Hidden
bool        Property cleanedup = false auto  hidden

Actor       Property iterActor = none auto Hidden
string      Property currentScriptName = "" auto hidden
int         Property currentLine = 0 auto hidden
int         Property totalLines = 0 auto hidden
int         Property lineNum = 1 auto hidden
string[]    Property callargs auto hidden
string      Property command = "" auto hidden

float       Property initialGameTime = 0.0 auto hidden

string      Property CANARY_GET_VAR_STRING = "<^&*0XDEADBEEF*&<^" AutoReadOnly

int         Property CLRR_INVALID = 0 AutoReadOnly
int         Property CLRR_ADVANCE = 1 AutoReadOnly
int         Property CLRR_NOADVANCE = 2 AutoReadOnly
int         Property CLRR_RETURN  = 3 AutoReadOnly

string Function CLRR_ToString(int _clrr)
    if CLRR_ADVANCE == _clrr
        return "CLRR_ADVANCE:" + _clrr
    elseif CLRR_NOADVANCE == _clrr
        return "CLRR_NOADVANCE:" + _clrr
    elseif CLRR_RETURN == _clrr
        return "CLRR_RETURN:" + _clrr
    elseif CLRR_INVALID == _clrr
        return "CLRR_INVALID:" + _clrr
    endif
    SFW("Truly unexpected value for _clrr(" + _clrr + "); not even CLRR_INVALID")
    return "CLRR_INVALID2:" + _clrr
EndFunction

string  _resolvedString
bool    _resolvedBool
int     _resolvedInt
float   _resolvedFloat
Form    _resolvedForm

int         Property CustomResolveType Auto Hidden

string      Property CustomResolveStringResult Hidden
    string Function Get()
        return _resolvedString
    EndFunction
    Function Set(string value)
        _resolvedString = value
        CustomResolveType = SLT.RT_STRING
    EndFunction
EndProperty
bool        Property CustomResolveBoolResult Hidden
    bool Function Get()
        return _resolvedBool
    EndFunction
    Function Set(bool value)
        _resolvedBool = value
        CustomResolveType = SLT.RT_BOOL
    EndFunction
EndProperty
int         Property CustomResolveIntResult  Hidden
    int Function Get()
        return _resolvedInt
    EndFunction
    Function Set(int value)
        _resolvedInt = value
        CustomResolveType = SLT.RT_INT
    EndFunction
EndProperty
float        Property CustomResolveFloatResult  Hidden
    float Function Get()
        return _resolvedFloat
    EndFunction
    Function Set(float value)
        _resolvedFloat = value
        CustomResolveType = SLT.RT_FLOAT
    EndFunction
EndProperty
Form        Property CustomResolveFormResult Hidden
    Form Function Get()
        return _resolvedForm
    EndFunction
    Function Set(Form value)
        _resolvedForm = value
        CustomResolveType = SLT.RT_FORM
    EndFunction
EndProperty

Function InvalidateCR()
    CustomResolveType = SLT.RT_INVALID
EndFunction

bool        Property IsCRLiteral Auto Hidden
bool        Property IsCRBare Auto Hidden

String Function CRToString()
    if SLT.RT_STRING == CustomResolveType
        return CustomResolveStringResult
    elseif SLT.RT_FORM == CustomResolveType
        return CustomResolveFormResult.GetFormID()
    elseif SLT.RT_FLOAT == CustomResolveType
        return CustomResolveFloatResult
    elseif SLT.RT_INT == CustomResolveType
        return CustomResolveIntResult
    elseif SLT.RT_BOOL == CustomResolveType
        return CustomResolveBoolResult as string
    endif
    return ""
EndFunction

bool Function CRToBool()
    if SLT.RT_BOOL == CustomResolveType
        return CustomResolveBoolResult
    elseif SLT.RT_STRING == CustomResolveType
        return CustomResolveStringResult != "false" && CustomResolveStringResult != "" && CustomResolveStringResult != "0"
    elseif SLT.RT_INT == CustomResolveType
        return CustomResolveIntResult != 0
    elseif SLT.RT_FLOAT == CustomResolveType
        return CustomResolveFloatResult != 0.0
    elseif SLT.RT_FORM == CustomResolveType
        return CustomResolveFormResult != none
    endif
    return false
EndFunction

int Function CRToInt()
    if SLT.RT_INT == CustomResolveType
        return CustomResolveIntResult
    elseif SLT.RT_STRING == CustomResolveType
        return CustomResolveStringResult as int
    elseif SLT.RT_FLOAT == CustomResolveType
        return CustomResolveFloatResult as int
    elseif SLT.RT_BOOL == CustomResolveType
        return CustomResolveBoolResult as int
    elseif SLT.RT_FORM == CustomResolveType
        return CustomResolveFormResult.GetFormID()
    endif
    return 0
EndFunction

float Function CRToFloat()
    if SLT.RT_FLOAT == CustomResolveType
        return CustomResolveFloatResult
    elseif SLT.RT_STRING == CustomResolveType
        return CustomResolveStringResult as float
    elseif SLT.RT_INT == CustomResolveType
        return CustomResolveIntResult as float
    elseif SLT.RT_BOOL == CustomResolveType
        return CustomResolveBoolResult as float
    elseif SLT.RT_FORM == CustomResolveType
        return CustomResolveFormResult.GetFormID() as float
    endif
    return 0.0
EndFunction

Form Function CRToForm()
    if SLT.RT_FORM == CustomResolveType
        if Debug_Cmd_ResolveForm
            SFD("CRToForm: had Form, returning Form")
        endif
        return CustomResolveFormResult
    elseif SLT.RT_STRING == CustomResolveType
        if Debug_Cmd_ResolveForm
            SFD("CRToForm: had string, returning GetFormById(\"" + CustomResolveStringResult + "\")")
        endif
        return GetFormById(CustomResolveStringResult)
    elseif SLT.RT_INT == CustomResolveType
        if Debug_Cmd_ResolveForm
            SFD("CRToForm: had int, returning GetFormById(" + CustomResolveIntResult + ")")
        endif
        return GetFormById(CustomResolveIntResult)
    elseif SLT.RT_FLOAT == CustomResolveType
        if Debug_Cmd_ResolveForm
            SFD("CRToForm: had float (" + CustomResolveFloatResult + "), returning GetFormById(" + (CustomResolveFloatResult as int) + ")")
        endif
        return GetFormById(CRToInt())
    elseif SLT.RT_BOOL == CustomResolveType
        if Debug_Cmd_ResolveForm
            SFW("CRToForm: no auto-conversion exists except RT_STRING, RT_INT (interpreted as FormID), and RT_FLOAT (cast to int and interpted as FormID) (from: " + SLT.RT_ToString(CustomResolveType) + ")")
        endif
        ; no auto-conversion from float or bool
        return none
    endif

    if Debug_Cmd_ResolveForm
        SFW("CRToForm: no auto-conversion exists except RT_STRING, RT_INT (interpreted as FormID), and RT_FLOAT (cast to int and interpted as FormID) (from: (" + CustomResolveType + ") [" + SLT.RT_ToString(CustomResolveType) + "]); note: if this does not indicate invalid, please report a bug")
    endif
    ; no auto-conversion from float or bool
    return none
EndFunction

Function SetVarFromCustomResult(string varscope, string varname)
    if !IsCustomResolveValid()
        SetVarString2(varscope, varname, "")
        return
    endif

    if SLT.RT_STRING == CustomResolveType
        SetVarString2(varscope, varname, CustomResolveStringResult)
    elseif SLT.RT_BOOL == CustomResolveType
        SetVarBool(varscope, varname, CustomResolveBoolResult)
    elseif SLT.RT_INT == CustomResolveType
        SetVarInt(varscope, varname, CustomResolveIntResult)
    elseif SLT.RT_FLOAT == CustomResolveType
        SetVarFloat(varscope, varname, CustomResolveFloatResult)
    elseif SLT.RT_FORM == CustomResolveType
        SetVarForm(varscope, varname, CustomResolveFormResult)
    endif
EndFunction

bool Function IsCustomResolveValid()
    bool knownStates = SLT.RT_STRING == CustomResolveType || SLT.RT_BOOL == CustomResolveType || SLT.RT_INT == CustomResolveType || SLT.RT_FLOAT == CustomResolveType || SLT.RT_FORM == CustomResolveType
    if SLT.RT_INVALID != CustomResolveType && !knownStates
        SFE("CustomResolveResult current value(" + CustomResolveStringResult + ") is not RT_INVALID(" + SLT.RT_INVALID + ") but not among known states; this is an error")
    endif
    return knownStates
EndFunction

Function SetMostRecentFromCustomResolve()
    if SLT.RT_STRING == CustomResolveType
        MostRecentStringResult = CustomResolveStringResult
    elseif SLT.RT_BOOL == CustomResolveType
        MostRecentBoolResult = CustomResolveBoolResult
    elseif SLT.RT_INT == CustomResolveType
        MostRecentIntResult = CustomResolveIntResult
    elseif SLT.RT_FLOAT == CustomResolveType
        MostRecentFloatResult = CustomResolveFloatResult
    elseif SLT.RT_FORM == CustomResolveType
        MostRecentFormResult = CustomResolveFormResult
    else
        InvalidateMostRecentResult()
    endif
EndFunction

; going to replace this with ResultFromBool(bool), ResultFromString(string), ResultFromForm(Form), etc.
; oh frabjous joy
int         Property MostRecentResultType Auto Hidden

string  _recentResultString
bool    _recentResultBool
int     _recentResultInt
float   _recentResultFloat
Form    _recentResultForm

string	    Property MostRecentStringResult Hidden
    string Function Get()
        return _recentResultString
    EndFunction
    Function Set(string value)
        _recentResultString = value
        MostRecentResultType = SLT.RT_STRING
    EndFunction
EndProperty
bool        Property MostRecentBoolResult Hidden
    bool Function Get()
        return _recentResultBool
    EndFunction
    Function Set(bool value)
        _recentResultBool = value
        MostRecentResultType = SLT.RT_BOOL
    EndFunction
EndProperty
int         Property MostRecentIntResult  Hidden
    int Function Get()
        return _recentResultInt
    EndFunction
    Function Set(int value)
        _recentResultInt = value
        MostRecentResultType = SLT.RT_INT
    EndFunction
EndProperty
float        Property MostRecentFloatResult  Hidden
    float Function Get()
        return _recentResultFloat
    EndFunction
    Function Set(float value)
        _recentResultFloat = value
        MostRecentResultType = SLT.RT_FLOAT
    EndFunction
EndProperty
Form        Property MostRecentFormResult Hidden
    Form Function Get()
        return _recentResultForm
    EndFunction
    Function Set(Form value)
        _recentResultForm = value
        MostRecentResultType = SLT.RT_FORM
    EndFunction
EndProperty

Function InvalidateMostRecentResult()
    MostRecentResultType = SLT.RT_INVALID
EndFunction


string[] threadVarKeys
string[] threadVarVals
int[]    threadVarTypes

string[] localVarKeys
string[] localVarVals
int[]    localVarTypes

string[]    gotoLabels = none 
int[]       gotoLines = none
string[]    gosubLabels = none
int[]       gosubLines = none 
int[]       gosubReturns = none
int[]       whileReturns = none

int[]       scriptlines
int[]       tokencounts
int[]       tokenoffsets
string[]    tokens

; thread values
string      initialScriptName = ""

bool hasValidFrame
bool IsResetRequested = false

int Property BE_NONE        = 0 AutoReadOnly Hidden
int Property BE_IF          = 1 AutoReadOnly Hidden
int Property BE_BEGINSUB    = 2 AutoReadOnly Hidden
int Property BE_WHILE       = 3 AutoReadOnly Hidden

string __be_starter = ""
string __be_ender = ""
int __be_needed = 0

Function SetBlockEndTarget(int betype)
    if BE_IF == betype
        __be_starter = "if"
        __be_ender = "endif"
        __be_needed = 1
    elseif BE_BEGINSUB == betype
        __be_starter = "beginsub"
        __be_ender = "endsub"
        __be_needed = 1
    elseif BE_WHILE == betype
        __be_starter = "while"
        __be_ender = "endwhile"
        __be_needed = 1
    else
        __be_starter = ""
        __be_ender = ""
        __be_needed = 0
    endif
EndFunction

Function ResetBlockEndTarget()
    __be_needed = 0
    __be_starter = ""
    __be_ender = ""
EndFunction

;/
Event OnEffectFinish(Actor akTarget, Actor akCaster)
    CleanupAndRemove()
EndEvent
/;

Event OnSLTReset(string eventName, string strArg, float numArg, Form sender)
    IsResetRequested = true
    CleanupAndRemove()
EndEvent

Event OnSLTSettingsUpdated(string eventName, string strArg, float numArg, Form sender)
    RefreshDebugFlagsFromSLT()
EndEvent

Event OnEffectStart(Actor akTarget, Actor akCaster)
    RefreshDebugFlagsFromSLT()

    if Debug_Cmd
        SLTDebugMsg("Cmd.OnEffectStart")
    endif

    initialGameTime = Utility.GetCurrentGameTime()

	CmdTargetActor = akCaster
    
    threadVarKeys = PapyrusUtil.StringArray(0)
    threadVarVals = PapyrusUtil.StringArray(0)
    threadVarTypes = PapyrusUtil.IntArray(0)

    DoStartup()
EndEvent

Event OnPlayerLoadGame()
    RefreshDebugFlagsFromSLT()

    DoStartup()
EndEvent

Function DoStartup()
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return
    endif

	SafeRegisterForModEvent_AME(self, EVENT_SLT_RESET(), "OnSLTReset")
    SafeRegisterForModEvent_AME(self, EVENT_SLT_SETTINGS_UPDATED(), "OnSLTSettingsUpdated")
    
    if !threadid
        ; need to determine our threadid
        string[] nextThreadInfo = SLT.ClaimNextThread(CmdTargetFormID)
        if nextThreadInfo.Length
            threadid = nextThreadInfo[0] as int
            initialScriptName = nextThreadInfo[1]
            CmdRequestId = nextThreadInfo[2] as int
        endif

        if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
            SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
            CleanupAndRemove()
            Return
        endif

        if threadid > 0
            if !slt_Frame_Push(initialScriptName, none)
                SLTErrMsg("sl_triggersCmd: invalid push frame attempt for script(" + initialScriptName + ")")
                CleanupAndRemove()
                return
            endif
        endif
    endif
    
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return
    endif

    if threadid && hasValidFrame
        if !isExecuting
            QueueUpdateLoop(0.01)
        endif
    else
        SLTErrMsg("sl_triggersCmd unable to obtain threadid; bailing")
        CleanupAndRemove()
    endif
EndFunction

Event OnUpdate()
    if !self || isExecuting
        return
    endif

    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return
    endif

    isExecuting = true

    SLT.RunningScriptCount += 1
    if Debug_Cmd
        SFD("Cmd.OnUpdate: starting threadid(" + threadid + ") RunningScriptCount is :" + SLT.RunningScriptCount)
    endif
    RunScript()
    SLT.RunningScriptCount -= 1
    if Debug_Cmd
        SFD("Cmd.OnUpdate: ending threadid(" + threadid + ") RunningScriptCount is :" + SLT.RunningScriptCount)
    endif
    
    CleanupAndRemove()
EndEvent

Function CleanupAndRemove()
    if cleanedup
        return
    endif

    cleanedup = true
    isExecuting = false
    UnregisterForAllModEvents()

    Self.Dispel()
EndFunction

Function RunOperationOnActor(string[] opCmdLine)
    if !opCmdLine.Length
        return
    endif
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return
    endif

    InvalidateMostRecentResult()

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
        
        if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
            SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
            CleanupAndRemove()
            Return
        endif

        Utility.Wait(afDelay)
    endwhile
EndFunction

Function CompleteOperationOnActor()
    runOpPending = false

    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return
    endif
EndFunction

; InternalResolve - returns true if resolution succeeded, false otherwise
; string token - any input that needs to be "resolved" into one of the CustomResolve<Type>Result properties.
; token resolution will be performed, meaning if what is provided is just a string, just a string will be returned (i.e. CustomResolveResult)
; if it is an interpolated string i.e. $"with spooky {varname} fields", the string will be interpolated (recursively using InternalResolve as needed) and the final string returned (i.e. CustomResolveResult)
; in other cases, if the environment warrants, a different CustomResolve<Type>Result will be populated, allowing more accurate follow-on results
;
; This is a one-time, context-sensitive resolution process; depending on variable and environmental values, the final result could differ dramatically
; This also means all of it should be quite transient and not need to be pushed and popped, right?
bool Function InternalResolve(string token)
    IsCRLiteral = false
    IsCRBare = true

    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return false
    endif

    if token == "$$"
        if SLT.RT_STRING == MostRecentResultType
            CustomResolveStringResult = MostRecentStringResult
        elseif SLT.RT_BOOL == MostRecentResultType
            CustomResolveBoolResult = MostRecentBoolResult
        elseif SLT.RT_INT == MostRecentResultType
            CustomResolveIntResult = MostRecentIntResult
        elseif SLT.RT_FLOAT == MostRecentResultType
            CustomResolveFloatResult = MostRecentFloatResult
        elseif SLT.RT_FORM == MostRecentResultType
            CustomResolveFormResult = MostRecentFormResult
        else
            SFE("Invalid MostRecentResultType value(" + MostRecentResultType + ")[" + SLT.RT_ToString(MostRecentResultType) + "](note: if invalid status is not indicated, please report a bug); likely due to using $$ after calling a function that has no return value")
            InvalidateCR()
        endif
        return true
    endif

    if token == "true"
        IsCRLiteral = true
        CustomResolveBoolResult = true
        return true
    endif
    if token == "false"
        IsCRLiteral = true
        CustomResolveBoolResult = false
        return true
    endif

    int tokenlength = StringUtil.GetLength(token)
    string[] varscopestringlist = new string[2]
    string vtok
    int j
    int i = 0
    bool resolved = false
    bool sltChecked = false

    string char0 = StringUtil.GetNthChar(token, 0)

    if char0 == "\""
        ; imbalanced starting quote, try to treat as closed
        ;if StringUtil.GetNthChar(token, tokenlength - 1) == "\""
            IsCRBare = false
            IsCRLiteral = true
            CustomResolveStringResult = StringUtil.Substring(token, 1, tokenlength - 2)
            return true
        ;endif

    elseif char0 == "$"
        if StringUtil.GetNthChar(token, 1) == "\""
            if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
                SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
                CleanupAndRemove()
                Return false
            endif

            string trimmed = StringUtil.Substring(token, 2, tokenlength - 3)
            string[] vartoks = sl_triggers.TokenizeForVariableSubstitution(trimmed)

            j = 0
            while j < vartoks.Length
                vartoks[j] = ResolveString(vartoks[j])
                ;/
                if InternalResolve(vartoks[j])
                    vartoks[j] = CustomResolveResult
                endif
                /;

                j += 1
            endwhile

            IsCRBare = false
            IsCRLiteral = true
            CustomResolveStringResult = PapyrusUtil.StringJoin(vartoks, "")
            return true
        endif

        if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
            SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
            CleanupAndRemove()
            Return false
        endif

        GetVarScope2(token, varscopestringlist)
        string scope = varscopestringlist[0]
        string vname = varscopestringlist[1]

        if Debug_Cmd_InternalResolve
            SLTDebugMsg("Cmd.InternalResolve: varscope<" + PapyrusUtil.StringJoin(varscopestringlist, ">,<") + ">")
        endif

        if "local" == scope || "global" == scope || "thread" == scope || "target" == scope
            CustomResolveStringResult = GetVarString2(scope, vname, "")
            return true
        endif

        if "system" == scope
            if "self" == vname
                CustomResolveFormResult = CmdTargetActor
                return true
            elseif "player" == vname
                CustomResolveFormResult = PlayerRef
                return true
            elseif "actor" == vname
                CustomResolveFormResult = iterActor
                return true
            elseif "random.100" == vname
                CustomResolveFloatResult = Utility.RandomFloat(0.0, 100.0)
                return true
            elseif "none" == vname
                CustomResolveFormResult = none
                return true
            elseif "is_player.inside" == vname
                CustomResolveBoolResult = PlayerRef.IsInInterior()
                return true
            elseif "is_player.outside" == vname
                CustomResolveBoolResult = !PlayerRef.IsInInterior()
                return true
            elseif "is_player.in_city" == vname
                CustomResolveBoolResult = SLT.IsLocationKeywordCity(SLT.GetPlayerLocationKeyword())
                return true
            elseif "is_player.in_dungeon" == vname
                CustomResolveBoolResult = SLT.IsLocationKeywordDungeon(SLT.GetPlayerLocationKeyword())
                return true
            elseif "is_player.in_safe" == vname
                CustomResolveBoolResult = SLT.IsLocationKeywordSafe(SLT.GetPlayerLocationKeyword())
                return true
            elseif "is_player.in_wilderness" == vname
                CustomResolveBoolResult = SLT.IsLocationKeywordWilderness(SLT.GetPlayerLocationKeyword())
                return true
            elseif "stats.running_scripts" == vname
                CustomResolveIntResult = SLT.RunningScriptCount
                return true
            elseif "realtime" == vname
                CustomResolveFloatResult = Utility.GetCurrentRealTime()
                return true
            elseif "gametime" == vname
                CustomResolveFloatResult = Utility.GetCurrentGameTime()
                return true
            elseif "initialGameTime" == vname
                CustomResolveFloatResult = initialGameTime
                return true
            elseif "initialScriptName" == vname
                CustomResolveStringResult = initialScriptName
                return true
            elseif "currentScriptName" == vname
                CustomResolveStringResult = currentScriptName
                return true
            elseif "sessionid" == vname
                CustomResolveIntResult = sl_triggers.GetSessionId()
                return true
            endif
        endif
        
        while i < SLT.Extensions.Length
            if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
                SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
                CleanupAndRemove()
                Return false
            endif

            sl_triggersExtension slext = SLT.Extensions[i] as sl_triggersExtension
            
            resolved = slext.CustomResolveScoped(self, scope, vname)
            if resolved
                return true
            endif

            i += 1
        endwhile
    endif

    ; last chance, checking for literal int or float values (we already checked for literal bools above)
    string literalNumeric = sl_triggers.GetNumericLiteral(token)
    if Debug_Cmd_InternalResolve
        SFD("Literal numeric lookup returned (" + literalNumeric + ") for token(" + token + ")")
    endif
    if "invalid" != literalNumeric
        string[] numlitinfo = PapyrusUtil.StringSplit(literalNumeric, ":")
        if !numlitinfo || numlitinfo.Length != 2
            SFE("Literal numeric result returned (" + literalNumeric + ") but doesn't appear valid")
        elseif numlitinfo[0] == "int"
            IsCRLiteral = true
            CustomResolveIntResult = numlitinfo[1] as int
            if Debug_Cmd_InternalResolve
                SFD("Literal numeric lookup returning int(" + numlitinfo[1] + ")")
            endif
            return true
        elseif numlitinfo[0] == "float"
            IsCRLiteral = true
            CustomResolveFloatResult = numlitinfo[1] as float
            if Debug_Cmd_InternalResolve
                SFD("Literal numeric lookup returning float(" + numlitinfo[1] + ")")
            endif
            return true
        else
            SFE("This state should not happen (" + PapyrusUtil.StringJoin(numlitinfo, "),(") + ")")
        endif
    else
        if Debug_Cmd_InternalResolve
            if (token as int) || (token as float)
                SFD("Cmd.InternalResolve: literalNumeric check failed for (" + token + ")")
            endif
        endif
    endif

    if Debug_Cmd_InternalResolve
        SFI("InternalResolve: returning actual token for token(" + token + "); what was I supposed to do with this?")
    endif

    ;CustomResolveResult = token

    return false
EndFunction

; ResolveString
; string token - a variable to retrieve the value of e.g. $$, $global.foo, $g3
; returns: the value as a string; token if unable to resolve
string Function ResolveString(string token)
    if InternalResolve(token)
        if IsCustomResolveValid()
            return CRToString()
        endif

        return ""
    endif

    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return ""
    endif

    return token
EndFunction

; ResolveActor
; string _code - a variable indicating an Actor e.g. $self, $player
; returns: an Actor representing the specified Actor; none if unable to resolve
Actor Function ResolveActor(string token)
    Actor _resolvedActor = CmdTargetActor
    if token
        Form _localForm = ResolveForm(token)
        if _localForm
            _resolvedActor = _localForm as Actor
            if !_resolvedActor
                SFW("Cmd.ResolveActor: ResolveForm() returned (" + _localForm + ") but was not an Actor; unable to convert")
            endif
        else
            _resolvedActor = none
        endif
    endif
    
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return none
    endif

    return _resolvedActor
EndFunction

Form Function ResolveForm(string token)
    CustomResolveFormResult = none

    if Debug_Cmd_ResolveForm
        SFD("ResolveForm: token(" + token + ")")
    endif

    if InternalResolve(token)
        if IsCustomResolveValid()
            return CRToForm()
        endif

        return none
    else
        SFW("ResolveForm: unable to resolve token(" + token + ")")
    endif

    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return none
    endif

    if Debug_Cmd_ResolveForm || Debug_Cmd
        SFD("Cmd.ResolveForm: falling back to GetFormById(\"" + token + "\")")
    endif
    return GetFormById(token)
EndFunction

bool Function ResolveBool(string token)
    if InternalResolve(token)
        if IsCustomResolveValid()
            return CRToBool()
        endif

        return false
    endif

    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return false
    endif

    return sl_triggers.SmartEquals(true, token)
EndFunction

int Function ResolveInt(string token)
    if InternalResolve(token)
        if IsCustomResolveValid()
            return CRToInt()
        endif

        return 0
    endif
    
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return 0
    endif

    if Debug_Cmd
        SFW("Cmd.ResolveInt defaulted to casting token(" + token + ")")
    endif

    return token as int
EndFunction

float Function ResolveFloat(string token)
    if InternalResolve(token)
        if IsCustomResolveValid()
            return CRToFloat()
        endif

        return 0.0
    endif
    
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return 0.0
    endif

    if Debug_Cmd
        SFW("Cmd.ResolveFloat defaulted to casting token(" + token + ")")
    endif

    return token as float
EndFunction

; returns true if should increment currentLine, false otherwise
int Function RunCommandLine(string[] cmdLine, int startidx, int endidx, bool subCommand = true)
    if Debug_Cmd_RunScript
        SFD("Cmd.RunCommandLine")
    endif

    if !cmdLine.Length
        if Debug_Cmd_RunScript
            SFD("cmdLine.Length == 0; advancing empty line")
        endif
        return CLRR_ADVANCE
    endif

    string[] varscopestringlist = new string[2]

    bool        __bVal
    int         __CLRR = CLRR_ADVANCE
    int         __intVal
    int         __intVal2
    float       __floatVal
    float       __floatVal2
    string      __operator
    string      __outresult
    string      __strVal
    string      __strVal2
    string[]    __strListVal

    command = ResolveString(cmdLine[0])
    if Debug_Cmd_RunScript
        SFD("Cmd.RunScript: Resolve(" + cmdLine[0] + ") => [" + command + "]")
    endif
    cmdLine[0] = command

    If !command
        if Debug_Cmd_RunScript
            SFD("Cmd.RunScript: empty command")
        endif
        MostRecentStringResult = ""
        ;currentLine += 1
    elseIf __be_needed > 0
        ; intercept all rows until __blockendsneeded is satisfied, i.e. <= 0
        ; but let's have a little hygiene and validate we really are looking for something and correct things if things have gotten weird

        if Debug_Cmd_RunScript_Blocks
            SLTInfoMsg("__blockendsneeded(" + __be_needed + ") __blockendstarter(" + __be_starter + ") __blockendtarget(" + __be_ender + "): these should have values")
        endif

        if subCommand
            __be_needed = 0
            __be_starter = ""
            __be_ender = ""
            SFE("subcommand processing should not be encountered during block skipping; please report your script as an indication of SLTR script engine failure")
        elseif !__be_starter || !__be_ender
            ; this isn't right, we bail after resetting __be_needed
            __be_needed = 0
            __be_starter = ""
            __be_ender = ""
            if Debug_Cmd_RunScript_Blocks
                SFW("__be_needed was [" + __be_needed + "], but either __be_starter() or __be_ender were empty (\"\"); resetting __be_needed to 0 and both __be_starter and __be_ender to \"\"")
            endif
        else
            if command == __be_starter
                __be_needed += 1
            elseif command == __be_ender
                __be_needed -= 1
                ; this might bring us below 0, i.e. no longer needing to blockskip
                ; which means we need to allow block end handling now
                if __be_needed <= 0
                    __be_starter = ""
                    __be_ender = ""
                    __CLRR = CLRR_NOADVANCE
                endif
            endif
        endif

        ; currentLine += 1
    elseIf command == "set"
        if Debug_Cmd_RunScript
            SFD("Cmd.RunScript: set")
        endif
        if subCommand
            SFE("'set' is not a valid subcommand")
        elseif ParamLengthGT(self, cmdLine.Length, 2)
            if Debug_Cmd_RunScript_Set
                SFD("Cmd.RunScript: set: pre var scope, varscopestringlist<" + PapyrusUtil.StringJoin(varscopestringlist, ">|<") + ">")
            endif

            GetVarScope2(cmdLine[1], varscopestringlist, true)

            if Debug_Cmd_RunScript_Set
                SFD("Cmd.RunScript: set: post var scope, varscopestringlist<" + PapyrusUtil.StringJoin(varscopestringlist, ">|<") + ">")
            endif
            
            if varscopestringlist[0]

                if cmdLine.Length == 3
                    if Debug_Cmd_RunScript_Set
                        SFD("Cmd.RunScript: set/3 <target> <source>")
                    endif

                    InternalResolve(cmdLine[2])
                    SetVarFromCustomResult(varscopestringlist[0], varscopestringlist[1])
                    ;SetVarString2(varscopestringlist[0], varscopestringlist[1], Resolve(cmdLine[2]))
                else
                    __operator = ResolveString(cmdLine[2])

                    if cmdLine.Length > 3 && __operator == "resultfrom"
                    
                        if Debug_Cmd_RunScript_Set
                            SFD("Cmd.RunScript: set>3/w/resultfrom <target> resultfrom <stuff...>")
                        endif

                        __strListVal = PapyrusUtil.SliceStringArray(cmdLine, 3)
                        
                        InvalidateMostRecentResult()
                        RunCommandLine(__strListVal, startidx + 3, endidx)
                        if Debug_Cmd_RunScript_Set
                            __outresult = ResolveString("$$")
                            SFD("set: resultfrom: MostRecentResultType(" + SLT.RT_ToString(MostRecentResultType) + ") and outresult is (" + __outresult + ")")
                            SetVarFromCustomResult(varscopestringlist[0], varscopestringlist[1])
                            ;SetVarString2(varscopestringlist[0], varscopestringlist[1], __outresult)
                        else
                            InternalResolve("$$")
                            SetVarFromCustomResult(varscopestringlist[0], varscopestringlist[1])
                            ;SetVarString2(varscopestringlist[0], varscopestringlist[1], Resolve("$$"))
                        endif
                    elseif cmdLine.length == 4 && __operator == "="
                        if Debug_Cmd_RunScript_Set
                            SFD("Cmd.RunScript: set/4/w/= <target> = <source>")
                        endif

                        if Debug_Cmd_RunScript_Set
                            string sourceStringValue = ResolveString(cmdLine[3])

                            ;SetVarString2(varscopestringlist[0], varscopestringlist[1], sourceStringValue)
                            SetVarFromCustomResult(varscopestringlist[0], varscopestringlist[1])

                            string fetchedSourceValue = GetVarString2(varscopestringlist[0], varscopestringlist[1], "")

                            SFD("set/4/w/=: sourceStringValue(" + sourceStringValue + ") fetchedSourceValue(" + fetchedSourceValue + ")")
                        else
                            InternalResolve(cmdLine[3])
                            SetVarFromCustomResult(varscopestringlist[0], varscopestringlist[1])
                            ;SetVarString2(varscopestringlist[0], varscopestringlist[1], Resolve(cmdLine[3]))
                        endif
                    elseif cmdLine.length == 5
                        if Debug_Cmd_RunScript_Set
                            SFD("Cmd.RunScript: set/5 <target> = <source> <op> <source>")
                        endif
                        __operator = ResolveString(cmdLine[3])
                
                        ; this is sloppy, imprecise
                        if __operator == "+"
                            __floatVal = ResolveFloat(cmdLine[2]) + ResolveFloat(cmdLine[4])
                            __intVal = __floatVal as int
                            __floatVal2 = __intVal
                            if __floatVal == __floatVal
                                SetVarInt(varscopestringlist[0], varscopestringlist[1], __intVal)
                            else
                                SetVarFloat(varscopestringlist[0], varscopestringlist[1], __floatVal)
                            endif
                        elseIf __operator == "-"
                            __floatVal = ResolveFloat(cmdLine[2]) - ResolveFloat(cmdLine[4])
                            __intVal = __floatVal as int
                            __floatVal2 = __intVal
                            if __floatVal == __floatVal
                                SetVarInt(varscopestringlist[0], varscopestringlist[1], __intVal)
                            else
                                SetVarFloat(varscopestringlist[0], varscopestringlist[1], __floatVal)
                            endif
                        elseIf __operator == "*"
                            __floatVal = ResolveFloat(cmdLine[2]) * ResolveFloat(cmdLine[4])
                            __intVal = __floatVal as int
                            __floatVal2 = __intVal
                            if __floatVal == __floatVal
                                SetVarInt(varscopestringlist[0], varscopestringlist[1], __intVal)
                            else
                                SetVarFloat(varscopestringlist[0], varscopestringlist[1], __floatVal)
                            endif
                        elseIf __operator == "/"
                            __floatVal = ResolveFloat(cmdLine[2]) / ResolveFloat(cmdLine[4])
                            __intVal = __floatVal as int
                            __floatVal2 = __intVal
                            if __floatVal == __floatVal
                                SetVarInt(varscopestringlist[0], varscopestringlist[1], __intVal)
                            else
                                SetVarFloat(varscopestringlist[0], varscopestringlist[1], __floatVal)
                            endif
                        elseIf __operator == "&"
                            SetVarString2(varscopestringlist[0], varscopestringlist[1], ResolveString(cmdLine[2]) + ResolveString(cmdLine[4]))
                        elseIf __operator == "&&"
                            SetVarBool(varscopestringlist[0], varscopestringlist[1], ResolveBool(cmdLine[2]) && ResolveBool(cmdLine[4]))
                        elseIf __operator == "||"
                            SetVarBool(varscopestringlist[0], varscopestringlist[1], ResolveBool(cmdLine[2]) || ResolveBool(cmdLine[4]))
                        else
                            SFE("unexpected operator for 'set' (" + __operator + ")")
                        endif
                    else
                        if Debug_Cmd_RunScript_Set
                            SFD("Cmd.RunScript: set/unhandled\n\tcmdLine<" + PapyrusUtil.StringJoin(cmdLine, ">,<") + "> varscopestringlist<" + PapyrusUtil.StringJoin(varscopestringlist, ">,<") + ">")
                        endif
                    endif
                endif
            else
                if Debug_Cmd_RunScript_Set
                    SFD("Cmd.RunScript: set/unhandled\n\tcmdLine<" + PapyrusUtil.StringJoin(cmdLine, ">,<") + "> varscopestringlist<" + PapyrusUtil.StringJoin(varscopestringlist, ">,<") + ">")
                endif
                SFE("invalid variable name, not resolvable (" + cmdLine[1] + ")")
            endif
        else
            SFE("unexpected number of arguments for 'set' got " + cmdLine.length + " expected 3 or 5")
        endif
        ;currentLine += 1
    elseIf command == "endif"
        if subCommand
            SFE("'endif' is not a valid subcommand")
        endif
        ;currentLine += 1
    elseIf command == "endwhile"
        if subCommand
            SFE("'endwhile' is not a valid subcommand")
        endif
        __intVal = slt_PopWhileReturn()
        if __intVal > -1
            currentLine = __intVal
            __CLRR = CLRR_NOADVANCE
        endif
        ;currentLine += 1
    elseIf command == "while"
        if subCommand
            SFE("'while' is not a valid subcommand")
        else
            if cmdLine.Length == 2
                if ResolveBool(cmdLine[1])
                    slt_PushWhileReturn(currentLine)
                else
                    SetBlockEndTarget(BE_WHILE)
                endif
            elseif cmdLine.Length == 4
                __operator = ResolveString(cmdLine[2])
                
                if __operator
                    __bVal = false
                    if __operator == "=" || __operator == "==" || __operator == "&="
                        __bVal = sl_triggers.SmartEquals(ResolveString(cmdLine[1]), ResolveString(cmdLine[3]))
                    elseIf __operator == "!=" || __operator == "&!="
                        __bVal = !sl_triggers.SmartEquals(ResolveString(cmdLine[1]), ResolveString(cmdLine[3]))
                    elseIf __operator == ">"
                        if ResolveFloat(cmdLine[1]) > ResolveFloat(cmdLine[3])
                            __bVal = true
                        endif
                    elseIf __operator == ">="
                        if ResolveFloat(cmdLine[1]) >= ResolveFloat(cmdLine[3])
                            __bVal = true
                        endif
                    elseIf __operator == "<"
                        if ResolveFloat(cmdLine[1]) < ResolveFloat(cmdLine[3])
                            __bVal = true
                        endif
                    elseIf __operator == "<="
                        if ResolveFloat(cmdLine[1]) <= ResolveFloat(cmdLine[3])
                            __bVal = true
                        endif
                    else
                        SFE("unexpected operator, this is likely an error in the SLT script")
                        __bVal = false
                    endif

                    if __bVal
                        slt_PushWhileReturn(currentLine)
                    else
                        SetBlockEndTarget(BE_WHILE)
                    endIf
                else
                    SFE("unable to resolve operator (" + cmdLine[2] + ") po(" + __operator + ")")
                endif
            else
                SFE("'while': while <var> | while <var> <op> <var>, invalid number of arguments provided")
            endif
        endif
    elseIf command == "if"
        if subCommand
            SFE("'if' is not a valid subcommand")
        elseif cmdLine.Length == 2
            ; if <boolval> ; treat like start of if-block and search for endif
            if !ResolveBool(cmdLine[1])
                ; find the matching endif
                SetBlockEndTarget(BE_IF)
            endif
        elseif cmdLine.Length == 3
            ; if <boolval> <label> ;
            if ResolveBool(cmdLine[1])
                __strVal = ResolveString(cmdLine[2])
                __intVal = slt_FindGoto(__strVal)
                if __intVal > -1
                    currentLine = __intVal
                else
                    SFE("Unable to resolve goto label (" + cmdLine[2] + ") resolved to (" + __strVal + ")")
                endif
            endif
        elseif cmdLine.Length == 4
            ; if <var1> <op> <var2> ; treat like start of if-block and search for endif
            __operator = ResolveString(cmdLine[2])

            __bVal = false
            
            if __operator == "=" || __operator == "==" || __operator == "&="
                __bVal = sl_triggers.SmartEquals(ResolveString(cmdLine[1]), ResolveString(cmdLine[3]))
            elseIf __operator == "!=" || __operator == "&!="
                __bVal = !sl_triggers.SmartEquals(ResolveString(cmdLine[1]), ResolveString(cmdLine[3]))
            elseIf __operator == ">"
                if ResolveFloat(cmdLine[1]) > ResolveFloat(cmdLine[3])
                    __bVal = true
                endif
            elseIf __operator == ">="
                if ResolveFloat(cmdLine[1]) >= ResolveFloat(cmdLine[3])
                    __bVal = true
                endif
            elseIf __operator == "<"
                if ResolveFloat(cmdLine[1]) < ResolveFloat(cmdLine[3])
                    __bVal = true
                endif
            elseIf __operator == "<="
                if ResolveFloat(cmdLine[1]) <= ResolveFloat(cmdLine[3])
                    __bVal = true
                endif
            else
                SFE("unexpected operator(" + __operator + "), this is likely an error in the SLT script")
                __bVal = false
            endif

            if !__bVal
                SetBlockEndTarget(BE_IF)
            endIf
        elseif cmdLine.Length == 5
            ; if <var1> <op> <var2> <label>
            __operator = ResolveString(cmdLine[2])
            
            if __operator

                __bVal = false
                if __operator == "=" || __operator == "==" || __operator == "&="
                    __bVal = sl_triggers.SmartEquals(ResolveString(cmdLine[1]), ResolveString(cmdLine[3]))
                elseIf __operator == "!=" || __operator == "&!="
                    __bVal = !sl_triggers.SmartEquals(ResolveString(cmdLine[1]), ResolveString(cmdLine[3]))
                elseIf __operator == ">"
                    if ResolveFloat(cmdLine[1]) > ResolveFloat(cmdLine[3])
                        __bVal = true
                    endif
                elseIf __operator == ">="
                    if ResolveFloat(cmdLine[1]) >= ResolveFloat(cmdLine[3])
                        __bVal = true
                    endif
                elseIf __operator == "<"
                    if ResolveFloat(cmdLine[1]) < ResolveFloat(cmdLine[3])
                        __bVal = true
                    endif
                elseIf __operator == "<="
                    if ResolveFloat(cmdLine[1]) <= ResolveFloat(cmdLine[3])
                        __bVal = true
                    endif
                else
                    SFE("unexpected operator, this is likely an error in the SLT script")
                    __bVal = false
                endif

                if __bVal
                    __strVal = ResolveString(cmdLine[4])
                    __intVal = slt_FindGoto(__strVal)
                    if __intVal > -1
                        currentLine = __intVal
                    else
                        SFE("Unable to resolve goto label (" + cmdLine[4] + ") resolved to (" + __strVal + ")")
                    endif
                endIf
            else
                SFE("unable to resolve operator (" + cmdLine[2] + ") po(" + __operator + ")")
            endif
        else
            SFE("'if': invalid number of arguments")
        endif
        ;currentLine += 1
    elseIf command == "inc"
        if subCommand
            SFE("'inc' is not a valid subcommand")
        elseif ParamLengthGT(self, cmdLine.Length, 1)
            __strVal = cmdLine[1]
            __intVal = 1
            __floatVal = 1.0
            __bVal = true
            if cmdLine.Length > 2
                __intVal = ResolveInt(cmdLine[2])
                __floatVal = ResolveFloat(cmdLine[2])
                __bVal = (__intVal == __floatVal)
            endif
                
            GetVarScope2(__strVal, varscopestringlist, true)
            if varscopestringlist[0]
                __strVal2 = GetVarString2(varscopestringlist[0], varscopestringlist[1], "")
                
                __intVal2 = __strVal2 as int
                __floatVal2 = __strVal2 as float
                if (__intVal2 == __floatVal2 && __bVal)
                    SetVarInt(varscopestringlist[0], varscopestringlist[1], __intVal2 + __intVal)
                else
                    SetVarFloat(varscopestringlist[0], varscopestringlist[1], __floatVal2 + __floatVal)
                endif
            else
                SFE("no resolve found for variable parameter (" + cmdLine[1] + ") varstr(" + __strVal + ") varscope(" + varscopestringlist[1] + ")")
            endif
        endif
        ;currentLine += 1
    elseIf command == "goto"
        if Debug_Cmd_RunScript
            SFD("Cmd.RunScript: goto")
        endif
        if subCommand
            SFE("'goto' is not a valid subcommand")
        elseif ParamLengthEQ(self, cmdLine.Length, 2)
            __strVal = ResolveString(cmdLine[1])
            __intVal = slt_FindGoto(__strVal)
            if __intVal > -1
                currentLine = __intVal
            else
                SFE("Unable to resolve goto label (" + cmdLine[1] + ") resolved to (" + __strVal + ")")
            endif
        endif
        ;currentLine += 1
    elseIf command == "cat"
        if subCommand
            SFE("'cat' is not a valid subcommand")
        elseif ParamLengthGT(self, cmdLine.Length, 2)
            __strVal = cmdLine[1]
            
            GetVarScope2(__strVal, varscopestringlist, true)
            if varscopestringlist[0]
                __intVal = 2
                __strVal2 = GetVarString2(varscopestringlist[0], varscopestringlist[1], "")
                while __intVal < cmdLine.Length
                    __strVal2 = __strVal2 + ResolveString(cmdLine[__intVal])
                    __intVal += 1
                endwhile
                SetVarString2(varscopestringlist[0], varscopestringlist[1], __strVal2)
            else
                SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
            endif
        endif
        ;currentLine += 1
    elseIf command == "gosub"
        if subCommand
            SFE("'gosub' is not a valid subcommand")
        elseif ParamLengthEQ(self, cmdLine.Length, 2)
            __strVal = ResolveString(cmdLine[1])
            __intVal = slt_FindGosub(__strVal)
            if __intVal > -1
                slt_PushGosubReturn(currentLine)
                currentLine = __intVal
            else
                SFE("Unable to resolve gosub label (" + cmdLine[1] + ") resolved to (" + __strVal + ")")
            endif
        endif
        ;currentLine += 1
    elseIf command == "call"
        if subCommand
            SFE("'call' is not a valid subcommand")
        elseif ParamLengthGT(self, cmdLine.Length, 1)
            __strVal = ResolveString(cmdLine[1])

            __strListVal = none
            if cmdLine.Length > 2
                __strListVal = PapyrusUtil.SliceStringArray(cmdLine, 2)
                __intVal = 0
                while __intVal < __strListVal.Length
                    __strListVal[__intVal] = ResolveString(__strListVal[__intVal])
                    __intVal += 1
                endwhile
            endif

            if !slt_Frame_Push(__strVal, __strListVal)
                SFE("call target file not parseable(" + __strVal + ") resolved from (" + cmdLine[1] + ")")
                ;currentLine += 1
            else
                __CLRR = CLRR_NOADVANCE
            endif
        else
            ;currentLine += 1
        endif
    elseIf command == "endsub"
        if subCommand
            SFE("'endsub' is not a valid subcommand")
        elseif ParamLengthEQ(self, cmdLine.Length, 1)
            __intVal = slt_PopGosubReturn()
            if __intVal > -1
                currentLine = __intVal
            endif
        endif
        ;currentLine += 1
    elseIf command == "beginsub"
        if subCommand
            SFE("set is not a valid subcommand")
        else
            if ParamLengthEQ(self, cmdLine.Length, 2)
                slt_AddGosub(ResolveString(cmdLine[1]), currentLine)
            endif
            ; still try to go through with finding the end
            __intVal = currentLine
            while __intVal < totalLines
                startidx = tokenoffsets[__intVal]
                if tokens[startidx] == "endsub"
                    currentLine = __intVal
                    __intVal = totalLines
                endif
                __intVal += 1
            endwhile
        endif
        ;currentLine += 1
    elseIf command == "callarg"
        if subCommand
            SFE("'callarg' is not a valid subcommand")
        elseif ParamLengthEQ(self, cmdLine.Length, 3)
            __intVal = ResolveInt(cmdLine[1])
            string arg = cmdLine[2]
            string newval

            if __intVal < callargs.Length && __intVal >= 0
                newval = callargs[__intVal]
            elseif __intVal < 0
                SFE("invalid index(" + __intVal + "): negative values not allowed")
            elseif __intVal >= callargs.Length
                SFE("invalid index(" + __intVal + "): maximum index for callarg is (" + callargs.Length + ")")
            endif
            
            GetVarScope2(arg, varscopestringlist, true)
            if varscopestringlist[0]
                SetVarString2(varscopestringlist[0], varscopestringlist[1], newval)
            else
                SFE("unable to resolve variable name (" + arg + ")")
            endif
        endif
        ;currentLine += 1
    elseIf command == "return"
        if subCommand
            SFE("'return' is not a valid subcommand")
        elseif !slt_Frame_Pop()
            __CLRR = CLRR_RETURN
        endif
        
        ;currentLine += 1
    else
        string _slt_mightBeLabel = _slt_IsLabel(cmdLine)
        if _slt_mightBeLabel
            if subCommand
                SFE("cannot define label as a subcommand")
            else
                if Debug_Cmd_RunScript
                    SFD("Cmd.RunScript: [might be label]")
                endif
                slt_AddGoto(_slt_mightBeLabel, currentLine)
            endif
        else
            if Debug_Cmd_RunScript
                SFD("Cmd.RunScript: RunOperationOnActor(" + PapyrusUtil.StringJoin(cmdLine, "),(") + ")")
            endif
            RunOperationOnActor(cmdLine)
        endif

        ;currentLine += 1
    endif

    return __CLRR
EndFunction

Function RunScript()
    if Debug_Cmd || Debug_Cmd_RunScript
        SFD("Cmd.RunScript")
    endif

    string[] cmdLine
    int commandLineRunResult

    while isExecuting && hasValidFrame
        if Debug_Cmd_RunScript
            SFD("Cmd.RunScript: isExecuting and hasValidFrame")
        endif
        if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
            SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
            CleanupAndRemove()
            Return
        endif

        while currentLine < totalLines
            lineNum = scriptlines[currentLine]
            int startidx = tokenoffsets[currentLine]
            int endidx = tokencounts[currentLine] + startidx - 1
            cmdLine = PapyrusUtil.SliceStringArray(tokens, startidx, endidx)
            
            if Debug_Cmd_RunScript
                SFD("Cmd.RunScript: lineNum(" + lineNum + ") startidx(" + startidx + ") endidx(" + endidx + ") currentScriptName(" + currentScriptName + ") initialScriptName(" + initialScriptName + ") cmdLine(" + PapyrusUtil.StringJoin(cmdLine, "), (") + ")")
            endif
            
            if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
                SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
                CleanupAndRemove()
                Return
            endif
            
            if cmdLine.Length
                if Debug_Cmd_RunScript
                    SFI("RunCommandLine values before: for cmdLine(" + PapyrusUtil.StringJoin(cmdLine, "), (") + ")" + ": currentLine(" + currentLine + ") totalLines(" + totalLines + ") currentScriptName(" + currentScriptName + ") initialScriptName(" + initialScriptName + ")")
                endif
                commandLineRunResult = RunCommandLine(cmdLine, startidx, endidx, false)
                if Debug_Cmd_RunScript
                    SFI("RunCommandLine result: (" + CLRR_ToString(commandLineRunResult) + ") for cmdLine(" + PapyrusUtil.StringJoin(cmdLine, "), (") + ")" + ": currentLine(" + currentLine + ") totalLines(" + totalLines + ") currentScriptName(" + currentScriptName + ") initialScriptName(" + initialScriptName + ")")
                endif

                if CLRR_RETURN == commandLineRunResult
                    if Debug_Cmd_RunScript
                        SFD("CLRR_RETURN; returning")
                    endif
                    return
                endif

                if CLRR_ADVANCE == commandLineRunResult
                    if Debug_Cmd_RunScript
                        SFD("CLRR_ADVANCE; incrementing currentLine")
                    endif
                    currentLine += 1
                endif

                if CLRR_NOADVANCE == commandLineRunResult
                    if Debug_Cmd_RunScript
                        SFD("CLRR_NOADVANCE; thus, not advancing")
                    endif
                endif
            else
                currentLine += 1
            endif
        endwhile

        if Debug_Cmd_RunScript
            SFI("Cmd.RunScript: Left while loop; currentLine(" + currentLine + ") totalLines(" + totalLines + ") currentScriptName(" + currentScriptName + ") initialScriptName(" + initialScriptName + ")")
        endif

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
            isLabel = ResolveString(StringUtil.Substring(_tokens[0], 1, _labelLen - 2))
        endif
    endif

    return isLabel
EndFunction

Function SFE(string msg)
	SquawkFunctionError(self, msg)
EndFunction

Function SFW(string msg)
	SquawkFunctionWarn(self, msg)
EndFunction

Function SFI(string msg)
	SquawkFunctionInfo(self, msg)
EndFunction

Function SFD(string msg)
	SquawkFunctionDebug(self, msg)
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
int[]       frame_var_type_store

int[]       frame_goto_label_count
string[]    frame_goto_labels
int[]       frame_goto_lines

int[]       frame_gosub_label_count
string[]    frame_gosub_labels
int[]       frame_gosub_lines

int[]       frame_gosub_return_count
int[]       frame_gosub_returns

int[]       frame_while_return_count
int[]       frame_while_returns

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
string[]    pushed_recentresultstring
bool[]      pushed_recentresultbool
int[]       pushed_recentresultint
float[]     pushed_recentresultfloat
Form[]      pushed_recentresultform
int[]       pushed_mostrecentresulttype
Actor[]     pushed_iteractor
string[]    pushed_currentscriptname

bool Function slt_Frame_Push(string scriptfilename, string[] parm_callargs)
    if !scriptfilename
        return false
    endif
    
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return false
    endif

    string cmdLineJoined
    int lineno = 0
    string[] cmdLine

    string[] rawtokenresult
    int totalFunctionalCommands = 0

    string[] cmdlines
    int totalJsonCommandCount = 0

    ; 0 - unknown
    ; 1 - json explicit
    ; 2 - ini explicit
    ; 3 - sltscript explicit
    ; 10 - json implicit
    ; 20 - ini implicit
    ; 30 - sltscript explicit
    int scrtype = sl_triggers.NormalizeScriptfilename(scriptfilename)
    string _myCmdName
    if scrtype == 1
        _myCmdName = CommandsFolder() + scriptfilename
        totalJsonCommandCount = JsonUtil.PathCount(_myCmdName, ".cmd")
    elseif scrtype == 2
        _myCmdName = scriptfilename

        rawtokenresult = sl_triggers.SplitScriptContentsAndTokenize(_myCmdName)
        totalFunctionalCommands = rawtokenresult[0] as int
    elseif scrtype == 3
        _myCmdName = scriptfilename

        rawtokenresult = sl_triggers.SplitScriptContentsAndTokenize(_myCmdName)
        totalFunctionalCommands = rawtokenresult[0] as int
        SLTDebugMsg("")
    elseif scrtype == 10
        scrtype = 1
        _myCmdName = CommandsFolder() + scriptfilename + ".json"
        totalJsonCommandCount = JsonUtil.PathCount(_myCmdName, ".cmd")
    elseif scrtype == 20
        ; for now, treat as the same; .sltscript is just a bandaid to improve syntax highlighting
        scrtype = 2
        _myCmdName = scriptfilename + ".ini"

        rawtokenresult = sl_triggers.SplitScriptContentsAndTokenize(_myCmdName)
        totalFunctionalCommands = rawtokenresult[0] as int
    elseif scrtype == 30
        ; for now, treat as the same; .sltscript is just a bandaid to improve syntax highlighting
        scrtype = 3
        _myCmdName = scriptfilename + ".sltscript"

        rawtokenresult = sl_triggers.SplitScriptContentsAndTokenize(_myCmdName)
        totalFunctionalCommands = rawtokenresult[0] as int
    else
        SFE("SLT: (unusual here) attempted to parse an unknown file type(" + _myCmdName + ") for scrtype (" + scrtype + ")")
        return false
    endif

    if hasValidFrame
        if !pushed_currentLine
            pushed_currentLine = PapyrusUtil.IntArray(0)
            pushed_totalLines = PapyrusUtil.IntArray(0)
            pushed_lastKey = PapyrusUtil.IntArray(0)
            pushed_command = PapyrusUtil.StringArray(0)
            pushed_recentresultstring = PapyrusUtil.StringArray(0)
            pushed_recentresultbool = PapyrusUtil.BoolArray(0)
            pushed_recentresultint = PapyrusUtil.IntArray(0)
            pushed_recentresultfloat = PapyrusUtil.FloatArray(0)
            pushed_recentresultform = PapyrusUtil.FormArray(0)
            pushed_mostrecentresulttype = PapyrusUtil.IntArray(0)
            pushed_iteractor = new Actor[1]
            pushed_iteractor = PapyrusUtil.ResizeActorArray(pushed_iteractor, 0)
            pushed_currentscriptname = PapyrusUtil.StringArray(0)
        endif

        pushed_currentLine = PapyrusUtil.PushInt(pushed_currentLine, currentLine)
        pushed_totalLines = PapyrusUtil.PushInt(pushed_totalLines, totalLines)
        pushed_lastKey = PapyrusUtil.PushInt(pushed_lastKey, lastKey)
        pushed_command = PapyrusUtil.PushString(pushed_command, command)
        pushed_recentresultstring = PapyrusUtil.PushString(pushed_recentresultstring, _recentResultString)
        pushed_recentresultbool = PapyrusUtil.PushBool(pushed_recentresultbool, _recentResultBool)
        pushed_recentresultint = PapyrusUtil.PushInt(pushed_recentresultint, _recentResultInt)
        pushed_recentresultfloat = PapyrusUtil.PushFloat(pushed_recentresultfloat, _recentResultFloat)
        pushed_recentresultform = PapyrusUtil.PushForm(pushed_recentresultform, _recentResultForm)
        pushed_mostrecentresulttype = PapyrusUtil.PushInt(pushed_mostrecentresulttype, MostRecentResultType)

        pushed_iteractor = PapyrusUtil.PushActor(pushed_iteractor, iterActor)
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
            frame_var_type_store = PapyrusUtil.IntArray(varcount)
        else
            frame_var_count = PapyrusUtil.PushInt(frame_var_count, varcount)
            frame_var_key_store = PapyrusUtil.ResizeStringArray(frame_var_key_store, varstoresize + varcount)
            frame_var_val_store = PapyrusUtil.ResizeStringArray(frame_var_val_store, varstoresize + varcount)
            frame_var_type_store = PapyrusUtil.ResizeIntArray(frame_var_type_store, varstoresize + varcount)
        endif

        if varcount
            i = 0
            while i < varcount
                j = i + varstoresize
                frame_var_key_store[j] = localVarKeys[i]
                frame_var_val_store[j] = localVarVals[i]
                frame_var_type_store[j] = localVarTypes[i]

                i += 1
            endwhile
        endif

        localVarKeys = PapyrusUtil.StringArray(0)
        localVarVals = PapyrusUtil.StringArray(0)
        localVarTypes = PapyrusUtil.IntArray(0)

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

        ; while block returns
        varcount        = whileReturns.Length
        varstoresize    = frame_while_returns.Length
        if !frame_while_return_count
            frame_while_return_count = new int[1]
            frame_while_return_count[0] = varcount
            frame_while_returns = PapyrusUtil.IntArray(varcount)
        else
            frame_while_return_count = PapyrusUtil.PushInt(frame_while_return_count, varcount)
            frame_while_returns = PapyrusUtil.ResizeIntArray(frame_while_returns, varstoresize + varcount)
        endif

        if varcount
            i = 0
            while i < varcount
                j = i + varstoresize
                frame_while_returns[j] = whileReturns[i]

                i += 1
            endwhile
        endif

        whileReturns = PapyrusUtil.IntArray(0)

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
        localVarTypes = PapyrusUtil.IntArray(0)
        gotoLabels = PapyrusUtil.StringArray(0)
        gotoLines = PapyrusUtil.IntArray(0)
        gosubLabels = PapyrusUtil.StringArray(0)
        gosubLines = PapyrusUtil.IntArray(0)
        gosubReturns = PapyrusUtil.IntArray(0)
        whileReturns = PapyrusUtil.IntArray(0)

        scriptlines = PapyrusUtil.IntArray(0)
        tokencounts = PapyrusUtil.IntArray(0)
        tokenoffsets = PapyrusUtil.IntArray(0)
        tokens = PapyrusUtil.StringArray(0)
    endif

    if scrtype == 1
        int theFileLine = 0
        while theFileLine < totalJsonCommandCount
            lineno += 1
            
            ; this accounts for comments
            cmdLine = JsonUtil.PathStringElements(_myCmdName, ".cmd[" + theFileLine + "]")
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
            theFileLine += 1
        endwhile
    elseif scrtype == 2 || scrtype == 3

        scriptlines = PapyrusUtil.IntArray(totalFunctionalCommands)
        tokencounts = PapyrusUtil.IntArray(totalFunctionalCommands)
        tokenoffsets = PapyrusUtil.IntArray(totalFunctionalCommands)
        tokens = PapyrusUtil.SliceStringArray(rawtokenresult, 1 + 3 * totalFunctionalCommands)

        int sloff = 1
        int tcoff = sloff + totalFunctionalCommands
        int tooff = tcoff + totalFunctionalCommands
        int tokoff = tooff + totalFunctionalCommands
        int offset
        int tokens_offset
        int iter

        int lhs
        int rhs
        
        int cmdIdx = 0
        int lastWhereLine = -1

        while cmdIdx < totalFunctionalCommands
            offset = sloff + cmdIdx
            scriptlines[cmdIdx] = rawtokenresult[offset] as int
            offset = tcoff + cmdIdx
            tokencounts[cmdIdx] = rawtokenresult[offset] as int
            offset = tooff + cmdIdx
            tokenoffsets[cmdIdx] = rawtokenresult[offset] as int

            if tokencounts[cmdIdx] == 1
                string cmdLine0 = tokens[tokenoffsets[cmdIdx]]
                int tlen = StringUtil.GetLength(cmdLine0)
                int tlenm1 = tlen - 1
                int tlenm2 = tlenm1 - 1
                if tlen > 2 && StringUtil.GetNthChar(cmdLine0, 0) == "[" && StringUtil.GetNthChar(cmdLine0, tlenm1) == "]"
                    string lbl = sl_triggers.Trim(StringUtil.Substring(cmdLine0, 1, tlenm2))
                    if lbl
                        slt_AddGoto(lbl, cmdIdx)
                    endif
                endif
            elseif tokencounts[cmdIdx] == 2 && tokens[tokenoffsets[cmdIdx]] == "beginsub"
                offset = tokenoffsets[cmdIdx] + 1
                slt_AddGosub(tokens[offset], cmdIdx)
            endif

            cmdIdx += 1
        endwhile
    endif

    lastKey = 0
    InvalidateMostRecentResult()
    _recentResultString = ""
    _recentResultBool = false
    _recentResultInt = 0
    _recentResultFloat = 0.0
    _recentResultForm = none
    iterActor = none
    currentScriptName = _myCmdName
    currentLine = 0
    lineNum = scriptlines[0]
    command = ""

    totalLines = scriptlines.Length

    if Debug_Cmd
        SLTDebugMsg("Cmd.slt_Frame_Push: scriptname:" + currentScriptName + ": totalLines:" + totalLines + ":")
    endif

    hasValidFrame = true

    ResetBlockEndTarget()

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
    
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return false
    endif

    currentLine                 = pushed_currentLine[pushed_currentLine.Length - 1]
    totalLines                  = pushed_totalLines[pushed_totalLines.Length - 1]
    lastKey                     = pushed_lastKey[pushed_lastKey.Length - 1]
    command                     = pushed_command[pushed_command.Length - 1]
    MostRecentResultType        = pushed_mostrecentresulttype[pushed_mostrecentresulttype.Length - 1]
    _recentResultString         = pushed_recentresultstring[pushed_recentresultstring.Length - 1]
    _recentResultBool           = pushed_recentresultbool[pushed_recentresultbool.Length - 1]
    _recentResultInt            = pushed_recentresultint[pushed_recentresultint.Length - 1]
    _recentResultFloat          = pushed_recentresultfloat[pushed_recentresultfloat.Length - 1]
    _recentResultForm           = pushed_recentresultform[pushed_recentresultform.Length - 1]
    currentScriptName           = pushed_currentscriptname[pushed_currentscriptname.Length - 1]
    iterActor                   = pushed_iteractor[pushed_iteractor.Length - 1]

    pushed_currentLine          = PapyrusUtil.ResizeIntArray(pushed_currentLine, pushed_currentLine.Length - 1)
    pushed_totalLines           = PapyrusUtil.ResizeIntArray(pushed_totalLines, pushed_totalLines.Length - 1)
    pushed_lastKey              = PapyrusUtil.ResizeIntArray(pushed_lastKey, pushed_lastKey.Length - 1)
    pushed_command              = PapyrusUtil.ResizeStringArray(pushed_command, pushed_command.Length - 1)
    pushed_mostrecentresulttype = PapyrusUtil.ResizeIntArray(pushed_mostrecentresulttype, pushed_mostrecentresulttype.Length - 1)
    pushed_recentresultstring   = PapyrusUtil.ResizeStringArray(pushed_recentresultstring, pushed_recentresultstring.Length - 1)
    pushed_recentresultbool     = PapyrusUtil.ResizeBoolArray(pushed_recentresultbool, pushed_recentresultbool.Length - 1)
    pushed_recentresultint      = PapyrusUtil.ResizeIntArray(pushed_recentresultint, pushed_recentresultint.Length - 1)
    pushed_recentresultfloat    = PapyrusUtil.ResizeFloatArray(pushed_recentresultfloat, pushed_recentresultfloat.Length - 1)
    pushed_recentresultform     = PapyrusUtil.ResizeFormArray(pushed_recentresultform, pushed_recentresultform.Length - 1)
    pushed_currentscriptname    = PapyrusUtil.ResizeStringArray(pushed_currentscriptname, pushed_currentscriptname.Length - 1)
    pushed_iteractor            = PapyrusUtil.ResizeActorArray(pushed_iteractor, pushed_iteractor.Length - 1)

    int varcount
    int newvarstoresize
    int i
    int j

    ; vars
    varcount = frame_var_count[frame_var_count.Length - 1]
    newvarstoresize = frame_var_key_store.Length - varcount

    localVarKeys = PapyrusUtil.StringArray(varcount)
    localVarVals = PapyrusUtil.StringArray(varcount)
    localVarTypes = PapyrusUtil.IntArray(varcount)

    if varcount
        i = 0
        while i < varcount
            j = newvarstoresize + i
            localVarKeys[i] = frame_var_key_store[j]
            localVarVals[i] = frame_var_val_store[j]
            localVarTypes[i] = frame_var_type_store[j]

            i += 1
        endwhile
    endif

    frame_var_count = PapyrusUtil.ResizeIntArray(frame_var_count, frame_var_count.Length - 1)
    frame_var_key_store = PapyrusUtil.ResizeStringArray(frame_var_key_store, newvarstoresize)
    frame_var_val_store = PapyrusUtil.ResizeStringArray(frame_var_val_store, newvarstoresize)
    frame_var_type_store = PapyrusUtil.ResizeIntArray(frame_var_type_store, newvarstoresize)

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

    ; while block returns
    varcount        = frame_while_return_count[frame_while_return_count.Length - 1]
    newvarstoresize = frame_while_returns.Length - varcount

    whileReturns = PapyrusUtil.IntArray(varcount)

    if varcount
        i = 0
        while i < varcount
            j = newvarstoresize + i
            whileReturns[i] = frame_while_returns[j]

            i += 1
        endwhile
    endif

    frame_while_return_count = PapyrusUtil.ResizeIntArray(frame_while_return_count, frame_while_return_count.Length - 1)
    frame_while_returns = PapyrusUtil.ResizeIntArray(frame_while_returns, newvarstoresize)

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

    ResetBlockEndTarget()

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

Function slt_PushWhileReturn(int targetline)
    if !whileReturns
        whileReturns = new int[1]
        whileReturns[0] = targetline
    else
        whileReturns = PapyrusUtil.PushInt(whileReturns, targetline)
    endif
EndFunction

int Function slt_PopWhileReturn()
    if !whileReturns.Length
        return -1
    endif
    int r = whileReturns[whileReturns.Length - 1]
    whileReturns = PapyrusUtil.ResizeIntArray(whileReturns, whileReturns.Length - 1)
    return r
EndFunction

bool Function HasFrameVar(string _key)
	return (localVarKeys.Find(_key, 0) > -1)
EndFunction

string Function GetFrameVarString(string _key, string missing)
	int i = localVarKeys.Find(_key, 0)
	if i > -1
		return localVarVals[i]
	endif
	return missing
EndFunction

bool Function GetFrameVarBool(string _key, bool missing)
	int i = localVarKeys.Find(_key, 0)
	if i > -1
        int rt = localVarTypes[i]
        if SLT.RT_BOOL == rt
            return localVarVals[i] as bool
        elseif SLT.RT_INT == rt
            return (localVarVals[i] as int) != 0
        elseif SLT.RT_FLOAT == rt
            return (localVarVals[i] as float) != 0
        elseif SLT.RT_STRING == rt
            return localVarVals[i] != "false" && localVarVals[i] != "" && localVarVals[i] != "0"
        elseIF SLT.RT_FORM == rt
            return (localVarVals[i] as int) != 0
        endif
        SFE("GetFrameVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
	endif
	return missing
EndFunction

int Function GetFrameVarInt(string _key, int missing)
	int i = localVarKeys.Find(_key, 0)
	if i > -1
        int rt = localVarTypes[i]
        if SLT.RT_BOOL == rt
            return (localVarVals[i] as bool) as int
        elseif SLT.RT_INT == rt
            return localVarVals[i] as int
        elseif SLT.RT_FLOAT == rt
            return (localVarVals[i] as float) as int
        elseif SLT.RT_STRING == rt
            return localVarVals[i] as int
        elseIf SLT.RT_FORM == rt
            return localVarVals[i] as int
        endif
        SFE("GetFrameVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
	endif
	return missing
EndFunction

float Function GetFrameVarFloat(string _key, float missing)
	int i = localVarKeys.Find(_key, 0)
	if i > -1
        int rt = localVarTypes[i]
        if SLT.RT_BOOL == rt
            return (localVarVals[i] as bool) as float
        elseif SLT.RT_INT == rt
            return localVarVals[i] as int
        elseif SLT.RT_FLOAT == rt
            return localVarVals[i] as float
        elseif SLT.RT_STRING == rt
            return localVarVals[i] as int
        elseIf SLT.RT_FORM == rt
            return localVarVals[i] as int
        endif
        SFE("GetFrameVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
	endif
	return missing
EndFunction

Form Function GetFrameVarForm(string _key, Form missing)
	int i = localVarKeys.Find(_key, 0)
	if i > -1
        int rt = localVarTypes[i]
        if SLT.RT_BOOL == rt
            return none
        elseif SLT.RT_INT == rt
            return Game.GetForm(localVarVals[i] as int)
        elseif SLT.RT_FLOAT == rt
            return Game.GetForm((localVarVals[i] as float) as int)
        elseif SLT.RT_STRING == rt
            return sl_triggers.GetForm(localVarVals[i])
        elseIf SLT.RT_FORM == rt
            return Game.GetForm(localVarVals[i] as int)
        endif
        SFE("GetFrameVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
	endif
	return missing
EndFunction

string Function SetFrameVarString(string _key, string value)
	int i = localVarKeys.Find(_key, 0)
	if i < 0
		localVarKeys = PapyrusUtil.PushString(localVarKeys, _key)
        localVarVals = PapyrusUtil.PushString(localVarVals, value)
        localVarTypes = PapyrusUtil.PushInt(localVarTypes, SLT.RT_STRING)
    else
		localVarVals[i] = value
        localVarTypes[i] = SLT.RT_STRING
	endif
	return value
EndFunction

bool Function SetFrameVarBool(string _key, bool value)
	int i = localVarKeys.Find(_key, 0)
	if i < 0
		localVarKeys = PapyrusUtil.PushString(localVarKeys, _key)
        localVarVals = PapyrusUtil.PushString(localVarVals, value)
        localVarTypes = PapyrusUtil.PushInt(localVarTypes, SLT.RT_BOOL)
    else
		localVarVals[i] = value
        localVarTypes[i] = SLT.RT_BOOL
	endif
	return value
EndFunction

int Function SetFrameVarInt(string _key, int value)
	int i = localVarKeys.Find(_key, 0)
	if i < 0
		localVarKeys = PapyrusUtil.PushString(localVarKeys, _key)
        localVarVals = PapyrusUtil.PushString(localVarVals, value)
        localVarTypes = PapyrusUtil.PushInt(localVarTypes, SLT.RT_INT)
    else
		localVarVals[i] = value
        localVarTypes[i] = SLT.RT_INT
	endif
	return value
EndFunction

float Function SetFrameVarFloat(string _key, float value)
	int i = localVarKeys.Find(_key, 0)
	if i < 0
		localVarKeys = PapyrusUtil.PushString(localVarKeys, _key)
        localVarVals = PapyrusUtil.PushString(localVarVals, value)
        localVarTypes = PapyrusUtil.PushInt(localVarTypes, SLT.RT_FLOAT)
    else
		localVarVals[i] = value
        localVarTypes[i] = SLT.RT_FLOAT
	endif
	return value
EndFunction

Form Function SetFrameVarForm(string _key, Form value)
	int i = localVarKeys.Find(_key, 0)
	if i < 0
		localVarKeys = PapyrusUtil.PushString(localVarKeys, _key)
        localVarVals = PapyrusUtil.PushString(localVarVals, value.GetFormID())
        localVarTypes = PapyrusUtil.PushInt(localVarTypes, SLT.RT_FORM)
    else
		localVarVals[i] = value
        localVarTypes[i] = SLT.RT_FORM
	endif
	return value
EndFunction

bool Function HasThreadVar(string _key)
    return (threadVarKeys.Find(_key, 0) > -1)
EndFunction

string Function GetThreadVarString(string _key, string missing)
	int i = threadVarKeys.Find(_key, 0)
	if i > -1
		return threadVarVals[i]
	endif
	return missing
EndFunction

bool Function GetThreadVarBool(string _key, bool missing)
	int i = threadVarKeys.Find(_key, 0)
	if i > -1
        int rt = threadVarTypes[i]
        if SLT.RT_BOOL == rt
            return threadVarVals[i] as bool
        elseif SLT.RT_INT == rt
            return (threadVarVals[i] as int) != 0
        elseif SLT.RT_FLOAT == rt
            return (threadVarVals[i] as float) != 0
        elseif SLT.RT_STRING == rt
            return threadVarVals[i] != "false" && threadVarVals[i] != "" && threadVarVals[i] != "0"
        elseIF SLT.RT_FORM == rt
            return (threadVarVals[i] as int) != 0
        endif
        SFE("GetThreadVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
	endif
	return missing
EndFunction

int Function GetThreadVarInt(string _key, int missing)
	int i = threadVarKeys.Find(_key, 0)
	if i > -1
        int rt = threadVarTypes[i]
        if SLT.RT_BOOL == rt
            return (threadVarVals[i] as bool) as int
        elseif SLT.RT_INT == rt
            return threadVarVals[i] as int
        elseif SLT.RT_FLOAT == rt
            return (threadVarVals[i] as float) as int
        elseif SLT.RT_STRING == rt
            return threadVarVals[i] as int
        elseIf SLT.RT_FORM == rt
            return threadVarVals[i] as int
        endif
        SFE("GetThreadVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
	endif
	return missing
EndFunction

float Function GetThreadVarFloat(string _key, float missing)
	int i = threadVarKeys.Find(_key, 0)
	if i > -1
        int rt = threadVarTypes[i]
        if SLT.RT_BOOL == rt
            return (threadVarVals[i] as bool) as float
        elseif SLT.RT_INT == rt
            return threadVarVals[i] as int
        elseif SLT.RT_FLOAT == rt
            return threadVarVals[i] as float
        elseif SLT.RT_STRING == rt
            return threadVarVals[i] as int
        elseIf SLT.RT_FORM == rt
            return threadVarVals[i] as int
        endif
        SFE("GetThreadVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
	endif
	return missing
EndFunction

Form Function GetThreadVarForm(string _key, Form missing)
	int i = threadVarKeys.Find(_key, 0)
	if i > -1
        int rt = threadVarTypes[i]
        if SLT.RT_BOOL == rt
            return none
        elseif SLT.RT_INT == rt
            return Game.GetForm(threadVarVals[i] as int)
        elseif SLT.RT_FLOAT == rt
            return Game.GetForm((threadVarVals[i] as float) as int)
        elseif SLT.RT_STRING == rt
            return sl_triggers.GetForm(threadVarVals[i])
        elseIf SLT.RT_FORM == rt
            return Game.GetForm(threadVarVals[i] as int)
        endif
        SFE("GetThreadVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
	endif
	return missing
EndFunction

string Function SetThreadVarString(string _key, string value)
	int i = threadVarKeys.Find(_key, 0)
	if i < 0
		threadVarKeys = PapyrusUtil.PushString(threadVarKeys, _key)
        threadVarVals = PapyrusUtil.PushString(threadVarVals, value)
        threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_STRING)
    else
		threadVarVals[i] = value
        threadVarTypes[i] = SLT.RT_STRING
	endif
    return value
EndFunction

bool Function SetThreadVarBool(string _key, bool value)
	int i = threadVarKeys.Find(_key, 0)
	if i < 0
		threadVarKeys = PapyrusUtil.PushString(threadVarKeys, _key)
        threadVarVals = PapyrusUtil.PushString(threadVarVals, value)
        threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_BOOL)
    else
		threadVarVals[i] = value
        threadVarTypes[i] = SLT.RT_BOOL
	endif
	return value
EndFunction

int Function SetThreadVarInt(string _key, int value)
	int i = threadVarKeys.Find(_key, 0)
	if i < 0
		threadVarKeys = PapyrusUtil.PushString(threadVarKeys, _key)
        threadVarVals = PapyrusUtil.PushString(threadVarVals, value)
        threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_INT)
    else
		threadVarVals[i] = value
        threadVarTypes[i] = SLT.RT_INT
	endif
	return value
EndFunction

float Function SetThreadVarFloat(string _key, float value)
	int i = threadVarKeys.Find(_key, 0)
	if i < 0
		threadVarKeys = PapyrusUtil.PushString(threadVarKeys, _key)
        threadVarVals = PapyrusUtil.PushString(threadVarVals, value)
        threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_FLOAT)
    else
		threadVarVals[i] = value
        threadVarTypes[i] = SLT.RT_FLOAT
	endif
	return value
EndFunction

Form Function SetThreadVarForm(string _key, Form value)
	int i = threadVarKeys.Find(_key, 0)
	if i < 0
		threadVarKeys = PapyrusUtil.PushString(threadVarKeys, _key)
        threadVarVals = PapyrusUtil.PushString(threadVarVals, value.GetFormID())
        threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_FORM)
    else
		threadVarVals[i] = value
        threadVarTypes[i] = SLT.RT_FORM
	endif
	return value
EndFunction

bool Function HasTargetVar(string _key)
    return HasStringValue(SLT, ktarget_v_prefix + _key)
EndFunction

string Function GetTargetVarString(string _key, string missing)
    return GetStringValue(SLT, ktarget_v_prefix + _key, missing)
EndFunction

bool Function GetTargetVarBool(string _key, bool missing)
    return GetIntValue(SLT, ktarget_v_prefix + _key, missing as int) != 0
EndFunction

int Function GetTargetVarInt(string _key, int missing)
    return GetIntValue(SLT, ktarget_v_prefix + _key, missing)
EndFunction

float Function GetTargetVarFloat(string _key, float missing)
    return GetFloatValue(SLT, ktarget_v_prefix + _key, missing)
EndFunction

Form Function GetTargetVarForm(string _key, Form missing)
    return GetFormValue(SLT, ktarget_v_prefix + _key, missing)
EndFunction

string Function SetTargetVarString(string _key, string value)
    return SetStringValue(SLT, ktarget_v_prefix + _key, value)
EndFunction

bool Function SetTargetVarBool(string _key, bool value)
    return SetIntValue(SLT, ktarget_v_prefix + _key, value as int) != 0
EndFunction

int Function SetTargetVarInt(string _key, int value)
    return SetIntValue(SLT, ktarget_v_prefix + _key, value)
EndFunction

float Function SetTargetVarFloat(string _key, float value)
    return SetFloatValue(SLT, ktarget_v_prefix + _key, value)
EndFunction

Form Function SetTargetVarForm(string _key, Form value)
    return SetFormValue(SLT, ktarget_v_prefix + _key, value)
EndFunction

string Function GetRequestString(string _key)
    return GetStringValue(SLT, krequest_v_prefix + _key)
EndFunction

bool Function GetRequestBool(string _key)
    return GetIntValue(SLT, krequest_v_prefix + _key) != 0
EndFunction

int Function GetRequestInt(string _key)
    return GetIntValue(SLT, krequest_v_prefix + _key)
EndFunction

float Function GetRequestFloat(string _key)
    return GetFloatValue(SLT, krequest_v_prefix + _key)
EndFunction

Form Function GetRequestForm(string _key)
    return GetFormValue(SLT, krequest_v_prefix + _key)
EndFunction

;;;;
;; Support
bool Function IsAssignableScope(string varscope)
    if "local" == varscope
        if Debug_Cmd
            SFD("Cmd.IsAssignableScope: scope(" + varscope + ") is considered assignable: LOCAL")
        endif
        return true
    elseif "thread" == varscope
        if Debug_Cmd
            SFD("Cmd.IsAssignableScope: scope(" + varscope + ") is considered assignable: THREAD")
        endif
        return true
    elseif "target" == varscope
        if Debug_Cmd
            SFD("Cmd.IsAssignableScope: scope(" + varscope + ") is considered assignable: TARGET")
        endif
        return true
    elseif "global" == varscope
        if Debug_Cmd
            SFD("Cmd.IsAssignableScope: scope(" + varscope + ") is considered assignable: GLOBAL")
        endif
        return true
    endif

    if Debug_Cmd
        SFD("Cmd.IsAssignableScope: scope(" + varscope + ") is not considered assignable")
    endif
    return false
EndFunction

function GetVarScope2(string varname, string[] varscope, bool forAssignment = false)
    if "$" == StringUtil.GetNthChar(varname, 0)
        int dotindex = StringUtil.Find(varname, ".", 1)
        if dotindex < 0
            varscope[0] = "local"
            varscope[1] = StringUtil.SubString(varname, 1)
        else
            int varnamelen = StringUtil.GetLength(varname)
            
            if dotindex >= varnamelen - 1 ; not possible, but sure why not
                varscope[0] = "local"
                varscope[1] = StringUtil.SubString(varname, 1)
            else
                varscope[0] = StringUtil.Substring(varname, 1, dotindex - 1)
                if forAssignment
                    bool scopeAssignable = IsAssignableScope(varscope[0])
                    if Debug_Cmd
                        SFD("varscope[0](" + varscope[0] + ") scopeAssignable(" + scopeAssignable + ")")
                    endif

                    if !scopeAssignable
                        varscope[0] = ""
                        varscope[1] = varname
                        SFE("Scope (" + varscope[0] + ") is not currently assignable but is on LHS of assignment")
                    endif
                endif
                
                if varscope[0]
                    varscope[1] = StringUtil.Substring(varname, dotindex + 1)
                    if !varscope[1]
                        varscope[0] = ""
                        varscope[1] = varname
                        SFE("Variable has invalid name, malformed: (" + varname + ")")
                    endif
                else
                    varscope[1] = varname
                endif
            endif
        endif
    else
        varscope[0] = ""
        varscope[1] = varname
    endif
endfunction

; these might get interesting soon
string function GetVarString2(string scope, string varname, string missing)
    if scope == "local"
        return GetFrameVarString(varname, missing)
    elseif scope == "global"
        return SLT.GetGlobalVarString(varname, missing)
    elseif scope == "thread"
        return GetThreadVarString(varname, missing)
    elseif scope == "target"
        return GetTargetVarString(varname, missing)
    endif
    return missing
endfunction

bool function GetVarBool(string scope, string varname, bool missing)
    if scope == "local"
        return GetFrameVarBool(varname, missing)
    elseif scope == "global"
        return SLT.GetGlobalVarBool(varname, missing)
    elseif scope == "thread"
        return GetThreadVarBool(varname, missing)
    elseif scope == "target"
        return GetTargetVarBool(varname, missing)
    endif
    return missing
endfunction

int function GetVarInt(string scope, string varname, int missing)
    if scope == "local"
        return GetFrameVarInt(varname, missing)
    elseif scope == "global"
        return SLT.GetGlobalVarInt(varname, missing)
    elseif scope == "thread"
        return GetThreadVarInt(varname, missing)
    elseif scope == "target"
        return GetTargetVarInt(varname, missing)
    endif
    return missing
endfunction

float function GetVarFloat(string scope, string varname, float missing)
    if scope == "local"
        return GetFrameVarFloat(varname, missing)
    elseif scope == "global"
        return SLT.GetGlobalVarFloat(varname, missing)
    elseif scope == "thread"
        return GetThreadVarFloat(varname, missing)
    elseif scope == "target"
        return GetTargetVarFloat(varname, missing)
    endif
    return missing
endfunction

Form function GetVarForm(string scope, string varname, Form missing)
    if scope == "local"
        return GetFrameVarForm(varname, missing)
    elseif scope == "global"
        return SLT.GetGlobalVarForm(varname, missing)
    elseif scope == "thread"
        return GetThreadVarForm(varname, missing)
    elseif scope == "target"
        return GetTargetVarForm(varname, missing)
    endif
    return missing
endfunction

string function SetVarString2(string scope, string varname, string value)
    if scope == "local"
        return SetFrameVarString(varname, value)
    elseif scope == "global"
        return SLT.SetGlobalVarString(varname, value)
    elseif scope == "thread"
        return SetThreadVarString(varname, value)
    elseif scope == "target"
        return SetTargetVarString(varname, value)
    elseif scope
        SFE("Attempted to assign to read-only scope (" + scope + ")")
        return ""
    endif
    SFE("Invalid scope for set")
    return ""
endfunction

bool function SetVarBool(string scope, string varname, bool value)
    if scope == "local"
        return SetFrameVarBool(varname, value)
    elseif scope == "global"
        return SLT.SetGlobalVarBool(varname, value)
    elseif scope == "thread"
        return SetThreadVarBool(varname, value)
    elseif scope == "target"
        return SetTargetVarBool(varname, value)
    elseif scope
        SFE("Attempted to assign to read-only scope (" + scope + ")")
        return false
    endif
    SFE("Invalid scope for set")
    return false
endfunction

int function SetVarInt(string scope, string varname, int value)
    if scope == "local"
        return SetFrameVarInt(varname, value)
    elseif scope == "global"
        return SLT.SetGlobalVarInt(varname, value)
    elseif scope == "thread"
        return SetThreadVarInt(varname, value)
    elseif scope == "target"
        return SetTargetVarInt(varname, value)
    elseif scope
        SFE("Attempted to assign to read-only scope (" + scope + ")")
        return 0
    endif
    SFE("Invalid scope for set")
    return 0
endfunction

float function SetVarFloat(string scope, string varname, float value)
    if scope == "local"
        return SetFrameVarFloat(varname, value)
    elseif scope == "global"
        return SLT.SetGlobalVarFloat(varname, value)
    elseif scope == "thread"
        return SetThreadVarFloat(varname, value)
    elseif scope == "target"
        return SetTargetVarFloat(varname, value)
    elseif scope
        SFE("Attempted to assign to read-only scope (" + scope + ")")
        return 0.0
    endif
    SFE("Invalid scope for set")
    return 0.0
endfunction

Form function SetVarForm(string scope, string varname, Form value)
    if scope == "local"
        return SetFrameVarForm(varname, value)
    elseif scope == "global"
        return SLT.SetGlobalVarForm(varname, value)
    elseif scope == "thread"
        return SetThreadVarForm(varname, value)
    elseif scope == "target"
        return SetTargetVarForm(varname, value)
    elseif scope
        SFE("Attempted to assign to read-only scope (" + scope + ")")
        return none
    endif
    SFE("Invalid scope for set")
    return none
endfunction

function PrecacheRequestString(sl_triggersMain slthost, int requestTargetFormId, int requestId, string varname, string value) global
    string ckey = "SLTR:target:" + requestTargetFormId + ":system.request:" + requestId + ":vars:" + varname
    SetStringValue(slthost, ckey, value)
endfunction

function PrecacheRequestBool(sl_triggersMain slthost, int requestTargetFormId, int requestId, string varname, bool value) global
    string ckey = "SLTR:target:" + requestTargetFormId + ":system.request:" + requestId + ":vars:" + varname
    SetIntValue(slthost, ckey, value as int)
endfunction

function PrecacheRequestInt(sl_triggersMain slthost, int requestTargetFormId, int requestId, string varname, int value) global
    string ckey = "SLTR:target:" + requestTargetFormId + ":system.request:" + requestId + ":vars:" + varname
    SetIntValue(slthost, ckey, value)
endfunction

function PrecacheRequestFloat(sl_triggersMain slthost, int requestTargetFormId, int requestId, string varname, float value) global
    string ckey = "SLTR:target:" + requestTargetFormId + ":system.request:" + requestId + ":vars:" + varname
    SetFloatValue(slthost, ckey, value)
endfunction

function PrecacheRequestForm(sl_triggersMain slthost, int requestTargetFormId, int requestId, string varname, Form value) global
    string ckey = "SLTR:target:" + requestTargetFormId + ":system.request:" + requestId + ":vars:" + varname
    SetFormValue(slthost, ckey, value)
endfunction