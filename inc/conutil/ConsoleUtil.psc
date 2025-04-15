Scriptname ConsoleUtil Hidden

; Print the given message into the console
Function PrintConsole(String asText) native global
Function PrintMessage(String a_message) native global

; Execute the given command in the console
Function ExecuteCommand(String a_command) native global
Function ExecuteCommandTarget(String asCommand, ObjectReference akTargetReference) native global

; Get the currently selected reference in the console
ObjectReference Function GetSelectedReference() native global

; Set the currently selected reference in the console
Function SetSelectedReference(ObjectReference a_reference) native global

; Get the last n console messages. The stack has a maximum size of 128 messages and only includes messages send by the player
String[] Function GetConsoleMessages(int n) native global

; Get the most recent message send to the console (from any source)
String Function ReadMessage() native global

; Register to receive an event if the specified console command is used
; If partial match is true, you will receive any command that contains the specified command, otherwise only exact matches will be received
; The target reference is optional, if specified, the event will only be sent if the specified target is selected
; targeted commands such as "player.additem f 100" are treated as "additem f 100" with akTargetRef == player
bool Function RegisterForConsoleCommand(Form akForm, String asCommand, bool abPartialMatch, ObjectReference akTargetRef) native global
bool Function RegisterForConsoleCommand_Alias(Alias akAlias, String asCommand, bool abPartialMatch, ObjectReference akTargetRef) native global
bool Function RegisterForConsoleCommand_MgEff(ActiveMagicEffect akMagicEffect, String asCommand, bool abPartialMatch, ObjectReference akTargetRef) native global
Function UnregisterForConsoleCommand(Form akForm, String asCommand, ObjectReference akTarget) native global
Function UnregisterForConsoleCommand_Alias(Alias akAlias, String asCommand, ObjectReference akTarget) native global
Function UnregisterForConsoleCommand_MgEff(ActiveMagicEffect akMagicEffect, String asCommand, ObjectReference akTarget) native global

Event OnConsoleCommand(String asCommand, ObjectReference akTargetReference)
EndEvent

; The scripts API version (will return 777 or greater for ConsoleUtil Extended)
int Function GetVersion() native global
