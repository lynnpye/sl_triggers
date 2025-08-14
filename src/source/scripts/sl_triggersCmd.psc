Scriptname sl_TriggersCmd extends ActiveMagicEffect

import sl_triggersStatics
import StorageUtil

string[] Function GetVarScope(string varname, bool forAssignment = false) global native

string[] Function GetVarScopeWithResolution(string varname, bool forAssignment = false)
    If (SLT.Debug_Cmd_InternalResolve || SLT.Debug_Cmd_RunScript_Set)
        SFD("Cmd.GetVarScopeWithResolution: varname(" + varname + ") forAssignment(" + forAssignment + ")")
    EndIf
    string[] varscope = GetVarScope(varname, forAssignment)
    if (varscope[SLT.VS_MAP_KEY])
        varscope[SLT.VS_RESOLVED_MAP_KEY] = ResolveString(varscope[SLT.VS_MAP_KEY])
    endif
    if (varscope[SLT.VS_LIST_INDEX])
        varscope[SLT.VS_RESOLVED_LIST_INDEX] = ResolveInt(varscope[SLT.VS_LIST_INDEX])
    endif
    If (SLT.Debug_Cmd_InternalResolve || SLT.Debug_Cmd_RunScript_Set)
        SFD("Cmd.GetVarScopeWithResolution: varscope returned, post resolution: " + SLT.VarScopeToString(varscope))
    EndIf
    return varscope
EndFunction

; SLT
; sl_triggersMain
; SLT API access
sl_triggersMain		Property SLT Auto

; Properties
Actor			Property PlayerRef Auto
Keyword			Property ActorTypeNPC Auto
Keyword			Property ActorTypeUndead Auto

Actor _cmdTA = none
string kframe_map_prefix
string kframe_list_prefix
string kthread_map_prefix
string kthread_list_prefix
string ktarget_map_prefix
string ktarget_list_prefix
string ktarget_v_prefix
string ktarget_type_v_prefix
string krequest_v_prefix
string krequest_type_prefix

string function Make_kframe_map_prefix()
    return "SLTR:frame:" + frameid + ":maps:"
endfunction

string function Make_kframe_list_prefix()
    return "SLTR:frame:" + frameid + ":lists:"
endfunction

string function Make_kthread_map_prefix()
    return "SLTR:thread:" + threadid + ":maps:"
endfunction

string function Make_kthread_list_prefix()
    return "SLTR:thread:" + threadid + ":lists:"
endfunction

string function Make_ktarget_map_prefix(int formid)
    return "SLTR:target:" + formid + ":maps:"
endfunction

string function Make_ktarget_list_prefix(int formid)
    return "SLTR:target:" + formid + ":lists:"
endfunction

string function Make_ktarget_v_prefix(int formid)
    return "SLTR:target:" + formid + ":vars:"
endfunction

string function Make_ktarget_type_v_prefix(int formid)
    return "SLTR:target:" + formid + ":vartypes:"
endfunction

string Function Global_Make_krequest_v_prefix(int requestTargetFormId, int requestId) global
    return "SLTR:target:" + requestTargetFormId + ":system.request:" + requestId + ":vars:"
endFunction

string Function Make_krequest_v_prefix()
    return Global_Make_krequest_v_prefix(CmdTargetFormID, CmdRequestId)
EndFunction

string Function Global_Make_krequest_type_prefix(int requestTargetFormId, int requestId) global
    return "SLTR:target:" + requestTargetFormId + ":system.request:" + requestId + ":vartypes:"
endFunction

string Function Make_krequest_type_prefix()
    return Global_Make_krequest_type_prefix(CmdTargetFormID, CmdRequestId)
EndFunction

Actor			Property CmdTargetActor Hidden
    Actor Function Get()
        return _cmdTA
    EndFunction
    Function Set(Actor value)
        _cmdTA = value

        if _cmdTA
            CmdTargetFormID             = _cmdTA.GetFormID()

            ktarget_map_prefix = Make_ktarget_map_prefix(CmdTargetFormID)
            ktarget_list_prefix = Make_ktarget_list_prefix(CmdTargetFormID)
            ktarget_v_prefix = Make_ktarget_v_prefix(CmdTargetFormID)
            ktarget_type_v_prefix = Make_ktarget_type_v_prefix(CmdTargetFormID)
            krequest_v_prefix = Make_krequest_v_prefix()
            krequest_type_prefix = Make_krequest_type_prefix()
        endif
    EndFunction
EndProperty
int             Property CmdTargetFormID Auto Hidden

; pre-generated keys for thread context
int _frameid = 0
int         Property frameid Hidden
    int Function Get()
        return _frameid
    EndFunction
    Function Set(int value)
        _frameid = value
        kframe_map_prefix = Make_kframe_map_prefix()
        kframe_list_prefix = Make_kframe_list_prefix()
    EndFunction
EndProperty

int _threadid = 0
int         Property threadid Hidden
    int Function Get()
        return _threadid
    EndFunction
    Function Set(int value)
        _threadid = value
        kthread_map_prefix = Make_kthread_map_prefix()
        kthread_list_prefix = Make_kthread_list_prefix()
    EndFunction
EndProperty

int _cmdRequestId = 0
int         Property CmdRequestId Hidden
    int Function Get()
        return _cmdRequestId
    EndFunction
    Function Set(int value)
        _cmdRequestId = value

        krequest_v_prefix = Make_krequest_v_prefix()
        krequest_type_prefix = Make_krequest_type_prefix()
    EndFunction
EndProperty

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
    SFW("Truly unexpected value for CommandLineReturnResult(" + _clrr + "); not even CLRR_INVALID")
    return "CLRR_INVALID2:" + _clrr
EndFunction

string  _unresolvedToken
string  _resolvedString
bool    _resolvedBool
int     _resolvedInt
float   _resolvedFloat
Form    _resolvedForm
string  _resolvedLabel
string[] _resolvedListString
string[] _resolvedListLabel
bool[]  _resolvedListBool
int[]   _resolvedListInt
float[] _resolvedListFloat
Form[]  _resolvedListForm

int         Property CustomResolveType Auto Hidden

string      Property CustomResolveUnresolvedResult Hidden
    string Function Get()
        return _unresolvedToken
    EndFunction
    Function Set(string value)
        _unresolvedToken = value
        CustomResolveType = SLT.RT_INVALID
    EndFunction
EndProperty
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
string      Property CustomResolveLabelResult Hidden
    string Function Get()
        return _resolvedLabel
    EndFunction
    Function Set(string value)
        _resolvedLabel = value
        CustomResolveType = SLT.RT_LABEL
    EndFunction
EndProperty
string[]    Property CustomResolveListStringResult Hidden
    string[] Function Get()
        return _resolvedListString
    EndFunction
    Function Set(string[] value)
        _resolvedListString = value
        CustomResolveType = SLT.RT_LIST_STRING
    EndFunction
EndProperty
string[]    Property CustomResolveListLabelResult Hidden
    string[] Function Get()
        return _resolvedListLabel
    EndFunction
    Function Set(string[] value)
        _resolvedListLabel = value
        CustomResolveType = SLT.RT_LIST_LABEL
    EndFunction
EndProperty
bool[]    Property CustomResolveListBoolResult Hidden
    bool[] Function Get()
        return _resolvedListBool
    EndFunction
    Function Set(bool[] value)
        _resolvedListBool = value
        CustomResolveType = SLT.RT_LIST_BOOL
    EndFunction
EndProperty
int[]    Property CustomResolveListIntResult Hidden
    int[] Function Get()
        return _resolvedListInt
    EndFunction
    Function Set(int[] value)
        _resolvedListInt = value
        CustomResolveType = SLT.RT_LIST_INT
    EndFunction
EndProperty
float[]    Property CustomResolveListFloatResult Hidden
    float[] Function Get()
        return _resolvedListFloat
    EndFunction
    Function Set(float[] value)
        _resolvedListFloat = value
        CustomResolveType = SLT.RT_LIST_FLOAT
    EndFunction
EndProperty
Form[]    Property CustomResolveListFormResult Hidden
    Form[] Function Get()
        return _resolvedListForm
    EndFunction
    Function Set(Form[] value)
        _resolvedListForm = value
        CustomResolveType = SLT.RT_LIST_FORM
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
        if CustomResolveFormResult == none
            return ""
        endif
        return CustomResolveFormResult.GetFormID() as string
    elseif SLT.RT_FLOAT == CustomResolveType
        return CustomResolveFloatResult
    elseif SLT.RT_INT == CustomResolveType
        return CustomResolveIntResult
    elseif SLT.RT_BOOL == CustomResolveType
        return CustomResolveBoolResult as string
    elseif SLT.RT_LABEL == CustomResolveType
        return CustomResolveLabelResult
    endif
    return CustomResolveUnresolvedResult
EndFunction

bool Function CRToBool()
    if SLT.RT_BOOL == CustomResolveType
        return CustomResolveBoolResult
    elseif SLT.RT_STRING == CustomResolveType
        return CustomResolveStringResult != ""
    elseif SLT.RT_INT == CustomResolveType
        return CustomResolveIntResult != 0
    elseif SLT.RT_FLOAT == CustomResolveType
        return CustomResolveFloatResult != 0.0
    elseif SLT.RT_FORM == CustomResolveType
        return CustomResolveFormResult != none
    elseif SLT.RT_LABEL == CustomResolveType
        SFE("Invalid conversion from LABEL to BOOL")
        return false
    endif
    return CustomResolveUnresolvedResult != ""
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
    elseif SLT.RT_LABEL == CustomResolveType
        SFE("Invalid conversion from LABEL to INT")
        return 0
    endif
    return CustomResolveUnresolvedResult as int
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
    elseif SLT.RT_LABEL == CustomResolveType
        SFE("Invalid conversion from LABEL to FLOAT")
        return 0.0
    endif
    return CustomResolveUnresolvedResult as float
EndFunction

Form Function CRToForm()
    if SLT.RT_FORM == CustomResolveType
        if SLT.Debug_Cmd_ResolveForm
            SFD("CRToForm: had Form, returning Form")
        endif
        return CustomResolveFormResult
    elseif SLT.RT_STRING == CustomResolveType
        if SLT.Debug_Cmd_ResolveForm
            SFD("CRToForm: had string, returning GetFormById(\"" + CustomResolveStringResult + "\")")
        endif
        return GetFormById(CustomResolveStringResult)
    elseif SLT.RT_INT == CustomResolveType
        if SLT.Debug_Cmd_ResolveForm
            SFD("CRToForm: had int, returning GetFormById(" + CustomResolveIntResult + ")")
        endif
        return GetFormById(CustomResolveIntResult)
    elseif SLT.RT_FLOAT == CustomResolveType
        if SLT.Debug_Cmd_ResolveForm
            SFD("CRToForm: had float (" + CustomResolveFloatResult + "), returning GetFormById(" + (CustomResolveFloatResult as int) + ")")
        endif
        return GetFormById(CRToInt())
    elseif SLT.RT_BOOL == CustomResolveType
        if SLT.Debug_Cmd_ResolveForm
            SFW("CRToForm: no auto-conversion exists except RT_STRING, RT_INT (interpreted as FormID), and RT_FLOAT (cast to int and interpted as FormID) (from: " + SLT.RT_ToString(CustomResolveType) + ")")
        endif
        ; no auto-conversion from float or bool
        return none
    elseif SLT.RT_LABEL == CustomResolveType
        SFE("Invalid conversion from LABEL to FORM")
        return none
    endif

    if SLT.Debug_Cmd_ResolveForm
        SFW("CRToForm: no auto-conversion exists except RT_STRING, RT_INT (interpreted as FormID), and RT_FLOAT (cast to int and interpted as FormID) (from: (" + CustomResolveType + ") [" + SLT.RT_ToString(CustomResolveType) + "]); note: if this does not indicate invalid, please report a bug")
    endif
    ; no auto-conversion from float or bool
    return GetFormById(CustomResolveUnresolvedResult)
EndFunction

String Function CRToLabel()
    if SLT.Debug_Cmd_RunScript_Labels
        SFD("CRToLabel: current type(" + SLT.RT_ToString(CustomResolveType) + ")")
    endif
    if SLT.RT_LABEL == CustomResolveType
        return CustomResolveLabelResult
    endif
    return "[" + CRToString() + "]"
EndFunction

Function SetVarFromCustomResult(string[] varscope)
    if SLT.RT_STRING == CustomResolveType
        if SLT.Debug_Cmd_RunScript_Set
            SFD("SetVarfromCustomResult: to (" + debstrjoin(varscope, "/") + ") STRING from (" + CustomResolveStringResult + ")")
        endif
        SetVarString(varscope, CustomResolveStringResult)
    elseif SLT.RT_BOOL == CustomResolveType
        if SLT.Debug_Cmd_RunScript_Set
            SFD("SetVarfromCustomResult: to (" + debstrjoin(varscope, "/") + ") BOOL from (" + CustomResolveBoolResult + ")")
        endif
        SetVarBool(varscope, CustomResolveBoolResult)
    elseif SLT.RT_INT == CustomResolveType
        if SLT.Debug_Cmd_RunScript_Set
            SFD("SetVarfromCustomResult: to (" + debstrjoin(varscope, "/") + ") INT from (" + CustomResolveIntResult + ")")
        endif
        SetVarInt(varscope, CustomResolveIntResult)
    elseif SLT.RT_FLOAT == CustomResolveType
        if SLT.Debug_Cmd_RunScript_Set
            SFD("SetVarfromCustomResult: to (" + debstrjoin(varscope, "/") + ") FLOAT from (" + CustomResolveFloatResult + ")")
        endif
        SetVarFloat(varscope, CustomResolveFloatResult)
    elseif SLT.RT_FORM == CustomResolveType
        if SLT.Debug_Cmd_RunScript_Set
            SFD("SetVarfromCustomResult: to (" + debstrjoin(varscope, "/") + ") FORM from (" + CustomResolveFormResult + ")")
        endif
        SetVarForm(varscope, CustomResolveFormResult)
    elseif SLT.RT_LABEL == CustomResolveType
        if SLT.Debug_Cmd_RunScript_Set
            SFD("SetVarfromCustomResult: to (" + debstrjoin(varscope, "/") + ") LABEL from (" + CustomResolveLabelResult + ")")
        endif
        SetVarLabel(varscope, CustomResolveLabelResult)
    elseif SLT.RT_LIST_STRING == CustomResolveType
        SetVarListString(varscope, CustomResolveListStringResult)
    elseif SLT.RT_LIST_BOOL == CustomResolveType
        SetVarListBool(varscope, CustomResolveListBoolResult)
    elseif SLT.RT_LIST_INT == CustomResolveType
        SetVarListInt(varscope, CustomResolveListIntResult)
    elseif SLT.RT_LIST_FLOAT == CustomResolveType
        SetVarListFloat(varscope, CustomResolveListFloatResult)
    elseif SLT.RT_LIST_FORM == CustomResolveType
        SetVarListForm(varscope, CustomResolveListFormResult)
    elseif SLT.RT_LIST_LABEL == CustomResolveType
        SetVarListLabel(varscope, CustomResolveListLabelResult)
    else
        if SLT.Debug_Cmd_RunScript_Set
            SFD("SetVarfromCustomResult: unhandled type converted to empty STRING (" + SLT.RT_ToString(CustomResolveType) + ")")
        endif
        SetVarString(varscope, "")
    endif
EndFunction

Function SetCustomResolveFromVar(string[] varscope)
    int vtype = GetVarType(varscope)

    if SLT.Debug_Cmd_InternalResolve || SLT.Debug_Cmd_RunScript_Set
        SFD("SetCustomResolveFromVar: varscope(" + debstrjoin(varscope, "/") + ") vtype(" + vtype + ")")
    endif

    if SLT.RT_STRING == vtype
        CustomResolveStringResult = GetVarString(varscope, "")
    elseif SLT.RT_BOOL == vtype
        CustomResolveBoolResult = GetVarBool(varscope, false)
    elseif SLT.RT_INT == vtype
        CustomResolveIntResult = GetVarInt(varscope, 0)
    elseif SLT.RT_FLOAT == vtype
        CustomResolveFloatResult = GetVarFloat(varscope, 0.0)
    elseif SLT.RT_FORM == vtype
        CustomResolveFormResult = GetVarForm(varscope, none)
    elseif SLT.RT_LABEL == vtype
        CustomResolveLabelResult = GetVarLabel(varscope, "")
    elseif SLT.RT_MAP == vtype
        SFW("Map not currently valid for assignment")
        CustomResolveStringResult = ""
    elseif SLT.RT_LIST_STRING == vtype
        CustomResolveListStringResult = GetVarListString(varscope)
    elseif SLT.RT_LIST_BOOL == vtype
        CustomResolveListBoolResult = GetVarListBool(varscope)
    elseif SLT.RT_LIST_INT == vtype
        CustomResolveListIntResult = GetVarListInt(varscope)
    elseif SLT.RT_LIST_FLOAT == vtype
        CustomResolveListFloatResult = GetVarListFloat(varscope)
    elseif SLT.RT_LIST_FORM == vtype
        CustomResolveListFormResult = GetVarListForm(varscope)
    elseif SLT.RT_LIST_LABEL == vtype
        CustomResolveListLabelResult = GetVarListLabel(varscope)
    elseif SLT.RT_IsList(vtype)
        SFW("List subtype not currently valid for assignment; type(" + SLT.RT_ToString(vtype) + ")")
        CustomResolveStringResult = ""
    else
        ;SFW("Unexpected type for SetCustomResolveFromVar (" + SLT.RT_ToString(vtype) + ")")
        CustomResolveStringResult = ""
    endif
EndFunction

;/
bool Function IsCustomResolveValidReadable()
    bool readableTypes = SLT.RT_STRING == CustomResolveType || SLT.RT_BOOL == CustomResolveType || SLT.RT_INT == CustomResolveType || SLT.RT_FLOAT == CustomResolveType || SLT.RT_FORM == CustomResolveType
    if SLT.RT_INVALID != CustomResolveType && !readableTypes
        SFE("CustomResolveResult current value(" + CustomResolveStringResult + ") is not RT_INVALID(" + SLT.RT_INVALID + ") but not among readable types; this suggests you are trying to use an invalid data type as a source e.g. RT_LABEL cannot be assigned to or from")
    endif
    return readableTypes
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
    elseif SLT.RT_LABEL == CustomResolveType
        MostRecentLabelResult = CustomResolveLabelResult
    else
        InvalidateMostRecentResult()
    endif
EndFunction
/;

; going to replace this with ResultFromBool(bool), ResultFromString(string), ResultFromForm(Form), etc.
; oh frabjous joy
int         Property MostRecentResultType Auto Hidden

string  _recentResultString
bool    _recentResultBool
int     _recentResultInt
float   _recentResultFloat
Form    _recentResultForm
string  _recentResultLabel
string[] _recentListString
string[] _recentListLabel
bool[]  _recentListBool
int[]   _recentListInt
float[] _recentListFloat
Form[]  _recentListForm

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
string      Property MostRecentLabelResult Hidden
    string Function Get()
        return _recentResultLabel
    EndFunction
    Function Set(string value)
        _recentResultLabel = value
        MostRecentResultType = SLT.RT_LABEL
    EndFunction
EndProperty
string[]    Property MostRecentListStringResult Hidden
    string[] Function Get()
        return _recentListString
    EndFunction
    Function Set(string[] value)
        _recentListString = value
        MostRecentResultType = SLT.RT_LIST_STRING
    EndFunction
EndProperty
string[]    Property MostRecentListLabelResult Hidden
    string[] Function Get()
        return _recentListLabel
    EndFunction
    Function Set(string[] value)
        _recentListLabel = value
        MostRecentResultType = SLT.RT_LIST_LABEL
    EndFunction
EndProperty
bool[]    Property MostRecentListBoolResult Hidden
    bool[] Function Get()
        return _recentListBool
    EndFunction
    Function Set(bool[] value)
        _recentListBool = value
        MostRecentResultType = SLT.RT_LIST_BOOL
    EndFunction
EndProperty
int[]    Property MostRecentListIntResult Hidden
    int[] Function Get()
        return _recentListInt
    EndFunction
    Function Set(int[] value)
        _recentListInt = value
        MostRecentResultType = SLT.RT_LIST_INT
    EndFunction
