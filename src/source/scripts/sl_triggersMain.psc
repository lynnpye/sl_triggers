Scriptname sl_TriggersMain extends Quest

import sl_triggersStatics
import sl_triggersHeap
import sl_triggersFile

; CONSTANTS
int		REGISTRATION_STATE_PENDING		= 0
int		REGISTRATION_STATE_OPEN			= 1
int		REGISTRATION_STATE_CLOSED		= 1000
float	SECONDS_FOR_CORE_INIT			= 0.1
float	SECONDS_FOR_REGISTRATION		= 6.0 ; seconds we wait to allow registration of extensions
float	ALLOWED_REAL_DELTA				= 2.0 ; if real time drifts more than this
float	ALLOWED_GAME_DELTA				= 0.00001 ; and game time less than this, it's probably a game load
string	KYPT_EXTENSION_SLT_GLOBAL		= "sl_triggers_global"
string	KYPT_KEYNAME_GLOBALVARS_PREFIX	= "globalvars"

; Properties
Actor               Property PlayerRef				Auto
Spell[]             Property customSpells			Auto
MagicEffect[]       Property customEffects			Auto
sl_triggersSetup	Property SLTMCM					Auto
Bool				Property bEnabled = true 		Auto Hidden
Bool				Property bDebugMsg = true 		Auto Hidden

; SLT sends this to itself at startup; you don't really need to listen for this though you may. It will run
; early after OnUpdate() starts running and will be sent once per launch, similar to OnInit().

string Function EVENT_SLT_GAME_LOADED_HANDLER() global
	return "OnSLTGameLoaded"
EndFunction

string Function EVENT_SLT_CLOSE_REGISTRATION_HANDLER()
	return "OnSLTCloseRegistration"
EndFunction

string Function EVENT_SLT_AME_HEARTBEAT_UPDATE_HANDLER()
	return "OnSLTAMEHeartbeatUpdate"
EndFunction

string Function SETTINGS_VERSION()
	return "version"
EndFunction

; Variables
int			registrationState = 0
string[]	commandsListCache
Form[]		extensions
Form[]		extensionBuffer
string[]	heartbeatEvents
string[]	settingsUpdateEvents
string[]	gameLoadedEvents

bool		sltIsReady = false
bool		oncePerLoadCompleted = false
bool		gameLoadedSent = false
bool		broadcastSettingsUpdated = false

; this is my buffer. there are many like it, but this one is mine. my buffer is my best friend. it is my life. i must master it as i must master my life.
ActiveMagicEffect[]	coreCmdMailbox0
ActiveMagicEffect[]	coreCmdMailbox1
ActiveMagicEffect[]	coreCmdMailbox2
ActiveMagicEffect[]	coreCmdMailbox3

int		coreCmdNextMailbox = 0
int 	coreCmdNextSilo
int		coreCmdNextSlot

; SLT settings functions

int Function GetSettingsVersion()
	return Settings_IntGet(SettingsFilename(), SETTINGS_VERSION(), GetModVersion())
EndFunction

Function SetSettingsVersion(int newVersion = -1)
	if newVersion == -1
		Settings_IntSet(SettingsFilename(), SETTINGS_VERSION(), GetModVersion())
	else
		Settings_IntSet(SettingsFilename(), SETTINGS_VERSION(), newVersion)
	endif
EndFunction

Event OnInit()
	DebMsg("Main.OnInit")
	DoOncePerLifetime()
	
	QueueUpdateLoop(0.1)
EndEvent

Event OnUpdate()
	if !self
		return
	endif
	
	DebMsg("Main.OnUpdate")
	
	float currentRealTime = Utility.GetCurrentRealTime()
	float currentGameTime = Utility.GetCurrentGameTime()
	
	; init timings
	if !oncePerLoadCompleted && currentRealTime > SECONDS_FOR_CORE_INIT
		oncePerLoadCompleted = true
		DoOncePerLoad()
		QueueUpdateLoop()
		return
	endif

	; don't start sending heartbeats until we are ready
	if sltIsReady
		if !gameLoadedSent
			SendSLTGameLoaded(gameLoadedSent)
			gameLoadedSent = true
		endif
		
		if registrationState == REGISTRATION_STATE_OPEN && currentRealTime > SECONDS_FOR_REGISTRATION
			SendSLTCloseRegistration()
		endif
		
		if broadcastSettingsUpdated
			broadcastSettingsUpdated = false
			SendModEvent(EVENT_SLT_SETTINGS_UPDATED())
		endif
	
		int i = 0
		int max = heartbeatEvents.Length
		while i < max
			SendModEvent(heartbeatEvents[i])
			i += 1
		endwhile
		i = 0
		max = CountAMEHeartbeats()
		while i < max
			SendModEvent(GetAMEHeartbeat(i))
			i += 1
		endwhile
	endif
	
	QueueUpdateLoop()
