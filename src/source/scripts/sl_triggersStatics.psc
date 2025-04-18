scriptname sl_triggersStatics

; DebMsg
; Shouts to the rooftops.
function DebMsg(string msg, bool shouldIDoAnything = true) global
	if !shouldIDoAnything
		return
	endif
	
	MiscUtil.WriteToFile("data/skse/plugins/sl_triggers/debugmsg.log", msg + "\n", true)
	MiscUtil.PrintConsole(msg)
	Debug.Notification(msg)
endfunction

int Function GetModVersion() global
	return 100
EndFunction

;;;;;;;;;
; ModEvent names

; SLT sends this any time the game is loaded (fresh character or save reload)
string Function EVENT_SLT_GAME_LOADED() global
	return "sl_triggers_SLTGameLoaded"
EndFunction

; SLT sends to all listeners; extensions should be auto-registered
; Do not mask this with your own handler; the base Extension script
; must be able to handle this event.
string Function EVENT_SLT_OPEN_REGISTRATION() global
	return "sl_triggers_SLTOpenRegistration"
EndFunction

; SLT sends this to itself; registration will fail if attempted once this is sent
string Function EVENT_SLT_CLOSE_REGISTRATION() global
	return "sl_triggers_SLTCloseRegistration"
EndFunction

; SLT sends this when settings have been updated
string Function EVENT_SLT_SETTINGS_UPDATED() global
	return "sl_triggers_SLTSettingsUpdated"
EndFunction

; SLT sends this when it is ready to interact with and receive events
string Function EVENT_SLT_READY() global
	return "sl_triggers_SLTReady"
EndFunction

; SLT listens for this and can send ad-hoc commands. If an Actor is not
; specified, the PlayerRef will be assumed.
string Function EVENT_SLT_REQUEST_COMMAND() global
	return "sl_triggers_SLTRequestCommand"
EndFunction

; SLT sends this event when extensions should send the shape of their
; trigger data to Setup, if they intend to let it manage their trigger data
string Function EVENT_SLT_POPULATE_MCM() global
	return "sl_triggers_SLTPopulateMCM"
EndFunction

; SLT uses these to update the hearbeat registry for the AMEs
string Function EVENT_SLT_AME_HEARTBEAT_UPDATE() global
	return "sl_triggers_SLTAMEHeartbeatUpdate"
EndFunction

;;;;;;;
; Annoying
; Registers a Quest for a mod event safely
Function SafeRegisterForModEvent_Quest(Quest _theSelf, String _theEvent, String _theHandler) global
	If _theSelf == None
		Debug.Trace("SafeRegisterForModEvent_Quest: registrar is None!")
		Return
	EndIf
	_theSelf.UnregisterForModEvent(_theEvent)
	_theSelf.RegisterForModEvent(_theEvent, _theHandler)
EndFunction

; Registers an ObjectReference for a mod event safely
Function SafeRegisterForModEvent_ObjectReference(ObjectReference _theSelf, String _theEvent, String _theHandler) global
	If _theSelf == None
		Debug.Trace("SafeRegisterForModEvent_ObjectReference: registrar is None!")
		Return
	EndIf
	_theSelf.UnregisterForModEvent(_theEvent)
	_theSelf.RegisterForModEvent(_theEvent, _theHandler)
EndFunction

; Registers an ActiveMagicEffect for a mod event safely
Function SafeRegisterForModEvent_AME(ActiveMagicEffect _theSelf, String _theEvent, String _theHandler) global
	If _theSelf == None
		Debug.Trace("SafeRegisterForModEvent_AME: registrar is None!")
		Return
	EndIf
	_theSelf.UnregisterForModEvent(_theEvent)
	_theSelf.RegisterForModEvent(_theEvent, _theHandler)
EndFunction


;;;;;;;;;
; Simple constants for Papyrus types
int Function PTYPE_STRING() global
	return 1
EndFunction

int Function PTYPE_INT() global
	return 2
EndFunction

int Function PTYPE_FLOAT() global
	return 3
EndFunction

int Function PTYPE_FORM() global
	return 4
EndFunction

;;;;;;;
; "Constants" - the "Aliens" guy
string FUNCTION DELETED_ATTRIBUTE() global
	return "trigger_deleted_by_user_via_mcm"
EndFunction


;;;;;;;;
; Global general values
string Function SettingsFolder() global
	return "../sl_triggers/"
EndFunction

string Function SettingsFilename() global
	return "settings"
EndFunction

string Function SettingsName() global
	return SettingsFolder() + SettingsFilename()
EndFunction

string Function ExtensionSettingsName(string extensionId) global
	return SettingsFolder() + extensionId
EndFunction

string Function CommandsFolder() global
	return SettingsFolder() + "commands/"
EndFunction

; I know it's tempting, but don't.
; You know what I'm talking about.
string Function ExtensionTriggersFolder(string extensionId) global
	return SettingsFolder() + extensionId + "/"
EndFunction

string Function ExtensionTriggerName(string extensionId, string triggerId) global
	return ExtensionTriggersFolder(extensionId) + triggerId
EndFunction

;;;;;;;;
; Utility functions
string Function MakeExtensionInstanceId(string extensionKey) global
	return extensionKey + "_instanceId"
EndFunction

string Function MakeInstanceKeyPrefix(string instance) global
	return "sl_triggers:" + instance
EndFunction

string Function MakeInstanceKey(string instance, string keyname) global
	return MakeInstanceKeyPrefix(instance) + ":" + keyname
EndFunction

string[] Function TokenizeLine(String line) Global 
    String[] tokens = PapyrusUtil.StringArray(0)
    String currentToken = ""
    Bool inQuotes = False
    Int i = 0
    Int len = StringUtil.GetLength(line)

    While i < len
        String c = StringUtil.Substring(line, i, 1)

        If inQuotes
            If c == "\""
                inQuotes = False
                currentToken += c
            Else
                currentToken += c
            EndIf
        Else
            ; Check for whitespace characters
            If c == " " || c == "\t"
                If currentToken != ""
                    tokens = PapyrusUtil.PushString(tokens, currentToken)
                    currentToken = ""
                EndIf
            ElseIf c == "\""
                inQuotes = True
                currentToken += c
            Else
                currentToken += c
            EndIf
        EndIf

        i += 1
    EndWhile

    ; Push the final token if any
    If currentToken != ""
        tokens = PapyrusUtil.PushString(tokens, currentToken)
    EndIf

    Return tokens
EndFunction