EndProperty
float[]    Property MostRecentListFloatResult Hidden
    float[] Function Get()
        return _recentListFloat
    EndFunction
    Function Set(float[] value)
        _recentListFloat = value
        MostRecentResultType = SLT.RT_LIST_FLOAT
    EndFunction
EndProperty
Form[]    Property MostRecentListFormResult Hidden
    Form[] Function Get()
        return _recentListForm
    EndFunction
    Function Set(Form[] value)
        _recentListForm = value
        MostRecentResultType = SLT.RT_LIST_FORM
    EndFunction
EndProperty

Function InvalidateMostRecentResult()
    MostRecentResultType = SLT.RT_INVALID
EndFunction


string[] threadVarKeys
string[] threadVarVals
int[]    threadVarTypes

string[] frameVarKeys
string[] frameVarVals
int[]    frameVarTypes

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


int _ifNestLevel
int Property IfNestLevel Hidden
    int Function Get()
        return _ifNestLevel
    EndFunction
    Function Set(int value)
        if value < 0
            _ifNestLevel = 0
        else
            _ifNestLevel = value
        endif
    EndFunction
EndProperty

;bool IsInsideIfBlock = false
bool IfBlockSatisfied = false

int Property BE_NONE        = 0 AutoReadOnly Hidden
int Property BE_IF          = 1 AutoReadOnly Hidden
int Property BE_BEGINSUB    = 2 AutoReadOnly Hidden
int Property BE_WHILE       = 3 AutoReadOnly Hidden

string __be_starter = ""
string __be_ender = ""
string __be_alt_starter = ""
string __be_alt_router = ""
int __be_needed = 0

Function SetBlockEndTarget(int betype)
    if BE_IF == betype
        __be_starter = "if"
        __be_ender = "endif"
        __be_alt_starter = "elseif"
        __be_alt_router = "else"
        __be_needed = 1
    elseif BE_BEGINSUB == betype
        __be_starter = "beginsub"
        __be_ender = "endsub"
        __be_alt_starter = ""
        __be_alt_router = ""
        __be_needed = 1
    elseif BE_WHILE == betype
        __be_starter = "while"
        __be_ender = "endwhile"
        __be_alt_starter = ""
        __be_alt_router = ""
        __be_needed = 1
    else
        __be_starter = ""
        __be_ender = ""
        __be_alt_starter = ""
        __be_alt_router = ""
        __be_needed = 0
    endif
EndFunction

Function ResetBlockEndTarget()
    __be_needed = 0
    __be_starter = ""
    __be_ender = ""
    __be_alt_starter = ""
    __be_alt_router = ""
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

Event OnEffectStart(Actor akTarget, Actor akCaster)
    if SLT.Debug_Cmd
        SLTDebugMsg("Cmd.OnEffectStart")
    endif

    initialGameTime = SLT.GetTheGameTime()

	CmdTargetActor = akCaster
    
    threadVarKeys = PapyrusUtil.StringArray(0)
    threadVarVals = PapyrusUtil.StringArray(0)
    threadVarTypes = PapyrusUtil.IntArray(0)

    DoStartup()
EndEvent

Event OnPlayerLoadGame()
    DoStartup()
EndEvent

Function DoStartup()
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return
    endif

	SafeRegisterForModEvent_AME(self, EVENT_SLT_RESET(), "OnSLTReset")
    
    if !threadid
        ; need to determine our threadid
        int[] requestresult = new int[1]
        int[] threadresult = new int[1]
        string[] scriptresult = new string[1]
        SLT.DequeueScriptForTarget(CmdTargetActor, requestresult, threadresult, scriptresult)

        if (requestresult[0] && threadresult[0] && scriptresult[0])
            CmdRequestId = requestresult[0]
            threadid = threadresult[0]
            initialScriptName = scriptresult[0]
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
            else
                initialScriptName = currentScriptName
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

    if SLT.Debug_Cmd
        SFD("Cmd.OnUpdate: before starting threadid(" + threadid + ") RunningScriptCount is :" + SLT.RunningScriptCount)
    endif
    SLT.RunningScriptCount += 1
    if SLT.Debug_Cmd
        SFD("Cmd.OnUpdate: starting threadid(" + threadid + ") RunningScriptCount is :" + SLT.RunningScriptCount)
    endif
    RunScript()
    if SLT.Debug_Cmd
        SFD("Cmd.OnUpdate: before ending threadid(" + threadid + ") RunningScriptCount is :" + SLT.RunningScriptCount)
    endif
    SLT.RunningScriptCount -= 1
    if SLT.Debug_Cmd
        SFD("Cmd.OnUpdate: ending threadid(" + threadid + ") RunningScriptCount is :" + SLT.RunningScriptCount)
    endif
    
    CleanupAndRemove()
EndEvent

Function CleanupAndRemove()
    if cleanedup
        return
    endif

    if _frameid
	    StorageUtil.ClearAllObjPrefix(SLT, "SLTR:frame:" + _frameid + ":")
    endif
    int i = pushed_frameid.Length
    while i
        i -= 1
	    StorageUtil.ClearAllObjPrefix(SLT, "SLTR:frame:" + pushed_frameid[i] + ":")
    endwhile
    if _threadid
	    StorageUtil.ClearAllObjPrefix(SLT, "SLTR:thread:" + _threadid + ":")
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

Int Function ActorRaceType(Actor _actor)
	return SLT.ActorRaceType(_actor)
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
    If (SLT.Debug_Cmd_InternalResolve)
        SFD("InternalResolve token(" + token + ")")
    EndIf
    InvalidateCR()

    IsCRLiteral = false
    IsCRBare = true

    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return false
    endif

    if token == "$$"
        If (SLT.Debug_Cmd_InternalResolve)
            SFD("InternalResolve token($$) pulling from most recent result type(" + SLT.RT_ToString(MostRecentResultType) + ")")
        EndIf
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
        elseif SLT.RT_LABEL == MostRecentResultType
            CustomResolveLabelResult = MostRecentLabelResult
        elseif SLT.RT_LIST_STRING == MostRecentResultType
            CustomResolveListStringResult = MostRecentListStringResult
        elseif SLT.RT_LIST_BOOL == MostRecentResultType
            CustomResolveListBoolResult = MostRecentListBoolResult
        elseif SLT.RT_LIST_INT == MostRecentResultType
            CustomResolveListIntResult = MostRecentListIntResult
        elseif SLT.RT_LIST_FLOAT == MostRecentResultType
            CustomResolveListFloatResult = MostRecentListFloatResult
        elseif SLT.RT_LIST_FORM == MostRecentResultType
            CustomResolveListFormResult = MostRecentListFormResult
        elseif SLT.RT_LIST_LABEL == MostRecentResultType
            CustomResolveListLabelResult = MostRecentListLabelResult
        else
            SFE("Invalid MostRecentResultType value(" + MostRecentResultType + ")[" + SLT.RT_ToString(MostRecentResultType) + "](note: if invalid status is not indicated, please report a bug); likely due to using $$ after calling a function that has no return value")
            InvalidateCR()
        endif
        return true
    endif

    if token == "true"
        IsCRLiteral = true
        CustomResolveBoolResult = true
        If (SLT.Debug_Cmd_InternalResolve)
            SFD("InternalResolve token(true) returning literal BOOL true")
        EndIf
        return true
    endif
    if token == "false"
        IsCRLiteral = true
        CustomResolveBoolResult = false
        If (SLT.Debug_Cmd_InternalResolve)
            SFD("InternalResolve token(false) returning literal BOOL false")
        EndIf
        return true
    endif
    if token == "none"
        IsCRLiteral = true
        CustomResolveFormResult = none
        If (SLT.Debug_Cmd_InternalResolve)
            SFD("InternalResolve token(none) returning literal Form none")
        EndIf
        return true
    endif

    int tokenlength = StringUtil.GetLength(token)
    string vtok
    int j
    int i = 0
    bool resolved = false
    bool sltChecked = false

    string char0 = StringUtil.GetNthChar(token, 0)

    if char0 == "\""
        if (tokenlength - 2) < 1 ; empty string, substring won't work
            CustomResolveStringResult = ""
        else
            CustomResolveStringResult = StringUtil.Substring(token, 1, tokenlength - 2)
        endif
        IsCRBare = false
        IsCRLiteral = true

        If (SLT.Debug_Cmd_InternalResolve)
            SFD("InternalResolve returning literal STRING (" + CustomResolveStringResult + ")")
        EndIf

        return true

    elseif char0 == "$"
        if StringUtil.GetNthChar(token, 1) == "\""
            if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
                SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
                CleanupAndRemove()
                Return false
            endif

            if (tokenlength - 3) < 1 ; empty string, substring won't work and this is all pointless anyway
                CustomResolveStringResult = ""
            else
                string trimmed = StringUtil.Substring(token, 2, tokenlength - 3)

                string[] vartoks = sl_triggers.TokenizeForVariableSubstitution(trimmed)

                j = 0
                while j < vartoks.Length
                    If (SLT.Debug_Cmd_InternalResolve)
                        string outtok = ResolveString(vartoks[j])
                        SFD("String interpolation: vartoks[" + j + "](" + vartoks[j] + ") resolved to(" + outtok + ")")
                        vartoks[j] = outtok
                    else
                        vartoks[j] = ResolveString(vartoks[j])
                    EndIf

                    j += 1
                endwhile

                CustomResolveStringResult = PapyrusUtil.StringJoin(vartoks, "")
            endif

            IsCRBare = false
            IsCRLiteral = true

            If (SLT.Debug_Cmd_InternalResolve)
                SFD("InternalResolve returning interpolated literal STRING (" + CustomResolveStringResult + ")")
            EndIf

            return true
        endif

        if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
            SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
            CleanupAndRemove()
            Return false
        endif

        string[] varscopestringlist = GetVarScopeWithResolution(token)
        ;GetVarScope2(token, varscopestringlist)
        string scope = varscopestringlist[SLT.VS_SCOPE]
        string vname = varscopestringlist[SLT.VS_NAME]

        if SLT.Debug_Cmd_InternalResolve
            SFD("Cmd.InternalResolve: varscope<" + PapyrusUtil.StringJoin(varscopestringlist, ">,<") + ">")
        endif

        if "local" == scope || "global" == scope || "thread" == scope || "target" == scope
            If (SLT.Debug_Cmd_InternalResolve)
                SFD("InternalResolve returning value from var (" + scope + "." + vname + ")")
            EndIf
            SetCustomResolveFromVar(varscopestringlist)
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
            elseif "is_player.in_combat" == vname
                CustomResolveBoolResult = PlayerRef.IsInCombat()
                return true
            elseif "stats.running_scripts" == vname
                CustomResolveIntResult = SLT.RunningScriptCount
                return true
            elseif "realtime" == vname
                CustomResolveFloatResult = Utility.GetCurrentRealTime()
                return true
            elseif "gametime" == vname
                CustomResolveFloatResult = SLT.GetTheGameTime()
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
            elseif "linenumber" == vname
                CustomResolveIntResult = lineNum
                return true
            elseif "sessionid" == vname
                CustomResolveIntResult = sl_triggers.GetSessionId()
                return true
            elseif "forms.gold" == vname || "forms.septim" == vname
                CustomResolveFormResult = sl_triggers.GetForm("0xf|Skyrim.esm")
                return true
            endif
        elseif "request" == scope
            int requestDataType = GetRequestDataType(vname)
            if SLT.RT_STRING == requestDataType
                CustomResolveStringResult = GetRequestString(vname)
                return true
            elseif SLT.RT_BOOL == requestDataType
                CustomResolveBoolResult = GetRequestBool(vname)
                return true
            elseif SLT.RT_INT == requestDataType
                CustomResolveIntResult = GetRequestInt(vname)
                return true
            elseif SLT.RT_FLOAT == requestDataType
                CustomResolveFloatResult = GetRequestFloat(vname)
                return true
            elseif SLT.RT_FORM == requestDataType
                CustomResolveFormResult = GetRequestForm(vname)
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
                If (SLT.Debug_Cmd_InternalResolve)
                    SFD("InternalResolve token returning value from extension (" + slext.SLTExtensionKey + ").CustomResolveScoped()")
                EndIf
                return true
            endif

            i += 1
        endwhile
    elseif char0 == "[" && tokenlength > 2
        ; for this, verify it terminates with ']'
        if "]" != StringUtil.GetNthChar(token, tokenlength - 1)
            ; this is likely an error
            SFW("Opening '[' indicates a label but lacks a closing ']'; will attempt to treat as a label, but you should fix this")
            token = token + "]"
            j = tokenlength - 1
        else
            j = tokenlength - 2
        endif
        If (SLT.Debug_Cmd_InternalResolve)
            SFD("InternalResolve: LABEL RESULT resolving (" + token + ")")
        EndIf
        IsCRBare = true
        IsCRLiteral = true
        CustomResolveLabelResult = token

        If (SLT.Debug_Cmd_InternalResolve)
            SFD("InternalResolve token(true) returning label (" + CustomResolveLabelResult + ")")
        EndIf
        return true
    endif

    ; last chance, checking for literal int or float values (we already checked for literal bools above)
    string literalNumeric = sl_triggers.GetNumericLiteral(token)
    if SLT.Debug_Cmd_InternalResolve_Literals
        SFD("Literal numeric lookup returned (" + literalNumeric + ") for token(" + token + ")")
    endif
    if "invalid" != literalNumeric
        string[] numlitinfo = PapyrusUtil.StringSplit(literalNumeric, ":")
        if !numlitinfo || numlitinfo.Length != 2
            SFE("Literal numeric result returned (" + literalNumeric + ") but doesn't appear valid")
        elseif numlitinfo[0] == "int"
            IsCRLiteral = true
            CustomResolveIntResult = numlitinfo[1] as int
            if SLT.Debug_Cmd_InternalResolve_Literals || SLT.Debug_Cmd_InternalResolve
                SFD("Literal numeric lookup returning int(" + numlitinfo[1] + ")")
            endif
            return true
        elseif numlitinfo[0] == "float"
            IsCRLiteral = true
            CustomResolveFloatResult = numlitinfo[1] as float
            if SLT.Debug_Cmd_InternalResolve_Literals || SLT.Debug_Cmd_InternalResolve
                SFD("Literal numeric lookup returning float(" + numlitinfo[1] + ")")
            endif
            return true
        else
            SFE("This state should not happen (" + PapyrusUtil.StringJoin(numlitinfo, "),(") + ")")
        endif
    else
        if SLT.Debug_Cmd_InternalResolve_Literals
            if (token as int) || (token as float)
                SFD("Cmd.InternalResolve: literalNumeric check failed for (" + token + ")")
            endif
        endif
    endif

    if SLT.Debug_Cmd_InternalResolve_Literals || SLT.Debug_Cmd_InternalResolve
        SFI("\t\tInternalResolve: UNRESOLVED: CustomResolveUnresolvedResult to token(" + token + ")")
    endif

    CustomResolveUnresolvedResult = token

    return false
EndFunction

; ResolveString
; string token - a variable to retrieve the value of e.g. $$, $global.foo, $g3
; returns: the value as a string; token if unable to resolve
string Function ResolveString(string token)
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return ""
    endif

    InternalResolve(token)
    return CRToString()
EndFunction

string Function ResolveLabel(string token)
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return ""
    endif
    InternalResolve(token)
    return CRToLabel()
EndFunction

; ResolveActor
; string _code - a variable indicating an Actor e.g. $self, $player
; returns: an Actor representing the specified Actor; none if unable to resolve
Actor Function ResolveActor(string token)
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return none
    endif
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
    return _resolvedActor
EndFunction

Form Function ResolveForm(string token)
    if SLT.Debug_Cmd_ResolveForm
        SFD("ResolveForm: token(" + token + ")")
    endif

    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return none
    endif

    InternalResolve(token)
    return CRToForm()
EndFunction

bool Function ResolveBool(string token)
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return false
    endif
    InternalResolve(token)
    return CRToBool()
EndFunction

int Function ResolveInt(string token)
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return 0
    endif
    InternalResolve(token)
    return CRToInt()
EndFunction

float Function ResolveFloat(string token)
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return 0.0
    endif
    InternalResolve(token)
    return CRToFloat()
EndFunction

string[] Function ResolveListString(string token)
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return none
    endif
    InternalResolve(token)
    if SLT.RT_LIST_STRING == CustomResolveType
        return CustomResolveListStringResult
    endif
    return none
EndFunction

bool[] Function ResolveListBool(string token)
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return none
    endif
    InternalResolve(token)
    if SLT.RT_LIST_BOOL == CustomResolveType
        return CustomResolveListBoolResult
    endif
    return none
EndFunction

int[] Function ResolveListInt(string token)
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return none
    endif
    InternalResolve(token)
    if SLT.RT_LIST_INT == CustomResolveType
        return CustomResolveListIntResult
    endif
    return none
EndFunction

float[] Function ResolveListFloat(string token)
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return none
    endif
    InternalResolve(token)
    if SLT.RT_LIST_FLOAT == CustomResolveType
        return CustomResolveListFloatResult
    endif
    return none
EndFunction

Form[] Function ResolveListForm(string token)
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return none
    endif
    InternalResolve(token)
    if SLT.RT_LIST_FORM == CustomResolveType
        return CustomResolveListFormResult
    endif
    return none
EndFunction

string[] Function ResolveListLabel(string token)
    if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
        SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
        CleanupAndRemove()
        Return none
    endif
    InternalResolve(token)
    if SLT.RT_LIST_LABEL == CustomResolveType
        return CustomResolveListLabelResult
    endif
    return none
EndFunction

Function ResetBlockContext()
    while slt_PopGosubReturn() > -1
    endwhile
    while slt_PopWhileReturn() > -1
    endwhile
EndFunction

bool __searchFoundBlockEnd = false

