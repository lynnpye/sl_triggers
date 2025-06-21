Scriptname sl_TriggersMain extends Quest

import sl_triggersStatics
import sl_triggersContext

; CONSTANTS
int		SLT_HEARTBEAT					= 0
int		SLT_BOOTSTRAPPING				= 100

int		REGISTRATION_BEACON_COUNT		= 15

; Properties
Actor               Property PlayerRef				Auto
sl_triggersSetup	Property SLTMCM					Auto
bool				Property bEnabled		= true	Auto Hidden
bool				Property bDebugMsg		= false	Auto Hidden
Form[]				Property Extensions				Auto Hidden
int					Property nextInstanceId			Auto Hidden

; Variables
int			SLTUpdateState
int			_registrationBeaconCount

Function SetEnabled(bool _newEnabledFlag)
	if bEnabled != _newEnabledFlag
		bEnabled = _newEnabledFlag
		JsonUtil.SetIntValue(FN_Settings(), "enabled", bEnabled as int)
	endif

	sl_triggersExtension ext
	int i
	while i < Extensions.Length
		ext = Extensions[i] as sl_triggersExtension
		if ext
			ext.SetEnabled(ext.bEnabled)
		endif
		i += 1
	endwhile
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Events

Event OnInit()
	if !self
		return
	endif

	BootstrapSLTInit()
EndEvent

Function DoPlayerLoadGame()
	if !self
		return
	endif
	BootstrapSLTInit()
EndFunction

Function BootstrapSLTInit()
	DebMsg("Main.BootstrapSLTInit")
	if !self
		return
	endif

	SetSLTHost(self)

	SafeRegisterForModEvent_Quest(self, EVENT_SLT_DELAY_START_COMMAND(), "OnSLTDelayStartCommand")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REGISTER_EXTENSION(), "OnSLTRegisterExtension")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REQUEST_COMMAND(), "OnSLTRequestCommand")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REQUEST_LIST(), "OnSLTRequestList")

	InitSettingsFile(FN_Settings())

	bool _userStoredFlag = JsonUtil.GetIntValue(FN_Settings(), "enabled") as bool
	SetEnabled(_userStoredFlag)

	_userStoredFlag = JsonUtil.GetIntValue(FN_Settings(), "debugmsg") as bool
	if _userStoredFlag != bDebugMsg
		bDebugMsg = _userStoredFlag
	endif
	
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
		SendEventSLTOnNewSession()
	endif

	if _registrationBeaconCount > 0
		_registrationBeaconCount -= 1
		DoRegistrationBeacon()
	endif

	QueueUpdateLoop(afDelay)
EndEvent

Event OnSLTRegisterExtension(string _eventName, string extensionKey, float fltval, Form extensionToRegister_asForm)
	Quest extensionToRegister = extensionToRegister_asForm as Quest
	if !self || !extensionToRegister
		return
	endif
	sl_triggersExtension sltExtension = extensionToRegister as sl_triggersExtension
	if !sltExtension
		DebMsg("Non-sl_triggersExtension attempted registration")
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

Event OnSLTRequestCommand(string _eventName, string _commandName, float __ignored, Form _theActor)
	if !self
		return
	endif
	if !_commandName
		return
	endif

	Actor _actualActor = _theActor as Actor
	if !_actualActor
		_actualActor = PlayerRef
	endif
	StartCommand(_actualActor, _commandName)
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
		
		SLTMCM.SetExtensionPages(extensionFriendlyNames, extensionKeys)
	else
		DebMsg("SLTMCM is empty")
	endif
EndFunction

Function DoInMemoryReset()
	SendModEvent(EVENT_SLT_RESET())
	BootstrapSLTInit()
EndFunction

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
			MiscUtil.PrintConsole("Reattempted script(" + initialScriptName + ") for Actor(" + target + ") attempts(" + reAttemptCount + ") - giving up")
			return
		endif
		target.SendModEvent(EVENT_SLT_DELAY_START_COMMAND(), initialScriptName, reAttemptCount)
	endif
EndEvent

; StartCommand
; Actor _theActor: the Actor to attach this command to
; string _scriptName: the file to run
Function StartCommand(Actor target, string initialScriptName)
	if !self
		return
	endif

	int threadid = GetNextInstanceId()

	Thread_SetInitialScriptName(threadid, initialScriptName)
	Thread_SetTarget(threadid, target)
	Target_AddThread(target, threadid)

	bool scriptStarted = sl_triggers_internal.StartScript(target, initialScriptName)
	if !scriptStarted
		MiscUtil.PrintConsole("Too many SLTR effects on target(" + target + "); attempting to delay script execution")
		target.SendModEvent(EVENT_SLT_DELAY_START_COMMAND(), initialScriptName, 0.0)
	endif
EndFunction