EndEvent

Function SetSLTReady()
	sltIsReady = true
	SendModEvent(EVENT_SLT_READY())
EndFunction

Function JumpStart()
	DebMsg("Main.JumpStart")
	sltIsReady = false
	gameLoadedSent = false
	oncePerLoadCompleted = false
	UnregisterForUpdate()
	QueueUpdateLoop(0.1)
	
	int i = 0
	while i < extensions.Length
		(extensions[i] as sl_triggersExtension).JumpStart()
		i += 1
	endwhile
EndFunction

Function DoOncePerLifetime()
	sltIsReady = false
	gameLoadedSent = false
	oncePerLoadCompleted = false
	registrationState = REGISTRATION_STATE_PENDING
	
	if !coreCmdMailbox0
		coreCmdMailbox0 = new ActiveMagicEffect[128]
		coreCmdMailbox1 = new ActiveMagicEffect[128]
		coreCmdMailbox2 = new ActiveMagicEffect[128]
		coreCmdMailbox3 = new ActiveMagicEffect[128]
		coreCmdNextMailbox = 0
		coreCmdNextSilo = 0
		coreCmdNextSlot = 0
	endif
EndFunction

Function DoOncePerLoad()
	DebMsg("Main.DoOncePerLoad")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_GAME_LOADED(), EVENT_SLT_GAME_LOADED_HANDLER())
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_CLOSE_REGISTRATION(), EVENT_SLT_CLOSE_REGISTRATION_HANDLER())
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_AME_HEARTBEAT_UPDATE(), EVENT_SLT_AME_HEARTBEAT_UPDATE_HANDLER())

	if SLTMCM
		SLTMCM.SetMCMReady(false)
	endif

	OpenRegistration()
	
	SetSLTReady()
EndFunction

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

; for ad-hoc requests and perhaps more
Event OnSLTRequestCommand(string _eventName, string _commandName, float __ignored, Form _theActor)
	if !_commandName
		return
	endif

	Actor _actualActor = _theActor as Actor
	if !_actualActor
		_actualActor = PlayerRef
	endif
	
	startCommand(_actualActor, _commandName, none)
EndEvent

Function SendSLTGameLoaded(bool firstTime = false)
	string ft = "false"
	if firstTime
		ft = "true"
	endif
	
	int i = 0
	while i < gameLoadedEvents.Length
		SendModEvent(gameLoadedEvents[i], ft, 0.0)
		i += 1
	endwhile
	SendModEvent(EVENT_SLT_GAME_LOADED(), ft, 0.0)
EndFunction

Function SendSLTCloseRegistration()
	; preemptive and duplicated; sneaky extensions might register during 
	; the event dispatch window, but I also don't want to lose track
	; of the fact that this state needs to be set to CLOSED
	; so kindly leave it in both locations
	registrationState = REGISTRATION_STATE_CLOSED
	SendModEvent(EVENT_SLT_CLOSE_REGISTRATION())
EndFunction

; Event OnSLTCloseRegistration
; OPTIONAL, NOT RECOMMENDED
; Sent by sl_triggers to indicate registration is closed and bookkeeping is required
; Not recommended to capture as it is of dubious usefulness.
Event OnSLTCloseRegistration(string eventName, string strArg, float numArg, Form sender)
	CloseRegistration()
EndEvent

Function QueueUpdateLoop(float afDelay = 1.0)
	RegisterForSingleUpdate(afDelay)
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


Function OpenRegistration()
	registrationState = REGISTRATION_STATE_OPEN
	SendModEvent(EVENT_SLT_OPEN_REGISTRATION())
EndFunction

Function RegisterExtension(sl_triggersExtension newExtension)
	if registrationState == REGISTRATION_STATE_CLOSED
		Debug.Trace("sl_triggers: extension attempted registration but registrationState is CLOSED: " + newExtension.GetId())
		return
	EndIf
	
	if !extensionBuffer
		extensionBuffer = PapyrusUtil.FormArray(0)
		heartbeatEvents = PapyrusUtil.StringArray(0)
		settingsUpdateEvents = PapyrusUtil.StringArray(0)
		gameLoadedEvents = PapyrusUtil.StringArray(0)
	endif
	extensionBuffer = PapyrusUtil.PushForm(extensionBuffer, newExtension)
	heartbeatEvents = PapyrusUtil.PushString(heartbeatEvents, newExtension._GetHeartbeatEvent())
	settingsUpdateEvents = PapyrusUtil.PushString(settingsUpdateEvents, newExtension._GetSettingsUpdateEvent())
	gameLoadedEvents = PapyrusUtil.PushString(gameLoadedEvents, newExtension._GetGameLoadedEvent())