; returns true if should increment currentLine, false otherwise
int Function RunCommandLine(string[] cmdLine, int startidx, int endidx, bool subCommand = true)
    if SLT.Debug_Cmd_RunScript
        SFD("Cmd.RunCommandLine")
    endif

    if !cmdLine.Length
        if SLT.Debug_Cmd_RunScript
            SFD("cmdLine.Length == 0; advancing empty line")
        endif
        return CLRR_ADVANCE
    endif

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

    InternalResolve(cmdLine[0])
    
    If SLT.RT_LABEL == CustomResolveType
        ; we are a label, but in what context?
        if SLT.Debug_Cmd_RunScript_Labels
            SFD("RunCommandLine: token(" + cmdLine[0] + ") is RT_LABEL")
        endif

        if !subCommand
            if SLT.Debug_Cmd_RunScript
                SFD("Cmd.RunScript: [might be label]")
            endif
            slt_AddGoto(CRToLabel(), currentLine)
        endif

        MostRecentLabelResult = CustomResolveLabelResult
        
        ; currentLine += 1
    else
        command = CRToString()
        if SLT.Debug_Cmd_RunScript
            SFD("Cmd.RunScript: Resolve(" + cmdLine[0] + ") => [" + command + "]")
        endif
        cmdLine[0] = command

        If !command
            if SLT.Debug_Cmd_RunScript
                SFD("Cmd.RunScript: empty command")
            endif
            MostRecentStringResult = ""
            ;currentLine += 1
        elseIf __be_needed > 0
            ; intercept all rows until __blockendsneeded is satisfied, i.e. <= 0
            ; but let's have a little hygiene and validate we really are looking for something and correct things if things have gotten weird

            if SLT.Debug_Cmd_RunScript_Blocks
                SFI("__blockendsneeded(" + __be_needed + ") __blockendstarter(" + __be_starter + ") __blockendtarget(" + __be_ender + "): these should have values")
            endif

            if subCommand
                ResetBlockEndTarget()
                SFE("subcommand processing should not be encountered during block skipping; please report your script as an indication of SLTR script engine failure")
            elseif !__be_starter || (!__be_ender && !__be_alt_router && !__be_alt_starter)
                ; this isn't right, we bail after resetting __be_needed
                ResetBlockEndTarget()
                if SLT.Debug_Cmd_RunScript_Blocks
                    SFW("__be_needed was [" + __be_needed + "], but either __be_starter() or __be_ender/__be_alt_starter/__be_alt_router were empty (\"\"); resetting __be_needed to 0 and both __be_starter and __be_ender to \"\"")
                endif
            else
                if command == __be_starter
                    if SLT.Debug_Cmd_RunScript_Blocks
                        SFD("block-skipping: found starter(" + __be_starter + "); incrementing")
                    endif
                    __be_needed += 1
                ; matching __be_needed == 1 for only top-level matches for elseif/else
                elseif command == __be_ender || (__be_needed == 1 && (command == __be_alt_router || command == __be_alt_starter))
                    if SLT.Debug_Cmd_RunScript_Blocks
                        SFD("block-skipping: something made this true: command == __be_ender || (__be_needed == 1 && (command == __be_alt_router || command == __be_alt_starter))")
                        SFD("block-skipping: command(" + command + ") needed(" + __be_needed + ") starter(" + __be_starter + ") ender(" + __be_ender + ") router(" + __be_alt_router + ") altstarter(" + __be_alt_starter + ")")
                    endif
                    __be_needed -= 1
                    ; this might bring us below 0, i.e. no longer needing to blockskip
                    ; which means we need to allow block end handling now
                    if __be_needed <= 0
                        if SLT.Debug_Cmd_RunScript_Blocks
                            SFD("dropping below 1 needed: " + __be_needed)
                        endif
                        ResetBlockEndTarget()
                        __searchFoundBlockEnd = true
                        ; no advance because we are going to return, the line will not move, we will still be on the block end, and then should advance
                        __CLRR = CLRR_NOADVANCE
                    endif
                endif
            endif

            ; currentLine += 1
        elseIf command == "set"
            if SLT.Debug_Cmd_RunScript
                SFD("Cmd.RunScript: set")
            endif
            if subCommand
                SFE("'set' is not a valid subcommand")
            elseif ParamLengthGT(self, cmdLine.Length, 2)
                string[] varscopestringlist = GetVarScopeWithResolution(cmdLine[1], true)
                ;GetVarScope2(cmdLine[1], varscopestringlist, true)

                if SLT.Debug_Cmd_RunScript_Set
                    SFD("Cmd.RunScript: set: post var scope, varscopestringlist<" + SLT.VarScopeToString(varscopestringlist) + "> resolved from (" + cmdLine[1] + ")")
                endif
                
                if varscopestringlist[SLT.VS_SCOPE]

                    if cmdLine.Length == 3
                        if SLT.Debug_Cmd_RunScript_Set
                            SFD("Cmd.RunScript: set/3 <target> <source>")
                        endif

                        InternalResolve(cmdLine[2])
                        if SLT.Debug_Cmd_RunScript_Set
                            __outresult = CRToString()
                            SFD("set/3:  CustomResolveType(" + SLT.RT_ToString(CustomResolveType) + ") and outresult is (" + __outresult + ")")
                        endif
                        SetVarFromCustomResult(varscopestringlist)
                        ;SetVarString2(varscopestringlist[0], varscopestringlist[1], Resolve(cmdLine[2]))
                    else
                        __operator = ResolveString(cmdLine[2])

                        if cmdLine.Length > 3 && __operator == "resultfrom"
                        
                            if SLT.Debug_Cmd_RunScript_Set
                                SFD("Cmd.RunScript: set>3/w/resultfrom <target> resultfrom <stuff...>")
                            endif

                            __strListVal = PapyrusUtil.SliceStringArray(cmdLine, 3)
                            
                            InvalidateMostRecentResult()
                            RunCommandLine(__strListVal, startidx + 3, endidx)
                            if SLT.Debug_Cmd_RunScript_Set
                                InternalResolve("$$")
                                __outresult = CRToString()
                                SFD("set: resultfrom: MostRecentResultType(" + SLT.RT_ToString(MostRecentResultType) + ") and outresult is (" + __outresult + ")")
                                SetVarFromCustomResult(varscopestringlist)
                                ;SetVarString2(varscopestringlist[0], varscopestringlist[1], __outresult)
                            else
                                InternalResolve("$$")
                                SetVarFromCustomResult(varscopestringlist)
                                ;SetVarString2(varscopestringlist[0], varscopestringlist[1], Resolve("$$"))
                            endif
                        elseif cmdLine.length == 4 && __operator == "="
                            if SLT.Debug_Cmd_RunScript_Set
                                SFD("Cmd.RunScript: set/4/w/= <target> = <source>")
                            endif

                            if SLT.Debug_Cmd_RunScript_Set
                                string sourceStringValue = ResolveString(cmdLine[3])

                                ;SetVarString2(varscopestringlist[0], varscopestringlist[1], sourceStringValue)
                                SetVarFromCustomResult(varscopestringlist)

                                string fetchedSourceValue = GetVarString(varscopestringlist, "")

                                SFD("set/4/w/=: sourceStringValue(" + sourceStringValue + ") resolved from (" + cmdLine[3] + ") fetchedSourceValue(" + fetchedSourceValue + ")")
                            else
                                InternalResolve(cmdLine[3])
                                SetVarFromCustomResult(varscopestringlist)
                                ;SetVarString2(varscopestringlist[0], varscopestringlist[1], Resolve(cmdLine[3]))
                            endif
                        elseif cmdLine.length == 5
                            if SLT.Debug_Cmd_RunScript_Set
                                SFD("Cmd.RunScript: set/5 <target> = <source> <op> <source>")
                            endif
                            __operator = ResolveString(cmdLine[3])

                    
                            ; this is sloppy, imprecise
                            if __operator == "+"
                                __floatVal = ResolveFloat(cmdLine[2]) + ResolveFloat(cmdLine[4])
                                __intVal = __floatVal as int
                                __floatVal2 = __intVal
                                if __floatVal == __floatVal2
                                    SetVarInt(varscopestringlist, __intVal)
                                else
                                    SetVarFloat(varscopestringlist, __floatVal)
                                endif
                            elseIf __operator == "-"
                                __floatVal = ResolveFloat(cmdLine[2]) - ResolveFloat(cmdLine[4])
                                __intVal = __floatVal as int
                                __floatVal2 = __intVal

                                if __floatVal == __floatVal2
                                    SetVarInt(varscopestringlist, __intVal)
                                else
                                    SetVarFloat(varscopestringlist, __floatVal)
                                endif
                            elseIf __operator == "*"
                                __floatVal = ResolveFloat(cmdLine[2]) * ResolveFloat(cmdLine[4])
                                __intVal = __floatVal as int
                                __floatVal2 = __intVal
                                if __floatVal == __floatVal2
                                    SetVarInt(varscopestringlist, __intVal)
                                else
                                    SetVarFloat(varscopestringlist, __floatVal)
                                endif
                            elseIf __operator == "/"
                                __floatVal = ResolveFloat(cmdLine[2]) / ResolveFloat(cmdLine[4])
                                __intVal = __floatVal as int
                                __floatVal2 = __intVal
                                if __floatVal == __floatVal2
                                    SetVarInt(varscopestringlist, __intVal)
                                else
                                    SetVarFloat(varscopestringlist, __floatVal)
                                endif
                            elseIf __operator == "&"
                                SetVarString(varscopestringlist, ResolveString(cmdLine[2]) + ResolveString(cmdLine[4]))
                            elseIf __operator == "&&"
                                SetVarBool(varscopestringlist, ResolveBool(cmdLine[2]) && ResolveBool(cmdLine[4]))
                            elseIf __operator == "||"
                                SetVarBool(varscopestringlist, ResolveBool(cmdLine[2]) || ResolveBool(cmdLine[4]))
                            elseIf __operator == "=="
                                SetVarBool(varscopestringlist, ResolveBool(cmdLine[2]) == ResolveBool(cmdLine[4]))
                            else
                                SFE("unexpected operator for 'set' (" + __operator + ")")
                            endif
                        else
                            if SLT.Debug_Cmd_RunScript_Set
                                SFD("Cmd.RunScript: set/unhandled\n\tcmdLine<" + PapyrusUtil.StringJoin(cmdLine, ">,<") + "> varscopestringlist<" + PapyrusUtil.StringJoin(varscopestringlist, ">,<") + ">")
                            endif
                        endif
                    endif
                else
                    if SLT.Debug_Cmd_RunScript_Set
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
            __searchFoundBlockEnd = false
            if !IfNestLevel
                SFE("'endif' encountered outside of if-block; ignoring")
            endif
            IfNestLevel -= 1
            ;IsInsideIfBlock = false
            IfBlockSatisfied = true
            ;currentLine += 1
        elseIf command == "else"
            if subCommand
                SFE("'else' is not a valid subcommand")
            endif
            __searchFoundBlockEnd = false
            if !IfNestLevel
                SFE("'else' encountered outside of if-block; ignoring")
            else
                if IfBlockSatisfied
                    SetBlockEndTarget(BE_IF)
                endif
                ; else always satisfies the if-block
                IfBlockSatisfied = true
            endif
            ;currentLine += 1
        elseIf command == "endwhile"
            if subCommand
                SFE("'endwhile' is not a valid subcommand")
            endif
            if __searchFoundBlockEnd
                __searchFoundBlockEnd = false
            else
                __intVal = slt_PopWhileReturn()
                if __intVal > -1
                    if SLT.Debug_Cmd_RunScript_Blocks
                        SFD("moving back to WHILE and not advancing")
                    endif
                    currentLine = __intVal
                    __CLRR = CLRR_NOADVANCE
                endif
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

                    if SLT.Debug_Cmd_RunScript_While
                        SFD("while /" + cmdLine[1] + "/ /" + cmdLine[2] + "/=>/" + __operator +  "/ /" + cmdLine[3] + "/")
                    endif
                    
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
                            if SLT.Debug_Cmd_RunScript_While
                                float flt1 = ResolveFloat(cmdLine[1])
                                float flt2 = ResolveFloat(cmdLine[3])
                                SFD("while: /" + cmdLine[1] + "/=>/" + flt1 + "/ /" + cmdLine[2] + "/=>/" + __operator +  "/ /" + cmdLine[3] + "/=>/" + flt2 + "/  => bval/" + __bVal + "/")
                            endif
                        elseIf __operator == "<="
                            if ResolveFloat(cmdLine[1]) <= ResolveFloat(cmdLine[3])
                                __bVal = true
                            endif
                        elseIf __operator == "||"
                            if ResolveBool(cmdLine[1]) || ResolveBool(cmdLine[3])
                                __bVal = true
                            endif
                        elseIf __operator == "&&"
                            if ResolveBool(cmdLine[1]) && ResolveBool(cmdLine[3])
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
        elseIf (command == "if" || command == "elseif")
            if !IfNestLevel && command == "elseif"
                SFW("'elseif' should be preceded by an 'if' to open the block; allowing it but you should change it to make sure your script semantics are as you expect")
            endif
            __searchFoundBlockEnd = false
            if subCommand
                if command == "if"
                    SFE("'if' is not a valid subcommand")
                else
                    SFE("'elseif' is not a valid subcommand")
                endif
            elseif IfNestLevel && IfBlockSatisfied && command == "elseif"
                SetBlockEndTarget(BE_IF)
                ; inside an if block but it's already been satisfied, keep going until we hit endif
            elseif cmdLine.Length == 2
                ; if <boolval> ; treat like start of if-block and search for endif
                if SLT.Debug_Cmd_RunScript_If
                    if command == "if"
                        SFD("if <bool>")
                    else
                        SFD("elseif <bool>")
                    endif
                endif
                
                if command == "if"
                    IfNestLevel += 1
                endif

                ;IsInsideIfBlock = true
                if !ResolveBool(cmdLine[1])
                    ; find the matching endif
                    IfBlockSatisfied = false
                    SetBlockEndTarget(BE_IF)
                else
                    IfBlockSatisfied = true
                endif
            elseif cmdLine.Length == 3
                ; if <boolval> <label> ;
                if SLT.Debug_Cmd_RunScript_If
                    if command == "if"
                        SFD("if <bool> <label>")
                    else
                        SFD("elseif <bool> <label>")
                    endif
                endif
                if command == "elseif"
                    SFE("'elseif' does not support [label] redirection; you will have to add an explicit goto on the following line instead")
                else
                    if ResolveBool(cmdLine[1])
                        __strVal = ResolveLabel(cmdLine[2])
                        __intVal = slt_FindGoto(__strVal)
                        if __intVal > -1
                            ResetBlockContext()
                            currentLine = __intVal
                        else
                            SFE("Unable to resolve goto label (" + cmdLine[2] + ") resolved to (" + __strVal + ")")
                        endif
                    endif
                endif
            elseif cmdLine.Length == 4
                ; if <var1> <op> <var2> ; treat like start of if-block and search for endif
                if SLT.Debug_Cmd_RunScript_If
                    if command == "if"
                        SFD("if <val> <op> <val>")
                    else
                        SFD("elseif <val> <op> <val>")
                    endif
                endif

                __operator = ResolveString(cmdLine[2])
                if SLT.Debug_Cmd_RunScript_If
                    SFD("<op> is    / " + __operator + " /")
                endif

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
                elseIf __operator == "||"
                    If ResolveBool(cmdLine[1]) || ResolveBool(cmdLine[3])
                        __bVal = true
                    EndIf
                elseIf __operator == "&&"
                    If ResolveBool(cmdLine[1]) && ResolveBool(cmdLine[3])
                        __bVal = true
                    EndIf
                else
                    SFE("unexpected operator(" + __operator + "), this is likely an error in the SLT script")
                    __bVal = false
                endif

                if command == "if"
                    IfNestLevel += 1
                endif
                ;IsInsideIfBlock = true
                if !__bVal
                    if SLT.Debug_Cmd_RunScript_If
                        SFD("\t\tif: EVALUATED (" + (__bVal) + "): searching for endif")
                    endif

                    IfBlockSatisfied = false
                    SetBlockEndTarget(BE_IF)
                else
                    IfBlockSatisfied = true
                    if SLT.Debug_Cmd_RunScript_If
                        SFD("\t\tif: EVALUATED (" + (__bVal) + "): proceeding into the if block")
                    endif
                endIf
            elseif cmdLine.Length == 5
                ; if <var1> <op> <var2> <label>
                if SLT.Debug_Cmd_RunScript_If
                    if command == "if"
                        SFD("if <var> <opt> <var> <label>")
                    else
                        SFD("elseif <var> <opt> <var> <label>")
                    endif
                endif
                
                if command == "elseif"
                    SFE("'elseif' does not support [label] redirection; you will have to add an explicit goto on the following line instead")
                else
                    __operator = ResolveString(cmdLine[2])
                    if SLT.Debug_Cmd_RunScript_If
                        SFD("<op> is    / " + __operator + " /")
                    endif

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
                        elseIf __operator == "||"
                            If ResolveBool(cmdLine[1]) || ResolveBool(cmdLine[3])
                                __bVal = true
                            EndIf
                        elseIf __operator == "&&"
                            If ResolveBool(cmdLine[1]) && ResolveBool(cmdLine[3])
                                __bVal = true
                            EndIf
                        else
                            SFE("unexpected operator, this is likely an error in the SLT script")
                            __bVal = false
                        endif

                        if __bVal
                            __strVal = ResolveLabel(cmdLine[4])
                            __intVal = slt_FindGoto(__strVal)
                            if __intVal > -1
                                ResetBlockContext()
                                currentLine = __intVal
                            else
                                SFE("Unable to resolve goto label (" + cmdLine[4] + ") resolved to (" + __strVal + ")")
                            endif
                        endIf
                    else
                        SFE("unable to resolve operator (" + cmdLine[2] + ") po(" + __operator + ")")
                    endif
                endif
            else
                SFE("'if': invalid number of arguments")
            endif
            ;currentLine += 1
        elseIf command == "mapunset"
            if subCommand
                SFE("'mapunset' is not a valid subcommand")
            elseif ParamLengthEQ(self, cmdLine.Length, 3)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    int vt = GetVarType(varscope)
                    if SLT.RT_MAP == vt
                        string mapkey = ResolveString(cmdLine[2])
                        if mapkey
                            UnsetMapKey(varscope, mapkey)
                        else
                            SFE("cannot mapunset with empty mapkey: resolved from(" + cmdLine[2] + ")")
                        endif
                    else
                        SFE("invalid target for mapunset: varscope(" + SLT.VarScopeToString(varscope) + ")")
                    endif
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "maphaskey"
            if ParamLengthEQ(self, cmdLine.Length, 3)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    int vt = GetVarType(varscope)
                    if SLT.RT_MAP == vt
                        string mapkey = ResolveString(cmdLine[2])
                        if mapkey
                            string baseMapKey = GetMapKey(varscope)
                            int foundIndex = StorageUtil.StringListFind(SLT, baseMapKey, mapkey)
                            MostRecentBoolResult = (foundIndex > -1)
                        else
                            SFE("cannot maphaskey with empty mapkey: resolved from(" + cmdLine[2] + ")")
                        endif
                    else
                        SFE("invalid target for maphaskey: varscope(" + SLT.VarScopeToString(varscope) + ")")
                    endif
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "mapcopy"
            if subCommand
                SFE("'mapcopy' is not a valid subcommand")
            elseif ParamLengthEQ(self, cmdLine.Length, 3)
                string[] sourceVarscope = GetVarScopeWithResolution(cmdLine[2], false)
                if sourceVarscope[SLT.VS_SCOPE]
                    int sourceBaseType = GetVarType(sourceVarscope)
                    if SLT.RT_MAP == sourceBaseType
                        string[] targetVarscope = GetVarScopeWithResolution(cmdLine[1], false)
                        if targetVarscope[SLT.VS_SCOPE]
                            string sourceKey = GetMapKey(sourceVarscope)
                            string targetKey = GetMapKey(targetVarscope)

                            string[] sourceMapKeys = StorageUtil.StringListToArray(SLT, sourceKey)
                            int smkindex = sourceMapKeys.Length
                            string sourceVal
                            string actualMapKey
                            int sourceType
                            while smkindex
                                smkindex -= 1
                                actualMapKey = sourceMapKeys[smkindex]

                                sourceType = StorageUtil.GetIntValue(SLT, sourceKey + actualMapKey)

                                sourceVarscope[SLT.VS_MAP_KEY] = actualMapKey
                                sourceVarscope[SLT.VS_RESOLVED_MAP_KEY] = actualMapKey
                                targetVarscope[SLT.VS_MAP_KEY] = actualMapKey
                                targetVarscope[SLT.VS_RESOLVED_MAP_KEY] = actualMapKey

                                if SLT.RT_BOOL == sourceType
                                    bool val = GetVarBool(sourceVarscope, false)
                                    SetVarBool(targetVarscope, val)
                                elseif SLT.RT_INT == sourceType
                                    int val = GetVarInt(sourceVarscope, 0)
                                    SetVarInt(targetVarscope, val)
                                elseif SLT.RT_FLOAT == sourceType
                                    float val = GetVarFloat(sourceVarscope, 0.0)
                                    SetVarFloat(targetVarscope, val)
                                elseif SLT.RT_STRING == sourceType
                                    string val = GetVarString(sourceVarscope, "")
                                    SetVarString(targetVarscope, val)
                                elseif SLT.RT_LABEL == sourceType
                                    string val = GetVarLabel(sourceVarscope, "")
                                    SetVarLabel(targetVarscope, val)
                                elseif SLT.RT_FORM == sourceType
                                    Form val = GetVarForm(sourceVarscope, none)
                                    SetVarForm(targetVarscope, val)
                                endif
                            endwhile
                        else
                            SFE("no resolve found for target map (" + cmdLine[1] + ")")
                        endif
                    else
                        SFW("Unable to mapcopy from non-map type: " + SLT.RT_ToString(sourceBaseType))
                    endif
                else
                    SFE("no resolve found for source map (" + cmdLine[2] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "mapclear"
            if subCommand
                SFE("'mapclear' is not a valid subcommand")
            elseif ParamLengthEQ(self, cmdLine.Length, 2)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    int vt = GetVarType(varscope)
                    if SLT.RT_MAP == vt
                        
                        string sourceKey = GetMapKey(varscope)
                        string[] sourceMapKeys = StorageUtil.StringListToArray(SLT, sourceKey)
                        int smkindex = sourceMapKeys.Length
                        while smkindex
                            smkindex -= 1
                            
                            UnsetMapKey(varscope, sourceMapKeys[smkindex])
                        endwhile
                    else
                        SFE("invalid target for mapclear: varscope(" + SLT.VarScopeToString(varscope) + ")")
                    endif
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "mapkeys"
            if ParamLengthEQ(self, cmdLine.Length, 2)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    int vt = GetVarType(varscope)
                    if SLT.RT_MAP == vt
                        string mapkey = GetMapKey(varscope)
                        MostRecentListStringResult = StorageUtil.StringListToArray(SLT, mapkey)
                    else
                        SFE("invalid target for mapkeys: varscope(" + SLT.VarScopeToString(varscope) + ")")
                    endif
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "listcount"
            if ParamLengthEQ(self, cmdLine.Length, 2)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    int vt = GetVarType(varscope)
                    if SLT.RT_IsList(vt)
                        MostRecentIntResult = StorageUtil.StringListCount(SLT, GetVarListKey(varscope))
                    else
                        SFE("invalid target for listcount: varscope(" + SLT.VarScopeToString(varscope) + "); type(" + SLT.RT_ToString(vt) + ")")
                    endif
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "listclear"
            if subCommand
                SFE("'listclear' is not a valid subcommand")
            elseif ParamLengthEQ(self, cmdLine.Length, 2)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    int vt = GetVarType(varscope)
                    if SLT.RT_IsList(vt)
                        StorageUtil.StringListResize(SLT, GetVarListKey(varscope), 0)
                    else
                        SFE("invalid target for listclear: varscope(" + SLT.VarScopeToString(varscope) + "); type(" + SLT.RT_ToString(vt) + ")")
                    endif
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "listadd"
            if subCommand
                SFE("'listadd' is not a valid subcommand")
            elseif ParamLengthGT(self, cmdLine.Length, 2)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    int rli = StorageUtil.StringListCount(SLT, GetVarListKey(varscope))
                    int cli = 2
                    while cli < cmdLine.Length
                        varscope[SLT.VS_LIST_INDEX] = rli
                        varscope[SLT.VS_RESOLVED_LIST_INDEX] = rli

                        InternalResolve(cmdLine[cli])
                        SetVarFromCustomResult(varscope)

                        cli += 1
                        rli += 1
                    endwhile
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "listresize"
            if subCommand
                SFE("'listresize' is not a valid subcommand")
            elseif ParamLengthEQ(self, cmdLine.Length, 3)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    int vt = GetVarType(varscope)
                    if SLT.RT_IsList(vt)
                        StorageUtil.StringListResize(SLT, GetVarListKey(varscope), ResolveInt(cmdLine[2]))
                    else
                        SFE("invalid target for listclear: varscope(" + SLT.VarScopeToString(varscope) + "); type(" + SLT.RT_ToString(vt) + ")")
                    endif
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "listslice" ; listslice $listvar $length [$startIndex]
            if ParamLengthGT(self, cmdLine.Length, 2)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    int vt = GetVarType(varscope)
                    if SLT.RT_IsList(vt)
                        int subrt = SLT.RT_ListSubtype(vt)
                        string[] slice = PapyrusUtil.StringArray(ResolveInt(cmdLine[2]))
                        StorageUtil.StringListSlice(SLT, GetVarListKey(varscope), slice, ResolveInt(cmdLine[3]))
                        if SLT.RT_BOOL == subrt
                            bool[] data = PapyrusUtil.BoolArray(slice.Length)
                            int i = data.Length
                            while i
                                i -= 1
                                data[i] = slice[i] as bool
                            endwhile
                            MostRecentListBoolResult = data
                        elseif SLT.RT_STRING == subrt
                            string[] data = PapyrusUtil.StringArray(slice.Length)
                            int i = data.Length
                            while i
                                i -= 1
                                data[i] = slice[i]
                            endwhile
                            MostRecentListStringResult = data
                        elseif SLT.RT_INT == subrt
                            int[] data = PapyrusUtil.IntArray(slice.Length)
                            int i = data.Length
                            while i
                                i -= 1
                                data[i] = slice[i] as int
                            endwhile
                            MostRecentListIntResult = data
                        elseif SLT.RT_FLOAT == subrt
                            float[] data = PapyrusUtil.FloatArray(slice.Length)
                            int i = data.Length
                            while i
                                i -= 1
                                data[i] = slice[i] as float
                            endwhile
                            MostRecentListFloatResult = data
                        elseif SLT.RT_FORM == subrt
                            Form[] data = PapyrusUtil.FormArray(slice.Length)
                            int i = data.Length
                            while i
                                i -= 1
                                data[i] = sl_triggers.GetForm(slice[i])
                            endwhile
                            MostRecentListFormResult = data
                        elseif SLT.RT_LABEL == subrt
                            string[] data = PapyrusUtil.StringArray(slice.Length)
                            int i = data.Length
                            while i
                                i -= 1
                                data[i] = slice[i]
                            endwhile
                            MostRecentListLabelResult = data
                        endif
                    else
                        SFE("invalid target for listclear: varscope(" + SLT.VarScopeToString(varscope) + "); type(" + SLT.RT_ToString(vt) + ")")
                    endif
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "inc"
            if subCommand
                SFE("'inc' is not a valid subcommand")
            elseif ParamLengthGT(self, cmdLine.Length, 1)
                __intVal = 1
                __floatVal = 1.0
                __bVal = true
                if cmdLine.Length > 2
                    __intVal = ResolveInt(cmdLine[2])
                    __floatVal = ResolveFloat(cmdLine[2])
                    __bVal = (__intVal == __floatVal)
                    If (SLT.Debug_Cmd_RunScript)
                        SFD("inc: RHS: i(" + __intVal + ") f(" + __floatVal + ") is_i(" + __bVal + ")")
                    EndIf
                endif
                
                
                string[] varscopestringlist = GetVarScopeWithResolution(cmdLine[1], true)
                ;GetVarScope2(cmdLine[1], varscopestringlist, true)
                if varscopestringlist[SLT.VS_SCOPE]
                    __strVal2 = GetVarString(varscopestringlist, "")
                    
                    __intVal2 = __strVal2 as int
                    __floatVal2 = __strVal2 as float
                    
                    If (SLT.Debug_Cmd_RunScript)
                        SFD("inc: LHS: varscopestringlist(" + PapyrusUtil.StringJoin(varscopestringlist, "),(") + ") i(" + __intVal2 + ") f(" + __floatVal2 + ") is_i(" + (__intVal2 == __floatVal2) + ") from GetVarString2()=>(" + __strVal2 + ")")
                    EndIf
                    if (__intVal2 == __floatVal2 && __bVal)
                        SetVarInt(varscopestringlist, __intVal2 + __intVal)
                        If (SLT.Debug_Cmd_RunScript)
                            int justin = GetVarInt(varscopestringlist, 12344321)
                            SFD("inc: as int, retrieved stored value(" + justin + ")")
                        EndIf
                    else
                        SetVarFloat(varscopestringlist, __floatVal2 + __floatVal)
                        If (SLT.Debug_Cmd_RunScript)
                            float justin = GetVarFloat(varscopestringlist, 1234.4321)
                            SFD("inc: as float, retrieved stored value(" + justin + ")")
                        EndIf
                    endif
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ") varstr(" + cmdLine[1] + ") varscope(" + varscopestringlist[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "goto"
            if SLT.Debug_Cmd_RunScript
                SFD("Cmd.RunScript: goto")
            endif
            if subCommand
                SFE("'goto' is not a valid subcommand")
            elseif ParamLengthEQ(self, cmdLine.Length, 2)
                __strVal = ResolveLabel(cmdLine[1])
                __intVal = slt_FindGoto(__strVal)
                if __intVal > -1
                    ; if we are in a gosub call or a while block, unset those since we are busting up the gang
                    ResetBlockContext()
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
                
                
                string[] varscopestringlist = GetVarScopeWithResolution(__strVal, true)
                ;GetVarScope2(__strVal, varscopestringlist, true)
                if varscopestringlist[SLT.VS_SCOPE]
                    __intVal = 2
                    __strVal2 = GetVarString(varscopestringlist, "")
                    while __intVal < cmdLine.Length
                        __strVal2 = __strVal2 + ResolveString(cmdLine[__intVal])
                        __intVal += 1
                    endwhile
                    SetVarString(varscopestringlist, __strVal2)
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
                SetBlockEndTarget(BE_BEGINSUB)
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
                
                
                string[] varscopestringlist = GetVarScopeWithResolution(arg, true)
                ;GetVarScope2(arg, varscopestringlist, true)
                if varscopestringlist[SLT.VS_SCOPE]
                    SetVarString(varscopestringlist, newval)
                else
                    SFE("unable to resolve variable name (" + arg + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "string[]"
            if ParamLengthEQ(self, cmdLine.Length, 2)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    SetVarType(varscope, SLT.RT_LIST_STRING)
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "bool[]"
            if ParamLengthEQ(self, cmdLine.Length, 2)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    SetVarType(varscope, SLT.RT_LIST_BOOL)
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "int[]"
            if ParamLengthEQ(self, cmdLine.Length, 2)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    SetVarType(varscope, SLT.RT_LIST_INT)
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "float[]"
            if ParamLengthEQ(self, cmdLine.Length, 2)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    SetVarType(varscope, SLT.RT_LIST_FLOAT)
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "Form[]"
            if ParamLengthEQ(self, cmdLine.Length, 2)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    SetVarType(varscope, SLT.RT_LIST_FORM)
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
                endif
            endif
            ;currentLine += 1
        elseIf command == "label[]"
            if ParamLengthEQ(self, cmdLine.Length, 2)
                string[] varscope = GetVarScopeWithResolution(cmdLine[1], true)
                if varscope[SLT.VS_SCOPE]
                    SetVarType(varscope, SLT.RT_LIST_LABEL)
                else
                    SFE("no resolve found for variable parameter (" + cmdLine[1] + ")")
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
            if SLT.Debug_Cmd_RunScript
                SFD("Cmd.RunScript: RunOperationOnActor(" + debstrjoin(cmdLine) + ")")
            endif
            
            RunOperationOnActor(cmdLine)

            ;currentLine += 1
        endif
    endif

    return __CLRR
EndFunction

Function RunScript()
    if SLT.Debug_Cmd || SLT.Debug_Cmd_RunScript
        SFD("Cmd.RunScript")
    endif

    string[] cmdLine
    int commandLineRunResult

    while isExecuting && hasValidFrame
        if SLT.Debug_Cmd_RunScript
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
            
            if SLT.Debug_Cmd_RunScript
                SFD("Cmd.RunScript: lineNum(" + lineNum + ") startidx(" + startidx + ") endidx(" + endidx + ") currentScriptName(" + currentScriptName + ") initialScriptName(" + initialScriptName + ") cmdLine(" + PapyrusUtil.StringJoin(cmdLine, "), (") + ")")
            endif
            
            if IsResetRequested || !SLT.IsEnabled || SLT.IsResetting
                SFI("SLTReset requested(" + IsResetRequested + ") / SLT.IsEnabled(" + SLT.IsEnabled + ") / SLT.IsResetting(" + SLT.IsResetting + ")")
                CleanupAndRemove()
                Return
            endif
            
            if cmdLine.Length
                if SLT.Debug_Cmd_RunScript
                    SFI("RunCommandLine values before: for cmdLine(" + PapyrusUtil.StringJoin(cmdLine, "), (") + ")" + ": currentLine(" + currentLine + ") totalLines(" + totalLines + ") currentScriptName(" + currentScriptName + ") initialScriptName(" + initialScriptName + ")")
                endif
                commandLineRunResult = RunCommandLine(cmdLine, startidx, endidx, false)
                if SLT.Debug_Cmd_RunScript
                    SFI("RunCommandLine result: (" + CLRR_ToString(commandLineRunResult) + ") for cmdLine(" + PapyrusUtil.StringJoin(cmdLine, "), (") + ")" + ": currentLine(" + currentLine + ") totalLines(" + totalLines + ") currentScriptName(" + currentScriptName + ") initialScriptName(" + initialScriptName + ")")
                endif

                if CLRR_RETURN == commandLineRunResult
                    if SLT.Debug_Cmd_RunScript
                        SFD("CLRR_RETURN; returning")
                    endif
                    return
                endif

                if CLRR_ADVANCE == commandLineRunResult
                    if SLT.Debug_Cmd_RunScript
                        SFD("CLRR_ADVANCE; incrementing currentLine")
                    endif
                    currentLine += 1
                endif

                if CLRR_NOADVANCE == commandLineRunResult
                    if SLT.Debug_Cmd_RunScript
                        SFD("CLRR_NOADVANCE; thus, not advancing")
                    endif
                endif
            else
                currentLine += 1
            endif
        endwhile

        if SLT.Debug_Cmd_RunScript
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
;bool[]      pushed_insideifblock
int[]       pushed_ifnestlevel
bool[]      pushed_ifsatisfied
int[]       pushed_frameid

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
        ;_myCmdName = CommandsFolder() + scriptfilename
        ;totalJsonCommandCount = JsonUtil.PathCount(_myCmdName, ".cmd")
        SFE("SLT: JSON script support has ended; please convert your script to SLTScript format")
        return false
    elseif scrtype == 2
        _myCmdName = scriptfilename

        rawtokenresult = sl_triggers.SplitScriptContentsAndTokenize(_myCmdName)
        totalFunctionalCommands = rawtokenresult[0] as int
    elseif scrtype == 3
        _myCmdName = scriptfilename

        rawtokenresult = sl_triggers.SplitScriptContentsAndTokenize(_myCmdName)
        totalFunctionalCommands = rawtokenresult[0] as int
    elseif scrtype == 10
        ;scrtype = 1
        ;_myCmdName = CommandsFolder() + scriptfilename + ".json"
        ;totalJsonCommandCount = JsonUtil.PathCount(_myCmdName, ".cmd")
        SFE("SLT: JSON script support has ended; please convert your script to SLTScript format")
        return false
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
            ;pushed_insideifblock = PapyrusUtil.BoolArray(0)
            pushed_ifnestlevel = PapyrusUtil.IntArray(0)
            pushed_ifsatisfied = PapyrusUtil.BoolArray(0)
            pushed_frameid = PapyrusUtil.IntArray(0)
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
        pushed_ifnestlevel = PapyrusUtil.PushInt(pushed_ifnestlevel, IfNestLevel)
        ;pushed_insideifblock = PapyrusUtil.PushBool(pushed_insideifblock, IsInsideIfBlock)
        pushed_ifsatisfied = PapyrusUtil.PushBool(pushed_ifsatisfied, IfBlockSatisfied)
        pushed_frameid = PapyrusUtil.PushInt(pushed_frameid, _frameid)

        int varcount
        int varstoresize
        int i
        int j

        ; vars
        varcount = frameVarKeys.Length
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
                frame_var_key_store[j] = frameVarKeys[i]
                frame_var_val_store[j] = frameVarVals[i]
                frame_var_type_store[j] = frameVarTypes[i]

                i += 1
            endwhile
        endif

        frameVarKeys = PapyrusUtil.StringArray(0)
        frameVarVals = PapyrusUtil.StringArray(0)
        frameVarTypes = PapyrusUtil.IntArray(0)

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
        frameVarKeys = PapyrusUtil.StringArray(0)
        frameVarVals = PapyrusUtil.StringArray(0)
        frameVarTypes = PapyrusUtil.IntArray(0)
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
        ;/
        ; JSON support has ended
        ; 
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
        /;
    elseif scrtype == 2 || scrtype == 3

        scriptlines = PapyrusUtil.IntArray(totalFunctionalCommands)
        tokencounts = PapyrusUtil.IntArray(totalFunctionalCommands)
        tokenoffsets = PapyrusUtil.IntArray(totalFunctionalCommands)
        tokens = PapyrusUtil.SliceStringArray(rawtokenresult, 1 + 3 * totalFunctionalCommands)
        
        If (SLT.Debug_Cmd_RunScript)
            SFD("scriptfilename(" + scriptfilename + ") rawtokens: (" + PapyrusUtil.StringJoin(rawtokenresult, "),(") + ")")
        EndIf

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
                    if SLT.Debug_Cmd_RunScript_Labels
                        SFI("Adding goto label during parsing /" + cmdLine0 + "/" + cmdIdx + "/")
                    endif
                    slt_AddGoto(cmdLine0, cmdIdx)
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

    if SLT.Debug_Cmd
        SFD("Cmd.slt_Frame_Push: scriptname:" + currentScriptName + ": totalLines:" + totalLines + ":")
    endif

    hasValidFrame = true
    IfBlockSatisfied = true
    IfNestLevel = 0
    ;IsInsideIfBlock = false

    ResetBlockEndTarget()
    
    frameid = SLT.GetNextInstanceID()

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

	StorageUtil.ClearAllObjPrefix(SLT, "SLTR:frame:" + frameid)

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
    ;IsInsideIfBlock             = pushed_insideifblock[pushed_insideifblock.Length - 1]
    IfNestLevel                 = pushed_ifnestlevel[pushed_ifnestlevel.Length - 1]
    IfBlockSatisfied            = pushed_ifsatisfied[pushed_ifsatisfied.Length - 1]
    frameid                     = pushed_frameid[pushed_frameid.Length - 1]

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
    ;pushed_insideifblock        = PapyrusUtil.ResizeBoolArray(pushed_insideifblock, pushed_insideifblock.Length - 1)
    pushed_ifnestlevel          = PapyrusUtil.ResizeIntArray(pushed_ifnestlevel, pushed_ifnestlevel.Length - 1)
    pushed_ifsatisfied          = PapyrusUtil.ResizeBoolArray(pushed_ifsatisfied, pushed_ifsatisfied.Length - 1)
    pushed_frameid              = PapyrusUtil.ResizeIntArray(pushed_frameid, pushed_frameid.Length - 1)

    int varcount
    int newvarstoresize
    int i
    int j

    ; vars
    varcount = frame_var_count[frame_var_count.Length - 1]
    newvarstoresize = frame_var_key_store.Length - varcount

    frameVarKeys = PapyrusUtil.StringArray(varcount)
    frameVarVals = PapyrusUtil.StringArray(varcount)
    frameVarTypes = PapyrusUtil.IntArray(varcount)

    if varcount
        i = 0
        while i < varcount
            j = newvarstoresize + i
            frameVarKeys[i] = frame_var_key_store[j]
            frameVarVals[i] = frame_var_val_store[j]
            frameVarTypes[i] = frame_var_type_store[j]

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
    if SLT.Debug_Cmd_RunScript_Labels
        SFD("slt_AddGoto: label/" + label + "/targetline/" + targetline + "/index(-1 is not found yet)/" + i + "/")
    endif
    if i > -1
        gotoLines[i] = targetline
    else
        gotoLabels = PapyrusUtil.PushString(gotoLabels, label)
        gotoLines = PapyrusUtil.PushInt(gotoLines, targetline)
    endif
EndFunction

int Function slt_FindGoto(string label)
    int i = gotoLabels.Find(label)
    if SLT.Debug_Cmd_RunScript_Labels
        int result = -1
        if i > -1
            result = gotoLines[i]
        endif
        SFD("slt_FindGoto: label/" + label + "/index(-1 is not found yet)/" + i + "/result/" + result + "/")
    endif
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
        if SLT.Debug_Cmd_RunScript_Blocks
            SFD("slt_PopWhileReturn: whileReturns.Length(" + whileReturns.Length + "): returning -1")
        endif
        return -1
    endif
    int r = whileReturns[whileReturns.Length - 1]
    if SLT.Debug_Cmd_RunScript_Blocks
        SFD("slt_PopWhileReturn: whileReturns.Length(" + whileReturns.Length + "): returning r(" + r + ")")
    endif
    whileReturns = PapyrusUtil.ResizeIntArray(whileReturns, whileReturns.Length - 1)
    return r
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;; Frame
;;
bool Function HasFrameVar(string[] varscope)
	return (frameVarKeys.Find(varscope[SLT.VS_NAME], 0) > -1)
EndFunction

string function GetFrameMapKey(string[] varscope)
    return kframe_map_prefix + varscope[SLT.VS_NAME] + ":"
endfunction

string function GetFrameListKey(string[] varscope)
    return kframe_list_prefix + varscope[SLT.VS_NAME] + ":"
endfunction

int Function GetFrameVarType(string[] varscope)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = frameVarTypes[i]
        if SLT.RT_MAP == rt
			if (varscope[SLT.VS_RESOLVED_MAP_KEY])
				return StorageUtil.GetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
			elseif (!varscope[SLT.VS_MAP_KEY])
				return SLT.RT_MAP
			endif
        elseif SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				return rt - SLT.RT_LIST_TYPE_OFFSET
			endif
		    return rt
        else
		    return rt
        endif
	endif
    return SLT.RT_INVALID
EndFunction

string Function GetFrameVarString(string[] varscope, string missing)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = frameVarTypes[i]
        if SLT.RT_BOOL == rt
            return (frameVarVals[i] != "")
		elseIf SLT.RT_MAP == rt
			If (varscope[SLT.VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
				if SLT.RT_BOOL == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) != "")
				endif
				return StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
			else
        		SFW("GetFrameVar: unable to coerce map to string; did you forget a map key?")
				return missing
			EndIf
		elseIf SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
				if SLT.RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) != "")
				endif
				return StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli)
			else
        		SFW("GetFrameVar: unable to coerce list to string; did you forget a list index?")
				return missing
			endif
        endif
		return frameVarVals[i]
	endif
	return missing
