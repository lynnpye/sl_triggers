scriptname sl_triggersStatics

Function SLTDebugMsg(string msg) global
	sl_triggers_internal.LogDebug(msg)
EndFunction

Function SLTErrMsg(string msg) global
	sl_triggers_internal.LogError("\n\n!!!!!!!!!!!!!!!!!\n\n\t\t\t\t" + msg + "\n\n\n")
EndFunction

Function SLTInfoMsg(string msg) global
	sl_triggers_internal.LogInfo(msg)
EndFunction

Function SLTWarnMsg(string msg) global
	sl_triggers_internal.LogWarn(msg)
EndFunction

int Function GetModVersion() global
	return 122
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
	return "_slt_event_slt_request_list_"
EndFunction

; SLT receives these from extensions for registration
string Function EVENT_SLT_REGISTER_EXTENSION() global
	return "OnSLTRegisterExtension"
EndFunction

string Function EVENT_SLT_ON_NEW_SESSION() global
	return "_slt_event_slt_on_new_session_"
EndFunction

;; Internal
string Function EVENT_SLT_INTERNAL_READY_EVENT() global
	return "_slt_event_slt_internal_ready_event_"
EndFunction

string Function EVENT_SLT_RESET() global
	return "_slt_event_slt_slt_reset_all_systems_"
EndFunction

; SLT sends this when settings have been updated
string Function EVENT_SLT_SETTINGS_UPDATED() global
	return "_slt_event_slt_settings_updated_"
EndFunction

string Function EVENT_SLT_DELAY_START_COMMAND() global
	return "OnSLTDelayStartCommand"
EndFunction

string Function EVENT_SLTR_ON_CONTAINER_ACTIVATE() global
	return "OnSLTRContainerActivate"
EndFunction

string Function EVENT_SLTR_ON_PLAYER_CELL_CHANGE() global
	return "OnSLTRPlayerCellChange"
EndFunction

string Function EVENT_SLTR_ON_PLAYER_LOADING_SCREEN() global
	return "OnSLTRPlayerLoadingScreen"
EndFunction

float Function SLT_LIST_REQUEST_SU_KEY_IS_GLOBAL() global
	return 1.7
EndFunction

;;;;;;;
; "Constants" - the "Aliens" guy
string FUNCTION DELETED_ATTRIBUTE() global
	return "trigger_deleted_by_user_via_mcm"
EndFunction

sl_TriggersMain Function GetSLTMain() global
	return Game.GetFormFromFile(0x83F, "sl_triggers.esp") as sl_TriggersMain
EndFunction

Form Function GetForm_SLT_Main() global
	return Game.GetFormFromFile(0x83F, "sl_triggers.esp")
EndFunction

Form Function GetForm_SLT_ExtensionCore() global
	return Game.GetFormFromFile(0x83C, "sl_triggers.esp")
EndFunction

Form Function GetForm_SLT_ExtensionSexLab() global
	return Game.GetFormFromFile(0x83D, "sl_triggers.esp")
EndFunction

Form Function GetForm_Skyrim_ActorTypeNPC() global
	return Game.GetFormFromFile(0x13794, "Skyrim.esm")
EndFunction

Form Function GetForm_Skyrim_ActorTypeUndead() global
	return Game.GetFormFromFile(0x13796, "Skyrim.esm")
EndFunction

Form Function GetForm_DAK_Status() global
	return Game.GetFormFromFile(0x801, "Dynamic Activation Key.esp")
EndFunction

Form Function GetForm_DAK_HotKey() global
	return Game.GetFormFromFile(0x804, "Dynamic Activation Key.esp")
EndFunction

Form Function GetForm_SexLab_Framework() global
	return Game.GetFormFromFile(0xD62, "SexLab.esm")
EndFunction

Form Function GetForm_SexLab_AnimatingFaction() global
	return Game.GetFormFromFile(0xE50F, "SexLab.esm")
EndFunction

Form Function GetForm_DeviousDevices_zadLibs() global
	return Game.GetFormFromFile(0xF624, "Devious Devices - Integration.esm")
EndFunction

Form Function GetForm_DeviousFollowers_dfQuest() global
	return Game.GetFormFromFile(0xD62, "DeviousFollowers.esp")
EndFunction

Form Function GetForm_DeviousFollowers_MCM() global
	return Game.GetFormFromFile(0xC545, "DeviousFollowers.esp")
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

string Function FN_MoreContainersWeKnowAndLove() global
	return "../sl_triggers/containers.json"
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

Function SquawkFunctionError(sl_triggersCmd _cmdPrimary, string msg) global
	sl_triggers_internal.LogError("SLT:(" + _cmdPrimary.currentScriptName + ")[" + _cmdPrimary.lineNum + "]: " + msg)
EndFunction

bool Function ParamLengthLT(sl_triggersCmd _cmdPrimary, int actualLength, int neededLength) global
    if actualLength >= neededLength
        SquawkFunctionError(_cmdPrimary, "too many parameters (needed no more than " + neededLength + " but was provided " + actualLength + ")")
        return false
    endif
    return true
EndFunction

bool Function ParamLengthGT(sl_triggersCmd _cmdPrimary, int actualLength, int neededLength) global
    if actualLength <= neededLength
        SquawkFunctionError(_cmdPrimary, "insufficient parameters (needed at least " + neededLength + " but only provided " + actualLength + ")")
        return false
    endif
    return true
EndFunction

bool Function ParamLengthEQ(sl_triggersCmd _cmdPrimary, int actualLength, int neededLength) global
    if actualLength != neededLength
        SquawkFunctionError(_cmdPrimary, "was provided incorrect number of parameters (was provided " + actualLength + " but needed " + neededLength + ")")
        return false
    endif
    return true
EndFunction