Scriptname sl_triggersThreadContext Hidden

; ThreadContext - One per script request sent to SLT
; Tracks the stack of FrameContexts for this thread
; Note: Not associated with actual C++ threads, but tracks execution path

; Factory functions - return handle to ThreadContext object
int function CreateEmpty() global native
int function CreateNew(int targetContextHandle, string initialScriptName) global native

; Basic accessors
int function GetTargetContextHandle(int handle) global native
function SetTargetContextHandle(int handle, int targetContextHandle) global native

string function GetInitialScriptName(int handle) global native
function SetInitialScriptName(int handle, string _scriptName) global native

bool function GetIsClaimed(int handle) global native
function SetIsClaimed(int handle, bool claimed) global native

bool function GetWasClaimed(int handle) global native
function SetWasClaimed(int handle, bool wasClaimed) global native

ActiveMagicEffect function GetActiveEffect(int handle) global native
function SetActiveEffect(int handle, ActiveMagicEffect ame) global native

; Thread variable management
string function SetThreadVar(int handle, string name, string value) global native
string function GetThreadVar(int handle, string name) global native
bool function HasThreadVar(int handle, string name) global native

; Frame context management
int function PushFrameContext(int handle, string _scriptName) global native
bool function PopFrameContext(int handle) global native
int function GetCurrentFrame(int handle) global native

; Call stack management
int function GetCallStackSize(int handle) global native
int function GetCallStackFrame(int handle, int index) global native

; Utility functions
function Destroy(int handle) global native

; Helper functions
bool function IsValid(int handle) global
    return sl_triggersForgeObject.IsValidHandle(handle)
endFunction

; Thread variable helpers
function ClearThreadVar(int handle, string name) global
    SetThreadVar(handle, name, "")
endFunction

; Get thread variable as integer
int function GetThreadVarAsInt(int handle, string name) global
    string value = GetThreadVar(handle, name)
    if value != ""
        return value as int
    endif
    return 0
endFunction

; Set thread variable from integer
function SetThreadVarFromInt(int handle, string name, int value) global
    SetThreadVar(handle, name, value as string)
endFunction

; Get thread variable as float
float function GetThreadVarAsFloat(int handle, string name) global
    string value = GetThreadVar(handle, name)
    if value != ""
        return value as float
    endif
    return 0.0
endFunction

; Set thread variable from float
function SetThreadVarFromFloat(int handle, string name, float value) global
    SetThreadVar(handle, name, value as string)
endFunction

; Get thread variable as boolean
bool function GetThreadVarAsBool(int handle, string name) global
    string value = GetThreadVar(handle, name)
    return value == "true" || value == "1"
endFunction

; Set thread variable from boolean
function SetThreadVarFromBool(int handle, string name, bool value) global
    if value
        SetThreadVar(handle, name, "true")
    else
        SetThreadVar(handle, name, "false")
    endif
endFunction

; Call stack helpers
bool function HasFrames(int handle) global
    return GetCallStackSize(handle) > 0
endFunction

; Get frame by index from top (0 = current frame)
int function GetFrameFromTop(int handle, int depth) global
    int stackSize = GetCallStackSize(handle)
    if depth >= 0 && depth < stackSize
        return GetCallStackFrame(handle, stackSize - 1 - depth)
    endif
    return 0
endFunction

; Get bottom frame (first frame pushed)
int function GetBottomFrame(int handle) global
    if GetCallStackSize(handle) > 0
        return GetCallStackFrame(handle, 0)
    endif
    return 0
endFunction

; Get top frame (current frame)
int function GetTopFrame(int handle) global
    return GetCurrentFrame(handle)
endFunction

; Check if call stack is empty
bool function IsCallStackEmpty(int handle) global
    return GetCallStackSize(handle) == 0
endFunction

; Get call stack depth
int function GetCallStackDepth(int handle) global
    return GetCallStackSize(handle)
endFunction