EndFunction

string Function GetFrameVarLabel(string[] varscope, string missing)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = frameVarTypes[i]
        if SLT.RT_BOOL == rt
            return (frameVarVals[i] != "")
		elseIf SLT.RT_MAP == rt
			If (varscope[SLT.VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
				if SLT.RT_BOOL == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) != "")
				endif
				return StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
			else
        		SFW("GetFrameVar: unable to coerce map to label; did you forget a map key?")
				return missing
			EndIf
		elseIf SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
				if SLT.RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) != "")
				endif
				return StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli)
			else
        		SFW("GetFrameVar: unable to coerce list to label; did you forget a list index?")
				return missing
			endif
        endif
		return frameVarVals[i]
	endif
	return missing
EndFunction

bool Function GetFrameVarBool(string[] varscope, bool missing)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = frameVarTypes[i]
        if SLT.RT_BOOL == rt
            return frameVarVals[i] != ""
        elseif SLT.RT_INT == rt
            return (frameVarVals[i] as int) != 0
        elseif SLT.RT_FLOAT == rt
            return (frameVarVals[i] as float) != 0
        elseif SLT.RT_STRING == rt
            return frameVarVals[i] != ""
        elseIF SLT.RT_FORM == rt
            return (frameVarVals[i] as int) != 0
		elseIf SLT.RT_MAP == rt
			If (varscope[SLT.VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
				if SLT.RT_BOOL == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) != "")
				elseif SLT.RT_INT == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int) != 0
				elseif SLT.RT_FLOAT == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float) != 0.0
				elseif SLT.RT_STRING == subrt
					return StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) != ""
				elseif SLT.RT_FORM == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int) != 0
				else
					SFE("GetFrameVar: mapped var found but not recognized type(" + SLT.RT_ToString(subrt) + ")")
				endif
			else
        		SFW("GetFrameVar: unable to coerce map to bool; did you forget a map key?")
			EndIf
		elseIf SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
				if SLT.RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) != "")
				elseif SLT.RT_LIST_INT == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as int) != 0
				elseif SLT.RT_LIST_FLOAT == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as float) != 0.0
				elseif SLT.RT_LIST_STRING == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) != "")
				elseif SLT.RT_LIST_FORM == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as int) != 0
				elseif SLT.RT_LIST_LABEL == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) != "")
				else
					SFE("GetFrameVar: list var found but not recognized type(" + SLT.RT_ToString(rt - SLT.RT_LIST_TYPE_OFFSET) + ")")
				endif
			else
        		SFW("GetFrameVar: unable to coerce list to bool; did you forget a list index?")
				return missing
			endif
        else
            SFE("GetFrameVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
        endif
	endif
	return missing
EndFunction

int Function GetFrameVarInt(string[] varscope, int missing)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = frameVarTypes[i]
        if SLT.RT_BOOL == rt
            return frameVarVals[i] as int
        elseif SLT.RT_INT == rt
            return frameVarVals[i] as int
        elseif SLT.RT_FLOAT == rt
            return (frameVarVals[i] as float) as int
        elseif SLT.RT_STRING == rt
            return frameVarVals[i] as int
        elseIf SLT.RT_FORM == rt
            return frameVarVals[i] as int
		elseIf SLT.RT_MAP == rt
			If (varscope[SLT.VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
				if SLT.RT_BOOL == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int)
				elseif SLT.RT_INT == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int)
				elseif SLT.RT_FLOAT == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float) as int
				elseif SLT.RT_STRING == subrt
					return StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int
				elseif SLT.RT_FORM == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int)
				else
					SFE("GetFrameVar: mapped var found but not recognized type(" + SLT.RT_ToString(subrt) + ")")
				endif
			else
        		SFW("GetFrameVar: unable to coerce map to int; did you forget a map key?")
			EndIf
		elseIf SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
				if SLT.RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as int)
				elseif SLT.RT_LIST_INT == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as int)
				elseif SLT.RT_LIST_FLOAT == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as float) as int
				elseif SLT.RT_LIST_STRING == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as int)
				elseif SLT.RT_LIST_FORM == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as int)
				elseif SLT.RT_LIST_LABEL == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as int)
				else
					SFE("GetFrameVar: list var found but not recognized type(" + SLT.RT_ToString(rt - SLT.RT_LIST_TYPE_OFFSET) + ")")
				endif
			else
        		SFW("GetFrameVar: unable to coerce list to int; did you forget a list index?")
				return missing
			endif
        else
            SFE("GetFrameVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
        endif
	endif
	return missing
EndFunction

float Function GetFrameVarFloat(string[] varscope, float missing)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = frameVarTypes[i]
        if SLT.RT_BOOL == rt
            return frameVarVals[i] as float
        elseif SLT.RT_INT == rt
            return frameVarVals[i] as float
        elseif SLT.RT_FLOAT == rt
            return frameVarVals[i] as float
        elseif SLT.RT_STRING == rt
            return frameVarVals[i] as float
        elseIf SLT.RT_FORM == rt
            return frameVarVals[i] as float
		elseIf SLT.RT_MAP == rt
			If (varscope[SLT.VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
				if SLT.RT_BOOL == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float)
				elseif SLT.RT_INT == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float)
				elseif SLT.RT_FLOAT == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float)
				elseif SLT.RT_STRING == subrt
					return StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float
				elseif SLT.RT_FORM == subrt
					return (StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float)
				else
					SFE("GetFrameVar: mapped var found but not recognized type(" + SLT.RT_ToString(subrt) + ")")
				endif
			else
        		SFW("GetFrameVar: unable to coerce map to float; did you forget a map key?")
			EndIf
		elseIf SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
				if SLT.RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as float)
				elseif SLT.RT_LIST_INT == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as float)
				elseif SLT.RT_LIST_FLOAT == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as float)
				elseif SLT.RT_LIST_STRING == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as float)
				elseif SLT.RT_LIST_FORM == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as float)
				elseif SLT.RT_LIST_LABEL == rt
					return (StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as float)
				else
					SFE("GetFrameVar: list var found but not recognized type(" + SLT.RT_ToString(rt - SLT.RT_LIST_TYPE_OFFSET) + ")")
				endif
			else
        		SFW("GetFrameVar: unable to coerce list to float; did you forget a list index?")
				return missing
			endif
        else
            SFE("GetFrameVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
        endif
	endif
	return missing
EndFunction

Form Function GetFrameVarForm(string[] varscope, Form missing)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = frameVarTypes[i]
        if SLT.RT_BOOL == rt
            return none
        elseif SLT.RT_INT == rt
            return sl_triggers.GetForm(frameVarVals[i])
        elseif SLT.RT_FLOAT == rt
            return sl_triggers.GetForm(((frameVarVals[i] as float) as int) as string)
        elseif SLT.RT_STRING == rt
            return sl_triggers.GetForm(frameVarVals[i])
        elseIf SLT.RT_FORM == rt
            return sl_triggers.GetForm(frameVarVals[i])
		elseIf SLT.RT_MAP == rt
			If (varscope[SLT.VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
				if SLT.RT_BOOL == subrt
					return none
				elseif SLT.RT_INT == subrt
					return sl_triggers.GetForm(StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]))
				elseif SLT.RT_FLOAT == subrt
					return sl_triggers.GetForm(StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]))
				elseif SLT.RT_STRING == subrt
					return sl_triggers.GetForm(StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]))
				elseif SLT.RT_FORM == subrt
					return sl_triggers.GetForm(StorageUtil.GetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]))
				else
					SFE("GetFrameVar: mapped var found but not recognized type(" + SLT.RT_ToString(subrt) + ")")
				endif
			else
        		SFW("GetFrameVar: unable to coerce map to Form; did you forget a map key?")
			EndIf
		elseIf SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
				if SLT.RT_LIST_BOOL == rt
					return none
				elseif SLT.RT_LIST_INT == rt
					return sl_triggers.GetForm(StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli))
				elseif SLT.RT_LIST_FLOAT == rt
					return sl_triggers.GetForm((StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli) as float) as int)
				elseif SLT.RT_LIST_STRING == rt
					return sl_triggers.GetForm(StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli))
				elseif SLT.RT_LIST_FORM == rt
					return sl_triggers.GetForm(StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli))
				elseif SLT.RT_LIST_LABEL == rt
					return sl_triggers.GetForm(StorageUtil.StringListGet(SLT, GetFrameListKey(varscope), rli))
				else
					SFE("GetFrameVar: list var found but not recognized type(" + SLT.RT_ToString(rt - SLT.RT_LIST_TYPE_OFFSET) + ")")
				endif
			else
        		SFW("GetFrameVar: unable to coerce list to Form; did you forget a list index?")
				return missing
			endif
        else
            SFE("GetFrameVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
        endif
	endif
	return missing
EndFunction

function UnsetFrameMapKey(string[] varscope, string mapkey)
    if !mapkey
        SFW("Attempted to unset empty map key: varscope(" + SLT.VarScopeToString(varscope) + ") mapkey(" + mapkey + ")")
    else
        StorageUtil.UnsetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + mapkey)
        StorageUtil.UnsetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + mapkey)
        StorageUtil.StringListRemove(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":", mapkey)
    endif
