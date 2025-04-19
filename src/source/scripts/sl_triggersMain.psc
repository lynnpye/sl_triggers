Scriptname sl_TriggersMain extends Quest

import sl_triggersStatics
import sl_triggersHeap
import sl_triggersFile

; CONSTANTS
int		SLT_UNDEFINED					= 0
int		SLT_BOOTSTRAPPING				= 100
int		SLT_POPULATING_MCM				= 200

float	MCM_POPULATION_DELAY			= 1.5

string	SUKEY_GLOBAL_INSTANCE			= "_slt_SUKEY_GLOBAL_INSTANCE_"
string	SUKEY_EXTENSION_REGISTRATION_QUEUE	= "EXTENSION_REGISTRATION_QUEUE"
string	KYPT_EXTENSION_SLT_GLOBAL		= "sl_triggers_global"
string	KYPT_KEYNAME_GLOBALVARS_PREFIX	= "globalvars"

string	PSEUDO_INSTANCE_KEY				= "SLTADHOCINSTANCEID"

string	EVENT_SLT_MAIN_INIT				= "_slt_event_slt_main_init_"
string	EVENT_SLT_REGISTER_EXTENSION	= "_slt_event_slt_register_extension_"


; Properties
Actor               Property PlayerRef				Auto
Spell[]             Property customSpells			Auto
MagicEffect[]       Property customEffects			Auto
sl_triggersSetup	Property SLTMCM					Auto
bool				Property bEnabled		= true	Auto Hidden
bool				Property bDebugMsg		= false	Auto Hidden
Form[]				Property Extensions				Auto Hidden
Form[]				Property ExtensionBuffer		Auto Hidden
; this is my buffer. there are many like it, but this one is mine. my buffer is my best friend. it is my life. i must master it as i must master my life.
ActiveMagicEffect[]	Property coreCmdMailbox0		Auto Hidden
ActiveMagicEffect[]	Property coreCmdMailbox1		Auto Hidden
ActiveMagicEffect[]	Property coreCmdMailbox2		Auto Hidden
ActiveMagicEffect[]	Property coreCmdMailbox3		Auto Hidden

; Variables
bool		broadcastSettingsUpdated
int			SLTUpdateState
int			coreCmdNextMailbox
int 		coreCmdNextSilo
int			coreCmdNextSlot
float		TimeToPopulateMCM
string[]	commandsListCache
;string[]	heartbeatEvents
string[]	settingsUpdateEvents
string[]	gameLoadedEvents
;string[]	openRegistrationEvents

sl_triggersMain Function GetInstance() global
	;                                            SUKEY_GLOBAL_INSTANCE
	return (StorageUtil.GetFormValue(none, "_slt_SUKEY_GLOBAL_INSTANCE_") as sl_triggersMain)
EndFunction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Events

Event OnInit()
	DebMsg("Main.OnInit")
	StorageUtil.SetFormValue(none, SUKEY_GLOBAL_INSTANCE, self)
	BootstrapSLTInit()
EndEvent

