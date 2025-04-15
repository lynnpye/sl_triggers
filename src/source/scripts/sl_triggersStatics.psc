scriptname sl_triggersStatics

; DebMsg
; Shouts to the rooftops.
function DebMsg(string msg, bool shouldIDoAnything = false) global
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
string Function EVENT_SLT_GAME_LOADED() global
	return "SLTGameLoaded"
EndFunction

string Function EVENT_SLT_CLOSE_REGISTRATION() global
	return "SLTCloseRegistration"
EndFunction

string Function EVENT_SLT_CORE_INIT() global
	return "SLTCoreInit"
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

; hypothetical future when an external mod taps into the trigger
; data handling framework but has not added commands, they could
; technically listen for this event.
; For now, extension authors will get this automatically: see sl_triggersExtension.SLTUpdated()
string Function EVENT_SLT_CONFIGURATION_UPDATED_INFORM_ALL_LISTENERS() global
	return "SLTConfigurationUpdatedInformAllListeners"
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
	return SettingsFolder() + extensionId + "/" + triggerId
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


