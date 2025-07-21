Scriptname sl_TriggersMain extends Quest

import sl_triggersStatics

; Feature Flags
bool Property FF_VersionUpdate_Remove_EVENT_ID_PLAYER_LOADING_SCREEN = true Auto Hidden
bool Property FF_VersionUpdate_SexLab_Migrate_LOCATION_to_DEEPLOCATION = true Auto Hidden

; CONSTANTS
int		SLT_HEARTBEAT					= 0
int		SLT_BOOTSTRAPPING				= 100

int		REGISTRATION_BEACON_COUNT		= 15

; Properties
Actor               Property PlayerRef				Auto
sl_triggersSetup	Property SLTMCM					Auto

sl_triggersPlayerOnLoadGameHandler Property SLTPLYREF Auto Hidden

Keyword Property LocTypePlayerHome  Auto 
Keyword Property LocTypeJail  Auto 
Keyword Property LocTypeDungeon  Auto  
Keyword Property LocSetCave  Auto 
Keyword Property LocTypeDwelling  Auto  
Keyword Property LocTypeCity  Auto  
Keyword Property LocTypeTown  Auto  
Keyword Property LocTypeHabitation  Auto  
Keyword Property LocTypeDraugrCrypt  Auto  
Keyword Property LocTypeDragonPriestLair  Auto  
Keyword Property LocTypeBanditCamp  Auto  
Keyword Property LocTypeFalmerHive  Auto  
Keyword Property LocTypeVampireLair  Auto  
Keyword Property LocTypeDwarvenAutomatons  Auto  
Keyword Property LocTypeMilitaryFort  Auto  
Keyword Property LocTypeMine  Auto  
Keyword Property LocTypeInn  Auto
Keyword Property LocTypeHold Auto

Perk Property SLTRContainerPerk Auto

Keyword[] Property LocationKeywords Auto Hidden

