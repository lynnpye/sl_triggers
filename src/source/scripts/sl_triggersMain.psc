Scriptname sl_TriggersMain extends Quest

import sl_triggersStatics

; CONSTANTS
int		SLT_HEARTBEAT					= 0
int		SLT_BOOTSTRAPPING				= 100

int		REGISTRATION_BEACON_COUNT		= 15

; Properties
Actor               Property PlayerRef				Auto
sl_triggersSetup	Property SLTMCM					Auto


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

Keyword[] Property LocationKeywords Auto Hidden



bool				Property bEnabled		= true	Auto Hidden
bool				Property bDebugMsg		= false	Auto Hidden
Form[]				Property Extensions				Auto Hidden
int					Property nextInstanceId			Auto Hidden

int					Property RunningScriptCount = 0 Auto Hidden

; Variables
int			SLTUpdateState
int			_registrationBeaconCount

string[] global_var_keys
string[] global_var_vals

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

	global_var_keys = PapyrusUtil.StringArray(0)
	global_var_vals = PapyrusUtil.StringArray(0)
	BootstrapSLTInit()
EndEvent

Function DoPlayerLoadGame()
	if bDebugMsg
		SLTDebugMsg("Main.DoPlayerLoadGame")
	endif
	if !self
		return
	endif
	BootstrapSLTInit()
EndFunction

Function BootstrapSLTInit()
	if bDebugMsg
		SLTDebugMsg("Main.BootstrapSLTInit")
	endif
	if !self
		return
	endif

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
			SLTDebugMsg("Main: Setting extension pages for SLTMCM")
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
	SendModEvent(EVENT_SLT_RESET())
	StorageUtil.ClearAllObjPrefix(self, "SLTR:")
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

string Function GetGlobalVar(string _key, string missing)
	int i = global_var_keys.Find(_key, 0)
	if i > -1
		return global_var_vals[i]
	endif
	return missing
EndFunction

string Function SetGlobalVar(string _key, string value)
	int i = global_var_keys.Find(_key, 0)
	if i < 0
		global_var_keys = PapyrusUtil.PushString(global_var_keys, _key)
		global_var_vals = PapyrusUtil.ResizeStringArray(global_var_vals, global_var_keys.Length)
		i = global_var_keys.Find(_key, 0)
	endif
	if i > -1
		global_var_vals[i] = value
		return value
	endif
	return ""
EndFunction

; I blame the DayQuil
string[]	thread_pending_info

string[] Function ClaimNextThread(int targetformid)
	int i = 0
	int j
	while i < thread_pending_info.Length
		int fid = thread_pending_info[i + 2] as int
		if fid == targetformid
			thread_pending_info[i + 2] = 0
			string[] result = new string[2]
			result[0] = thread_pending_info[i]
			result[1] = thread_pending_info[i + 1]
			if (i + 3) < thread_pending_info.length
				thread_pending_info = PapyrusUtil.MergeStringArray(PapyrusUtil.SliceStringArray(thread_pending_info, 0, i - 1), PapyrusUtil.SliceStringArray(thread_pending_info, i + 3))
			else
				thread_pending_info = PapyrusUtil.SliceStringArray(thread_pending_info, 0, i - 1)
			endif
			return result
		endif

		i += 3
	endwhile
	return none
EndFunction

; StartCommand
; Form targetForm: the Actor to attach this command to
; string initialScriptName: the file to run
Function StartCommand(Form targetForm, string initialScriptName)
	if !self
		return
	endif

	Actor target = targetForm as Actor ; for now, only Actors
	if !target
		target = PlayerRef
	endif

	int threadid = GetNextInstanceId()

	string[] new_thread_info = new string[3]

	new_thread_info[0] = threadid as string
	new_thread_info[1] = initialScriptName
	new_thread_info[2] = target.GetFormID() as string

	if !thread_pending_info
		thread_pending_info = new_thread_info
	else
		thread_pending_info = PapyrusUtil.MergeStringArray(thread_pending_info, new_thread_info)
	endif

	bool scriptStarted = sl_triggers_internal.StartScript(target, initialScriptName)
	if !scriptStarted
		SLTWarnMsg("Too many SLTR effects on target(" + target + "); attempting to delay script execution")
		target.SendModEvent(EVENT_SLT_DELAY_START_COMMAND(), initialScriptName, 0.0)
	endif
EndFunction