endfunction

Function SetFrameVarType(string[] varscope, int newType)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i < 0
		frameVarKeys = PapyrusUtil.PushString(frameVarKeys, varscope[SLT.VS_NAME])
        frameVarVals = PapyrusUtil.PushString(frameVarVals, "")
        frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, newType)
    else
        frameVarVals[i] = ""
        frameVarTypes[i] = newType
    endif
EndFunction

string Function SetFrameVarString(string[] varscope, string value)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
    If (SLT.Debug_Cmd_RunScript_Set)
        SFD("Cmd.SetFrameVarString: varscope(" + SLT.VarScopeToString(varscope) + ") to value(" + value + "); index from find (" + i + ")")
    EndIf
	if i < 0
		frameVarKeys = PapyrusUtil.PushString(frameVarKeys, varscope[SLT.VS_NAME])
		If (varscope[SLT.VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_STRING)
			frameVarVals = PapyrusUtil.PushString(frameVarVals, "")
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_MAP)
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			string retval = SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
            string flkey = GetFrameListKey(varscope)
			frameVarVals = PapyrusUtil.PushString(frameVarVals, "")
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_LIST_STRING)
		else
			frameVarVals = PapyrusUtil.PushString(frameVarVals, value)
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_STRING)
		EndIf
    else
        if (varscope[SLT.VS_RESOLVED_MAP_KEY])
            StorageUtil.SetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_STRING)
            frameVarTypes[i] = SLT.RT_MAP
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rt = GetFrameVarType(varscope)
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			If (SLT.RT_STRING == rt)
				string retval = SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
            string flkey = GetFrameListKey(varscope)
			elseif SLT.RT_BOOL == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value != "")
			elseif SLT.RT_INT == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value as int)
			elseif SLT.RT_FLOAT == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value as float)
			elseif SLT.RT_FORM == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value as int)
			elseif SLT.RT_LABEL == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			EndIf
        else
            frameVarVals[i] = value
            frameVarTypes[i] = SLT.RT_STRING
        endif
	endif
	return value
EndFunction

string Function SetFrameVarLabel(string[] varscope, string value)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i < 0
		frameVarKeys = PapyrusUtil.PushString(frameVarKeys, varscope[SLT.VS_NAME])
		If (varscope[SLT.VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_LABEL)
			frameVarVals = PapyrusUtil.PushString(frameVarVals, "")
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_MAP)
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			frameVarVals = PapyrusUtil.PushString(frameVarVals, "")
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_LIST_LABEL)
		else
			frameVarVals = PapyrusUtil.PushString(frameVarVals, value)
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_LABEL)
		EndIf
    else
        if (varscope[SLT.VS_RESOLVED_MAP_KEY])
            StorageUtil.SetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_LABEL)
            frameVarTypes[i] = SLT.RT_MAP
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rt = GetFrameVarType(varscope)
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			If (SLT.RT_STRING == rt)
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			elseif SLT.RT_BOOL == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value != "")
			elseif SLT.RT_INT == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value as int)
			elseif SLT.RT_FLOAT == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value as float)
			elseif SLT.RT_FORM == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value as int)
			elseif SLT.RT_LABEL == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			EndIf
        else
            frameVarVals[i] = value
            frameVarTypes[i] = SLT.RT_LABEL
        endif
	endif
	return value
EndFunction

bool Function SetFrameVarBool(string[] varscope, bool boolvalue)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
    string value
    if boolvalue
        value = "1"
    endif
	if i < 0
		frameVarKeys = PapyrusUtil.PushString(frameVarKeys, varscope[SLT.VS_NAME])
		If (varscope[SLT.VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_BOOL)
			frameVarVals = PapyrusUtil.PushString(frameVarVals, "")
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_MAP)
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			frameVarVals = PapyrusUtil.PushString(frameVarVals, "")
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_LIST_BOOL)
		else
			frameVarVals = PapyrusUtil.PushString(frameVarVals, value)
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_BOOL)
		EndIf
    else
        if (varscope[SLT.VS_RESOLVED_MAP_KEY])
            StorageUtil.SetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_BOOL)
            frameVarTypes[i] = SLT.RT_MAP
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rt = GetFrameVarType(varscope)
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			If (SLT.RT_STRING == rt)
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, boolvalue)
			elseif SLT.RT_BOOL == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			elseif SLT.RT_INT == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value as int)
			elseif SLT.RT_FLOAT == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value as float)
			elseif SLT.RT_FORM == rt
				; bool->Form => none; always
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, "")
			elseif SLT.RT_LABEL == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, boolvalue)
			EndIf
        else
            frameVarVals[i] = value
            frameVarTypes[i] = SLT.RT_BOOL
        endif
	endif
	return boolvalue
EndFunction

int Function SetFrameVarInt(string[] varscope, int value)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i < 0
		frameVarKeys = PapyrusUtil.PushString(frameVarKeys, varscope[SLT.VS_NAME])
		If (varscope[SLT.VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_INT)
			frameVarVals = PapyrusUtil.PushString(frameVarVals, "")
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_MAP)
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			frameVarVals = PapyrusUtil.PushString(frameVarVals, "")
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_LIST_INT)
		else
			frameVarVals = PapyrusUtil.PushString(frameVarVals, value)
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_INT)
		EndIf
    else
        if (varscope[SLT.VS_RESOLVED_MAP_KEY])
            StorageUtil.SetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_INT)
            frameVarTypes[i] = SLT.RT_MAP
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rt = GetFrameVarType(varscope)
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			If (SLT.RT_STRING == rt)
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			elseif SLT.RT_BOOL == rt
				string boolstrval
				if (value != 0)
					boolstrval = "1"
				endif
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, boolstrval)
			elseif SLT.RT_INT == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			elseif SLT.RT_FLOAT == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			elseif SLT.RT_FORM == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			elseif SLT.RT_LABEL == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			EndIf
        else
            frameVarVals[i] = value
            frameVarTypes[i] = SLT.RT_INT
        endif
	endif
	return value
EndFunction

float Function SetFrameVarFloat(string[] varscope, float value)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i < 0
		frameVarKeys = PapyrusUtil.PushString(frameVarKeys, varscope[SLT.VS_NAME])
		If (varscope[SLT.VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_FLOAT)
			frameVarVals = PapyrusUtil.PushString(frameVarVals, "")
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_MAP)
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			frameVarVals = PapyrusUtil.PushString(frameVarVals, "")
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_LIST_FLOAT)
		else
			frameVarVals = PapyrusUtil.PushString(frameVarVals, value)
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_FLOAT)
		EndIf
    else
        if (varscope[SLT.VS_RESOLVED_MAP_KEY])
            StorageUtil.SetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_FLOAT)
            frameVarTypes[i] = SLT.RT_MAP
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rt = GetFrameVarType(varscope)
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			If (SLT.RT_STRING == rt)
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			elseif SLT.RT_BOOL == rt
				string boolstrval
				if (value != 0.0)
					boolstrval = "1"
				endif
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, boolstrval)
			elseif SLT.RT_INT == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value as int)
			elseif SLT.RT_FLOAT == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			elseif SLT.RT_FORM == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value as int)
			elseif SLT.RT_LABEL == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			EndIf
        else
            frameVarVals[i] = value
            frameVarTypes[i] = SLT.RT_FLOAT
        endif
	endif
	return value
EndFunction

Form Function SetFrameVarForm(string[] varscope, Form formvalue)
	int i = frameVarKeys.Find(varscope[SLT.VS_NAME], 0)
    string value
    if formvalue
        value = formvalue.GetFormId()
    endif
	if i < 0
		frameVarKeys = PapyrusUtil.PushString(frameVarKeys, varscope[SLT.VS_NAME])
		If (varscope[SLT.VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_FORM)
			frameVarVals = PapyrusUtil.PushString(frameVarVals, "")
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_MAP)
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			frameVarVals = PapyrusUtil.PushString(frameVarVals, "")
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_LIST_FORM)
		else
			frameVarVals = PapyrusUtil.PushString(frameVarVals, value)
			frameVarTypes = PapyrusUtil.PushInt(frameVarTypes, SLT.RT_FORM)
		EndIf
    else
        if (varscope[SLT.VS_RESOLVED_MAP_KEY])
            StorageUtil.SetStringValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kframe_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_FORM)
            frameVarTypes[i] = SLT.RT_MAP
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rt = GetFrameVarType(varscope)
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			If (SLT.RT_STRING == rt)
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			elseif SLT.RT_BOOL == rt
				string boolstrval
				if (formvalue != none)
					boolstrval = "1"
				endif
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, boolstrval)
			elseif SLT.RT_INT == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			elseif SLT.RT_FLOAT == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			elseif SLT.RT_FORM == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			elseif SLT.RT_LABEL == rt
				SU_StringListSet(SLT, GetFrameListKey(varscope), rli, value)
			EndIf
        else
            frameVarVals[i] = value
            frameVarTypes[i] = SLT.RT_FORM
        endif
	endif
	return formvalue
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;; Thread
;;
bool Function HasThreadVar(string[] varscope)
    return (threadVarKeys.Find(varscope[SLT.VS_NAME], 0) > -1)
EndFunction

string function GetThreadMapKey(string[] varscope)
    return kthread_map_prefix + varscope[SLT.VS_NAME] + ":"
endfunction

string function GetThreadListKey(string[] varscope)
    return kthread_list_prefix + varscope[SLT.VS_NAME] + ":"
endfunction

int Function GetThreadVarType(string[] varscope)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = threadVarTypes[i]
        if SLT.RT_MAP == rt
			if (varscope[SLT.VS_RESOLVED_MAP_KEY])
				return StorageUtil.GetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
			elseif (!varscope[SLT.VS_MAP_KEY])
				return SLT.RT_MAP
			endif
        elseif SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				return rt - SLT.RT_LIST_TYPE_OFFSET
			endif
		    return rt
        else
		    return rt
        endif
	endif
    return SLT.RT_INVALID
EndFunction

