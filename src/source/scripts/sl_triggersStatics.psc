scriptname sl_triggersStatics

function DebMsg(string msg) global
	DebMsgForce(msg, true)
endfunction

function DebMsgForce(string msg, bool shouldIDoAnything) global
	if !shouldIDoAnything
		return
	endif
	
	float tss = Utility.GetCurrentRealTime()
	tss = Math.Floor(tss * 100.0) / 100.0
	msg = (tss as string) + ": " + msg 
	MiscUtil.WriteToFile("data/skse/plugins/sl_triggers/debugmsg.log", msg + "\n", true)
	MiscUtil.PrintConsole(msg)
	;Debug.Notification(msg)
endfunction

int Function GetModVersion() global
	return 111
EndFunction

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
; ModEvent names

; SLT listens for this event.
; SendModEvent(EVENT_SLT_REQUEST_COMMAND(), "<command, required>")
; Will run the specified command with the Player as the target.
string Function EVENT_SLT_REQUEST_COMMAND() global
	return "sl_triggers_SLTRequestCommand"
EndFunction

string Function EVENT_SLT_REQUEST_LIST() global
	return "sl_triggers_SLTRequestList"
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

float Function SLT_LIST_REQUEST_SU_KEY_IS_GLOBAL() global
	return 1.7
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
; SLT Global/General
string Function CommandsFolder() global
	return "../sl_triggers/commands/"
EndFunction

string Function FullCommandsFolder() global
	return "data/SKSE/Plugins/sl_triggers/commands/"
EndFunction

string Function ExtensionTriggersFolder(string _extensionKey) global
	return "../sl_triggers/extensions/" + _extensionKey + "/"
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
Function InitSettingsFile(string filename, bool force = false) global
	if JsonUtil.JsonExists(filename) && JsonUtil.HasIntValue(filename, "enabled") && !force
		return
	endif
	JsonUtil.SetIntValue(filename, "enabled", 1)
	JsonUtil.Save(filename)
EndFunction

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



Function SquawkFunctionError(sl_triggersCmd _cmdPrimary, string msg) global
	DebMsg("SLT: [" + _cmdPrimary.cmdName + "][cmdIdx:" + _cmdPrimary.cmdIdx + "] " + msg)
EndFunction

bool Function ParamLengthLT(sl_triggersCmd _cmdPrimary, int actualLength, int neededLength) global
    if actualLength < neededLength
        SquawkFunctionError(_cmdPrimary, "insufficient parameters (needed at least " + neededLength + " but only provided " + actualLength + ")")
        return true
    endif
    return false
EndFunction

bool Function ParamLengthGT(sl_triggersCmd _cmdPrimary, int actualLength, int neededLength) global
    if actualLength < neededLength
        SquawkFunctionError(_cmdPrimary, "too many parameters (needed no more than " + neededLength + " but was provided " + actualLength + ")")
        return true
    endif
    return false
EndFunction

bool Function ParamLengthEQ(sl_triggersCmd _cmdPrimary, int actualLength, int neededLength) global
    if actualLength < neededLength
        SquawkFunctionError(_cmdPrimary, "was provided incorrect number of parameters (was provided " + actualLength + ")")
        return true
    endif
    return false
EndFunction

bool Function ParamLengthNEQ(sl_triggersCmd _cmdPrimary, int actualLength, int neededLength) global
    if actualLength < neededLength
        SquawkFunctionError(_cmdPrimary, "was provided incorrect number of parameters (needed " + neededLength + " but was provided " + actualLength + ")")
        return true
    endif
    return false
EndFunction

bool Function ParamLengthNEQ2(sl_triggersCmd _cmdPrimary, int actualLength, int neededLength, int neededLength2) global
    if actualLength < neededLength
        SquawkFunctionError(_cmdPrimary, "was provided incorrect number of parameters (needed " + neededLength + " or " + neededLength2 + " but was provided " + actualLength + ")")
        return true
    endif
    return false
EndFunction