; flagset: bool[] - min length >= 19
; Upon return, flagset will have the following values (true if the indicated keyword is present at current location):
; [0] - no Location set
; [1] - LocTypePlayerHome
; [2] - LocTypeJail
; ...etc
Function GetPlayerLocationFlags(bool[] flagset)
	if !flagset.Length
		return
	endif

	Location pLoc = PlayerRef.GetCurrentLocation()
	flagset[0] = pLoc != none

	int i = 1
	while i < LocationKeywords.Length && i < flagset.Length
		flagset[i] = pLoc.HasKeyword(LocationKeywords[i - 1])
		i += 1
	endwhile
EndFunction

Function GetActorLocationFlags(Actor theActor, bool[] flagset)
	if !flagset.Length || !theActor
		return
	endif

	Location pLoc = theActor.GetCurrentLocation()
	flagset[0] = pLoc != none

	int i = 1
	while i < LocationKeywords.Length && i < flagset.Length
		flagset[i] = pLoc.HasKeyword(LocationKeywords[i - 1])
		i += 1
	endwhile
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

; available in a pinch, but not performant
bool Function PlayerIsInDungeon()
	if !PlayerRef.GetParentCell().IsInterior()
		return false
	endif
	Location pLoc = PlayerRef.GetCurrentLocation()

	return pLoc && (pLoc.HasKeyword(LocTypeDraugrCrypt) || ploc.HasKeyword(LocTypeDragonPriestLair) || ploc.HasKeyword(LocTypeFalmerHive) || ploc.HasKeyword(LocTypeVampireLair) || ploc.HasKeyword(LocTypeDwarvenAutomatons) || ploc.HasKeyword(LocTypeDungeon) || ploc.HasKeyword(LocTypeMine) || ploc.HasKeyword(LocSetCave))
EndFunction

bool Function PlayerIsInWilderness()
	if PlayerRef.GetParentCell().IsInterior()
		return false
	endif
	Location pLoc = PlayerRef.GetCurrentLocation()

	return !pLoc || pLoc.HasKeyword(LocTypeHold) || ploc.HasKeyword(LocTypeBanditCamp) || ploc.HasKeyword(LocTypeMilitaryFort)
EndFunction

bool Function PlayerIsInCity()
	Location pLoc = PlayerRef.GetCurrentLocation()

	return pLoc && (pLoc.HasKeyword(LocTypeCity) || pLoc.HasKeyword(LocTypeTown) || pLoc.HasKeyword(LocTypeHabitation) || pLoc.HasKeyword(LocTypeDwelling))
EndFunction

bool Function PlayerIsInSafeLocation()
	Location pLoc = PlayerRef.GetCurrentLocation()

	return pLoc && (pLoc.HasKeyword(LocTypePlayerHome) || pLoc.HasKeyword(LocTypeJail) || pLoc.HasKeyword(LocTypeInn))
EndFunction

bool Function ActorIsInDungeon(Actor theActor)
	if !theActor.GetParentCell().IsInterior()
		return false
	endif
	Location pLoc = theActor.GetCurrentLocation()

	return pLoc && (pLoc.HasKeyword(LocTypeDraugrCrypt) || ploc.HasKeyword(LocTypeDragonPriestLair) || ploc.HasKeyword(LocTypeFalmerHive) || ploc.HasKeyword(LocTypeVampireLair) || ploc.HasKeyword(LocTypeDwarvenAutomatons) || ploc.HasKeyword(LocTypeDungeon) || ploc.HasKeyword(LocTypeMine) || ploc.HasKeyword(LocSetCave))
EndFunction

bool Function ActorIsInWilderness(Actor theActor)
	if theActor.GetParentCell().IsInterior()
		return false
	endif
	Location pLoc = theActor.GetCurrentLocation()

	return !pLoc || pLoc.HasKeyword(LocTypeHold) || ploc.HasKeyword(LocTypeBanditCamp) || ploc.HasKeyword(LocTypeMilitaryFort)
EndFunction

bool Function ActorIsInCity(Actor theActor)
	Location pLoc = theActor.GetCurrentLocation()

	return pLoc && (pLoc.HasKeyword(LocTypeCity) || pLoc.HasKeyword(LocTypeTown) || pLoc.HasKeyword(LocTypeHabitation) || pLoc.HasKeyword(LocTypeDwelling))
EndFunction

bool Function ActorIsInSafeLocation(Actor theActor)
	Location pLoc = theActor.GetCurrentLocation()

	return pLoc && (pLoc.HasKeyword(LocTypePlayerHome) || pLoc.HasKeyword(LocTypeJail) || pLoc.HasKeyword(LocTypeInn))
EndFunction