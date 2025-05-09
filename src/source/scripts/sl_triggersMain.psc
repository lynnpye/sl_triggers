Scriptname sl_TriggersMain extends Quest

import sl_triggersStatics
import sl_triggersHeap

; CONSTANTS
int		SLT_HEARTBEAT					= 0
int		SLT_BOOTSTRAPPING				= 100

int		REGISTRATION_BEACON_COUNT		= 30

string	Function GLOBAL_PSEUDO_INSTANCE_KEY() global
	return "_slt_global_pseudo_instance_key_sl_triggersMain_"
EndFunction

string Property PSEUDO_INSTANCE_KEY
	string Function Get()
		return sl_triggersMain.GLOBAL_PSEUDO_INSTANCE_KEY()
	EndFunction
EndProperty

string	GLOBALVARS_KEYNAME_PREFIX	= "globalvars"

string	EVENT_SLT_DELAYED_SETTINGS_BROADCAST = "_slt_event_slt_delayed_settings_broadcast_"

string Property SLT_MAIN_INSTANCE_KEY Hidden
	string Function Get()
		return sl_triggersMain.GLOBAL_SLT_MAIN_INSTANCE_KEY()
	EndFunction
EndProperty

string Property SLT_EXTENSION_REGISTRATION_QUEUE
	string Function Get()
		return sl_triggersMain.GLOBAL_SLT_EXTENSION_REGISTRATION_QUEUE()
	EndFunction
EndProperty

string Function GLOBAL_SLT_MAIN_INSTANCE_KEY() global
	return "_slt_main_instance_key_"
EndFunction

string Function GLOBAL_SLT_EXTENSION_REGISTRATION_QUEUE() global
	return "_slt_extension_registration_queue_"
EndFunction

; Properties
Actor               Property PlayerRef				Auto
Spell[]             Property customSpells			Auto
MagicEffect[]       Property customEffects			Auto
sl_triggersSetup	Property SLTMCM					Auto
bool				Property bEnabled					 Hidden
	bool Function Get()
		return _enabledFlag
	EndFunction

	Function Set(bool _newEnabledFlag)
		_enabledFlag = _newEnabledFlag
		int _newval = 0
		if _enabledFlag
			_newval = 1
		endif
		JsonUtil.SetIntValue(FN_Settings(), "enabled", _newval)
		; AND MORE
	EndFunction
EndProperty
bool				Property bDebugMsg		= false	Auto Hidden
Form[]				Property Extensions				Auto Hidden
string[]			Property Libraries				Auto Hidden

; Variables
int			SLTUpdateState
int			_registrationBeaconCount
bool		_enabledFlag
string[]	commandsListCache
string[]	settingsUpdateEvents
string[]	extensionInternalReadyEvents

sl_triggersMain Function GetInstance() global
	return (StorageUtil.GetFormValue(none, GLOBAL_SLT_MAIN_INSTANCE_KEY()) as sl_triggersMain)
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

		SLTUpdateState = SLT_HEARTBEAT

		QueueUpdateLoop(0.1)
	else
		if _registrationBeaconCount > 0
			_registrationBeaconCount -= 1
			DoRegistrationBeacon()
		endif
	
		 ; if SLT_HEARTBEAT ; this is the default behavior
		; Heartbeats
		SendSLTHeartbeats()
	
		QueueUpdateLoop()
	endif
EndEvent

Event OnSLTRegisterExtension(string _eventName, string _strArg, float _fltArg, Form _frmArg)
	if !self
		return
	endif
	DoRegistrationActivity(_strArg)
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

	string[] list = GetScriptsList()
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

Event OnSLTDelayedSettingsBroadcast(string _eventName, string _commandName, float __ignored, Form _theActor)
	if !self
		return
	endif
	SendSettingsUpdateBroadcast()
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Functions
Function SelfRegisterExtension(sl_triggersExtension _theExtension) global
	Heap_FormSetX(sl_triggersMain.GetInstance(), sl_triggersMain.GLOBAL_PSEUDO_INSTANCE_KEY(), GLOBAL_SLT_EXTENSION_REGISTRATION_QUEUE() + _theExtension.GetExtensionKey(), _theExtension)
	_theExtension.SendModEvent(EVENT_SLT_REGISTER_EXTENSION(), _theExtension.GetExtensionKey())
EndFunction

Function OnInitBody()
	if !self
		return
	endif
	_enabledFlag = true
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

Function UpdateLibraryCache()
	Libraries = GetFunctionLibraries()
	if sl_triggers_internal.SafePrecacheLibraries(Libraries)
		if bDebugMsg
			DebMsg("Main.DoBootstrapActivity: Libraries pre-cached in sl-triggers-internal")
		endif
	endif
