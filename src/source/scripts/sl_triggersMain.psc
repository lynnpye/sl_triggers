Scriptname sl_TriggersMain extends Quest

import sl_triggersStatics

; CONSTANTS
int		SLT_HEARTBEAT					= 0
int		SLT_BOOTSTRAPPING				= 100
int		SLT_NEW_SESSION_ALERT			= 200

int		REGISTRATION_BEACON_COUNT		= 30

string	Function GLOBAL_PSEUDO_INSTANCE_KEY() global
	return "_slt_global_pseudo_instance_key_sl_triggersMain_"
EndFunction

string Property PSEUDO_INSTANCE_KEY
	string Function Get()
		return sl_triggersMain.GLOBAL_PSEUDO_INSTANCE_KEY()
	EndFunction
EndProperty

string Function GLOBAL_SLT_MAIN_INSTANCE_KEY() global
	return "_slt_main_instance_key_"
EndFunction

string Property SLT_MAIN_INSTANCE_KEY Hidden
	string Function Get()
		return sl_triggersMain.GLOBAL_SLT_MAIN_INSTANCE_KEY()
	EndFunction
EndProperty

; Properties
Actor               Property PlayerRef				Auto
sl_triggersSetup	Property SLTMCM					Auto
bool				Property bEnabled		= true	Auto	 Hidden
bool				Property bDebugMsg		= false	Auto Hidden
Form[]				Property Extensions				Auto Hidden

; Variables
int			SLTUpdateState
int			_registrationBeaconCount
string[]	commandsListCache
string[]	extensionInternalReadyEvents

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
	endwhile
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Events

Event OnInit()
	if !self
		return
	endif

	OnInitBody()
EndEvent

Event OnUpdate()
	if !self
		return
	endif

	; state checks
	if SLTUpdateState == SLT_BOOTSTRAPPING
		DoBootstrapActivity()

		SLTUpdateState = SLT_NEW_SESSION_ALERT

		QueueUpdateLoop(0.1)
	elseif SLTUpdateState == SLT_NEW_SESSION_ALERT
		SendEventSLTOnNewSession()

		SLTUpdateState = SLT_HEARTBEAT

		QueueUpdateLoop(0.1)
	else
		if _registrationBeaconCount > 0
			_registrationBeaconCount -= 1
			DoRegistrationBeacon()
		endif
	
		QueueUpdateLoop()
	endif
EndEvent

Event OnSLTRegisterExtension(Form extensionToRegister)
	if !self || !extensionToRegister
		return
	endif
	sl_triggersExtension sltExtension = extensionToRegister as sl_triggersExtension
	if !sltExtension
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

Function OnInitBody()
	if !self
		return
	endif
	StorageUtil.SetFormValue(none, SLT_MAIN_INSTANCE_KEY, self)
	BootstrapSLTInit()
EndFunction

Function BootstrapSLTInit()
	if !self
		return
	endif
	SLTUpdateState = SLT_BOOTSTRAPPING
	_registrationBeaconCount = REGISTRATION_BEACON_COUNT

	UnregisterForUpdate()
	QueueUpdateLoop(0.1)
EndFunction

Function DoOnPlayerLoadGame()
	if !self
		return
	endif
	StorageUtil.SetFormValue(none, SLT_MAIN_INSTANCE_KEY, self)
	BootstrapSLTInit()
EndFunction

Function DoBootstrapActivity()
	if !self
		return
	endif

	if bDebugMsg
		DebMsg("Main.DoBootstrapActivity: Post library cache checkpoint")
	endif
	InitSettingsFile(FN_Settings())

	bool _userStoredFlag = JsonUtil.GetIntValue(FN_Settings(), "enabled") as bool
	SetEnabled(_userStoredFlag)

	_userStoredFlag = JsonUtil.GetIntValue(FN_Settings(), "debugmsg") as bool
	if _userStoredFlag != bDebugMsg
		bDebugMsg = _userStoredFlag
	endif

	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REGISTER_EXTENSION(), "OnSLTRegisterExtension")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REQUEST_COMMAND(), "OnSLTRequestCommand")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REQUEST_LIST(), "OnSLTRequestList")

	; on first launch, this will obviously be empty
	; on subsequent loads, we need to iterate the extensions we are
	; aware of and bootstrap them
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
			sltx._slt_BootstrapSLTInit()
			i += 1
		endif
	endwhile

	if SLTMCM
		SLTMCM.ScriptsList = sl_triggers.GetScriptsList()
	endif
EndFunction

Function DoRegistrationBeacon()
	if !self
		return
	endif
	SendSLTInternalReady()
EndFunction

; Unfortunately this might get called repeatedly for new extensions, but
; still has to deal with the possibility of existing extensions
Function DoRegistrationActivity(sl_triggersExtension _extensionToRegister)
	if !self
		return
	endif
	bool needSorting = false

	;/
	Form _fetch = Heap_FormGetX(self, PSEUDO_INSTANCE_KEY, SLT_EXTENSION_REGISTRATION_QUEUE + _extensionKeyToRegister)
	if !_fetch
		Return
	endif
	Heap_FormUnsetX(self, PSEUDO_INSTANCE_KEY, SLT_EXTENSION_REGISTRATION_QUEUE + _extensionKeyToRegister)
	sl_triggersExtension _extensionToRegister = _fetch as sl_triggersExtension
	/;
	if !_extensionToRegister
		return
	endif

	; our first patient
	if !Extensions
		Extensions						= PapyrusUtil.FormArray(0)
		extensionInternalReadyEvents 	= PapyrusUtil.StringArray(0)
	endif

	; do we already know about you?
	int _xidx = Extensions.Find(_extensionToRegister)

	if _xidx < 0
		Extensions						= PapyrusUtil.PushForm(Extensions, _extensionToRegister)
		extensionInternalReadyEvents 	= PapyrusUtil.PushString(extensionInternalReadyEvents, _extensionToRegister._slt_GetInternalReadyEvent())
		_xidx = Extensions.Length - 1
		needSorting = true
	endif

	if needSorting
		; sort extensions by priority
		if Extensions
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
	endif
	
	if SLTMCM
		int i = 0
		string[] extensionFriendlyNames = PapyrusUtil.StringArray(Extensions.Length)
		string[] extensionKeys = PapyrusUtil.StringArray(Extensions.Length)
		while i < Extensions.Length
			sl_triggersExtension _ext = GetExtensionByIndex(i)

			extensionFriendlyNames[i] = _ext.SLTFriendlyName
			extensionKeys[i] = _ext.SLTExtensionKey
			
			i += 1
		endwhile
		
		SLTMCM.SetExtensionPages(extensionFriendlyNames, extensionKeys)
	endif
EndFunction

Function DoInMemoryReset()
	commandsListCache				= none

	SendModEvent(EVENT_SLT_RESET())
	OnInitBody()
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
			ext._slt_PreSettingsUpdate()
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

; StartCommand
; Actor _theActor: the Actor to attach this command to
; string _cmdName: the file to run; is also the triggerKey or triggerId
string Function StartCommand(Actor _theActor, string _cmdName)
	if !self
		return ""
	endif

	if !sl_triggers.PrepareContextForTargetedScript(_theActor, _cmdName)
		DebMsg("Failed to start script " + _cmdName)
	endif
	
	return true
EndFunction