Scriptname sl_TriggersMain extends Quest

import sl_triggersStatics
import sl_triggersHeap
import sl_triggersFile

; CONSTANTS
int		REGISTRATION_STATE_PENDING		= 0
int		REGISTRATION_STATE_OPEN			= 1
int		REGISTRATION_STATE_CLOSED		= 1000
string	EVENT_SLT_GAME_LOADED_HANDLER	= "OnSLTGameLoaded"
string	EVENT_SLT_CLOSE_REGISTRATION_HANDLER = "OnSLTCloseRegistration"
string	EVENT_SLT_CORE_INIT_HANDLER		= "OnSLTCoreInit"
;string	TEMP_KEYCODE_LIST				= "sl_triggers:::KEYCODE_LIST"
;string	SUMO_EXTENSION_LIST				= "slt:sumoextensionlist"
string	SETTINGS_VERSION				= "version"
float	SECONDS_FOR_REGISTRATION		= 4.0 ; seconds we wait to allow registration of extensions
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
Bool				Property bDebugMsg = false 		Auto Hidden

; Variables
int		registrationState = 0
Form[]	extensions
Form[]	extensionBuffer
float	lastRealTime = 0.0
float	lastGameTime = 0.0
bool 	gameHasLoaded = false
bool	coreInitCompleted = false

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
	return Settings_IntGet(SettingsFilename(), SETTINGS_VERSION, GetModVersion())
EndFunction

Function SetSettingsVersion(int newVersion = -1)
	if newVersion == -1
		Settings_IntSet(SettingsFilename(), SETTINGS_VERSION, GetModVersion())
	else
		Settings_IntSet(SettingsFilename(), SETTINGS_VERSION, newVersion)
	endif
EndFunction

Event OnInit()
	registrationState = REGISTRATION_STATE_PENDING
	DebMsg("Main.OnInit")
	
	OpenRegistration()
	
	RegisterForModEvent(EVENT_SLT_CORE_INIT(), EVENT_SLT_CORE_INIT_HANDLER)
	
	coreInitCompleted = false
	DoCoreInit()
EndEvent

; because Utility.Wait() and OnInit() don't mix
Function DoCoreInit()
	if coreInitCompleted
		return
	endif
	Utility.Wait(0.0)
	SendModEvent(EVENT_SLT_CORE_INIT())
EndFunction

Event OnCoreInit()
	if coreInitCompleted
		return
	endif
	
	coreInitCompleted = true
	
	if !coreCmdMailbox0
		coreCmdMailbox0 = new ActiveMagicEffect[128]
		coreCmdMailbox1 = new ActiveMagicEffect[128]
		coreCmdMailbox2 = new ActiveMagicEffect[128]
		coreCmdMailbox3 = new ActiveMagicEffect[128]
		coreCmdNextMailbox = 0
		coreCmdNextSilo = 0
		coreCmdNextSlot = 0
		Debug.Trace("sl_trigger: Main: setting coreCmdMailbox")
	endif
	
	UnregisterForModEvent(EVENT_SLT_CORE_INIT())
	
	lastRealTime = Utility.GetCurrentRealTime()
	
	RegisterEvents()
	
	QueueUpdateLoop()
EndEvent

Event OnUpdate()
	if !self
		return
	endif
	DebMsg("Main.OnUpdate")
	
	float currentRealTime = Utility.GetCurrentRealTime()
	float currentGameTime = Utility.GetCurrentGameTime()
	
	if registrationState == REGISTRATION_STATE_OPEN && currentRealTime > SECONDS_FOR_REGISTRATION
		SendSLTCloseRegistration()
	endif
	
	if (currentRealTime - lastRealTime) > ALLOWED_REAL_DELTA && (currentGameTime - lastGameTime) < ALLOWED_GAME_DELTA
		SendSLTGameLoaded()
	endif
	
	lastRealTime = currentRealTime
	lastGameTime = currentGameTime
	
	QueueUpdateLoop()
EndEvent

Function UnregisterEvents()
	DebMsg("Main._unregisterEvents")
    if bDebugMsg
        Debug.Notification("SL Triggers: unregister events")
    endIf
	
	UnregisterForModEvent(EVENT_SLT_GAME_LOADED())
	UnregisterForModEvent(EVENT_SLT_CLOSE_REGISTRATION())
EndFunction

Function RegisterEvents()
	DebMsg("Main._registerEvents")
    if bDebugMsg
        Debug.Notification("SL Triggers: register events")
    endIf
	
	UnregisterForModEvent(EVENT_SLT_GAME_LOADED())
	RegisterForModEvent(EVENT_SLT_GAME_LOADED(), EVENT_SLT_GAME_LOADED_HANDLER)
	
	UnregisterForModEvent(EVENT_SLT_CLOSE_REGISTRATION())
	RegisterForModEvent(EVENT_SLT_CLOSE_REGISTRATION(), EVENT_SLT_CLOSE_REGISTRATION_HANDLER)
EndFunction

Function SendSLTGameLoaded()
	DebMsg("Main.SendSLTGameLoaded")
	if gameHasLoaded
		SendModEvent(EVENT_SLT_GAME_LOADED())
	else
		gameHasLoaded = true
		SendModEvent(EVENT_SLT_GAME_LOADED(), true)
	endif
EndFunction

Function SendSLTCloseRegistration()
	; preemptive and duplicated; sneaky extensions might register during 
	; the event dispatch window, but I also don't want to lose track
	; of the fact that this state needs to be set to CLOSED
	; so kindly leave it in both locations
	registrationState = REGISTRATION_STATE_CLOSED
	SendModEvent(EVENT_SLT_CLOSE_REGISTRATION())
EndFunction

; Event OnSLTGameLoaded
; OPTIONAL
; Sent by sl_triggers any time a game is loaded (i.e. when character is first created, and each time the character's save is loaded)
; strArg - "true" if this is the first load (i.e. just launching the game); "false" otherwise
Event OnSLTGameLoaded(string eventName, string strArg, float numArg, Form sender)
	DebMsg("Main.OnSLTGameLoaded: firstTime: " + (strArg as bool))
EndEvent

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
EndFunction

Function RegisterExtension(sl_triggersExtension newExtension)
	if registrationState == REGISTRATION_STATE_CLOSED
		Debug.Trace("sl_triggers: extension attempted registration but registrationState is CLOSED: " + newExtension.GetId())
		return
	EndIf
	
	if !extensionBuffer
		extensionBuffer = PapyrusUtil.FormArray(0)
	endif
	PapyrusUtil.PushForm(extensionBuffer, newExtension)
EndFunction

Function CloseRegistration()
	Utility.Wait(0.0)
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
	string _instanceId = _sltext._NextInstanceId()
    
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

string[] Function GetCommandsList()
	string[] _blank = new string[1]
	_blank[0] = ""
	return PapyrusUtil.MergeStringArray(_blank, JsonUtil.JsonInFolder(CommandsFolder()))
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
	endwhile
	
	SLTMCM.SetExtensionPages(extensionFriendlyNames, extensionKeys)
EndFunction