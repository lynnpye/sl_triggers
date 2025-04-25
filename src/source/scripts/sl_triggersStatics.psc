scriptname sl_triggersStatics

; DebMsg
; Shouts to the rooftops.
function DebMsg(string msg) global
	DebMsgForce(msg, true)
endfunction

function DebMsgForce(string msg, bool shouldIDoAnything) global
	if !shouldIDoAnything
		return
	endif
	
	MiscUtil.WriteToFile("data/skse/plugins/sl_triggers/debugmsg.log", msg + "\n", true)
	MiscUtil.PrintConsole(msg)
	Debug.Notification(msg)
endfunction

int Function GetModVersion() global
	return 104
EndFunction

;;;;;;;;;
; ModEvent names

; SLT listens for this and can send ad-hoc commands. If an Actor is not
; specified, the PlayerRef will be assumed.
string Function EVENT_SLT_REQUEST_COMMAND() global
	return "sl_triggers_SLTRequestCommand"
EndFunction

; SLT receives these from extensions for registration
string Function EVENT_SLT_REGISTER_EXTENSION() global
	return "_slt_event_slt_register_extension_"
EndFunction

;; Internal
string Function EVENT_SLT_INTERNAL_READY_EVENT() global
	return "_slt_event_slt_internal_ready_event_"
EndFunction

string Function EVENT_SLT_HEARTBEAT() global
	RETURN "_SLT_INTERNAL_HEARTBEAT_EVENT_DO_NOT_OVERRIDE_OR_CAPTURE_THIS_EVENT_"
EndFunction

string Function EVENT_SLT_RESET() global
	return "_slt_event_slt_slt_reset_all_systems_"
EndFunction

; SLT sends this when settings have been updated
string Function EVENT_SLT_SETTINGS_UPDATED() global
	return "sl_triggers_SLTSettingsUpdated"
EndFunction






;/
; SLT sends this when it is ready to interact with and receive events
string Function EVENT_SLT_READY() global
	return "sl_triggers_SLTReady"
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
/;

;;;;;;;
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

string Function FullSettingsFolder() global
	return "data/SKSE/Plugins/sl_triggers/"
EndFunction

; SLT Global/General
string Function SettingsName() global
	return SettingsFolder() + SettingsFilename()
EndFunction

string Function CommandsFolder() global
	return SettingsFolder() + "commands/"
EndFunction

string Function FullCommandsFolder() global
	return FullSettingsFolder() + "commands/"
EndFunction

string Function ExtensionsFolder() global
	return SettingsFolder() + "extensions/"
EndFunction

; Extension specific
string Function ExtensionBase(string _extensionKey) global
	return ExtensionsFolder() + _extensionKey
EndFunction

string Function ExtensionSettingsName(string _extensionKey) global
	return ExtensionBase(_extensionKey) + ".json"
EndFunction

string Function ExtensionAttributesName(string _extensionKey) global
	return ExtensionBase(_extensionKey) + "/attributes"
EndFunction

string Function ExtensionTriggersFolder(string _extensionKey) global
	return ExtensionBase(_extensionKey) + "/triggers/"
EndFunction

string Function ExtensionTriggerName(string _extensionKey, string _triggerKey) global
	return ExtensionTriggersFolder(_extensionKey) + _triggerKey
EndFunction
; okay, all done



Function InitSettingsFile(string filename, bool force = false) global
	if JsonUtil.JsonExists(filename) && JsonUtil.HasIntValue(filename, "enabled") && !force
		return
	endif
	JsonUtil.SetIntValue(filename, "enabled", 1)
	JsonUtil.Save(filename)
EndFunction

string Function FN_Settings() global
	return "../sl_triggers/settings"
EndFunction

string Function FN_X_Settings(string _x) global
	if !_x
		return FN_Settings()
	endif
	return "../sl_triggers/extensions/" + _x + "-settings"
EndFunction

string Function FN_X_Attributes(string _x) global
	return "../sl_triggers/extensions/" + _x + "-attributes"
EndFunction

string Function FN_Trigger(string _x, string _t) global
	; a hack
	if !_t
		return FN_X_Settings(_x)
	endif
	return "../sl_triggers/extensions/" + _x + "/" + _t
EndFunction



;;;;;;;;
; Utility functions
int Function GlobalHexToInt(string _value) global
    int retVal
    int idx
    int iDigit
    int pos
    string sChar
    string hexChars = "0123456789ABCDEF"
    
    idx = StringUtil.GetLength(_value) - 1
    while idx >= 0
        sChar = StringUtil.GetNthChar(_value, idx)
        iDigit = StringUtil.Find(hexChars, sChar, 0)
        if iDigit >= 0
            iDigit = Math.LeftShift(iDigit, 4 * pos)
            retVal = Math.LogicalOr(retVal, iDigit)
            idx -= 1
            pos += 1
        else 
            idx = -1
        endIf
    endWhile
    
    return retVal
EndFunction

float Function GetKeepAliveTimeWithJitter(float _time, float _jitter) global
	float maxJitter = _jitter
	float minJitter = -1 * maxJitter
	return _time + Utility.RandomFloat(minJitter, maxJitter)
EndFunction

float Function DefaultGetKeepAliveTimeWithJitter(float _time) global
	float jitter = _time * 0.1
	return GetKeepAliveTimeWithJitter(_time, jitter)
EndFunction

string Function MakeExtensionInstanceId(string extensionKey) global
	return extensionKey + "_instanceId"
EndFunction

string Function MakeInstanceKeyPrefix(string instance) global
	return "sl_triggers:" + instance
EndFunction

string Function MakeInstanceKey(string instance, string keyname) global
	return MakeInstanceKeyPrefix(instance) + ":" + keyname
EndFunction