Event OnUpdate()
	if !self
		return
	endif

	; state checks
	if SLTUpdateState == SLT_BOOTSTRAPPING
		SLTUpdateState = SLT_UNDEFINED
		UnregisterForModEvent(EVENT_SLT_MAIN_INIT)
		; on first launch, this will obviously be empty
		; on subsequent loads, we need to iterate the extensions we are
		; aware of and bootstrap them
		int i = 0
		while i < Extensions.Length
			sl_triggersExtension sltx = Extensions[i] as sl_triggersExtension
			if !sltx
				; need to remove it from the list, it was removed from the game perhaps?
				Debug.Trace("SLTMain.OnUpdate: Bootstrapping: Removed empty extension from main.Extensions")
				DebMsg("SLTMain.OnUpdate: Bootstrapping: Removed empty extension from main.Extensions")
				if Extensions.Length > i + 1
					Extensions = PapyrusUtil.MergeFormArray(PapyrusUtil.SliceFormArray(Extensions, 0, i - 1), PapyrusUtil.SliceFormArray(Extensions, i + 1))
				else
					Extensions = PapyrusUtil.SliceFormArray(Extensions, 0, i - 1)
				endif
			else
				sltx.BootstrapSLTInit()
				i += 1
			endif
		endwhile
		SendModEvent(EVENT_SLT_MAIN_INIT)
		return
	endif

	; no specific state to take action on, check other actions
	float currentRealTime = Utility.GetCurrentRealTime()
	if TimeToPopulateMCM && TimeToPopulateMCM < currentRealTime && SLTMCM
		TimeToPopulateMCM = 0.0
		
		SLTMCM.ClearSetupHeap()
		SLTMCM.SetCommandsList(GetCommandsList())
	
		int i = 0
		string[] extensionFriendlyNames = PapyrusUtil.StringArray(Extensions.Length)
		string[] extensionKeys = PapyrusUtil.StringArray(Extensions.Length)
		while i < Extensions.Length
			sl_triggersExtension _ext = GetExtensionByIndex(i)

			_ext.SLTMCM = SLTMCM
			extensionFriendlyNames[i] = _ext.GetFriendlyName()
			extensionKeys[i] = _ext.GetExtensionKey()
			
			SLTMCM.SetTriggers(_ext.GetExtensionKey(), _ext.TriggerKeys)
			
			i += 1
		endwhile
		
		SLTMCM.SetExtensionPages(extensionFriendlyNames, extensionKeys)
		
		SendModEvent(EVENT_SLT_POPULATE_MCM())
	endif

	; Let everyone know settings changed
	if broadcastSettingsUpdated
		broadcastSettingsUpdated = false
		SendModEvent(EVENT_SLT_SETTINGS_UPDATED())
	endif
	
	; Heartbeats
	;/
	int i = 0
	int max = heartbeatEvents.Length
	while i < max
		SendModEvent(heartbeatEvents[i])
		i += 1
	endwhile
	/;
	int i = 0
	int max = CountAMEHeartbeats()
	while i < max
		SendModEvent(GetAMEHeartbeat(i))
		i += 1
	endwhile

	QueueUpdateLoop()
EndEvent

Event OnSLTMainInit(string _eventName, string _strArg, float _fltArg, Form _frmArg)
	if !coreCmdMailbox0
		coreCmdMailbox0 = new ActiveMagicEffect[128]
		coreCmdMailbox1 = new ActiveMagicEffect[128]
		coreCmdMailbox2 = new ActiveMagicEffect[128]
		coreCmdMailbox3 = new ActiveMagicEffect[128]
		coreCmdNextMailbox = 0
		coreCmdNextSilo = 0
		coreCmdNextSlot = 0
	endif

	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REGISTER_EXTENSION, "OnSLTRegisterExtension")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_AME_HEARTBEAT_UPDATE(), "OnSLTAMEHeartbeatUpdate")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REQUEST_COMMAND(), "OnSLTRequestCommand")
	;;;;;
	;;;;;
	;;;;;
	;;;;;
	;;;;;
	;;;;;  DON'T FORGET TO ADD REQUIRED EVENT REGISTRATION
	;;;;;
	;;;;;
	;;;;;
	;;;;;
	;;;;;

	SendSLTGameLoaded()

	; get us started
	QueueUpdateLoop()
EndEvent

Event OnSLTRegisterExtension(string _eventName, string _strArg, float _fltArg, Form _frmArg)
	bool needSorting = false

	while Heap_FormListCountX(self, PSEUDO_INSTANCE_KEY, SUKEY_EXTENSION_REGISTRATION_QUEUE) > 0
		sl_triggersExtension sltx = Heap_FormListShiftX(self, PSEUDO_INSTANCE_KEY, SUKEY_EXTENSION_REGISTRATION_QUEUE) as sl_triggersExtension
		if sltx
			if PapyrusUtil.CountForm(Extensions, sltx) < 1 ; exists and not in our list already
				if !Extensions
					Extensions				= PapyrusUtil.FormArray(0)
					settingsUpdateEvents	= PapyrusUtil.StringArray(0)
					gameLoadedEvents		= PapyrusUtil.StringArray(0)
				endif
				Extensions				= PapyrusUtil.PushForm(Extensions, sltx)
				settingsUpdateEvents	= PapyrusUtil.PushString(settingsUpdateEvents, sltx._slt_GetSettingsUpdateEvent())
				gameLoadedEvents		= PapyrusUtil.PushString(gameLoadedEvents, sltx._slt_GetGameLoadedEvent())
				needSorting = true
			endif
		endif
	endwhile

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

	; unless we get called again to push it out even further, mcm population should be kicked off in this long
	BumpTimeToPopulateMCM(MCM_POPULATION_DELAY)
EndEvent

