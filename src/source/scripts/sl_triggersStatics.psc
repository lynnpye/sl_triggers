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
	return 101
EndFunction

;;;;;;;;;
; ModEvent names

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

; SLT receives these from extensions for registration
string Function EVENT_SLT_REGISTER_EXTENSION() global
	return "_slt_event_slt_register_extension_"
EndFunction

;; Internal
string Function EVENT_SLT_INTERNAL_READY_EVENT() global
	return "_slt_event_slt_internal_ready_event_"
EndFunction

string Function EVENT_SLT_RESET() global
	return "_slt_event_slt_slt_reset_all_systems_"
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

string Function FullSettingsFolder() global
	return "data/SKSE/Plugins/sl_triggers/"
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

string Function FullCommandsFolder() global
	return FullSettingsFolder() + "commands/"
EndFunction

string Function ExtensionTriggersFolder(string extensionId) global
	return SettingsFolder() + extensionId + "/"
EndFunction

string Function ExtensionTriggerName(string extensionId, string triggerId) global
	return ExtensionTriggersFolder(extensionId) + triggerId
EndFunction

; Internal use only
; Do not apply externally
string Function PSEUDO_INSTANCE_KEY() global
	return "SLTADHOCINSTANCEID"
EndFunction

string Function SUKEY_GLOBAL_INSTANCE() global
	return "_slt_SUKEY_GLOBAL_INSTANCE_"
EndFunction

string Function SUKEY_EXTENSION_REGISTRATION_QUEUE() global
	return "EXTENSION_REGISTRATION_QUEUE"
EndFunction

string Function SLT_DOUBLE_ON_INIT_COUNTER() global
	return "SLT_DOUBLE_ON_INIT_COUNTER"
EndFunction

string Function EVENT_SLT_HEARTBEAT() global
	RETURN "_SLT_INTERNAL_HEARTBEAT_EVENT_DO_NOT_OVERRIDE_OR_CAPTURE_THIS_EVENT_"
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

bool Function IsTokenWhitespace(string _str) global
	bool retval = (_str == " ") || (_str == "\t")
	return retval
EndFunction

string Function TrimString(string _str) global
	if !_str
		return _str
	endif
	int pointer = 0
	int start = pointer
	int len = StringUtil.GetLength(_str)
	int end = len - 1
	string tch
	bool matched = false

	while pointer < len && !matched
		tch = StringUtil.GetNthChar(_str, pointer)
		if !IsTokenWhitespace(tch)
			start = pointer
			matched = true
		else
			pointer += 1
		endif
	endwhile

	if !matched
		return _str
	endif

	matched = false
	pointer = end
	while pointer >= 0 && !matched
		tch = StringUtil.GetNthChar(_str, pointer)
		if !IsTokenWhitespace(tch)
			end = pointer
			matched = true
		else
			pointer -= 1
		endif
	endwhile

	if !matched
		return _str
	endif

	return StringUtil.Substring(_str, start, end - start + 1)
EndFunction

string[] Function TokenizeString(string _line) global
	string[] result = PapyrusUtil.StringArray(0)
	string _str = TrimString(_line)

	int pointer = 0
	int start = 0
	int end = -1
	int len = StringUtil.GetLength(_str)
	string tch
	string peek
	bool gathering = false
	bool inquotes = false
	string _theToken
	string[] summer = new string[2]

	while pointer < len
		tch = StringUtil.GetNthChar(_str, pointer)
		if gathering
			if !inquotes
				if tch == "\""
					; bad parse, found opening quote in middle of token
					return none
				elseif IsTokenWhitespace(tch)
					gathering = false
					end = pointer - 1
					_theToken = StringUtil.Substring(_line, start, end - start + 1)
					result = PapyrusUtil.PushString(result, _theToken)
				endif
			else
				if tch == "\""
					if (pointer + 1) >= len
						gathering = false
						end = pointer - 1
						_theToken = StringUtil.Substring(_line, start, end - start + 1)
						if summer[0]
							summer[1] = _theToken
							_theToken = PapyrusUtil.StringJoin(summer, "")
						endif
						result = PapyrusUtil.PushString(result, _theToken)
						return result
					else
						peek = StringUtil.GetNthChar(_str, pointer + 1)
						if peek != "\""
							gathering = false
							end = pointer - 1
							_theToken = StringUtil.Substring(_line, start, end - start + 1)
							start = pointer + 1
							if summer[0]
								summer[1] = _theToken
								_theToken = PapyrusUtil.StringJoin(summer, "")
							endif
							result = PapyrusUtil.PushString(result, _theToken)
							summer[0] = ""
							summer[1] = ""
						else
							; start up to and including pointer
							end = pointer
							if summer[0]
								summer[1] = StringUtil.Substring(_line, start, end - start + 1)
								summer[0] = PapyrusUtil.StringJoin(summer, "")
							else
								summer[0] = StringUtil.Substring(_line, start, end - start + 1)
							endif
							pointer += 1
							start = pointer + 1
						endif
					endif
				endif
			endif
		else
			if !IsTokenWhitespace(tch)
				gathering = true
				if tch == "\""
					if (pointer + 1) >= len
						; bad parse, found opening boundary quote but EOL
						return none
					endif
					inquotes = true
					start = pointer + 1
				else
					start = pointer
				endif
			endif
		endif
		pointer += 1
	endwhile
	
	if end < start
		_theToken = StringUtil.Substring(_line, start)
		if summer[0]
			summer[1] = _theToken
			_theToken = PapyrusUtil.StringJoin(summer, "")
		endif
		result = PapyrusUtil.PushString(result, _theToken)
	endif

	return result
EndFunction