string Function GetThreadVarString(string[] varscope, string missing)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = threadVarTypes[i]
        if SLT.RT_BOOL == rt
            return (threadVarVals[i] != "")
		elseIf SLT.RT_MAP == rt
			If (varscope[SLT.VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
				if SLT.RT_BOOL == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) != "")
				endif
				return StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
			else
        		SFW("GetThreadVar: unable to coerce map to string; did you forget a map key?")
				return missing
			EndIf
		elseIf SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
				if SLT.RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) != "")
				endif
				return StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli)
			else
        		SFW("GetThreadVar: unable to coerce list to string; did you forget a list index?")
				return missing
			endif
        endif
		return threadVarVals[i]
	endif
	return missing
EndFunction

string Function GetThreadVarLabel(string[] varscope, string missing)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = threadVarTypes[i]
        if SLT.RT_BOOL == rt
            return (threadVarVals[i] != "")
		elseIf SLT.RT_MAP == rt
			If (varscope[SLT.VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
				if SLT.RT_BOOL == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) != "")
				endif
				return StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
			else
        		SFW("GetThreadVar: unable to coerce map to label; did you forget a map key?")
				return missing
			EndIf
		elseIf SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
				if SLT.RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) != "")
				endif
				return StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli)
			else
        		SFW("GetThreadVar: unable to coerce list to label; did you forget a list index?")
				return missing
			endif
        endif
		return threadVarVals[i]
	endif
	return missing
EndFunction

bool Function GetThreadVarBool(string[] varscope, bool missing)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = threadVarTypes[i]
        if SLT.RT_BOOL == rt
            return threadVarVals[i] != ""
        elseif SLT.RT_INT == rt
            return (threadVarVals[i] as int) != 0
        elseif SLT.RT_FLOAT == rt
            return (threadVarVals[i] as float) != 0.0
        elseif SLT.RT_STRING == rt
            return threadVarVals[i] != ""
        elseIF SLT.RT_FORM == rt
            return (threadVarVals[i] as int) != 0
		elseIf SLT.RT_MAP == rt
			If (varscope[SLT.VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
				if SLT.RT_BOOL == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) != "")
				elseif SLT.RT_INT == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int) != 0
				elseif SLT.RT_FLOAT == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float) != 0.0
				elseif SLT.RT_STRING == subrt
					return StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) != ""
				elseif SLT.RT_FORM == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int) != 0
				else
					SFE("GetThreadVar: mapped var found but not recognized type(" + SLT.RT_ToString(subrt) + ")")
				endif
			else
        		SFW("GetThreadVar: unable to coerce map to bool; did you forget a map key?")
			EndIf
		elseIf SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
				if SLT.RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) != "")
				elseif SLT.RT_LIST_INT == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as int) != 0
				elseif SLT.RT_LIST_FLOAT == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as float) != 0.0
				elseif SLT.RT_LIST_STRING == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) != "")
				elseif SLT.RT_LIST_FORM == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as int) != 0
				elseif SLT.RT_LIST_LABEL == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) != "")
				else
					SFE("GetThreadVar: list var found but not recognized type(" + SLT.RT_ToString(rt - SLT.RT_LIST_TYPE_OFFSET) + ")")
				endif
			else
        		SFW("GetThreadVar: unable to coerce list to bool; did you forget a list index?")
				return missing
			endif
        else
            SFE("GetThreadVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
        endif
	endif
	return missing
EndFunction

int Function GetThreadVarInt(string[] varscope, int missing)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = threadVarTypes[i]
        if SLT.RT_BOOL == rt
            return threadVarVals[i] as int
        elseif SLT.RT_INT == rt
            return threadVarVals[i] as int
        elseif SLT.RT_FLOAT == rt
            return (threadVarVals[i] as float) as int
        elseif SLT.RT_STRING == rt
            return threadVarVals[i] as int
        elseIf SLT.RT_FORM == rt
            return threadVarVals[i] as int
		elseIf SLT.RT_MAP == rt
			If (varscope[SLT.VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
				if SLT.RT_BOOL == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int)
				elseif SLT.RT_INT == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int)
				elseif SLT.RT_FLOAT == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float) as int
				elseif SLT.RT_STRING == subrt
					return StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int
				elseif SLT.RT_FORM == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int)
				else
					SFE("GetThreadVar: mapped var found but not recognized type(" + SLT.RT_ToString(subrt) + ")")
				endif
			else
        		SFW("GetThreadVar: unable to coerce map to int; did you forget a map key?")
			EndIf
		elseIf SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
				if SLT.RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as int)
				elseif SLT.RT_LIST_INT == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as int)
				elseif SLT.RT_LIST_FLOAT == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as float) as int
				elseif SLT.RT_LIST_STRING == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as int)
				elseif SLT.RT_LIST_FORM == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as int)
				elseif SLT.RT_LIST_LABEL == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as int)
				else
					SFE("GetThreadVar: list var found but not recognized type(" + SLT.RT_ToString(rt - SLT.RT_LIST_TYPE_OFFSET) + ")")
				endif
			else
        		SFW("GetThreadVar: unable to coerce list to int; did you forget a list index?")
				return missing
			endif
        else
            SFE("GetThreadVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
        endif
	endif
	return missing
EndFunction

float Function GetThreadVarFloat(string[] varscope, float missing)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = threadVarTypes[i]
        if SLT.RT_BOOL == rt
            return threadVarVals[i] as float
        elseif SLT.RT_INT == rt
            return threadVarVals[i] as float
        elseif SLT.RT_FLOAT == rt
            return threadVarVals[i] as float
        elseif SLT.RT_STRING == rt
            return threadVarVals[i] as float
        elseIf SLT.RT_FORM == rt
            return threadVarVals[i] as float
		elseIf SLT.RT_MAP == rt
			If (varscope[SLT.VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
				if SLT.RT_BOOL == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float)
				elseif SLT.RT_INT == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float)
				elseif SLT.RT_FLOAT == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float)
				elseif SLT.RT_STRING == subrt
					return StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float
				elseif SLT.RT_FORM == subrt
					return (StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float)
				else
					SFE("GetThreadVar: mapped var found but not recognized type(" + SLT.RT_ToString(subrt) + ")")
				endif
			else
        		SFW("GetThreadVar: unable to coerce map to float; did you forget a map key?")
			EndIf
		elseIf SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
				if SLT.RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as float)
				elseif SLT.RT_LIST_INT == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as float)
				elseif SLT.RT_LIST_FLOAT == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as float)
				elseif SLT.RT_LIST_STRING == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as float)
				elseif SLT.RT_LIST_FORM == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as float)
				elseif SLT.RT_LIST_LABEL == rt
					return (StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as float)
				else
					SFE("GetThreadVar: list var found but not recognized type(" + SLT.RT_ToString(rt - SLT.RT_LIST_TYPE_OFFSET) + ")")
				endif
			else
        		SFW("GetThreadVar: unable to coerce list to float; did you forget a list index?")
				return missing
			endif
        else
            SFE("GetThreadVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
        endif
	endif
	return missing
EndFunction

Form Function GetThreadVarForm(string[] varscope, Form missing)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i > -1
        int rt = threadVarTypes[i]
        if SLT.RT_BOOL == rt
            return none
        elseif SLT.RT_INT == rt
            return sl_triggers.GetForm(threadVarVals[i])
        elseif SLT.RT_FLOAT == rt
            return sl_triggers.GetForm((threadVarVals[i] as float) as int)
        elseif SLT.RT_STRING == rt
            return sl_triggers.GetForm(threadVarVals[i])
        elseIf SLT.RT_FORM == rt
            return sl_triggers.GetForm(threadVarVals[i])
		elseIf SLT.RT_MAP == rt
			If (varscope[SLT.VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
				if SLT.RT_BOOL == subrt
					return none
				elseif SLT.RT_INT == subrt
					return sl_triggers.GetForm(StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]))
				elseif SLT.RT_FLOAT == subrt
					return sl_triggers.GetForm(StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]))
				elseif SLT.RT_STRING == subrt
					return sl_triggers.GetForm(StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]))
				elseif SLT.RT_FORM == subrt
					return sl_triggers.GetForm(StorageUtil.GetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]))
				else
					SFE("GetThreadVar: mapped var found but not recognized type(" + SLT.RT_ToString(subrt) + ")")
				endif
			else
        		SFW("GetThreadVar: unable to coerce map to label; did you forget a map key?")
			EndIf
		elseIf SLT.RT_IsList(rt)
			if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
				int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
				if SLT.RT_LIST_BOOL == rt
					return none
				elseif SLT.RT_LIST_INT == rt
					return sl_triggers.GetForm(StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli))
				elseif SLT.RT_LIST_FLOAT == rt
					return sl_triggers.GetForm((StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli) as float) as int)
				elseif SLT.RT_LIST_STRING == rt
					return sl_triggers.GetForm(StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli))
				elseif SLT.RT_LIST_FORM == rt
					return sl_triggers.GetForm(StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli))
				elseif SLT.RT_LIST_LABEL == rt
					return sl_triggers.GetForm(StorageUtil.StringListGet(SLT, GetThreadListKey(varscope), rli))
				else
					SFE("GetThreadVar: list var found but not recognized type(" + SLT.RT_ToString(rt - SLT.RT_LIST_TYPE_OFFSET) + ")")
				endif
			else
        		SFW("GetThreadVar: unable to coerce list to Form; did you forget a list index?")
				return missing
			endif
        else
            SFE("GetThreadVar: var found but not recognized type(" + SLT.RT_ToString(rt) + ")")
        endif
	endif
	return missing
EndFunction

function UnsetThreadMapKey(string[] varscope, string mapkey)
    if !mapkey
        SFW("Attempted to unset empty map key: varscope(" + SLT.VarScopeToString(varscope) + ") mapkey(" + mapkey + ")")
    else
        StorageUtil.UnsetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + mapkey)
        StorageUtil.UnsetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + mapkey)
        StorageUtil.StringListRemove(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":", mapkey)
    endif
endfunction

Function SetThreadVarType(string[] varscope, int newType)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i < 0
		threadVarKeys = PapyrusUtil.PushString(threadVarKeys, varscope[SLT.VS_NAME])
        threadVarVals = PapyrusUtil.PushString(threadVarVals, "")
        threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, newType)
    else
        threadVarVals[i] = ""
        threadVarTypes[i] = newType
    endif
EndFunction

string Function SetThreadVarString(string[] varscope, string value)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i < 0
		threadVarKeys = PapyrusUtil.PushString(threadVarKeys, varscope[SLT.VS_NAME])
		If (varscope[SLT.VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_STRING)
			threadVarVals = PapyrusUtil.PushString(threadVarVals, "")
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_MAP)
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			threadVarVals = PapyrusUtil.PushString(threadVarVals, "")
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_LIST_STRING)
		else
			threadVarVals = PapyrusUtil.PushString(threadVarVals, value)
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_STRING)
		EndIf
    else
        if (varscope[SLT.VS_RESOLVED_MAP_KEY])
            StorageUtil.SetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_STRING)
            threadVarTypes[i] = SLT.RT_MAP
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rt = GetThreadVarType(varscope)
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			If (SLT.RT_STRING == rt)
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			elseif SLT.RT_BOOL == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value != "")
			elseif SLT.RT_INT == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value as int)
			elseif SLT.RT_FLOAT == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value as float)
			elseif SLT.RT_FORM == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value as int)
			elseif SLT.RT_LABEL == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			EndIf
        else
            threadVarVals[i] = value
            threadVarTypes[i] = SLT.RT_STRING
        endif
	endif
    return value
EndFunction

string Function SetThreadVarLabel(string[] varscope, string value)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i < 0
		threadVarKeys = PapyrusUtil.PushString(threadVarKeys, varscope[SLT.VS_NAME])
		If (varscope[SLT.VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_LABEL)
			threadVarVals = PapyrusUtil.PushString(threadVarVals, "")
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_MAP)
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			threadVarVals = PapyrusUtil.PushString(threadVarVals, "")
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_LIST_LABEL)
		else
			threadVarVals = PapyrusUtil.PushString(threadVarVals, value)
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_LABEL)
		EndIf
    else
        if (varscope[SLT.VS_RESOLVED_MAP_KEY])
            StorageUtil.SetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_LABEL)
            threadVarTypes[i] = SLT.RT_MAP
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rt = GetThreadVarType(varscope)
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			If (SLT.RT_STRING == rt)
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			elseif SLT.RT_BOOL == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value != "")
			elseif SLT.RT_INT == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value as int)
			elseif SLT.RT_FLOAT == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value as float)
			elseif SLT.RT_FORM == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value as int)
			elseif SLT.RT_LABEL == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			EndIf
        else
            threadVarVals[i] = value
            threadVarTypes[i] = SLT.RT_LABEL
        endif
	endif
    return value
EndFunction

bool Function SetThreadVarBool(string[] varscope, bool boolvalue)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
    string value
    if boolvalue
        value = "1"
    endif
	if i < 0
		threadVarKeys = PapyrusUtil.PushString(threadVarKeys, varscope[SLT.VS_NAME])
		If (varscope[SLT.VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_BOOL)
			threadVarVals = PapyrusUtil.PushString(threadVarVals, "")
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_MAP)
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			threadVarVals = PapyrusUtil.PushString(threadVarVals, "")
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_LIST_BOOL)
		else
			threadVarVals = PapyrusUtil.PushString(threadVarVals, value)
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_BOOL)
		EndIf
    else
        if (varscope[SLT.VS_RESOLVED_MAP_KEY])
            StorageUtil.SetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_BOOL)
            threadVarTypes[i] = SLT.RT_MAP
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rt = GetThreadVarType(varscope)
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			If (SLT.RT_STRING == rt)
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, boolvalue)
			elseif SLT.RT_BOOL == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			elseif SLT.RT_INT == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value as int)
			elseif SLT.RT_FLOAT == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value as float)
			elseif SLT.RT_FORM == rt
				; bool->Form => none; always
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, "")
			elseif SLT.RT_LABEL == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, boolvalue)
			EndIf
        else
            threadVarVals[i] = value
            threadVarTypes[i] = SLT.RT_BOOL
        endif
	endif
	return boolvalue
EndFunction

int Function SetThreadVarInt(string[] varscope, int value)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i < 0
		threadVarKeys = PapyrusUtil.PushString(threadVarKeys, varscope[SLT.VS_NAME])
		If (varscope[SLT.VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_INT)
			threadVarVals = PapyrusUtil.PushString(threadVarVals, "")
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_MAP)
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			threadVarVals = PapyrusUtil.PushString(threadVarVals, "")
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_LIST_INT)
		else
			threadVarVals = PapyrusUtil.PushString(threadVarVals, value)
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_INT)
		EndIf
    else
        if (varscope[SLT.VS_RESOLVED_MAP_KEY])
            StorageUtil.SetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_INT)
            threadVarTypes[i] = SLT.RT_MAP
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rt = GetThreadVarType(varscope)
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			If (SLT.RT_STRING == rt)
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			elseif SLT.RT_BOOL == rt
				string boolstrval
				if (value != 0)
					boolstrval = "1"
				endif
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, boolstrval)
			elseif SLT.RT_INT == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			elseif SLT.RT_FLOAT == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			elseif SLT.RT_FORM == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			elseif SLT.RT_LABEL == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			EndIf
        else
            threadVarVals[i] = value
            threadVarTypes[i] = SLT.RT_INT
        endif
	endif
	return value
EndFunction

float Function SetThreadVarFloat(string[] varscope, float value)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
	if i < 0
		threadVarKeys = PapyrusUtil.PushString(threadVarKeys, varscope[SLT.VS_NAME])
		If (varscope[SLT.VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_FLOAT)
			threadVarVals = PapyrusUtil.PushString(threadVarVals, "")
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_MAP)
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			threadVarVals = PapyrusUtil.PushString(threadVarVals, "")
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_LIST_FLOAT)
		else
			threadVarVals = PapyrusUtil.PushString(threadVarVals, value)
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_FLOAT)
		EndIf
    else
        if (varscope[SLT.VS_RESOLVED_MAP_KEY])
            StorageUtil.SetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_FLOAT)
            threadVarTypes[i] = SLT.RT_MAP
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rt = GetThreadVarType(varscope)
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			If (SLT.RT_STRING == rt)
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			elseif SLT.RT_BOOL == rt
				string boolstrval
				if (value != 0.0)
					boolstrval = "1"
				endif
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, boolstrval)
			elseif SLT.RT_INT == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value as int)
			elseif SLT.RT_FLOAT == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			elseif SLT.RT_FORM == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value as int)
			elseif SLT.RT_LABEL == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			EndIf
        else
            threadVarVals[i] = value
            threadVarTypes[i] = SLT.RT_FLOAT
        endif
	endif
	return value
EndFunction

Form Function SetThreadVarForm(string[] varscope, Form formvalue)
	int i = threadVarKeys.Find(varscope[SLT.VS_NAME], 0)
    string value
    if formvalue
        value = formvalue.GetFormID()
    endif
	if i < 0
		threadVarKeys = PapyrusUtil.PushString(threadVarKeys, varscope[SLT.VS_NAME])
		If (varscope[SLT.VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_FORM)
			threadVarVals = PapyrusUtil.PushString(threadVarVals, "")
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_MAP)
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			threadVarVals = PapyrusUtil.PushString(threadVarVals, "")
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_LIST_FORM)
		else
			threadVarVals = PapyrusUtil.PushString(threadVarVals, value)
			threadVarTypes = PapyrusUtil.PushInt(threadVarTypes, SLT.RT_FORM)
		EndIf
    else
        if (varscope[SLT.VS_RESOLVED_MAP_KEY])
            StorageUtil.SetStringValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(SLT, kthread_map_prefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_FORM)
            threadVarTypes[i] = SLT.RT_MAP
		elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
			int rt = GetThreadVarType(varscope)
			int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
			If (SLT.RT_STRING == rt)
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			elseif SLT.RT_BOOL == rt
				string boolstrval
				if (formvalue != none)
					boolstrval = "1"
				endif
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, boolstrval)
			elseif SLT.RT_INT == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			elseif SLT.RT_FLOAT == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			elseif SLT.RT_FORM == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			elseif SLT.RT_LABEL == rt
				SU_StringListSet(SLT, GetThreadListKey(varscope), rli, value)
			EndIf
        else
            threadVarVals[i] = value
            threadVarTypes[i] = SLT.RT_FORM
        endif
	endif
	return formvalue
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;; Target
;;
bool Function HasTargetVar(string[] varscope)
    return HasIntValue(SLT, ktarget_type_v_prefix + varscope[SLT.VS_NAME])
EndFunction

string function GetTargetMapKey(string mapprefix, string[] varscope)
    return mapprefix + varscope[SLT.VS_NAME] + ":"
endfunction

string function GetTargetListKey(string mapprefix, string[] varscope)
    return mapprefix + varscope[SLT.VS_NAME] + ":"
endfunction

int Function GetTargetVarType(string typeprefix, string mapprefix, string[] varscope)
    int rt = GetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INVALID)
    if SLT.RT_MAP == rt
        if (varscope[SLT.VS_RESOLVED_MAP_KEY])
            return StorageUtil.GetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
        elseif (!varscope[SLT.VS_MAP_KEY])
            return SLT.RT_MAP
        endif
    elseif SLT.RT_IsList(rt)
        if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
            return rt - SLT.RT_LIST_TYPE_OFFSET
        endif
        return rt
    endif
    return rt
EndFunction

string Function GetTargetVarString(string typeprefix, string dataprefix, string mapprefix, string[] varscope, string missing)
    int rt = GetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INVALID)
    if SLT.RT_BOOL == rt
        return GetIntValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing as int) != 0
    elseif SLT.RT_INT == rt
        return GetIntValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing as int)
    elseif SLT.RT_FLOAT == rt
        return GetFloatValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing as float)
    elseif SLT.RT_STRING == rt
        return GetStringValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing)
    elseif SLT.RT_FORM == rt
        return GetFormValue(SLT, dataprefix + varscope[SLT.VS_NAME], none).GetFormID()
    elseif SLT.RT_LABEL == rt
        return GetStringValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing)
    elseIf SLT.RT_MAP == rt
        If (varscope[SLT.VS_RESOLVED_MAP_KEY])
            int subrt = StorageUtil.GetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
            if SLT.RT_BOOL == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) != "")
            endif
            return StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
        else
            SFW("GetTargetVar: unable to coerce map to string; did you forget a map key?")
        EndIf
    elseIf SLT.RT_IsList(rt)
        if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
            int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
            if SLT.RT_LIST_BOOL == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) != "")
            endif
            return StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli)
        else
            SFW("GetTargetVar: unable to coerce list to string; did you forget a list index?")
            return missing
        endif
    endif
    return missing