; this is a save-unique timestamp, specifically the timestamp at the time this save was created
; (as each save gets it's own copy of the quest object, we simply store that timestamp during OnInit)
string				Property SaveTimestamp Auto Hidden

bool				Property IsResetting = false Auto Hidden
bool				Property bDebugMsg		= false	Auto Hidden
Form[]				Property Extensions				Auto Hidden
int					Property nextInstanceId			Auto Hidden
GlobalVariable 		Property GameDaysPassed Auto Hidden

int _runningScriptCount = 0
int					Property RunningScriptCount Hidden
	int Function Get()
		if (_runningScriptCount < 0)
			_runningScriptCount = 0
		endif
		return _runningScriptCount
	EndFunction
	Function Set(int value)
		if (value < 0)
			SLTWarnMsg("Main.RunningScriptCount.Set: attempted to set negative value(" + value + "); setting to 0")
			_runningScriptCount = 0
		else
			_runningScriptCount = value
		endif
	EndFunction
EndProperty

int					Property SLTRVersion = 0 Auto Hidden


; duplicated from sl_triggersCmd
int     Property RT_INVALID =   	0 AutoReadOnly
int     Property RT_STRING =    	1 AutoReadOnly
int     Property RT_BOOL =      	2 AutoReadOnly
int     Property RT_INT =       	3 AutoReadOnly
int     Property RT_FLOAT =     	4 AutoReadOnly
int     Property RT_FORM =      	5 AutoReadOnly
int		Property RT_LABEL =			6 AutoReadOnly

string Function RT_ToString(int rt_type)
    if RT_STRING == rt_type
        return "RT_STRING"
    elseif RT_INT == rt_type
        return "RT_INT"
    elseif RT_FLOAT == rt_type
        return "RT_FLOAT"
    elseif RT_BOOL == rt_type
        return "RT_BOOL"
    elseif RT_FORM == rt_type
        return "RT_FORM"
	elseif RT_LABEL == rt_type
		return "RT_LABEL"
    endif
    return "<invalid RT type: " + rt_type + ">"
EndFunction

bool Property Debug_Cmd Auto Hidden
bool Property Debug_Cmd_Functions Auto Hidden
bool Property Debug_Cmd_InternalResolve Auto Hidden
bool Property Debug_Cmd_InternalResolve_Literals Auto Hidden
bool Property Debug_Cmd_ResolveForm Auto Hidden
bool Property Debug_Cmd_RunScript Auto Hidden
bool Property Debug_Cmd_RunScript_Blocks Auto Hidden
bool Property Debug_Cmd_RunScript_If Auto Hidden
bool Property Debug_Cmd_RunScript_Labels Auto Hidden
bool Property Debug_Cmd_RunScript_Set Auto Hidden
bool Property Debug_Cmd_RunScript_While Auto Hidden
bool Property Debug_Extension Auto Hidden
bool Property Debug_Extension_Core Auto Hidden
bool Property Debug_Extension_Core_Keymapping Auto Hidden
bool Property Debug_Extension_Core_Timer Auto Hidden
bool Property Debug_Extension_Core_TopOfTheHour Auto Hidden
bool Property Debug_Extension_SexLab Auto Hidden
bool Property Debug_Extension_CustomResolveScoped Auto Hidden
bool Property Debug_Setup Auto Hidden

Function SetupSettingsFlags()
	bool flagValue

	string fns = FN_Settings()

	Debug_Setup							= GetFlag(Debug_Setup, fns, "Debug_Setup")
	
	IsEnabled							= GetFlag(Debug_Setup, fns, "enabled", true)
	bDebugMsg							= GetFlag(Debug_Setup, fns, "debugmsg")

	Debug_Cmd							= GetFlag(Debug_Setup, fns, "Debug_Cmd")
	Debug_Cmd_Functions					= GetFlag(Debug_Setup, fns, "Debug_Cmd_Functions")
	Debug_Cmd_InternalResolve			= GetFlag(Debug_Setup, fns, "Debug_Cmd_InternalResolve")
	Debug_Cmd_InternalResolve_Literals	= GetFlag(Debug_Setup, fns, "Debug_Cmd_InternalResolve_Literals")
	Debug_Cmd_ResolveForm				= GetFlag(Debug_Setup, fns, "Debug_Cmd_ResolveForm")
	Debug_Cmd_RunScript 				= GetFlag(Debug_Setup, fns, "Debug_Cmd_RunScript")
	Debug_Cmd_RunScript_Blocks			= GetFlag(Debug_Setup, fns, "Debug_Cmd_RunScript_Blocks")
	Debug_Cmd_RunScript_If				= GetFlag(Debug_Setup, fns, "Debug_Cmd_RunScript_If")
	Debug_Cmd_RunScript_Labels			= GetFlag(Debug_Setup, fns, "Debug_Cmd_RunScript_Labels")
	Debug_Cmd_RunScript_Set				= GetFlag(Debug_Setup, fns, "Debug_Cmd_RunScript_Set")
	Debug_Cmd_RunScript_While			= GetFlag(Debug_Setup, fns, "Debug_Cmd_RunScript_While")
	Debug_Extension						= GetFlag(Debug_Setup, fns, "Debug_Extension")
	Debug_Extension_Core				= GetFlag(Debug_Setup, fns, "Debug_Extension_Core")
	Debug_Extension_Core_Keymapping		= GetFlag(Debug_Setup, fns, "Debug_Extension_Core_Keymapping")
	Debug_Extension_Core_Timer			= GetFlag(Debug_Setup, fns, "Debug_Extension_Core_Timer")
	Debug_Extension_Core_TopOfTheHour	= GetFlag(Debug_Setup, fns, "Debug_Extension_Core_TopOfTheHour")
	Debug_Extension_SexLab				= GetFlag(Debug_Setup, fns, "Debug_Extension_SexLab")
	Debug_Extension_CustomResolveScoped	= GetFlag(Debug_Setup, fns, "Debug_Extension_CustomResolveScoped")
EndFunction

Float Function GetTheGameTime()
	return GameDaysPassed.GetValue()
EndFunction

; Variables
int			SLTUpdateState
int			_registrationBeaconCount

string[] global_var_keys
string[] global_var_vals
int[]    global_var_types

bool	__IsEnabled = true
bool				Property IsEnabled Hidden
	bool Function Get()
		return __IsEnabled
	EndFunction
	Function Set(bool value)
		if (value != __IsEnabled)
			__IsEnabled = value

			sl_triggersExtension ext
			int i = 0
			while i < Extensions.Length
				ext = Extensions[i] as sl_triggersExtension
				if ext
					ext.SetEnabled(ext.bEnabled)
				endif
				i += 1
			endwhile
		endif
	EndFunction
EndProperty

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Events

Event OnInit()
	SetupSettingsFlags()

	if bDebugMsg
		SLTDebugMsg("Main.OnInit")
	endif

	if !self
		return
	endif

	LocationKeywords = new Keyword[18]
	LocationKeywords[0] = LocTypePlayerHome
	LocationKeywords[1] = LocTypeJail
	LocationKeywords[2] = LocTypeDungeon
	LocationKeywords[3] = LocSetCave
	LocationKeywords[4] = LocTypeDwelling
	LocationKeywords[5] = LocTypeCity
	LocationKeywords[6] = LocTypeTown
	LocationKeywords[7] = LocTypeHabitation
	LocationKeywords[8] = LocTypeDraugrCrypt
	LocationKeywords[9] = LocTypeDragonPriestLair
	LocationKeywords[10] = LocTypeBanditCamp
	LocationKeywords[11] = LocTypeFalmerHive
	LocationKeywords[12] = LocTypeVampireLair
	LocationKeywords[13] = LocTypeDwarvenAutomatons
	LocationKeywords[14] = LocTypeMilitaryFort
	LocationKeywords[15] = LocTypeMine
	LocationKeywords[16] = LocTypeInn
	LocationKeywords[17] = LocTypeHold

	SaveTimestamp = sl_triggers.GetTimestamp()

	BootstrapSLTInit(false)
EndEvent

Function DoPlayerLoadGame()
	SetupSettingsFlags()

	if bDebugMsg
		SLTDebugMsg("Main.DoPlayerLoadGame")
	endif

	if !self
		return
	endif
	BootstrapSLTInit(false)
EndFunction

Function BootstrapSLTInit(bool bSetupFlags)
	if bSetupFlags
		SetupSettingsFlags()
	endif

	if bDebugMsg
		SLTDebugMsg("Main.BootstrapSLTInit")
	endif
	
	if !self
		return
	endif
	
	GameDaysPassed = sl_triggers.GetForm("GameDaysPassed") as GlobalVariable

	CheckVersionUpdates()

	if !global_var_keys || !global_var_vals
		global_var_keys = PapyrusUtil.StringArray(0)
		global_var_vals = PapyrusUtil.StringArray(0)
		global_var_types = PapyrusUtil.IntArray(0)
	endif

	SafeRegisterForModEvent_Quest(self, EVENT_SLT_RESET(), "OnSLTReset")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_DELAY_START_COMMAND(), "OnSLTDelayStartCommand")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REGISTER_EXTENSION(), "OnSLTRegisterExtension")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REQUEST_COMMAND(), "OnSLTRequestCommand")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REQUEST_LIST(), "OnSLTRequestList")
	
	SLTUpdateState = SLT_BOOTSTRAPPING
	_registrationBeaconCount = REGISTRATION_BEACON_COUNT
	
	int i = 0
	while i < Extensions.Length
		sl_triggersExtension sltx = Extensions[i] as sl_triggersExtension
		if !sltx
			; need to remove it from the list, it was removed from the game perhaps?
			if Extensions.Length > i + 1
				Extensions = PapyrusUtil.MergeFormArray(PapyrusUtil.SliceFormArray(Extensions, 0, i - 1), PapyrusUtil.SliceFormArray(Extensions, i + 1))
			else
				Extensions = PapyrusUtil.SliceFormArray(Extensions, 0, i - 1)
			endif
		else
			sltx.SLTInit()
			i += 1
		endif
	endwhile

	IsResetting = false

	UnregisterForUpdate()
	QueueUpdateLoop(0.01)