EndFunction

Function CloseRegistration()
	Utility.Wait(0.1)
	; preemptive and duplicated; sneaky extensions might register during 
	; the event dispatch window, but I also don't want to lose track
	; of the fact that this state needs to be set to CLOSED
	; so kindly leave it in both locations
	registrationState = REGISTRATION_STATE_CLOSED
	
	; sort extensions by priority
	Form[] tmpBuffer = extensionBuffer
	extensionBuffer = none
	
	if tmpBuffer
		sl_TriggersExtension f_j
		sl_TriggersExtension f_i
		Form f_swap
		int j = 0
		while j < tmpBuffer.Length
			f_j = tmpBuffer[j] as sl_TriggersExtension
			int i = j + 1
			while i < tmpBuffer.Length
				f_i = tmpBuffer[i] as sl_TriggersExtension
				if f_i.GetPriority() < f_j.GetPriority()
					f_swap = tmpBuffer[j]
					tmpBuffer[j] = tmpBuffer[i]
					tmpBuffer[i] = f_swap
				endif
				i = i + 1
			endwhile
			j = j + 1
		endwhile
	endif
	
	extensions = tmpBuffer
	
	; update the MCM now we know what we are working with
	PopulateMCM()
EndFunction

; simple get handler for infini-globals
string Function globalvars_get(int varsindex)
	return Heap_StringGetFK(self, MakeInstanceKey(KYPT_EXTENSION_SLT_GLOBAL, KYPT_KEYNAME_GLOBALVARS_PREFIX + varsindex))
EndFunction

; simple set handler for infini-globals
string Function globalvars_set(int varsindex, string value)
	return Heap_StringSetFK(self, MakeInstanceKey(KYPT_EXTENSION_SLT_GLOBAL, KYPT_KEYNAME_GLOBALVARS_PREFIX + varsindex), value)
EndFunction

; twins, basil... twins!
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

; startCommand
; Actor _theActor: the Actor to attach this command to
; string _cmdName: the file to run; is also the triggerKey or triggerId
; sl_triggersExtension _sltex: the extension making the request
string Function startCommand(Actor _theActor, string _cmdName, sl_triggersExtension _sltext)
	string _instanceId
	if _sltext
		_instanceId = _sltext._NextInstanceId()
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
			if _thisExt._HasPool()
				spellForms[extensionIndex] = _thisExt._NextPooledSpellForActor(_theActor)
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

string Function _GetPseudoInstanceKey()
	return "SLTADHOCINSTANCEID"
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

;;;
;; MCM stuff.. yay
Function PopulateMCM()
	if !SLTMCM
		return
	endif
	
	SLTMCM.ClearSetupHeap()
	
	SLTMCM.SetCommandsList(GetCommandsList())
	
	int i = 0
	string[] extensionFriendlyNames = PapyrusUtil.StringArray(extensions.Length)
	string[] extensionKeys = PapyrusUtil.StringArray(extensions.Length)
	while i < extensions.Length
		sl_triggersExtension _ext = GetExtensionByIndex(i)
		extensionFriendlyNames[i] = _ext.GetFriendlyName()
		extensionKeys[i] = _ext.GetExtensionKey()
		
		_ext._InternalPopulateMCM(SLTMCM)
		
		i += 1
	endwhile
	
	SLTMCM.SetExtensionPages(extensionFriendlyNames, extensionKeys)
	
	SendModEvent(EVENT_SLT_POPULATE_MCM())
EndFunction

Function SendSettingsUpdateEvents()
	int i = 0
	while i < settingsUpdateEvents.Length
		SendModEvent(settingsUpdateEvents[i])
		
		i += 1
	endwhile
	broadcastSettingsUpdated = true
EndFunction

Function AddAMEHeartbeat(string heartbeatEvent)
	Heap_StringListAddX(self, _GetPseudoInstanceKey(), "AMEHEARTBEATS", heartbeatEvent, false)
EndFunction

Function RemoveAMEHeartbeat(string heartbeatEvent)
	Heap_StringListRemoveX(self, _GetPseudoInstanceKey(), "AMEHEARTBEATS", heartbeatEvent, true)
EndFunction

int Function CountAMEHeartbeats()
	return Heap_StringListCountX(self, _GetPseudoInstanceKey(), "AMEHEARTBEATS")
EndFunction

string Function GetAMEHeartbeat(int index)
	return Heap_StringListGetX(self, _GetPseudoInstanceKey(), "AMEHEARTBEATS", index)
EndFunction