EndFunction

string Function GetTargetVarLabel(string typeprefix, string dataprefix, string mapprefix, string[] varscope, string missing)
    int rt = GetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INVALID)
    if SLT.RT_BOOL == rt
        return GetIntValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing as int) != 0
    elseif SLT.RT_INT == rt
        return GetIntValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing as int)
    elseif SLT.RT_FLOAT == rt
        return GetFloatValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing as float)
    elseif SLT.RT_STRING == rt
        return GetStringValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing)
    elseif SLT.RT_FORM == rt
        return GetFormValue(SLT, dataprefix + varscope[SLT.VS_NAME], none).GetFormID()
    elseif SLT.RT_LABEL == rt
        return GetStringValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing)
    elseIf SLT.RT_MAP == rt
        If (varscope[SLT.VS_RESOLVED_MAP_KEY])
            int subrt = StorageUtil.GetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
            if SLT.RT_BOOL == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) != "")
            endif
            return StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
        else
            SFW("GetTargetVar: unable to coerce map to label; did you forget a map key?")
        EndIf
    elseIf SLT.RT_IsList(rt)
        if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
            int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
            if SLT.RT_LIST_BOOL == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) != "")
            endif
            return StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli)
        else
            SFW("GetTargetVar: unable to coerce list to label; did you forget a list index?")
            return missing
        endif
    endif
    return missing
EndFunction

bool Function GetTargetVarBool(string typeprefix, string dataprefix, string mapprefix, string[] varscope, bool missing)
    int rt = GetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INVALID)
    if SLT.RT_BOOL == rt
        return GetIntValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing as int) != 0
    elseif SLT.RT_INT == rt
        return GetIntValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing as int) != 0
    elseif SLT.RT_FLOAT == rt
        return GetFloatValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing as float) != 0.0
    elseif SLT.RT_STRING == rt
        return (GetStringValue(SLT, dataprefix + varscope[SLT.VS_NAME], "") as int) != 0
    elseif SLT.RT_FORM == rt
        return (GetFormValue(SLT, dataprefix + varscope[SLT.VS_NAME], none).GetFormID() != 0)
    elseIf SLT.RT_MAP == rt
        If (varscope[SLT.VS_RESOLVED_MAP_KEY])
            int subrt = StorageUtil.GetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
            if SLT.RT_BOOL == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) != "")
            elseif SLT.RT_INT == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int) != 0
            elseif SLT.RT_FLOAT == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float) != 0.0
            elseif SLT.RT_STRING == subrt
                return StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) != ""
            elseif SLT.RT_FORM == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int) != 0
            else
                SFE("GetTargetVar: mapped var found but not recognized type(" + SLT.RT_ToString(subrt) + ")")
            endif
        else
            SFW("GetTargetVar: unable to coerce map to bool; did you forget a map key?")
        EndIf
    elseIf SLT.RT_IsList(rt)
        if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
            int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
            if SLT.RT_LIST_BOOL == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) != "")
            elseif SLT.RT_LIST_INT == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as int) != 0
            elseif SLT.RT_LIST_FLOAT == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as float) != 0.0
            elseif SLT.RT_LIST_STRING == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) != "")
            elseif SLT.RT_LIST_FORM == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as int) != 0
            elseif SLT.RT_LIST_LABEL == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) != "")
            else
                SFE("GetTargetVar: list var found but not recognized type(" + SLT.RT_ToString(rt - SLT.RT_LIST_TYPE_OFFSET) + ")")
            endif
        else
            SFW("GetTargetVar: unable to coerce list to bool; did you forget a list index?")
            return missing
        endif
    endif
    return missing
EndFunction

int Function GetTargetVarInt(string typeprefix, string dataprefix, string mapprefix, string[] varscope, int missing)
    int rt = GetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INVALID)
    if SLT.RT_BOOL == rt
        return GetIntValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing)
    elseif SLT.RT_INT == rt
        return GetIntValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing)
    elseif SLT.RT_FLOAT == rt
        return GetFloatValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing) as int
    elseif SLT.RT_STRING == rt
        return GetStringValue(SLT, dataprefix + varscope[SLT.VS_NAME], "") as int
    elseif SLT.RT_FORM == rt
        return GetFormValue(SLT, dataprefix + varscope[SLT.VS_NAME], none).GetFormID() as int
    elseIf SLT.RT_MAP == rt
        If (varscope[SLT.VS_RESOLVED_MAP_KEY])
            int subrt = StorageUtil.GetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
            if SLT.RT_BOOL == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int)
            elseif SLT.RT_INT == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int)
            elseif SLT.RT_FLOAT == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float) as int
            elseif SLT.RT_STRING == subrt
                return StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int
            elseif SLT.RT_FORM == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as int)
            else
                SFE("GetTargetVar: mapped var found but not recognized type(" + SLT.RT_ToString(subrt) + ")")
            endif
        else
            SFW("GetTargetVar: unable to coerce map to int; did you forget a map key?")
        EndIf
    elseIf SLT.RT_IsList(rt)
        if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
            int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
            if SLT.RT_LIST_BOOL == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as int)
            elseif SLT.RT_LIST_INT == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as int)
            elseif SLT.RT_LIST_FLOAT == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as float) as int
            elseif SLT.RT_LIST_STRING == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as int)
            elseif SLT.RT_LIST_FORM == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as int)
            elseif SLT.RT_LIST_LABEL == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as int)
            else
                SFE("GetTargetVar: list var found but not recognized type(" + SLT.RT_ToString(rt - SLT.RT_LIST_TYPE_OFFSET) + ")")
            endif
        else
            SFW("GetTargetVar: unable to coerce list to int; did you forget a list index?")
            return missing
        endif
    endif
    return missing
EndFunction

float Function GetTargetVarFloat(string typeprefix, string dataprefix, string mapprefix, string[] varscope, float missing)
    int rt = GetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INVALID)
    if SLT.RT_BOOL == rt
        return GetIntValue(SLT, dataprefix + varscope[SLT.VS_NAME], 0) as float
    elseif SLT.RT_INT == rt
        return GetIntValue(SLT, dataprefix + varscope[SLT.VS_NAME], 0) as float
    elseif SLT.RT_FLOAT == rt
        return GetFloatValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing)
    elseif SLT.RT_STRING == rt
        return GetStringValue(SLT, dataprefix + varscope[SLT.VS_NAME], "") as float
    elseif SLT.RT_FORM == rt
        return GetFormValue(SLT, dataprefix + varscope[SLT.VS_NAME], none).GetFormID() as float
    elseIf SLT.RT_MAP == rt
        If (varscope[SLT.VS_RESOLVED_MAP_KEY])
            int subrt = StorageUtil.GetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
            if SLT.RT_BOOL == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float)
            elseif SLT.RT_INT == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float)
            elseif SLT.RT_FLOAT == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float)
            elseif SLT.RT_STRING == subrt
                return StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float
            elseif SLT.RT_FORM == subrt
                return (StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]) as float)
            else
                SFE("GetTargetVar: mapped var found but not recognized type(" + SLT.RT_ToString(subrt) + ")")
            endif
        else
            SFW("GetTargetVar: unable to coerce map to float; did you forget a map key?")
        EndIf
    elseIf SLT.RT_IsList(rt)
        if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
            int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
            if SLT.RT_LIST_BOOL == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as float)
            elseif SLT.RT_LIST_INT == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as float)
            elseif SLT.RT_LIST_FLOAT == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as float)
            elseif SLT.RT_LIST_STRING == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as float)
            elseif SLT.RT_LIST_FORM == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as float)
            elseif SLT.RT_LIST_LABEL == rt
                return (StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as float)
            else
                SFE("GetTargetVar: list var found but not recognized type(" + SLT.RT_ToString(rt - SLT.RT_LIST_TYPE_OFFSET) + ")")
            endif
        else
            SFW("GetTargetVar: unable to coerce list to float; did you forget a list index?")
            return missing
        endif
    endif
    return missing
EndFunction

Form Function GetTargetVarForm(string typeprefix, string dataprefix, string mapprefix, string[] varscope, Form missing)
    int rt = GetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INVALID)
    if SLT.RT_BOOL == rt
        return none
    elseif SLT.RT_INT == rt
        return sl_triggers.GetForm(GetIntValue(SLT, dataprefix + varscope[SLT.VS_NAME], 0))
    elseif SLT.RT_FLOAT == rt
        return sl_triggers.GetForm(GetFloatValue(SLT, dataprefix + varscope[SLT.VS_NAME], 0.0) as int)
    elseif SLT.RT_STRING == rt
        return sl_triggers.GetForm(GetStringValue(SLT, dataprefix + varscope[SLT.VS_NAME], ""))
    elseif SLT.RT_FORM == rt
        return GetFormValue(SLT, dataprefix + varscope[SLT.VS_NAME], missing)
    elseIf SLT.RT_MAP == rt
        If (varscope[SLT.VS_RESOLVED_MAP_KEY])
            int subrt = StorageUtil.GetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY])
            if SLT.RT_BOOL == subrt
                return none
            elseif SLT.RT_INT == subrt
                return sl_triggers.GetForm(StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]))
            elseif SLT.RT_FLOAT == subrt
                return sl_triggers.GetForm(StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]))
            elseif SLT.RT_STRING == subrt
                return sl_triggers.GetForm(StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]))
            elseif SLT.RT_FORM == subrt
                return sl_triggers.GetForm(StorageUtil.GetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY]))
            else
                SFE("GetTargetVar: mapped var found but not recognized type(" + SLT.RT_ToString(subrt) + ")")
            endif
        else
            SFW("GetTargetVar: unable to coerce map to Form; did you forget a map key?")
        EndIf
    elseIf SLT.RT_IsList(rt)
        if (varscope[SLT.VS_RESOLVED_LIST_INDEX])
            int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
            if SLT.RT_LIST_BOOL == rt
                return none
            elseif SLT.RT_LIST_INT == rt
                return sl_triggers.GetForm(StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli))
            elseif SLT.RT_LIST_FLOAT == rt
                return sl_triggers.GetForm((StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli) as float) as int)
            elseif SLT.RT_LIST_STRING == rt
                return sl_triggers.GetForm(StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli))
            elseif SLT.RT_LIST_FORM == rt
                return sl_triggers.GetForm(StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli))
            elseif SLT.RT_LIST_LABEL == rt
                return sl_triggers.GetForm(StorageUtil.StringListGet(SLT, GetTargetListKey(mapprefix, varscope), rli))
            else
                SFE("GetTargetVar: list var found but not recognized type(" + SLT.RT_ToString(rt - SLT.RT_LIST_TYPE_OFFSET) + ")")
            endif
        else
            SFW("GetTargetVar: unable to coerce list to Form; did you forget a list index?")
            return missing
        endif
    endif
    return missing
EndFunction

function UnsetTargetMapKey(string mapprefix, string[] varscope, string mapkey)
    if !mapkey
        SFW("Attempted to unset empty map key: varscope(" + SLT.VarScopeToString(varscope) + ") mapkey(" + mapkey + ")")
    else
        StorageUtil.UnsetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + mapkey)
        StorageUtil.UnsetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + mapkey)
        StorageUtil.StringListRemove(SLT, mapprefix + varscope[SLT.VS_NAME] + ":", mapkey)
    endif
endfunction

Function SetTargetVarType(string typeprefix, string[] varscope, int newType)
    SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], newType)
EndFunction

string Function SetTargetVarString(string typeprefix, string dataprefix, string mapprefix, string[] varscope, string value)
    If (varscope[SLT.VS_RESOLVED_MAP_KEY])
        SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_MAP)
        StorageUtil.SetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_STRING)
        StorageUtil.StringListAdd(SLT, mapprefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
        SetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
    elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
        int rt = GetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INVALID)
        if !SLT.RT_IsList(rt)
            rt = SLT.RT_LIST_STRING
            SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], rt)
        endif
        int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
        if SLT.RT_LIST_STRING == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        elseif SLT.RT_BOOL == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value != "")
        elseif SLT.RT_INT == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value as int)
        elseif SLT.RT_FLOAT == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value as float)
        elseif SLT.RT_FORM == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value as int)
        elseif SLT.RT_LABEL == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        endif
    else
        SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_STRING)
        SetStringValue(SLT, dataprefix + varscope[SLT.VS_NAME], value)
    EndIf
    return value
EndFunction

string Function SetTargetVarLabel(string typeprefix, string dataprefix, string mapprefix, string[] varscope, string value)
    If (varscope[SLT.VS_RESOLVED_MAP_KEY])
        SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_MAP)
        StorageUtil.SetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_LABEL)
        StorageUtil.StringListAdd(SLT, mapprefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
        SetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
    elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
        int rt = GetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INVALID)
        if !SLT.RT_IsList(rt)
            rt = SLT.RT_LIST_LABEL
            SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], rt)
        endif
        int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
        if SLT.RT_LIST_STRING == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        elseif SLT.RT_BOOL == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value != "")
        elseif SLT.RT_INT == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value as int)
        elseif SLT.RT_FLOAT == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value as float)
        elseif SLT.RT_FORM == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value as int)
        elseif SLT.RT_LABEL == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        endif
    else
        SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_LABEL)
        SetStringValue(SLT, dataprefix + varscope[SLT.VS_NAME], value)
    EndIf
    return value
EndFunction

bool Function SetTargetVarBool(string typeprefix, string dataprefix, string mapprefix, string[] varscope, bool boolvalue)
    If (varscope[SLT.VS_RESOLVED_MAP_KEY])
        string value
        if boolvalue
            value = "1"
        endif
        SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_MAP)
        StorageUtil.SetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_BOOL)
        StorageUtil.StringListAdd(SLT, mapprefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
        SetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
    elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
        int rt = GetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INVALID)
        if !SLT.RT_IsList(rt)
            rt = SLT.RT_LIST_BOOL
            SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], rt)
        endif
        int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
        string value
        if boolvalue
            value = "1"
        endif
        if SLT.RT_LIST_STRING == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, boolvalue)
        elseif SLT.RT_BOOL == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        elseif SLT.RT_INT == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value as int)
        elseif SLT.RT_FLOAT == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value as float)
        elseif SLT.RT_FORM == rt
            ; bool->Form => none; always
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, "")
        elseif SLT.RT_LABEL == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, boolvalue)
        endif
    else
        SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_BOOL)
        SetIntValue(SLT, dataprefix + varscope[SLT.VS_NAME], boolvalue as int)
    EndIf
    return boolvalue
EndFunction

int Function SetTargetVarInt(string typeprefix, string dataprefix, string mapprefix, string[] varscope, int value)
    If (varscope[SLT.VS_RESOLVED_MAP_KEY])
        SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_MAP)
        StorageUtil.SetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_INT)
        StorageUtil.StringListAdd(SLT, mapprefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
        SetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
    elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
        int rt = GetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INVALID)
        if !SLT.RT_IsList(rt)
            rt = SLT.RT_LIST_INT
            SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], rt)
        endif
        int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
        if SLT.RT_LIST_STRING == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        elseif SLT.RT_BOOL == rt
            string boolstrval
            if (value != 0)
                boolstrval = "1"
            endif
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, boolstrval)
        elseif SLT.RT_INT == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        elseif SLT.RT_FLOAT == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        elseif SLT.RT_FORM == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        elseif SLT.RT_LABEL == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        endif
    else
        SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INT)
        SetIntValue(SLT, dataprefix + varscope[SLT.VS_NAME], value)
    EndIf
    return value
EndFunction

float Function SetTargetVarFloat(string typeprefix, string dataprefix, string mapprefix, string[] varscope, float value)
    If (varscope[SLT.VS_RESOLVED_MAP_KEY])
        SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_MAP)
        StorageUtil.SetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_FLOAT)
        StorageUtil.StringListAdd(SLT, mapprefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
        SetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
    elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
        int rt = GetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INVALID)
        if !SLT.RT_IsList(rt)
            rt = SLT.RT_LIST_FLOAT
            SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], rt)
        endif
        int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
        if SLT.RT_LIST_STRING == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        elseif SLT.RT_BOOL == rt
            string boolstrval
            if (value != 0.0)
                boolstrval = "1"
            endif
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, boolstrval)
        elseif SLT.RT_INT == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value as int)
        elseif SLT.RT_FLOAT == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        elseif SLT.RT_FORM == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value as int)
        elseif SLT.RT_LABEL == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        endif
    else
        SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_FLOAT)
        SetFloatValue(SLT, dataprefix + varscope[SLT.VS_NAME], value)
    EndIf
    return value
EndFunction

Form Function SetTargetVarForm(string typeprefix, string dataprefix, string mapprefix, string[] varscope, Form formvalue)
    If (varscope[SLT.VS_RESOLVED_MAP_KEY])
        string value
        if formvalue
            value = formvalue.GetFormID()
        endif
        SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_MAP)
        StorageUtil.SetIntValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], SLT.RT_FORM)
        StorageUtil.StringListAdd(SLT, mapprefix + varscope[SLT.VS_NAME] + ":", varscope[SLT.VS_RESOLVED_MAP_KEY], false)
        SetStringValue(SLT, mapprefix + varscope[SLT.VS_NAME] + ":" + varscope[SLT.VS_RESOLVED_MAP_KEY], value)
    elseif(varscope[SLT.VS_RESOLVED_LIST_INDEX])
        string value
        if formvalue
            value = formvalue.GetFormID()
        endif
        int rt = GetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_INVALID)
        if !SLT.RT_IsList(rt)
            rt = SLT.RT_LIST_FLOAT
            SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], rt)
        endif
        int rli = varscope[SLT.VS_RESOLVED_LIST_INDEX] as int
        if SLT.RT_LIST_STRING == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        elseif SLT.RT_BOOL == rt
            string boolstrval
            if (formvalue != none)
                boolstrval = "1"
            endif
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, boolstrval)
        elseif SLT.RT_INT == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        elseif SLT.RT_FLOAT == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        elseif SLT.RT_FORM == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        elseif SLT.RT_LABEL == rt
            SU_StringListSet(SLT, GetTargetListKey(mapprefix, varscope), rli, value)
        endif
    else
        SetIntValue(SLT, typeprefix + varscope[SLT.VS_NAME], SLT.RT_FORM)
        SetFormValue(SLT, dataprefix + varscope[SLT.VS_NAME], formvalue)
    EndIf
    return formvalue
EndFunction

;;;;
;; Support
bool Function IsAssignableScope(string varscope)
    if "local" == varscope
        if SLT.Debug_Cmd
            SFD("Cmd.IsAssignableScope: scope(" + varscope + ") is considered assignable: LOCAL")
        endif
        return true
    elseif "thread" == varscope
        if SLT.Debug_Cmd
            SFD("Cmd.IsAssignableScope: scope(" + varscope + ") is considered assignable: THREAD")
        endif
        return true
    elseif "target" == varscope
        if SLT.Debug_Cmd
            SFD("Cmd.IsAssignableScope: scope(" + varscope + ") is considered assignable: TARGET")
        endif
        return true
    elseif "global" == varscope
        if SLT.Debug_Cmd
            SFD("Cmd.IsAssignableScope: scope(" + varscope + ") is considered assignable: GLOBAL")
        endif
        return true
    endif

    if SLT.Debug_Cmd
        SFD("Cmd.IsAssignableScope: scope(" + varscope + ") is not considered assignable")
    endif
    return false
EndFunction

