Scriptname sl_triggersFrameContext Hidden

; FrameContext - Handle-based wrapper for script execution frame context
; Tracks local variables and state for the currently executing SLT script

; Factory functions - return handle to FrameContext object
int function CreateEmpty() global native
int function CreateNew(int threadContextHandle, string _scriptName) global native

; Basic accessors
string function GetScriptName(int handle) global native
function SetScriptName(int handle, string _scriptName) global native

int function GetCurrentLine(int handle) global native
function SetCurrentLine(int handle, int currentLine) global native

bool function GetIsReady(int handle) global native
function SetIsReady(int handle, bool isReady) global native

string function GetMostRecentResult(int handle) global native
function SetMostRecentResult(int handle, string result) global native

Actor function GetIterActor(int handle) global native
function SetIterActor(int handle, Actor actor) global native

; Local variable management
string function SetLocalVar(int handle, string name, string value) global native
string function GetLocalVar(int handle, string name) global native
bool function HasLocalVar(int handle, string name) global native

; Script token management
int function GetScriptTokenCount(int handle) global native
int function GetScriptToken(int handle, int index) global native

; Call arguments
string[] function GetCallArgs(int handle) global native
function SetCallArgs(int handle, string[] args) global native

; Utility functions
function Destroy(int handle) global native

; Helper functions
bool function IsValid(int handle) global
    return sl_triggersForgeObject.IsValidHandle(handle)
endFunction

; Get call argument count
int function GetCallArgCount(int handle) global
    string[] args = GetCallArgs(handle)
    if args
        return args.length
    endif
    return 0
endFunction

; Get specific call argument by index
string function GetCallArg(int handle, int index) global
    string[] args = GetCallArgs(handle)
    if args && index >= 0 && index < args.length
        return args[index]
    endif
    return ""
endFunction

; Add call argument
function AddCallArg(int handle, string arg) global
    string[] currentArgs = GetCallArgs(handle)
    string[] newArgs
    
    if currentArgs
        newArgs = PapyrusUtil.StringArray(currentArgs.length + 1)
        int i = 0
        while i < currentArgs.length
            newArgs[i] = currentArgs[i]
            i += 1
        endwhile
        newArgs[currentArgs.length] = arg
    else
        newArgs = new string[1]
        newArgs[0] = arg
    endif
    
    SetCallArgs(handle, newArgs)
endFunction

; Clear call arguments
function ClearCallArgs(int handle) global
    string[] emptyArgs = PapyrusUtil.StringArray(0)
    SetCallArgs(handle, emptyArgs)
endFunction

; Local variable helpers
function ClearLocalVar(int handle, string name) global
    SetLocalVar(handle, name, "")
endFunction

; Get local variable as integer
int function GetLocalVarAsInt(int handle, string name) global
    string value = GetLocalVar(handle, name)
    if value != ""
        return value as int
    endif
    return 0
endFunction

; Set local variable from integer
function SetLocalVarFromInt(int handle, string name, int value) global
    SetLocalVar(handle, name, value as string)
endFunction

; Get local variable as float
float function GetLocalVarAsFloat(int handle, string name) global
    string value = GetLocalVar(handle, name)
    if value != ""
        return value as float
    endif
    return 0.0
endFunction

; Set local variable from float
function SetLocalVarFromFloat(int handle, string name, float value) global
    SetLocalVar(handle, name, value as string)
endFunction

; Get local variable as boolean
bool function GetLocalVarAsBool(int handle, string name) global
    string value = GetLocalVar(handle, name)
    return value == "true" || value == "1"
endFunction

; Set local variable from boolean
function SetLocalVarFromBool(int handle, string name, bool value) global
    if value
        SetLocalVar(handle, name, "true")
    else
        SetLocalVar(handle, name, "false")
    endif
endFunction