EndFunction

Event OnUpdate()
	if !self
		return
	endif

	; state checks
	if SLTUpdateState
		if SLTUpdateState == SLT_BOOTSTRAPPING

			SLTUpdateState = SLT_HEARTBEAT

			QueueUpdateLoop(0.1)
			return
		endif
	endif

	; SLT_HEARTBEAT == 0
	; the default fall-through case
	float afDelay = 0.25
	if _registrationBeaconCount == REGISTRATION_BEACON_COUNT
		afDelay = 0.1
	endif
	
	if _registrationBeaconCount == REGISTRATION_BEACON_COUNT - 1
		if bDebugMsg
			SLTDebugMsg("Main: Sending new session event")
		endif
		SendEventSLTOnNewSession()
	endif

	if _registrationBeaconCount > 0
		_registrationBeaconCount -= 1
		if bDebugMsg
			SLTDebugMsg("Main: Sending registration beacon")
		endif
		DoRegistrationBeacon()
	endif

	QueueUpdateLoop(afDelay)
EndEvent

Event OnSLTRegisterExtension(string _eventName, string extensionKey, float fltval, Form extensionToRegister_asForm)
	if bDebugMsg
		SLTDebugMsg("Main.OnSLTRegisterExtension extensionKey(" + extensionKey + ")")
	endif
	Quest extensionToRegister = extensionToRegister_asForm as Quest
	if !self || !extensionToRegister
		return
	endif
	sl_triggersExtension sltExtension = extensionToRegister as sl_triggersExtension
	if !sltExtension
		SLTWarnMsg("Non-sl_triggersExtension attempted registration")
		return
	endif
	DoRegistrationActivity(sltExtension)
EndEvent

Event OnSLTRequestList(string _eventName, string _storageUtilStringListKey, float _isGlobal, Form _storageUtilObj)
	if !self || !_storageUtilStringListKey
		return
	endif

	Form suAnchor = _storageUtilObj
	if _isGlobal == SLT_LIST_REQUEST_SU_KEY_IS_GLOBAL()
		suAnchor = none
	endif

	string returnEvent

	if StorageUtil.StringListCount(suAnchor, _storageUtilStringListKey) > 0
		returnEvent = StorageUtil.StringListGet(suAnchor, _storageUtilStringListKey, 0)
	endif

	string[] list = sl_triggers.GetScriptsList()
	if list.Length
		StorageUtil.StringListCopy(suAnchor, _storageUtilStringListKey, list)

		if returnEvent
			SendModEvent(returnEvent)
		endif
	endif
