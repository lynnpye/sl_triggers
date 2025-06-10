Scriptname sl_triggersTargetContext Hidden

; TargetContext - One per target (Actor)
; Tracks all threads and provides target-specific variables and state

; Factory functions - return handle to TargetContext object  
int function CreateEmpty() global native
int function CreateNew(Form target) global native
int function CreateForActor(Actor actor) global native

; Basic accessors
Form function GetTarget(int handle) global native
function SetTarget(int handle, Form target) global native

Actor function GetActor(int handle) global native

int function GetTargetFormID(int handle) global native

; Target variable management
string function SetTargetVar(int handle, string name, string value) global native
string function GetTargetVar(int handle, string name) global native
bool function HasTargetVar(int handle, string name) global native

; Thread management
int function GetThreadCount(int handle) global native
int function GetThread(int handle, int index) global native
function AddThread(int handle, int threadHandle) global native
bool function RemoveThread(int handle, int threadHandle) global native
bool function RemoveThreadAt(int handle, int index) global native
function ClearThreads(int handle) global native
int[] function GetAllThreads(int handle) global native
function SetAllThreads(int handle, int[] threads) global native

; Utility functions
function Destroy(int handle) global native

; Helper functions
bool function IsValid(int handle) global
    return sl_triggersForgeObject.IsValidHandle(handle)
endFunction

; Target variable helpers
function ClearTargetVar(int handle, string name) global
    SetTargetVar(handle, name, "")
endFunction

; Get target variable as integer
int function GetTargetVarAsInt(int handle, string name) global
    string value = GetTargetVar(handle, name)
    if value != ""
        return value as int
    endif
    return 0
endFunction

; Set target variable from integer
function SetTargetVarFromInt(int handle, string name, int value) global
    SetTargetVar(handle, name, value as string)
endFunction

; Get target variable as float
float function GetTargetVarAsFloat(int handle, string name) global
    string value = GetTargetVar(handle, name)
    if value != ""
        return value as float
    endif
    return 0.0
endFunction

; Set target variable from float
function SetTargetVarFromFloat(int handle, string name, float value) global
    SetTargetVar(handle, name, value as string)
endFunction

; Get target variable as boolean
bool function GetTargetVarAsBool(int handle, string name) global
    string value = GetTargetVar(handle, name)
    return value == "true" || value == "1"
endFunction

; Set target variable from boolean
function SetTargetVarFromBool(int handle, string name, bool value) global
    if value
        SetTargetVar(handle, name, "true")
    else
        SetTargetVar(handle, name, "false")
    endif
endFunction

; Thread management helpers
bool function HasThreads(int handle) global
    return GetThreadCount(handle) > 0
endFunction

; Find thread by handle
int function FindThread(int handle, int threadHandle) global
    int count = GetThreadCount(handle)
    int i = 0
    while i < count
        if GetThread(handle, i) == threadHandle
            return i
        endif
        i += 1
    endwhile
    return -1
endFunction

; Check if thread exists
bool function HasThread(int handle, int threadHandle) global
    return FindThread(handle, threadHandle) >= 0
endFunction

; Get first thread
int function GetFirstThread(int handle) global
    if GetThreadCount(handle) > 0
        return GetThread(handle, 0)
    endif
    return 0
endFunction

; Get last thread
int function GetLastThread(int handle) global
    int count = GetThreadCount(handle)
    if count > 0
        return GetThread(handle, count - 1)
    endif
    return 0
endFunction