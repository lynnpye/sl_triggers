Scriptname sl_triggersForgeObject Hidden

; Base script for all ForgeObject types
; Provides common handle-based functionality

; Note: Most ForgeObject functionality is implemented in the specific derived types
; This script primarily serves as documentation and potential future base functionality

; Common concepts:
; - All ForgeObjects use integer handles for identification
; - Handles are returned by Create functions and used by all other functions
; - Always call Destroy when done with an object to prevent memory leaks
; - Invalid handles (0) indicate null/error conditions

; Handle validation helper
bool function IsValidHandle(int handle) global
    return handle != 0
endFunction