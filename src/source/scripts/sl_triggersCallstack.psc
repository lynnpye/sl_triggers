Scriptname sl_triggersCallstack Hidden

; ===================================================================
; SLT Callstack Management System
; StorageUtil-based implementation for script execution context
; Supports: Local, Session/Thread, Actor/Target, and Global scopes
; ===================================================================

import StorageUtil
import StringUtil

; =============================================================================
; KEY GENERATION UTILITIES
; =============================================================================

; Generate base key for an instance
string Function MakeInstanceKey(string instanceId, string suffix) global
    return "slt:inst:" + instanceId + ":" + suffix
EndFunction

; Generate callstack-specific key
string Function MakeCallstackKey(string instanceId, string callstackId, string suffix) global
    return "slt:inst:" + instanceId + ":cs:" + callstackId + ":" + suffix
EndFunction

; Generate variable key for different scopes
string Function MakeVariableKey(string instanceId, string callstackId, string scope, string varName) global
    if scope == "local"
        return "slt:inst:" + instanceId + ":cs:" + callstackId + ":var:" + varName
    elseif scope == "session" || scope == "thread"
        return "slt:inst:" + instanceId + ":session:var:" + varName
    elseif scope == "actor" || scope == "target"
        return "slt:actor:var:" + varName
    elseif scope == "global"
        return "slt:global:var:" + varName
    else
        return "slt:inst:" + instanceId + ":cs:" + callstackId + ":var:" + varName ; default to local
    endif
EndFunction

; =============================================================================
; CALLSTACK MANAGEMENT
; =============================================================================

; Initialize a new callstack for an instance
string Function InitializeCallstack(Actor target, string instanceId) global
    string callstackId = "cs0"
    string baseKey = MakeInstanceKey(instanceId, "callstack_counter")
    
    ; Reset callstack counter
    SetIntValue(target, baseKey, 0)
    
    ; Initialize current callstack ID
    SetStringValue(target, MakeInstanceKey(instanceId, "current_callstack"), callstackId)
    
    ; Initialize callstack stack (for nested calls)
    ClearStringListValue(target, MakeInstanceKey(instanceId, "callstack_stack"))
    
    ; Initialize execution state
    SetIntValue(target, MakeCallstackKey(instanceId, callstackId, "cmd_idx"), 0)
    SetIntValue(target, MakeCallstackKey(instanceId, callstackId, "cmd_num"), 0)
    SetStringValue(target, MakeCallstackKey(instanceId, callstackId, "cmd_name"), "")
    SetStringValue(target, MakeCallstackKey(instanceId, callstackId, "cmd_type"), "")
    SetStringValue(target, MakeCallstackKey(instanceId, callstackId, "most_recent_result"), "")
    SetIntValue(target, MakeCallstackKey(instanceId, callstackId, "last_key"), 0)
    
    ; Initialize goto/gosub tracking
    SetIntValue(target, MakeCallstackKey(instanceId, callstackId, "goto_count"), 0)
    SetIntValue(target, MakeCallstackKey(instanceId, callstackId, "gosub_count"), 0)
    SetIntValue(target, MakeCallstackKey(instanceId, callstackId, "gosub_return_idx"), -1)
    
    ; Clear any existing goto/gosub data
    ClearStringListValue(target, MakeCallstackKey(instanceId, callstackId, "goto_labels"))
    ClearIntListValue(target, MakeCallstackKey(instanceId, callstackId, "goto_indices"))
    ClearStringListValue(target, MakeCallstackKey(instanceId, callstackId, "gosub_labels"))
    ClearIntListValue(target, MakeCallstackKey(instanceId, callstackId, "gosub_indices"))
    ClearIntListValue(target, MakeCallstackKey(instanceId, callstackId, "gosub_return_stack"))
    
    return callstackId
EndFunction