EndFunction

Function DoBootstrapActivity()
	if !self
		return
	endif

	if bDebugMsg
		DebMsg("Main.DoBootstrapActivity: Post library cache checkpoint")
	endif
	InitSettingsFile(FN_Settings())

	bool _userStoredFlag = (JsonUtil.GetIntValue(FN_Settings(), "enabled") != 0)
	if _userStoredFlag != bEnabled
		_enabledFlag = _userStoredFlag
	endif

	_userStoredFlag = (JsonUtil.GetIntValue(FN_Settings(), "debugmsg") != 0)
	if _userStoredFlag != bDebugMsg
		bDebugMsg = _userStoredFlag
	endif

	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REGISTER_EXTENSION(), "OnSLTRegisterExtension")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REQUEST_COMMAND(), "OnSLTRequestCommand")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REQUEST_LIST(), "OnSLTRequestList")

	SafeRegisterForModEvent_Quest(self, EVENT_SLT_DELAYED_SETTINGS_BROADCAST, "OnSLTDelayedSettingsBroadcast")

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

	UpdateLibraryCache()

	if SLTMCM
		SLTMCM.ScriptsList = GetScriptsList()
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
Function DoRegistrationActivity(string _extensionKeyToRegister)
	if !self
		return
	endif
	bool needSorting = false

	Form _fetch = Heap_FormGetX(self, PSEUDO_INSTANCE_KEY, SLT_EXTENSION_REGISTRATION_QUEUE + _extensionKeyToRegister)
	if !_fetch
		Return
	endif
	Heap_FormUnsetX(self, PSEUDO_INSTANCE_KEY, SLT_EXTENSION_REGISTRATION_QUEUE + _extensionKeyToRegister)
	sl_triggersExtension _extensionToRegister = _fetch as sl_triggersExtension
	if !_extensionToRegister
		return
	endif

	; our first patient
	if !Extensions
		Extensions						= PapyrusUtil.FormArray(0)
		settingsUpdateEvents			= PapyrusUtil.StringArray(0)
		extensionInternalReadyEvents 	= PapyrusUtil.StringArray(0)
	endif

	; do we already know about you?
	int _xidx = Extensions.Find(_extensionToRegister)

	if _xidx < 0
		Extensions						= PapyrusUtil.PushForm(Extensions, _extensionToRegister)
		settingsUpdateEvents			= PapyrusUtil.PushString(settingsUpdateEvents, _extensionToRegister._slt_GetSettingsUpdateEvent())
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

	UpdateLibraryCache()
	
	if SLTMCM
		int i = 0
		string[] extensionFriendlyNames = PapyrusUtil.StringArray(Extensions.Length)
		string[] extensionKeys = PapyrusUtil.StringArray(Extensions.Length)
		while i < Extensions.Length
			sl_triggersExtension _ext = GetExtensionByIndex(i)

			extensionFriendlyNames[i] = _ext.GetFriendlyName()
			extensionKeys[i] = _ext.GetExtensionKey()
			
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

Function SendSLTHeartbeats()
	if !self
		return
	endif

	SendModEvent(EVENT_SLT_HEARTBEAT())
EndFunction

Function SendSLTInternalReady()
	if !self
		return
	endif
	SendModEvent(EVENT_SLT_INTERNAL_READY_EVENT())
EndFunction

Function SendDelayedSettingsUpdateEvent()
	if !self
		return
	endif
	SendModEvent(EVENT_SLT_DELAYED_SETTINGS_BROADCAST)
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

	UpdateLibraryCache()

	int i = 0
	while i < settingsUpdateEvents.Length
		SendModEvent(settingsUpdateEvents[i])
		
		i += 1
	endwhile
	SendDelayedSettingsUpdateEvent()
EndFunction


; simple get handler for infini-globals
string Function globalvars_get(int varsindex)
	return Heap_StringGetFK(self, MakeInstanceKey(PSEUDO_INSTANCE_KEY, GLOBALVARS_KEYNAME_PREFIX + varsindex))
EndFunction

; simple set handler for infini-globals
string Function globalvars_set(int varsindex, string value)
	return Heap_StringSetFK(self, MakeInstanceKey(PSEUDO_INSTANCE_KEY, GLOBALVARS_KEYNAME_PREFIX + varsindex), value)
EndFunction

;/
Function EnqueueAMEValues(Actor _theActor, string cmd, string instanceId)
	if !self
		return
	endif
EndFunction
/;

sl_triggersExtension Function GetExtensionByIndex(int _index)
	return extensions[_index] as sl_triggersExtension
EndFunction