EndEvent

Event OnSLTRequestCommand(string _eventName, string _scriptname, float __ignored, Form _theTarget)
	if bDebugMsg
		SLTDebugMsg("Main.OnSLTRequestCommand scriptname(" + _scriptname + ") target(" + _theTarget + ")")
	endif
	if !self
		return
	endif
	if !_scriptname
		return
	endif

	StartCommand(_theTarget, _scriptname)
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Functions

Function DoRegistrationBeacon()
	if !self
		return
	endif
	SendSLTInternalReady()
EndFunction

int Function GetNextInstanceId()
	if nextInstanceId < 0
		nextInstanceId = 0
	endif
	nextInstanceId += 1
	return nextInstanceId
EndFunction

; Unfortunately this might get called repeatedly for new extensions, but
; still has to deal with the possibility of existing extensions
Function DoRegistrationActivity(sl_triggersExtension _extensionToRegister)
	if !self
		return
	endif

	if !_extensionToRegister
		return
	endif

	; our first patient
	if !Extensions
		Extensions						= PapyrusUtil.FormArray(0)
	endif

	; do we already know about you?
	int _xidx = Extensions.Find(_extensionToRegister)

	if _xidx < 0
		Extensions						= PapyrusUtil.PushForm(Extensions, _extensionToRegister)
		_xidx = Extensions.Length - 1
		
		sl_TriggersExtension f_j
		sl_TriggersExtension f_i
		Form f_swap
		int j = 0
		while j < Extensions.Length
			f_j = Extensions[j] as sl_TriggersExtension
			int i = j + 1
			while i < Extensions.Length
				f_i = Extensions[i] as sl_TriggersExtension
				if f_i.GetPriority() < f_j.GetPriority()
					f_swap = Extensions[j]
					Extensions[j] = Extensions[i]
					Extensions[i] = f_swap
				endif
				i = i + 1
			endwhile
			j = j + 1
		endwhile
	endif
	
	if SLTMCM
		int i = 0
		int j = 0
		string[] extensionFriendlyNames = PapyrusUtil.StringArray(Extensions.Length)
		string[] extensionKeys = PapyrusUtil.StringArray(Extensions.Length)
		Form[] newForms = PapyrusUtil.FormArray(Extensions.Length)
		while i < Extensions.Length
			sl_triggersExtension _ext = Extensions[i] as sl_triggersExtension

			if _ext
				extensionFriendlyNames[j] = _ext.SLTFriendlyName
				extensionKeys[j] = _ext.SLTExtensionKey
				newForms[j] = _ext
				j += 1
			endif
			
			i += 1
		endwhile

		if j < i
			extensionFriendlyNames = PapyrusUtil.ResizeStringArray(extensionFriendlyNames, j)
			extensionKeys = PapyrusUtil.ResizeStringArray(extensionKeys, j)
			newForms = PapyrusUtil.ResizeFormArray(newForms, j)
		endif
		Extensions = newForms
		
		if bDebugMsg
			SLTDebugMsg("Main: Setting extension pages for SLTMCM (" + PapyrusUtil.StringJoin(extensionFriendlyNames, "),(") + ")")
		endif
		SLTMCM.SetExtensionPages(extensionFriendlyNames, extensionKeys)
	else
		SLTErrMsg("SLTMCM is empty")
	endif
EndFunction

Function DoInMemoryReset()
	if bDebugMsg
		SLTDebugMsg("Main: Sending SLT Reset event and clearing StorageUtil for SLTR objects")
	endif
	
	IsResetting = true

	; Clear all frame and thread contexts
	SendModEvent(EVENT_SLT_RESET())

EndFunction

Event OnSLTReset(string eventName, string strArg, float numArg, Form sender)
	; Clear all target contexts
	StorageUtil.ClearAllObjPrefix(self, "SLTR:")

	; Clear global context
	global_var_keys = none
	global_var_vals = none
	global_var_types = none
	
	BootstrapSLTInit(true)
EndEvent

Function QueueUpdateLoop(float afDelay = 1.0)
	if !self
		return
	endif
	RegisterForSingleUpdate(afDelay)
EndFunction

Function SendEventSLTOnNewSession()
	if !self
		return
	endif

	int handle = ModEvent.Create(EVENT_SLT_ON_NEW_SESSION())
	ModEvent.PushInt(handle, sl_triggers.GetSessionId())
	ModEvent.Send(handle)
EndFunction

Function SendSLTInternalReady()
	if !self
		return
	endif
	SendModEvent(EVENT_SLT_INTERNAL_READY_EVENT())
EndFunction

Function SendSettingsUpdateBroadcast()
	if !self
		return
	endif
	SendModEvent(EVENT_SLT_SETTINGS_UPDATED())
EndFunction

