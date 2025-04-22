Scriptname sl_TriggersMain extends Quest

import sl_triggersStatics
import sl_triggersHeap
import sl_triggersFile

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
bool				Property bEnabled		= true	Auto Hidden
bool				Property bDebugMsg		= false	Auto Hidden
Form[]				Property Extensions				Auto Hidden

; Variables
int			SLTUpdateState
int			_registrationBeaconCount
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
		return
	endif
	
	if _registrationBeaconCount > 0
		_registrationBeaconCount -= 1
		DoRegistrationBeacon()
	endif

	 ; if SLT_HEARTBEAT ; this is the default behavior
	; Heartbeats
	SendSLTHeartbeats()

	QueueUpdateLoop()
EndEvent

Event OnSLTRegisterExtension(string _eventName, string _strArg, float _fltArg, Form _frmArg)
	if !self
		return
	endif
	DoRegistrationActivity(_strArg)
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
	
	StartCommand(_actualActor, _commandName, none)
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
	;Heap_FormListAddX(SLT, PSEUDO_INSTANCE_KEY(), SUKEY_EXTENSION_REGISTRATION_QUEUE(), self, false)
	_theExtension.SendModEvent(EVENT_SLT_REGISTER_EXTENSION(), _theExtension.GetExtensionKey())
EndFunction

Function OnInitBody()
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

	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REGISTER_EXTENSION(), "OnSLTRegisterExtension")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REQUEST_COMMAND(), "OnSLTRequestCommand")

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

	if SLTMCM
		SLTMCM.CommandsList = GetCommandsList()
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
		_extensionToRegister.SLTMCM = SLTMCM
		if SLTMCM
			_extensionToRegister._slt_PopulateMCM()
			SLTMCM.SetTriggers(_extensionToRegister.GetExtensionKey(), _extensionToRegister.TriggerKeys)
		endif

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
	SLTMCM.ClearSetupHeap()

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
	int i = 0
	while i < settingsUpdateEvents.Length
		SendModEvent(settingsUpdateEvents[i])
		
		i += 1
	endwhile
	SendDelayedSettingsUpdateEvent()
EndFunction


int Function GetSettingsVersion()
	return Settings_IntGet(SettingsFilename(), "version", GetModVersion())
EndFunction

Function SetSettingsVersion(int newVersion = -1)
	if newVersion == -1
		Settings_IntSet(SettingsFilename(), "version", GetModVersion())
	else
		Settings_IntSet(SettingsFilename(), "version", newVersion)
	endif
EndFunction

; simple get handler for infini-globals
string Function globalvars_get(int varsindex)
	return Heap_StringGetFK(self, MakeInstanceKey(PSEUDO_INSTANCE_KEY, GLOBALVARS_KEYNAME_PREFIX + varsindex))
EndFunction

; simple set handler for infini-globals
string Function globalvars_set(int varsindex, string value)
	return Heap_StringSetFK(self, MakeInstanceKey(PSEUDO_INSTANCE_KEY, GLOBALVARS_KEYNAME_PREFIX + varsindex), value)
EndFunction

Function EnqueueAMEValues(Actor _theActor, string cmd, string instanceId, Form[] spellForms, string[] extensionInstanceIds)
	if !self
		return
	endif
	Heap_StringSetFK(_theActor, MakeInstanceKey(instanceId, "cmd"), cmd)
	int count = 0
	if spellForms.Length
		int sfi = 0
		while sfi < spellForms.Length
			if spellForms[sfi] && extensionInstanceIds[sfi]
				Heap_FormListAddFK(_theActor, MakeInstanceKey(instanceId, "spellForms"), spellForms[sfi])
				Heap_StringListAddFK(_theActor, extensionInstanceIds[sfi], instanceId)
				count += 1
			endif
		
			sfi += 1
		endwhile
	endif
	Heap_IntSetFK(_theActor, MakeInstanceKey(instanceId, "spellFormsLength"), count)
	Heap_EnqueueInstanceIdF(_theActor, instanceId)
EndFunction

sl_triggersExtension Function GetExtensionByIndex(int _index)
	return extensions[_index] as sl_triggersExtension
EndFunction

; StartCommand
; Actor _theActor: the Actor to attach this command to
; string _cmdName: the file to run; is also the triggerKey or triggerId
; sl_triggersExtension _sltex: the extension making the request
string Function StartCommand(Actor _theActor, string _cmdName, sl_triggersExtension _sltext)
	if !self
		return ""
	endif

	string _instanceId
	if _sltext
		_instanceId = _sltext._slt_NextInstanceId()
	else
		_instanceId = _NextInstanceId()
	endif
    
	Spell coreSpell = NextPooledSpellForActor(_theActor)
	
	if !coreSpell
        MiscUtil.PrintConsole("Too many SLT core effects on: " + _theActor)
		return ""
	endif
	
	Form[] spellForms
	string[] extensionInstanceIds
	; certain things only need to be done if we have extensions
	if extensions.Length > 0
		spellForms = PapyrusUtil.FormArray(extensions.Length)
		extensionInstanceIds = PapyrusUtil.StringArray(extensions.Length)
		
		int extensionIndex = 0
		while extensionIndex < spellForms.Length
			sl_triggersExtension _thisExt = GetExtensionByIndex(extensionIndex)
			if _thisExt._slt_HasPool()
				spellForms[extensionIndex] = _thisExt._slt_NextPooledSpellForActor(_theActor)
				if !spellForms[extensionIndex]
					MiscUtil.PrintConsole("Too many effects on: " + _theActor + " from extension: " + _thisExt.GetExtensionKey())
					return ""
				endif
				string asdfasdf = MakeExtensionInstanceId(_thisExt.GetExtensionKey())
				extensionInstanceIds[extensionIndex] = MakeExtensionInstanceId(_thisExt.GetExtensionKey())
			endif
			
			extensionIndex += 1
		endwhile
	endif
	
	; spells are forms, we can milk them
	EnqueueAMEValues(_theActor, _cmdName, _instanceId, spellForms, extensionInstanceIds)
	
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
	return "(" + _NextCycledInstanceNumber() + ")"
EndFunction

string[] Function GetCommandsList()
	string[] if1 = MiscUtil.FilesInFolder(FullCommandsFolder(), "ini")
	string[] if2 = MiscUtil.FilesInFolder(FullCommandsFolder(), "json")

	commandsListCache = PapyrusUtil.MergeStringArray(if1, if2)
	;commandsListCache = JsonUtil.JsonInFolder(CommandsFolder())
	return commandsListCache
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