; these might get interesting soon
int function GetVarType(string[] varscope)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        return GetFrameVarType(varscope)
    elseif scope == "global"
        return SLT.GetGlobalVarType(varscope)
    elseif scope == "thread"
        return GetThreadVarType(varscope)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
            mapprefix = ktarget_map_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("GetVarType: typeprefix(" + typeprefix + ") varscope(" + debstrjoin(varscope, "/") + ")")
        EndIf
        return GetTargetVarType(typeprefix, mapprefix, varscope)
    endif
    SFE("GetVarType: Invalid scope(" + scope + ")")
    return SLT.RT_INVALID
endfunction

string function GetMapKey(string[] varscope)
    string scope = varscope[SLT.VS_SCOPE]

    if scope == "local"
        return GetFrameMapKey(varscope)
    elseif scope == "global"
        return SLT.GetGlobalMapKey(varscope)
    elseif scope == "thread"
        return GetThreadMapKey(varscope)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !mapprefix
            mapprefix = ktarget_map_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("GetMapKey: mapprefix(" + mapprefix + ") varscope(" + debstrjoin(varscope, "/") + ")")
        EndIf
        return GetTargetMapKey(mapprefix, varscope)
    endif
    SFE("Invalid scope for GetMapKey (" + scope + ")")
    return ""
endfunction

string function GetVarListKey(string[] varscope)
    string scope = varscope[SLT.VS_SCOPE]

    if scope == "local"
        return GetFrameListKey(varscope)
    elseif scope == "global"
        return SLT.GetGlobalListKey(varscope)
    elseif scope == "thread"
        return GetThreadListKey(varscope)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                mapprefix = Make_ktarget_list_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !mapprefix
            mapprefix = ktarget_list_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("GetVarListKey: mapprefix(" + mapprefix + ") varscope(" + debstrjoin(varscope, "/") + ")")
        EndIf
        return GetTargetListKey(mapprefix, varscope)
    endif
    SFE("Invalid scope for GetVarListKey (" + scope + ")")
    return ""
endfunction

string function GetVarString(string[] varscope, string missing)
    string scope = varscope[SLT.VS_SCOPE]

    if scope == "local"
        return GetFrameVarString(varscope, missing)
    elseif scope == "global"
        return SLT.GetGlobalVarString(self, varscope, missing)
    elseif scope == "thread"
        return GetThreadVarString(varscope, missing)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        string dataprefix
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
                dataprefix = Make_ktarget_v_prefix(formid)
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
            dataprefix = ktarget_v_prefix
            mapprefix = ktarget_map_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("GetVarString: typeprefix(" + typeprefix + ") dataprefix(" + dataprefix + ") mapprefix(" + mapprefix + ") varscope(" + debstrjoin(varscope, "/") + ")")
        EndIf
        return GetTargetVarString(typeprefix, dataprefix, mapprefix, varscope, missing)
    endif
    return missing
endfunction

string function GetVarLabel(string[] varscope, string missing)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        return GetFrameVarLabel(varscope, missing)
    elseif scope == "global"
        return SLT.GetGlobalVarLabel(self, varscope, missing)
    elseif scope == "thread"
        return GetThreadVarLabel(varscope, missing)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        string dataprefix
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
                dataprefix = Make_ktarget_v_prefix(formid)
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
            dataprefix = ktarget_v_prefix
            mapprefix = ktarget_map_prefix
        endif
        return GetTargetVarLabel(typeprefix, dataprefix, mapprefix, varscope, missing)
    endif
    return missing
endfunction

bool function GetVarBool(string[] varscope, bool missing)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        return GetFrameVarBool(varscope, missing)
    elseif scope == "global"
        return SLT.GetGlobalVarBool(self, varscope, missing)
    elseif scope == "thread"
        return GetThreadVarBool(varscope, missing)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        string dataprefix
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
                dataprefix = Make_ktarget_v_prefix(formid)
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
            dataprefix = ktarget_v_prefix
            mapprefix = ktarget_map_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("GetVarBool: typeprefix(" + typeprefix + ") dataprefix(" + dataprefix + ") varscope(" + debstrjoin(varscope, "/") + ")")
        EndIf
        return GetTargetVarBool(typeprefix, dataprefix, mapprefix, varscope, missing)
    endif
    return missing
endfunction

int function GetVarInt(string[] varscope, int missing)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        return GetFrameVarInt(varscope, missing)
    elseif scope == "global"
        return SLT.GetGlobalVarInt(self, varscope, missing)
    elseif scope == "thread"
        return GetThreadVarInt(varscope, missing)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        string dataprefix
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
                dataprefix = Make_ktarget_v_prefix(formid)
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
            dataprefix = ktarget_v_prefix
            mapprefix = ktarget_map_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("GetVarInt: typeprefix(" + typeprefix + ") dataprefix(" + dataprefix + ") varscope(" + debstrjoin(varscope, "/") + ")")
        EndIf
        return GetTargetVarInt(typeprefix, dataprefix, mapprefix, varscope, missing)
    endif
    return missing
endfunction

float function GetVarFloat(string[] varscope, float missing)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        return GetFrameVarFloat(varscope, missing)
    elseif scope == "global"
        return SLT.GetGlobalVarFloat(self, varscope, missing)
    elseif scope == "thread"
        return GetThreadVarFloat(varscope, missing)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        string dataprefix
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
                dataprefix = Make_ktarget_v_prefix(formid)
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
            dataprefix = ktarget_v_prefix
            mapprefix = ktarget_map_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("GetVarInt: typeprefix(" + typeprefix + ") dataprefix(" + dataprefix + ") varscope(" + debstrjoin(varscope, "/") + ")")
        EndIf
        return GetTargetVarFloat(typeprefix, dataprefix, mapprefix, varscope, missing)
    endif
    return missing
endfunction

Form function GetVarForm(string[] varscope, Form missing)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        return GetFrameVarForm(varscope, missing)
    elseif scope == "global"
        return SLT.GetGlobalVarForm(self, varscope, missing)
    elseif scope == "thread"
        return GetThreadVarForm(varscope, missing)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        string dataprefix
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
                dataprefix = Make_ktarget_v_prefix(formid)
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
            dataprefix = ktarget_v_prefix
            mapprefix = ktarget_map_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("GetVarInt: typeprefix(" + typeprefix + ") dataprefix(" + dataprefix + ") varscope(" + debstrjoin(varscope, "/") + ")")
        EndIf
        return GetTargetVarForm(typeprefix, dataprefix, mapprefix, varscope, missing)
    endif
    return missing
endfunction

string[] function GetVarListString(string[] varscope)
    string listKey = GetVarListKey(varscope)
    string[] values = StorageUtil.StringListToArray(SLT, listKey)
    return values
endfunction

bool[] function GetVarListBool(string[] varscope)
    string listKey = GetVarListKey(varscope)
    string[] values = StorageUtil.StringListToArray(SLT, listKey)
    bool[] retval = PapyrusUtil.BoolArray(values.Length)
    int i = values.Length
    while i
        i -= 1
        retval[i] = values[i] != ""
    endwhile
    return retval
endfunction

int[] function GetVarListInt(string[] varscope)
    string listKey = GetVarListKey(varscope)
    string[] values = StorageUtil.StringListToArray(SLT, listKey)
    int[] retval = PapyrusUtil.IntArray(values.Length)
    int i = values.Length
    while i
        i -= 1
        retval[i] = values[i] as int
    endwhile
    return retval
endfunction

float[] function GetVarListFloat(string[] varscope)
    string listKey = GetVarListKey(varscope)
    string[] values = StorageUtil.StringListToArray(SLT, listKey)
    float[] retval = PapyrusUtil.FloatArray(values.Length)
    int i = values.Length
    while i
        i -= 1
        retval[i] = values[i] as float
    endwhile
    return retval
endfunction

Form[] function GetVarListForm(string[] varscope)
    string listKey = GetVarListKey(varscope)
    string[] values = StorageUtil.StringListToArray(SLT, listKey)
    Form[] retval = PapyrusUtil.FormArray(values.Length)
    int i = values.Length
    while i
        i -= 1
        retval[i] = sl_triggers.GetForm(values[i])
    endwhile
    return retval
endfunction

string[] function GetVarListLabel(string[] varscope)
    string listKey = GetVarListKey(varscope)
    string[] values = StorageUtil.StringListToArray(SLT, listKey)
    string[] retval = PapyrusUtil.StringArray(values.Length)
    int i = values.Length
    while i
        i -= 1
        retval[i] = values[i]
    endwhile
    return retval
endfunction

function UnsetMapKey(string[] varscope, string mapkey)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        UnsetFrameMapKey(varscope, mapkey)
    elseif scope == "global"
        SLT.UnsetGlobalMapKey(self, varscope, mapkey)
    elseif scope == "thread"
        UnsetThreadMapKey(varscope, mapkey)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                mapprefix = Make_ktarget_map_prefix(targetForm.GetFormID())
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !mapprefix
            mapprefix = ktarget_map_prefix
        endif
        UnsetTargetMapKey(mapprefix, varscope, mapkey)
    else
        SFE("Attempted to unset invalid scope (" + scope + ")")
    endif
endfunction

function SetVarType(string[] varscope, int value)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        SetFrameVarType(varscope, value)
        return
    elseif scope == "global"
        SLT.SetGlobalVarType(varscope, value)
        return
    elseif scope == "thread"
        SetThreadVarType(varscope, value)
        return
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("SetTargetVarString: typeprefix(" + typeprefix + ") varscope(" + debstrjoin(varscope, "/") + ") value(" + value + ")")
        EndIf
        SetTargetVarType(typeprefix, varscope, value)
        return
    elseif scope
        SFE("Attempted to assign to read-only scope (" + scope + ")")
        return
    endif
    SFE("Invalid scope for SetVarType")
endfunction

string function SetVarString(string[] varscope, string value)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        return SetFrameVarString(varscope, value)
    elseif scope == "global"
        return SLT.SetGlobalVarString(varscope, value)
    elseif scope == "thread"
        return SetThreadVarString(varscope, value)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        string dataprefix
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
                dataprefix = Make_ktarget_v_prefix(formid)
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
            dataprefix = ktarget_v_prefix
            mapprefix = ktarget_map_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("SetTargetVarString: typeprefix(" + typeprefix + ") dataprefix(" + dataprefix + ") varscope(" + debstrjoin(varscope, "/") + ") value(" + value + ")")
        EndIf
        return SetTargetVarString(typeprefix, dataprefix, mapprefix, varscope, value)
    elseif scope
        SFE("Attempted to assign to read-only scope (" + scope + ")")
        return ""
    endif
    SFE("Invalid scope for set")
    return ""
endfunction

string function SetVarLabel(string[] varscope, string value)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        return SetFrameVarLabel(varscope, value)
    elseif scope == "global"
        return SLT.SetGlobalVarLabel(varscope, value)
    elseif scope == "thread"
        return SetThreadVarLabel(varscope, value)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        string dataprefix
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
                dataprefix = Make_ktarget_v_prefix(formid)
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
            dataprefix = ktarget_v_prefix
            mapprefix = ktarget_map_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("SetTargetSetVarLabelVarString: typeprefix(" + typeprefix + ") dataprefix(" + dataprefix + ") varscope(" + debstrjoin(varscope, "/") + ") value(" + value + ")")
        EndIf
        return SetTargetVarLabel(typeprefix, dataprefix, mapprefix, varscope, value)
    elseif scope
        SFE("Attempted to assign to read-only scope (" + scope + ")")
        return ""
    endif
    SFE("Invalid scope for set")
    return ""
endfunction

bool function SetVarBool(string[] varscope, bool value)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        return SetFrameVarBool(varscope, value)
    elseif scope == "global"
        return SLT.SetGlobalVarBool(varscope, value)
    elseif scope == "thread"
        return SetThreadVarBool(varscope, value)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        string dataprefix
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
                dataprefix = Make_ktarget_v_prefix(formid)
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
            dataprefix = ktarget_v_prefix
            mapprefix = ktarget_map_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("SetVarBool: typeprefix(" + typeprefix + ") dataprefix(" + dataprefix + ") varscope(" + debstrjoin(varscope, "/") + ") value(" + value + ")")
        EndIf
        return SetTargetVarBool(typeprefix, dataprefix, mapprefix, varscope, value)
    elseif scope
        SFE("Attempted to assign to read-only scope (" + scope + ")")
        return false
    endif
    SFE("Invalid scope for set")
    return false
endfunction

int function SetVarInt(string[] varscope, int value)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        return SetFrameVarInt(varscope, value)
    elseif scope == "global"
        return SLT.SetGlobalVarInt(varscope, value)
    elseif scope == "thread"
        return SetThreadVarInt(varscope, value)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        string dataprefix
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
                dataprefix = Make_ktarget_v_prefix(formid)
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
            dataprefix = ktarget_v_prefix
            mapprefix = ktarget_map_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("SetVarInt: typeprefix(" + typeprefix + ") dataprefix(" + dataprefix + ") varscope(" + debstrjoin(varscope, "/") + ") value(" + value + ")")
        EndIf
        return SetTargetVarInt(typeprefix, dataprefix, mapprefix, varscope, value)
    elseif scope
        SFE("Attempted to assign to read-only scope (" + scope + ")")
        return 0
    endif
    SFE("Invalid scope for set")
    return 0
endfunction

float function SetVarFloat(string[] varscope, float value)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        return SetFrameVarFloat(varscope, value)
    elseif scope == "global"
        return SLT.SetGlobalVarFloat(varscope, value)
    elseif scope == "thread"
        return SetThreadVarFloat(varscope, value)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        string dataprefix
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
                dataprefix = Make_ktarget_v_prefix(formid)
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
            dataprefix = ktarget_v_prefix
            mapprefix = ktarget_map_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("SetVarFloat: typeprefix(" + typeprefix + ") dataprefix(" + dataprefix + ") varscope(" + debstrjoin(varscope, "/") + ") value(" + value + ")")
        EndIf
        return SetTargetVarFloat(typeprefix, dataprefix, mapprefix, varscope, value)
    elseif scope
        SFE("Attempted to assign to read-only scope (" + scope + ")")
        return 0.0
    endif
    SFE("Invalid scope for set")
    return 0.0
endfunction

Form function SetVarForm(string[] varscope, Form value)
    string scope = varscope[SLT.VS_SCOPE]
    if scope == "local"
        return SetFrameVarForm(varscope, value)
    elseif scope == "global"
        return SLT.SetGlobalVarForm(varscope, value)
    elseif scope == "thread"
        return SetThreadVarForm(varscope, value)
    elseif scope == "target"
        string varname = varscope[SLT.VS_NAME]
        string typeprefix
        string dataprefix
        string mapprefix
        if varscope[SLT.VS_TARGET_EXT]
            Form targetForm = ResolveForm("$" + varscope[SLT.VS_TARGET_EXT])
            if targetForm
                int formid = targetForm.GetFormID()
                typeprefix = Make_ktarget_type_v_prefix(formid)
                dataprefix = Make_ktarget_v_prefix(formid)
                mapprefix = Make_ktarget_map_prefix(formid)
            else
                SFE("Unable to resolve target-scoped alternate target(" + varscope[SLT.VS_TARGET_EXT] + ")")
            endif
        endif
        if !typeprefix
            typeprefix = ktarget_type_v_prefix
            dataprefix = ktarget_v_prefix
            mapprefix = ktarget_map_prefix
        endif
        If (SLT.Debug_Cmd_RunScript_Set)
            SFD("SetVarForm: typeprefix(" + typeprefix + ") dataprefix(" + dataprefix + ") varscope(" + debstrjoin(varscope, "/") + ") value(" + value + ")")
        EndIf
        return SetTargetVarForm(typeprefix, dataprefix, mapprefix, varscope, value)
    elseif scope
        SFE("Attempted to assign to read-only scope (" + scope + ")")
        return none
    endif
    SFE("Invalid scope for set")
    return none
endfunction

string[] Function SetVarListString(string[] varscope, string[] values)
    string listKey = GetVarListKey(varscope)
    SetVarType(varscope, SLT.RT_LIST_STRING)
    StorageUtil.StringListCopy(SLT, listKey, values)
    return values
endfunction

bool[] Function SetVarListBool(string[] varscope, bool[] values)
    string listKey = GetVarListKey(varscope)
    SetVarType(varscope, SLT.RT_LIST_STRING)
    int i = values.Length
    string[] inputs = PapyrusUtil.StringArray(i)
    while i
        i -= 1
        if (values[i])
            inputs[i] = "1"
        endif
    endwhile
    StorageUtil.StringListCopy(SLT, listKey, inputs)
    return values
endfunction

int[] Function SetVarListInt(string[] varscope, int[] values)
    string listKey = GetVarListKey(varscope)
    SetVarType(varscope, SLT.RT_LIST_STRING)
    int i = values.Length
    string[] inputs = PapyrusUtil.StringArray(i)
    while i
        i -= 1
        inputs[i] = values[i]
    endwhile
    StorageUtil.StringListCopy(SLT, listKey, inputs)
    return values
endfunction

float[] Function SetVarListFloat(string[] varscope, float[] values)
    string listKey = GetVarListKey(varscope)
    SetVarType(varscope, SLT.RT_LIST_STRING)
    int i = values.Length
    string[] inputs = PapyrusUtil.StringArray(i)
    while i
        i -= 1
        inputs[i] = values[i]
    endwhile
    StorageUtil.StringListCopy(SLT, listKey, inputs)
    return values
endfunction

Form[] Function SetVarListForm(string[] varscope, Form[] values)
    string listKey = GetVarListKey(varscope)
    SetVarType(varscope, SLT.RT_LIST_STRING)
    int i = values.Length
    string[] inputs = PapyrusUtil.StringArray(i)
    while i
        i -= 1
        inputs[i] = values[i].GetFormID()
    endwhile
    StorageUtil.StringListCopy(SLT, listKey, inputs)
    return values
endfunction

string[] Function SetVarListLabel(string[] varscope, string[] values)
    string listKey = GetVarListKey(varscope)
    SetVarType(varscope, SLT.RT_LIST_LABEL)
    StorageUtil.StringListCopy(SLT, listKey, values)
    return values
endfunction

int Function GetRequestDataType(string _key)
    string typeprefix = krequest_type_prefix
    int output =  GetIntValue(SLT, krequest_type_prefix + _key)
    return GetIntValue(SLT, krequest_type_prefix + _key)
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

function PrecacheRequestString(sl_triggersMain slthost, int requestTargetFormId, int requestId, string varname, string value) global
    SetIntValue(slthost, Global_Make_krequest_type_prefix(requestTargetFormId, requestId) + varname, slthost.RT_STRING)
    SetStringValue(slthost, Global_Make_krequest_v_prefix(requestTargetFormId, requestId) + varname, value)
endfunction

function PrecacheRequestBool(sl_triggersMain slthost, int requestTargetFormId, int requestId, string varname, bool value) global
    SetIntValue(slthost, Global_Make_krequest_type_prefix(requestTargetFormId, requestId) + varname, slthost.RT_BOOL)
    SetIntValue(slthost, Global_Make_krequest_v_prefix(requestTargetFormId, requestId) + varname, value as int)
endfunction

function PrecacheRequestInt(sl_triggersMain slthost, int requestTargetFormId, int requestId, string varname, int value) global
    SetIntValue(slthost, Global_Make_krequest_type_prefix(requestTargetFormId, requestId) + varname, slthost.RT_INT)
    SetIntValue(slthost, Global_Make_krequest_v_prefix(requestTargetFormId, requestId) + varname, value)
endfunction

function PrecacheRequestFloat(sl_triggersMain slthost, int requestTargetFormId, int requestId, string varname, float value) global
    SetIntValue(slthost, Global_Make_krequest_type_prefix(requestTargetFormId, requestId) + varname, slthost.RT_FLOAT)
    SetFloatValue(slthost, Global_Make_krequest_v_prefix(requestTargetFormId, requestId) + varname, value)
endfunction

function PrecacheRequestForm(sl_triggersMain slthost, int requestTargetFormId, int requestId, string varname, Form value) global
    string typeprefix = Global_Make_krequest_type_prefix(requestTargetFormId, requestId)
    SetIntValue(slthost, Global_Make_krequest_type_prefix(requestTargetFormId, requestId) + varname, slthost.RT_FORM)
    SetFormValue(slthost, Global_Make_krequest_v_prefix(requestTargetFormId, requestId) + varname, value)
endfunction