Function SendInternalSettingsUpdateEvents()
	if !self
		return
	endif

	int i = 0
	while i < Extensions.Length
		sl_triggersExtension ext = Extensions[i] as sl_triggersExtension
		if ext
			ext._slt_RefreshTriggers()
		endif
		
		i += 1
	endwhile
	SendSettingsUpdateBroadcast()
EndFunction

sl_triggersExtension Function GetExtensionByIndex(int _index)
	return extensions[_index] as sl_triggersExtension
EndFunction

sl_triggersExtension Function GetExtensionByKey(string _extensionKey)
	int i = 0
	while i < Extensions.Length
		sl_triggersExtension slext = Extensions[i] as sl_triggersExtension
		if slext && slext.SLTExtensionKey == _extensionKey
			return slext
		endif
		i += 1
	endwhile
	return none
EndFunction

sl_triggersExtension Function GetExtensionByScope(string _scope)
	int i = 0
	while i < Extensions.Length
		sl_triggersExtension slext = Extensions[i] as sl_triggersExtension
		if slext && slext.SLTScope == _scope
			return slext
		endif
		i += 1
	endwhile
	return none
EndFunction

Event OnSLTDelayStartCommand(string eventName, string initialScriptName, float reAttemptCount, Form sender)
	Utility.Wait(1.0)
	if !sender
		return
	endif
	Actor target = sender as Actor
	if !target
		return ; not ready yet
	endif

	reAttemptCount += 1.0
	
	bool scriptStarted = sl_triggers_internal.StartScript(target, initialScriptName)
	if !scriptStarted
		if reAttemptCount > 5
			SLTWarnMsg("Reattempted script(" + initialScriptName + ") for Actor(" + target + ") attempts(" + reAttemptCount + ") - giving up")
			return
		endif
		target.SendModEvent(EVENT_SLT_DELAY_START_COMMAND(), initialScriptName, reAttemptCount)
	endif
EndEvent

bool Function HasGlobalVar(string _key)
	return (global_var_keys.Find(_key, 0) > -1)
EndFunction

int Function GetGlobalVarType(string _key)
	int i = global_var_keys.Find(_key, 0)
	if i > -1
		return global_var_types[i]
	endif
    return RT_INVALID
EndFunction

string Function GetGlobalVarString(string _key, string missing)
	int i = global_var_keys.Find(_key, 0)
	if i > -1
		int rt = global_var_types[i]
		if RT_BOOL == rt
			return (global_var_vals[i] != "")
		endif
		return global_var_vals[i]
	endif
	return missing
EndFunction

string Function GetGlobalVarLabel(string _key, string missing)
	int i = global_var_keys.Find(_key, 0)
	if i > -1
		int rt = global_var_types[i]
		if RT_BOOL == rt
			return (global_var_vals[i] != "")
		endif
		return global_var_vals[i]
	endif
	return missing
EndFunction

bool Function GetGlobalVarBool(string _key, bool missing)
	int i = global_var_keys.Find(_key, 0)
	if i > -1
        int rt = global_var_types[i]
        if RT_BOOL == rt
            return global_var_vals[i] != ""
        elseif RT_INT == rt
            return (global_var_vals[i] as int) != 0
        elseif RT_FLOAT == rt
            return (global_var_vals[i] as float) != 0
        elseif RT_STRING == rt
            return global_var_vals[i] != ""
        elseIF RT_FORM == rt
            return (global_var_vals[i] as int) != 0
        endif
        SLTErrMsg("GetGlobalVar: var found but not recognized type(" + RT_ToString(rt) + ")")
	endif
	return missing
EndFunction

int Function GetGlobalVarInt(string _key, int missing)
	int i = global_var_keys.Find(_key, 0)
	if i > -1
        int rt = global_var_types[i]
        if RT_BOOL == rt
            return global_var_vals[i] as int
        elseif RT_INT == rt
            return global_var_vals[i] as int
        elseif RT_FLOAT == rt
            return (global_var_vals[i] as float) as int
        elseif RT_STRING == rt
            return global_var_vals[i] as int
        elseIf RT_FORM == rt
            return global_var_vals[i] as int
        endif
        SLTErrMsg("GetGlobalVar: var found but not recognized type(" + RT_ToString(rt) + ")")
	endif
	return missing
EndFunction

float Function GetGlobalVarFloat(string _key, float missing)
	int i = global_var_keys.Find(_key, 0)
	if i > -1
        int rt = global_var_types[i]
        if RT_BOOL == rt
            return global_var_vals[i] as float
        elseif RT_INT == rt
            return global_var_vals[i] as float
        elseif RT_FLOAT == rt
            return global_var_vals[i] as float
        elseif RT_STRING == rt
            return global_var_vals[i] as float
        elseIf RT_FORM == rt
            return global_var_vals[i] as float
        endif
        SLTErrMsg("GetGlobalVar: var found but not recognized type(" + RT_ToString(rt) + ")")
	endif
	return missing
EndFunction