Event OnSLTAMEHeartbeatUpdate(string _eventName, string _ameHeartbeat, float _addingHeartbeat, Form _theActor)
	if !_ameHeartbeat
		Debug.Trace("Main.AMEHeartbeat: heartbeat was empty")
		return
	endif
	
	if _addingHeartbeat
		AddAMEHeartbeat(_ameHeartbeat)
	else
		RemoveAMEHeartbeat(_ameHeartbeat)
	endif
EndEvent

Event OnSLTRequestCommand(string _eventName, string _commandName, float __ignored, Form _theActor)
	if !_commandName
		return
	endif

	Actor _actualActor = _theActor as Actor
	if !_actualActor
		_actualActor = PlayerRef
	endif
	
	StartCommand(_actualActor, _commandName, none)
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Functions
Function QueueUpdateLoop(float afDelay = 1.0)
	RegisterForSingleUpdate(afDelay)
EndFunction

Function DoOnPlayerLoadGame()
	DebMsg("Main.OnPlayerLoadGame (not really, but, you know)")
	BootstrapSLTInit()
EndFunction

Function BootstrapSLTInit()
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_MAIN_INIT, "OnSLTMainInit")

	SLTUpdateState = SLT_BOOTSTRAPPING
	TimeToPopulateMCM = 0.0
	broadcastSettingsUpdated = false

	UnregisterForUpdate()
	QueueUpdateLoop(0.1)
EndFunction

Function SendSLTGameLoaded(bool firstTime = false)
	string ft = "false"
	if firstTime
		ft = "true"
	endif
	
	SendModEvent(EVENT_SLT_GAME_LOADED(), ft, 0.0)
EndFunction

Function SendSettingsUpdateEvents()
	int i = 0
	while i < settingsUpdateEvents.Length
		SendModEvent(settingsUpdateEvents[i])
		
		i += 1
	endwhile
	broadcastSettingsUpdated = true
EndFunction

Function RegisterExtension(sl_triggersExtension newExtension) global
	DebMsg("Main.RegisterExtension received from (" + newExtension.GetExtensionKey() + ")")

	sl_triggersMain sltInstance = sl_triggersMain.GetInstance()
	if !sltInstance
		Debug.Trace("sl_triggersMain.RegisterExtension: cannot locate global SLT instance, unable to register extension (" + newExtension.GetExtensionKey() + ")")
		DebMsg("sl_triggersMain.RegisterExtension: cannot locate global SLT instance, unable to register extension (" + newExtension.GetExtensionKey() + ")")
	endif
	;                              PSEUDO_INSTANCE_KEY    SUKEY_EXTENSION_REGISTRATION_QUEUE
	Heap_FormListAddX(sltInstance, "SLTADHOCINSTANCEID", "EXTENSION_REGISTRATION_QUEUE", newExtension)
	;                              EVENT_SLT_REGISTER_EXTENSION
	newExtension.SendModEvent("_slt_event_slt_register_extension_")
EndFunction

Function BumpTimeToPopulateMCM(float timeToAdvance)
	; don't bother without SkyUI
	if SLTMCM
		TimeToPopulateMCM = Utility.GetCurrentRealTime() + timeToAdvance
	endif
EndFunction

Function AddAMEHeartbeat(string heartbeatEvent)
	Heap_StringListAddX(self, PSEUDO_INSTANCE_KEY, "AMEHEARTBEATS", heartbeatEvent, false)
EndFunction

Function RemoveAMEHeartbeat(string heartbeatEvent)
	Heap_StringListRemoveX(self, PSEUDO_INSTANCE_KEY, "AMEHEARTBEATS", heartbeatEvent, true)
EndFunction

int Function CountAMEHeartbeats()
	return Heap_StringListCountX(self, PSEUDO_INSTANCE_KEY, "AMEHEARTBEATS")
EndFunction

string Function GetAMEHeartbeat(int index)
	return Heap_StringListGetX(self, PSEUDO_INSTANCE_KEY, "AMEHEARTBEATS", index)
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

int Function SiloFromMailbox(int mailbox)
	return mailbox / 128
EndFunction

int Function SlotFromMailbox(int mailbox)
	return mailbox % 128
EndFunction

int Function MailboxFromSiloAndSlot(int silo, int slot)
	return silo * 128 + slot
EndFunction