; Push a new callstack for nested script execution
string Function PushCallstack(Actor target, string instanceId, string newScriptName) global
    string currentCallstackId = GetCurrentCallstackId(target, instanceId)
    
    ; Increment callstack counter
    string counterKey = MakeInstanceKey(instanceId, "callstack_counter")
    int newCallstackNum = GetIntValue(target, counterKey, 0) + 1
    SetIntValue(target, counterKey, newCallstackNum)
    
    string newCallstackId = "cs" + newCallstackNum
    
    ; Push current callstack ID onto stack
    string stackKey = MakeInstanceKey(instanceId, "callstack_stack")
    StringListAdd(target, stackKey, currentCallstackId)
    
    ; Set new current callstack
    SetStringValue(target, MakeInstanceKey(instanceId, "current_callstack"), newCallstackId)
    
    ; Initialize new callstack
    SetIntValue(target, MakeCallstackKey(instanceId, newCallstackId, "cmd_idx"), 0)
    SetIntValue(target, MakeCallstackKey(instanceId, newCallstackId, "cmd_num"), 0)
    SetStringValue(target, MakeCallstackKey(instanceId, newCallstackId, "cmd_name"), newScriptName)
    SetStringValue(target, MakeCallstackKey(instanceId, newCallstackId, "cmd_type"), "")
    SetStringValue(target, MakeCallstackKey(instanceId, newCallstackId, "most_recent_result"), "")
    SetIntValue(target, MakeCallstackKey(instanceId, newCallstackId, "last_key"), 0)
    SetIntValue(target, MakeCallstackKey(instanceId, newCallstackId, "goto_count"), 0)
    SetIntValue(target, MakeCallstackKey(instanceId, newCallstackId, "gosub_count"), 0)
    SetIntValue(target, MakeCallstackKey(instanceId, newCallstackId, "gosub_return_idx"), -1)
    
    ; Clear collections for new callstack
    ClearStringListValue(target, MakeCallstackKey(instanceId, newCallstackId, "goto_labels"))
    ClearIntListValue(target, MakeCallstackKey(instanceId, newCallstackId, "goto_indices"))
    ClearStringListValue(target, MakeCallstackKey(instanceId, newCallstackId, "gosub_labels"))
    ClearIntListValue(target, MakeCallstackKey(instanceId, newCallstackId, "gosub_indices"))
    ClearIntListValue(target, MakeCallstackKey(instanceId, newCallstackId, "gosub_return_stack"))
    
    return newCallstackId
EndFunction

; Pop the current callstack, returning to the previous one
bool Function PopCallstack(Actor target, string instanceId) global
    string stackKey = MakeInstanceKey(instanceId, "callstack_stack")
    int stackSize = StringListCount(target, stackKey)
    
    if stackSize <= 0
        return false ; No more callstacks to pop
    endif
    
    ; Get previous callstack ID
    string previousCallstackId = StringListGet(target, stackKey, stackSize - 1)
    StringListRemoveAt(target, stackKey, stackSize - 1)
    
    ; Set as current callstack
    SetStringValue(target, MakeInstanceKey(instanceId, "current_callstack"), previousCallstackId)
    
    return true
EndFunction

; Get the current callstack ID
string Function GetCurrentCallstackId(Actor target, string instanceId) global
    return GetStringValue(target, MakeInstanceKey(instanceId, "current_callstack"), "cs0")
EndFunction

; Check if there are nested callstacks
bool Function HasNestedCallstacks(Actor target, string instanceId) global
    string stackKey = MakeInstanceKey(instanceId, "callstack_stack")
    return StringListCount(target, stackKey) > 0
EndFunction

; =============================================================================
; EXECUTION STATE MANAGEMENT
; =============================================================================

; Set/Get command index (current line of execution)
Function SetCommandIndex(Actor target, string instanceId, int index) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    SetIntValue(target, MakeCallstackKey(instanceId, callstackId, "cmd_idx"), index)
EndFunction

int Function GetCommandIndex(Actor target, string instanceId) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    return GetIntValue(target, MakeCallstackKey(instanceId, callstackId, "cmd_idx"), 0)
EndFunction

; Set/Get command count (total lines in script)
Function SetCommandCount(Actor target, string instanceId, int count) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    SetIntValue(target, MakeCallstackKey(instanceId, callstackId, "cmd_num"), count)
EndFunction

int Function GetCommandCount(Actor target, string instanceId) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    return GetIntValue(target, MakeCallstackKey(instanceId, callstackId, "cmd_num"), 0)
EndFunction

; Set/Get script name
Function SetScriptName(Actor target, string instanceId, string scriptName) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    SetStringValue(target, MakeCallstackKey(instanceId, callstackId, "cmd_name"), scriptName)
EndFunction

string Function GetScriptName(Actor target, string instanceId) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    return GetStringValue(target, MakeCallstackKey(instanceId, callstackId, "cmd_name"), "")
EndFunction

; Set/Get script type (ini/json)
Function SetScriptType(Actor target, string instanceId, string scriptType) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    SetStringValue(target, MakeCallstackKey(instanceId, callstackId, "cmd_type"), scriptType)
EndFunction

string Function GetScriptType(Actor target, string instanceId) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    return GetStringValue(target, MakeCallstackKey(instanceId, callstackId, "cmd_type"), "")
EndFunction

; Set/Get most recent result
Function SetMostRecentResult(Actor target, string instanceId, string result) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    SetStringValue(target, MakeCallstackKey(instanceId, callstackId, "most_recent_result"), result)
EndFunction

string Function GetMostRecentResult(Actor target, string instanceId) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    return GetStringValue(target, MakeCallstackKey(instanceId, callstackId, "most_recent_result"), "")
EndFunction