Form Function GetGlobalVarForm(string _key, Form missing)
	int i = global_var_keys.Find(_key, 0)
	if i > -1
        int rt = global_var_types[i]
        if RT_BOOL == rt
            return none
        elseif RT_INT == rt
            return sl_triggers.GetForm(global_var_vals[i])
        elseif RT_FLOAT == rt
            return sl_triggers.GetForm((global_var_vals[i] as float) as int)
        elseif RT_STRING == rt
            return sl_triggers.GetForm(global_var_vals[i])
        elseIf RT_FORM == rt
            return sl_triggers.GetForm(global_var_vals[i])
        endif
        SLTErrMsg("GetGlobalVar: var found but not recognized type(" + RT_ToString(rt) + ")")
	endif
	return missing
EndFunction

string Function SetGlobalVarString(string _key, string value)
	int i = global_var_keys.Find(_key, 0)
	if i < 0
		global_var_keys = PapyrusUtil.PushString(global_var_keys, _key)
		global_var_vals = PapyrusUtil.PushString(global_var_vals, value)
		global_var_types = PapyrusUtil.PushInt(global_var_types, RT_STRING)
	else
		global_var_vals[i] = value
		global_var_types[i] = RT_STRING
	endif
	return value
EndFunction

string Function SetGlobalVarLabel(string _key, string value)
	int i = global_var_keys.Find(_key, 0)
	if i < 0
		global_var_keys = PapyrusUtil.PushString(global_var_keys, _key)
		global_var_vals = PapyrusUtil.PushString(global_var_vals, value)
		global_var_types = PapyrusUtil.PushInt(global_var_types, RT_LABEL)
	else
		global_var_vals[i] = value
		global_var_types[i] = RT_LABEL
	endif
	return value
EndFunction

bool Function SetGlobalVarBool(string _key, bool value)
	int i = global_var_keys.Find(_key, 0)
	if i < 0
		global_var_keys = PapyrusUtil.PushString(global_var_keys, _key)
		if value
        	global_var_vals = PapyrusUtil.PushString(global_var_vals, "1")
		else
        	global_var_vals = PapyrusUtil.PushString(global_var_vals, "")
		endif
        global_var_types = PapyrusUtil.PushInt(global_var_types, RT_BOOL)
    else
		if value
			global_var_vals[i] = "1"
		else
			global_var_vals[i] = ""
		endif
		global_var_types[i] = RT_BOOL
	endif
	return value
EndFunction

int Function SetGlobalVarInt(string _key, int value)
	int i = global_var_keys.Find(_key, 0)
	if i < 0
		global_var_keys = PapyrusUtil.PushString(global_var_keys, _key)
        global_var_vals = PapyrusUtil.PushString(global_var_vals, value)
        global_var_types = PapyrusUtil.PushInt(global_var_types, RT_INT)
    else
		global_var_vals[i] = value
		global_var_types[i] = RT_INT
	endif
	return value
EndFunction

float Function SetGlobalVarFloat(string _key, float value)
	int i = global_var_keys.Find(_key, 0)
	if i < 0
		global_var_keys = PapyrusUtil.PushString(global_var_keys, _key)
        global_var_vals = PapyrusUtil.PushString(global_var_vals, value)
        global_var_types = PapyrusUtil.PushInt(global_var_types, RT_FLOAT)
    else
		global_var_vals[i] = value
		global_var_types[i] = RT_FLOAT
	endif
	return value
EndFunction

Form Function SetGlobalVarForm(string _key, Form value)
	int i = global_var_keys.Find(_key, 0)
	if i < 0
		global_var_keys = PapyrusUtil.PushString(global_var_keys, _key)
		if value
        	global_var_vals = PapyrusUtil.PushString(global_var_vals, value.GetFormID())
		else
        	global_var_vals = PapyrusUtil.PushString(global_var_vals, "")
		endif
        global_var_types = PapyrusUtil.PushInt(global_var_types, RT_FORM)
    else
		if value
			global_var_vals[i] = value
		else
			global_var_vals[i] = ""
		endif
		global_var_types[i] = RT_FORM
	endif
	return value
EndFunction

Function StartCommand(Form targetForm, string initialScriptName)
	if bDebugMsg
		SLTDebugMsg("Main.StartCommand targetForm(" + targetForm + ") initialScriptName(" + initialScriptName + ")")
	endif
	if !self
		return
	endif
	
	int requestId = GetNextInstanceId()
	int threadId = GetNextInstanceId()
	StartCommandWithThreadId(targetForm, initialScriptName, requestId, threadId)
EndFunction

Function PushScriptForTarget(Form targetForm, int requestId, int threadid, string initialScriptName)
	If (!targetForm || !threadid || !initialScriptName || !requestId)
		SLTErrMsg("PushScriptForTarget: Invalid arguments")
		return
	EndIf
	StorageUtil.IntListAdd(targetForm, "SLTR:pending_requestid_list", requestid)
	StorageUtil.IntListAdd(targetForm, "SLTR:pending_threadid_list", threadid)
	StorageUtil.StringListAdd(targetForm, "SLTR:pending_initialscriptname_list", initialScriptName)