sl_triggersExtension Function GetExtensionByKey(string _extensionKey)
	int i = 0
	while i < Extensions.Length
		sl_triggersExtension slext = Extensions[i] as sl_triggersExtension
		if slext && slext.GetExtensionKey() == _extensionKey
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

	string _instanceId = _NextInstanceId()
    
	Spell coreSpell = NextPooledSpellForActor(_theActor)
	
	if !coreSpell
        MiscUtil.PrintConsole("Too many SLT core effects on: " + _theActor)
		return ""
	endif
	
	Heap_StringSetFK(_theActor, MakeInstanceKey(_instanceId, "cmd"), _cmdName)
	Heap_EnqueueInstanceIdF(_theActor, _instanceId)
	
	; cast the core AME
	coreSpell.RemoteCast(_theActor, _theActor, _theActor)

	return _instanceId
EndFunction

; NextCycledInstanceNumber
; DO NOT OVERRIDE
; int oneupmin = -30000
; int oneupmax = 30000
; returns: the next value in the cycle; if the max is exceeded, the cycle resets to min
; 	if you get 60000 of these launched in your game, you win /sarcasm
int		oneupnumber
int Function _NextCycledInstanceNumber(int oneupmin = -30000, int oneupmax = 30000)
	int nextup = oneupnumber
	oneupnumber += 1
	if oneupnumber > oneupmax
		oneupnumber = oneupmin
	endif
	return nextup
EndFunction

; NextInstanceId
; DO NOT OVERRIDE
; returns: an instanceId derived from this extension, typically as a result
; 	of requesting a command be executed in response to an event
string Function _NextInstanceId()
	return "sl_triggersMain(" + _NextCycledInstanceNumber() + ")"
EndFunction

string[] Function GetScriptsList()
	string[] if1 = MiscUtil.FilesInFolder(FullCommandsFolder(), "ini")
	string[] if2 = MiscUtil.FilesInFolder(FullCommandsFolder(), "json")

	commandsListCache = PapyrusUtil.MergeStringArray(if1, if2)
	;commandsListCache = JsonUtil.JsonInFolder(CommandsFolder())
	return commandsListCache
EndFunction

string[] Function GetFunctionLibraries()
	string[] libs = PapyrusUtil.StringArray(1)
	int[] libpris = PapyrusUtil.IntArray(1)

	libs[0] = "sl_triggersCmdLibSLT"
	libpris[0] = 0

	; find all '-libraries' files
	string[] libconfigs = JsonUtil.JsonInFolder("../sl_triggers/extensions/")
	int i = 0
	int j = 0
	while i < libconfigs.Length
		string libfilename = "../sl_triggers/extensions/" + libconfigs[i]
		int configlen = StringUtil.GetLength(libconfigs[i])
		int taillen = StringUtil.GetLength("-libraries.json")
		string tail = StringUtil.Substring(libconfigs[i], configlen - taillen)
		if tail == "-libraries.json"
			string _maybeExtensionKey = StringUtil.Substring(libconfigs[i], 0, configlen - taillen)
			sl_triggersExtension _maybeExtension = GetExtensionByKey(_maybeExtensionKey)
			if _maybeExtension && _maybeExtension.IsEnabled
				string[] cfglibs = JsonUtil.PathMembers(libfilename, ".")
				j = 0
				while j < cfglibs.Length
					string lib = cfglibs[j]
					int libpri = JsonUtil.GetPathIntValue(libfilename, lib, 1000)
	
	
					; populate both, keeping in sync
					libs = PapyrusUtil.PushString(libs, lib)
					libpris = PapyrusUtil.PushInt(libpris, libpri)
	
					j += 1
				endwhile
			endif
		endif

		i += 1
	endwhile

	; bubble sort libs and libpris using libpris values
	string tmp_s
	int tmp_i
	i = 0
	while i < libs.Length - 1
		j = i + 1
		while j < libs.Length
			if libpris[i] > libpris[j]
				tmp_i = libpris[i]
				tmp_s = libs[i]

				libpris[i] = libpris[j]
				libs[i] = libs[j]

				libpris[j] = tmp_i
				libs[j] = tmp_s
			endif

			j += 1
		endwhile

		i += 1
	endwhile

	return libs
EndFunction

Spell Function NextPooledSpellForActor(Actor _theActor)
	if !_theActor
		Debug.Trace("sl_triggersMain.NextPooledSpellForActor: _theActor is none")
		return none
	endif
	
	int _i = 0
	while _i < CustomSpells.Length && _i < CustomEffects.Length
		if !_theActor.HasMagicEffect(CustomEffects[_i])
			return CustomSpells[_i]
		endif
	
		_i += 1
	endwhile
	
	Debug.Trace("sl_triggersMain.NextPooledSpellForActor: No core effects available.")
	return none
EndFunction