int Function RequestCoreMailbox(sl_triggersCmd coreCmd)
	if !coreCmdMailbox0 || !coreCmdMailbox1 || !coreCmdMailbox2 || !coreCmdMailbox3
		Debug.Trace("sl_triggers: Main: coreCmdMailboxes not initialized")
		return -1
	endif
	
	int iterCount = 0
	int i = coreCmdNextMailbox
	
	while iterCount < 512
		int silo = SiloFromMailbox(i)
		int slot = SlotFromMailbox(i)

		if silo == 0 && !coreCmdMailbox0[slot]
			coreCmdMailbox0[slot] = coreCmd
			coreCmdNextMailbox = (i + 1) % 512
			return i
		elseif silo == 1 && !coreCmdMailbox1[slot]
			coreCmdMailbox1[slot] = coreCmd
			coreCmdNextMailbox = (i + 1) % 512
			return i
		elseif silo == 2 && !coreCmdMailbox2[slot]
			coreCmdMailbox2[slot] = coreCmd
			coreCmdNextMailbox = (i + 1) % 512
			return i
		elseif silo == 3 && !coreCmdMailbox3[slot]
			coreCmdMailbox3[slot] = coreCmd
			coreCmdNextMailbox = (i + 1) % 512
			return i
		endif

		iterCount += 1
		i = (i + 1) % 512
	endwhile
	
	Debug.Trace("sl_triggers: Main: coreCmdMailbox full (unlikely?)")
	return -1
EndFunction

sl_triggersCmd Function GetCoreCmdFromMailbox(int mailbox)
	int silo = SiloFromMailbox(mailbox)
	int slot = SlotFromMailbox(mailbox)

	if silo == 0
		return coreCmdMailbox0[slot] as sl_triggersCmd
	elseif silo == 1
		return coreCmdMailbox1[slot] as sl_triggersCmd
	elseif silo == 2
		return coreCmdMailbox2[slot] as sl_triggersCmd
	elseif silo == 3
		return coreCmdMailbox3[slot] as sl_triggersCmd
	else
		Debug.Trace("sl_triggers: Invalid silo in GetCoreCmdFromMailbox: " + silo)
		return none
	endif
EndFunction

Function ReleaseCoreMailbox(int mailbox)
	int silo = SiloFromMailbox(mailbox)
	int slot = SlotFromMailbox(mailbox)

	if silo == 0
		coreCmdMailbox0[slot] = none
	elseif silo == 1
		coreCmdMailbox1[slot] = none
	elseif silo == 2
		coreCmdMailbox2[slot] = none
	elseif silo == 3
		coreCmdMailbox3[slot] = none
	else
		Debug.Trace("sl_triggers: Invalid silo in ReleaseCoreMailbox: " + silo)
	endif
EndFunction

; simple get handler for infini-globals
string Function globalvars_get(int varsindex)
	return Heap_StringGetFK(self, MakeInstanceKey(KYPT_EXTENSION_SLT_GLOBAL, KYPT_KEYNAME_GLOBALVARS_PREFIX + varsindex))
EndFunction

; simple set handler for infini-globals
string Function globalvars_set(int varsindex, string value)
	return Heap_StringSetFK(self, MakeInstanceKey(KYPT_EXTENSION_SLT_GLOBAL, KYPT_KEYNAME_GLOBALVARS_PREFIX + varsindex), value)
EndFunction

Function EnqueueAMEValues(Actor _theActor, string cmd, string instanceId, Form[] spellForms, string[] extensionInstanceIds)
	Heap_StringSetFK(_theActor, MakeInstanceKey(instanceId, "cmd"), cmd)
	Heap_IntSetFK(_theActor, MakeInstanceKey(instanceId, "spellFormsLength"), spellForms.Length)
	if spellForms.Length
		int sfi = 0
		while sfi < spellForms.Length
			if spellForms[sfi] && extensionInstanceIds[sfi]
				Heap_FormListSetFK(_theActor, MakeInstanceKey(instanceId, "spellForms"), sfi, spellForms[sfi])
				Heap_StringListAddFK(_theActor, extensionInstanceIds[sfi], instanceId)
			endif
		
			sfi += 1
		endwhile
	endif
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
				extensionInstanceIds[extensionIndex] = MakeExtensionInstanceId(_thisExt.GetExtensionKey())
			endif
			
			extensionIndex += 1
		endwhile
	endif
	
	; spells are forms, we can milk them
	EnqueueAMEValues(_theActor, CommandsFolder() + _cmdName, _instanceId, spellForms, extensionInstanceIds)
	
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
	Utility.Wait(0)
	
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
	commandsListCache = JsonUtil.JsonInFolder(CommandsFolder())
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