; Set/Get last key pressed
Function SetLastKey(Actor target, string instanceId, int keyCode) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    SetIntValue(target, MakeCallstackKey(instanceId, callstackId, "last_key"), keyCode)
EndFunction

int Function GetLastKey(Actor target, string instanceId) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    return GetIntValue(target, MakeCallstackKey(instanceId, callstackId, "last_key"), 0)
EndFunction

; =============================================================================
; VARIABLE MANAGEMENT
; =============================================================================

; Parse variable scope from variable name (e.g., "$session#varname" -> "session", "varname")
string[] Function ParseVariableScope(string varName) global
    string[] result = new string[2]
    
    if StringUtil.GetNthChar(varName, 0) != "$"
        result[0] = "local"
        result[1] = varName
        return result
    endif
    
    string remaining = StringUtil.Substring(varName, 1)
    int hashPos = StringUtil.Find(remaining, "#")
    
    if hashPos >= 0
        result[0] = StringUtil.Substring(remaining, 0, hashPos)
        result[1] = StringUtil.Substring(remaining, hashPos + 1)
    else
        result[0] = "local"
        result[1] = remaining
    endif
    
    return result
EndFunction

; Set variable value with scope resolution
Function SetVariable(Actor target, string instanceId, string varName, string value) global
    string[] scopeInfo = ParseVariableScope(varName)
    string scope = scopeInfo[0]
    string actualVarName = scopeInfo[1]
    string callstackId = GetCurrentCallstackId(target, instanceId)
    
    string key = MakeVariableKey(instanceId, callstackId, scope, actualVarName)
    SetStringValue(target, key, value)
EndFunction

; Get variable value with scope resolution
string Function GetVariable(Actor target, string instanceId, string varName) global
    string[] scopeInfo = ParseVariableScope(varName)
    string scope = scopeInfo[0]
    string actualVarName = scopeInfo[1]
    string callstackId = GetCurrentCallstackId(target, instanceId)
    
    string key = MakeVariableKey(instanceId, callstackId, scope, actualVarName)
    return GetStringValue(target, key, "")
EndFunction

; Check if variable exists
bool Function HasVariable(Actor target, string instanceId, string varName) global
    string[] scopeInfo = ParseVariableScope(varName)
    string scope = scopeInfo[0]
    string actualVarName = scopeInfo[1]
    string callstackId = GetCurrentCallstackId(target, instanceId)
    
    string key = MakeVariableKey(instanceId, callstackId, scope, actualVarName)
    return HasStringValue(target, key)
EndFunction

; =============================================================================
; GOTO/GOSUB LABEL MANAGEMENT
; =============================================================================

; Add a goto label
Function AddGotoLabel(Actor target, string instanceId, int lineIndex, string label) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    
    ; Check if label already exists
    string labelsKey = MakeCallstackKey(instanceId, callstackId, "goto_labels")
    int existingIndex = StringListFind(target, labelsKey, label)
    if existingIndex >= 0
        return ; Label already exists
    endif
    
    ; Add new label
    StringListAdd(target, labelsKey, label)
    IntListAdd(target, MakeCallstackKey(instanceId, callstackId, "goto_indices"), lineIndex)
    
    ; Update count
    int count = GetIntValue(target, MakeCallstackKey(instanceId, callstackId, "goto_count"), 0)
    SetIntValue(target, MakeCallstackKey(instanceId, callstackId, "goto_count"), count + 1)
EndFunction

; Find goto label and return line index
int Function FindGotoLabel(Actor target, string instanceId, string label) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    string labelsKey = MakeCallstackKey(instanceId, callstackId, "goto_labels")
    
    int labelIndex = StringListFind(target, labelsKey, label)
    if labelIndex >= 0
        return IntListGet(target, MakeCallstackKey(instanceId, callstackId, "goto_indices"), labelIndex)
    endif
    
    return -1 ; Label not found
EndFunction

; Add a gosub label
Function AddGosubLabel(Actor target, string instanceId, int lineIndex, string label) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    
    ; Check if label already exists
    string labelsKey = MakeCallstackKey(instanceId, callstackId, "gosub_labels")
    int existingIndex = StringListFind(target, labelsKey, label)
    if existingIndex >= 0
        return ; Label already exists
    endif
    
    ; Add new label
    StringListAdd(target, labelsKey, label)
    IntListAdd(target, MakeCallstackKey(instanceId, callstackId, "gosub_indices"), lineIndex)
    
    ; Update count
    int count = GetIntValue(target, MakeCallstackKey(instanceId, callstackId, "gosub_count"), 0)
    SetIntValue(target, MakeCallstackKey(instanceId, callstackId, "gosub_count"), count + 1)
EndFunction