EndFunction

Function PopScriptForTarget(Form targetForm, int[] requestId, int[] threadid, string[] initialScriptName)
	If (!targetForm || !threadid.Length || !initialScriptName.Length || !requestId.Length)
		SLTErrMsg("PopScriptForTarget: Invalid arguments")
		return
	EndIf
	requestid[0] = StorageUtil.IntListPop(targetForm, "SLTR:pending_requestid_list")
	threadid[0] = StorageUtil.IntListPop(targetForm, "SLTR:pending_threadid_list")
	initialScriptName[0] = StorageUtil.StringListPop(targetForm, "SLTR:pending_initialscriptname_list")
EndFunction

; StartCommand
; Form targetForm: the Actor to attach this command to
; string initialScriptName: the file to run
Function StartCommandWithThreadId(Form targetForm, string initialScriptName, int requestId, int threadid)
	if bDebugMsg
		SLTDebugMsg("Main.StartCommandWithThreadId targetForm(" + targetForm + ") initialScriptName(" + initialScriptName + ") requestId(" + requestId + ") threadId(" + threadid + ")")
	endif
	if !self
		return
	endif

	Actor target = targetForm as Actor ; for now, only Actors
	if !target
		target = PlayerRef
	endif

	PushScriptForTarget(targetForm, requestId, threadid, initialScriptName)
	
	if bDebugMsg
		SLTDebugMsg("Calling sl_triggers_internal.StartScript(target=<" + target + ">, initialScriptName=<" + initialScriptName + ">)")
	endif
	bool scriptStarted = sl_triggers_internal.StartScript(target, initialScriptName)
	if !scriptStarted
		SLTWarnMsg("Too many SLTR effects on target(" + target + "); attempting to delay script execution")
		target.SendModEvent(EVENT_SLT_DELAY_START_COMMAND(), initialScriptName, 0.0)
	else
		if bDebugMsg
			SLTDebugMsg("sl_triggers_internal.StartScript(target=<" + target + ">, initialScriptName=<" + initialScriptName + ">) reported success")
		endif
	endif
EndFunction

; flagset: bool[] - min length >= 19
; Upon return, flagset will have the following values (true if the indicated keyword is present at current location):
; [0] - no Location set
; [1] - LocTypePlayerHome
; [2] - LocTypeJail
; ...etc
Function GetLocationFlags(Location pLoc, bool[] flagset)
	if flagset.Length < (LocationKeywords.Length + 1)
		SLTErrMsg("Main.GetLocationFlags: flagset must have minimum length(" + (LocationKeywords.Length + 1) + "); not setting any flags")
		return
	endif

	flagset[0] = pLoc != none

	int i = 1
	while i < LocationKeywords.Length && i < flagset.Length
		flagset[i] = pLoc.HasKeyword(LocationKeywords[i - 1])
		i += 1
	endwhile
EndFunction

Function GetPlayerLocationFlags(bool[] flagset)
	if !PlayerRef
		SLTWarnMsg("Main.GetPlayerLocationFlags: PlayerRef(" + PlayerRef + ") is required but was not provided")
		return
	endif

	Location pLoc = PlayerRef.GetCurrentLocation()
	GetLocationFlags(pLoc, flagset)
EndFunction

Function GetActorLocationFlags(Actor theActor, bool[] flagset)
	if !theActor
		SLTWarnMsg("Main.GetActorLocationFlags: theActor(" + theActor + ") is required but was not provided")
		return
	endif

	Location pLoc = theActor.GetCurrentLocation()
	GetLocationFlags(pLoc, flagset)
EndFunction

Keyword Function GetPlayerLocationKeyword()
	Location pLoc = PlayerRef.GetCurrentLocation()
	int i = 0
	while pLoc && i < LocationKeywords.length
		if pLoc.HasKeyword(LocationKeywords[i])
			return LocationKeywords[i]
		endif
		i += 1
	endwhile
	return none
EndFunction

Keyword Function GetActorLocationKeyword(Actor theActor)
	Location pLoc = theActor.GetCurrentLocation()
	int i = 0
	while pLoc && i < LocationKeywords.length
		if pLoc.HasKeyword(LocationKeywords[i])
			return LocationKeywords[i]
		endif
		i += 1
	endwhile
	return none
EndFunction

bool Function IsFlagsetSafe(bool[] flagset)
	If (flagset.Length < (LocationKeywords.Length + 1))
		return false
	EndIf
	return flagset[1] || flagset[2] || flagset[17]
EndFunction

bool Function IsFlagsetInCity(bool[] flagset)
	If (flagset.Length < (LocationKeywords.Length + 1))
		return false
	EndIf
	return flagset[6] || flagset[7] || flagset[8] || flagset[5]