; Find gosub label and return line index
int Function FindGosubLabel(Actor target, string instanceId, string label) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    string labelsKey = MakeCallstackKey(instanceId, callstackId, "gosub_labels")
    
    int labelIndex = StringListFind(target, labelsKey, label)
    if labelIndex >= 0
        return IntListGet(target, MakeCallstackKey(instanceId, callstackId, "gosub_indices"), labelIndex)
    endif
    
    return -1 ; Label not found
EndFunction

; =============================================================================
; GOSUB RETURN STACK MANAGEMENT
; =============================================================================

; Push return address onto gosub stack
bool Function PushGosubReturn(Actor target, string instanceId, int returnAddress) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    string stackKey = MakeCallstackKey(instanceId, callstackId, "gosub_return_stack")
    
    IntListAdd(target, stackKey, returnAddress)
    
    ; Update return index
    int newIndex = IntListCount(target, stackKey) - 1
    SetIntValue(target, MakeCallstackKey(instanceId, callstackId, "gosub_return_idx"), newIndex)
    
    return true
EndFunction

; Pop return address from gosub stack
int Function PopGosubReturn(Actor target, string instanceId) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    string stackKey = MakeCallstackKey(instanceId, callstackId, "gosub_return_stack")
    string indexKey = MakeCallstackKey(instanceId, callstackId, "gosub_return_idx")
    
    int currentIndex = GetIntValue(target, indexKey, -1)
    if currentIndex < 0
        return -1 ; Stack is empty
    endif
    
    int returnAddress = IntListGet(target, stackKey, currentIndex)
    IntListRemoveAt(target, stackKey, currentIndex)
    SetIntValue(target, indexKey, currentIndex - 1)
    
    return returnAddress
EndFunction

; =============================================================================
; COMMAND LINE STORAGE
; =============================================================================

; Store a parsed command line
Function SetCommandLine(Actor target, string instanceId, int lineIndex, string[] tokens) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    string key = MakeCallstackKey(instanceId, callstackId, "line_" + lineIndex)
    
    ; Clear existing tokens
    ClearStringListValue(target, key)
    
    ; Add new tokens
    int i = 0
    while i < tokens.Length
        StringListAdd(target, key, tokens[i])
        i += 1
    endwhile
EndFunction

; Get a stored command line
string[] Function GetCommandLine(Actor target, string instanceId, int lineIndex) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    string key = MakeCallstackKey(instanceId, callstackId, "line_" + lineIndex)
    
    int count = StringListCount(target, key)
    string[] result = PapyrusUtil.StringArray(count)
    
    int i = 0
    while i < count
        result[i] = StringListGet(target, key, i)
        i += 1
    endwhile
    
    return result
EndFunction

; Set line number mapping (for error reporting)
Function SetLineNumberMapping(Actor target, string instanceId, int commandIndex, int actualLineNumber) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    string key = MakeCallstackKey(instanceId, callstackId, "linemap_" + commandIndex)
    SetIntValue(target, key, actualLineNumber)
EndFunction

; Get actual line number for command index
int Function GetActualLineNumber(Actor target, string instanceId, int commandIndex) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    string key = MakeCallstackKey(instanceId, callstackId, "linemap_" + commandIndex)
    return GetIntValue(target, key, commandIndex + 1) ; Default to 1-based indexing
EndFunction

; =============================================================================
; CLEANUP UTILITIES
; =============================================================================

; Clean up all data for an instance
Function CleanupInstance(Actor target, string instanceId) global
    ; This is a simplified cleanup - StorageUtil keys with the instanceId prefix
    ; will be automatically cleaned up, but for immediate cleanup we could
    ; enumerate and clear specific keys if needed
    
    ; Clear main instance data
    UnsetStringValue(target, MakeInstanceKey(instanceId, "current_callstack"))
    UnsetIntValue(target, MakeInstanceKey(instanceId, "callstack_counter"))
    ClearStringListValue(target, MakeInstanceKey(instanceId, "callstack_stack"))
    
    ; Note: Individual callstack data will be cleaned up by StorageUtil's
    ; automatic cleanup when the actor is unloaded/reloaded
EndFunction

; =============================================================================
; DEBUGGING/DIAGNOSTIC UTILITIES
; =============================================================================

; Get current execution state as debug string
string Function GetExecutionState(Actor target, string instanceId) global
    string callstackId = GetCurrentCallstackId(target, instanceId)
    string scriptName = GetScriptName(target, instanceId)
    int cmdIdx = GetCommandIndex(target, instanceId)
    int cmdNum = GetCommandCount(target, instanceId)
    int actualLine = GetActualLineNumber(target, instanceId, cmdIdx)
    
    return "[" + scriptName + ":" + actualLine + "] Command " + (cmdIdx + 1) + "/" + cmdNum + " (Callstack: " + callstackId + ")"
EndFunction