EndFunction

bool Function IsFlagsetInWilderness(bool[] flagset)
	If (flagset.Length < (LocationKeywords.Length + 1))
		return false
	EndIf
	return flagset[0] || (flagset[18] || flagset[11] || flagset[15])
EndFunction

bool Function IsFlagsetInDungeon(bool[] flagset)
	If (flagset.Length < (LocationKeywords.Length + 1))
		return false
	EndIf
	return flagset[9] || flagset[10] || flagset[12] || flagset[13] || flagset[14] || flagset[3] || flagset[16] || flagset[4]
EndFunction

bool Function IsLocationKeywordSafe(Keyword locKeyword)
	return locKeyword == LocTypePlayerHome || locKeyword == LocTypeJail || locKeyword == LocTypeInn
EndFunction

bool Function IsLocationKeywordCity(Keyword locKeyword)
	return locKeyword == LocTypeCity || locKeyword == LocTypeTown || locKeyword == LocTypeHabitation || locKeyword == LocTypeDwelling
EndFunction

bool Function IsLocationKeywordWilderness(Keyword locKeyword)
	return !locKeyword || locKeyword == LocTypeHold || locKeyword == LocTypeBanditCamp || locKeyword == LocTypeMilitaryFort
EndFunction

bool Function IsLocationKeywordDungeon(Keyword locKeyword)
	return locKeyword == LocTypeDraugrCrypt || locKeyword == LocTypeDragonPriestLair || locKeyword == LocTypeFalmerHive || locKeyword == LocTypeVampireLair || locKeyword == LocTypeDwarvenAutomatons || locKeyword == LocTypeDungeon || locKeyword == LocTypeMine || locKeyword == LocSetCave
EndFunction

bool Function IsLocationSafe(Location pLoc)
	return pLoc && (pLoc.HasKeyword(LocTypePlayerHome) || pLoc.HasKeyword(LocTypeJail) || pLoc.HasKeyword(LocTypeInn))
EndFunction

bool Function IsLocationInCity(Location pLoc)
	return pLoc && (pLoc.HasKeyword(LocTypeCity) || pLoc.HasKeyword(LocTypeTown) || pLoc.HasKeyword(LocTypeHabitation) || pLoc.HasKeyword(LocTypeDwelling))
EndFunction

bool Function IsLocationInWilderness(Location pLoc)
	return !pLoc || pLoc.HasKeyword(LocTypeHold) || ploc.HasKeyword(LocTypeBanditCamp) || ploc.HasKeyword(LocTypeMilitaryFort)
EndFunction

bool Function IsLocationInDungeon(Location pLoc)
	return pLoc && (pLoc.HasKeyword(LocTypeDraugrCrypt) || ploc.HasKeyword(LocTypeDragonPriestLair) || ploc.HasKeyword(LocTypeFalmerHive) || ploc.HasKeyword(LocTypeVampireLair) || ploc.HasKeyword(LocTypeDwarvenAutomatons) || ploc.HasKeyword(LocTypeDungeon) || ploc.HasKeyword(LocTypeMine) || ploc.HasKeyword(LocSetCave))
EndFunction

; available in a pinch, but not performant
bool Function PlayerIsInDungeon()
	if !PlayerRef.GetParentCell().IsInterior()
		return false
	endif

	return IsLocationInDungeon(PlayerRef.GetCurrentLocation())
EndFunction

bool Function PlayerIsInWilderness()
	if PlayerRef.GetParentCell().IsInterior()
		return false
	endif

	return IsLocationInWilderness(PlayerRef.GetCurrentLocation())
EndFunction

bool Function PlayerIsInCity()
	return IsLocationInCity(PlayerRef.GetCurrentLocation())
EndFunction

bool Function PlayerIsInSafeLocation()
	return IsLocationSafe(PlayerRef.GetCurrentLocation())
EndFunction

bool Function ActorIsInDungeon(Actor theActor)
	if !theActor.GetParentCell().IsInterior()
		return false
	endif

	return IsLocationInDungeon(theActor.GetCurrentLocation())
EndFunction

bool Function ActorIsInWilderness(Actor theActor)
	if theActor.GetParentCell().IsInterior()
		return false
	endif

	return IsLocationInWilderness(theActor.GetCurrentLocation())
EndFunction

bool Function ActorIsInCity(Actor theActor)
	return IsLocationInCity(theActor.GetCurrentLocation())
EndFunction

bool Function ActorIsInSafeLocation(Actor theActor)
	return IsLocationSafe(theActor.GetCurrentLocation())
EndFunction

;; handle version updates, let extensions do it too
Function CheckVersionUpdates()
	int newVersion = GetModVersion()
	SLTDebugMsg("Main.CheckVersionUpdates: oldVersion(" + SLTRVersion + ") newVersion(" + newVersion + ")")

	SLTRVersion = newVersion
EndFunction