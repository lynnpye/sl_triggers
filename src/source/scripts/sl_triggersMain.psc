Scriptname sl_TriggersMain extends Quest

import sl_triggersStatics

; Feature Flags
bool Property FF_VersionUpdate_Remove_Race_Partner_Types = true Auto Hidden

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

Perk Property SLTRContainerPerk Auto

Keyword[] Property LocationKeywords Auto Hidden

Keyword				Property ActorTypeNPC Auto Hidden ; will be populated on startup
Keyword				Property ActorTypeUndead Auto Hidden ; will be populated on startup

; this is a save-unique timestamp, specifically the timestamp at the time this save was created
; (as each save gets it's own copy of the quest object, we simply store that timestamp during OnInit)
string				Property SaveTimestamp Auto Hidden

bool				Property IsResetting = false Auto Hidden
bool				Property bDebugMsg		= false	Auto Hidden
int					Property nextInstanceId			Auto Hidden
GlobalVariable 		Property GameDaysPassed Auto Hidden

Form[]				instensions
Form[] Function GetExtensions()
	if Debug_Extension_List || Debug_Setup
		SLTDebugMsg("Main.GetExtensions: FormListCount(" + StorageUtil.FormListCount(self, SLTRExtensionListKey()) + ") instensions.Length(" + instensions.Length + ")")
	endif
	if StorageUtil.FormListCount(self, SLTRExtensionListKey()) != instensions.Length
		instensions = StorageUtil.FormListToArray(self, SLTRExtensionListKey())
		int _xidx = instensions.Length - 1
		
		sl_TriggersExtension f_j
		sl_TriggersExtension f_i
		Form f_swap
		int j = 0
		while j < instensions.Length
			f_j = instensions[j] as sl_TriggersExtension
			int i = j + 1
			while i < instensions.Length
				f_i = instensions[i] as sl_TriggersExtension
				if f_i.GetPriority() < f_j.GetPriority()
					f_swap = instensions[j]
					instensions[j] = instensions[i]
					instensions[i] = f_swap
				endif
				i = i + 1
			endwhile
			j = j + 1
		endwhile
	endif
	return instensions
EndFunction

Function AddExtension(sl_triggersExtension newExtension)
	if Debug_Extension_List || Debug_Setup
		SLTDebugMsg("Main.AddExtension: before(" + newExtension.SLTExtensionKey + ") FormListCount(" + StorageUtil.FormListCount(self, SLTRExtensionListKey()) + ")")
	endif
	StorageUtil.FormListAdd(self, SLTRExtensionListKey(), newExtension, false)
	if Debug_Extension_List || Debug_Setup
		SLTDebugMsg("Main.AddExtension: after(" + newExtension.SLTExtensionKey + ") FormListCount(" + StorageUtil.FormListCount(self, SLTRExtensionListKey()) + ")")
	endif
EndFunction

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

string Property kglobal_map_prefix Hidden
	string Function Get()
		return DOMAIN_DATA_GLOBAL() + "maps:"
	EndFunction
EndProperty
string Property kglobal_list_prefix Hidden
	string Function Get()
		return DOMAIN_DATA_GLOBAL() + "lists:"
	EndFunction
EndProperty

; duplicated from sl_triggersCmd
int Property VS_SCOPE = 0 AutoReadOnly
int Property VS_NAME = 1 AutoReadOnly
int Property VS_TARGET_EXT = 2 AutoReadOnly
int Property VS_LIST_INDEX = 3 AutoReadOnly
int Property VS_MAP_KEY = 4 AutoReadOnly
int Property VS_RESOLVED_MAP_KEY = 5 AutoReadOnly
int Property VS_RESOLVED_LIST_INDEX = 6 AutoReadOnly

string Function VarScopeToString(string[] varscope)
	if varscope.Length >= VS_RESOLVED_MAP_KEY
		return "(SCOPE[" + varscope[VS_SCOPE] + "] / NAME[" + varscope[VS_NAME] + "] / TARGET_EXT[" + varscope[VS_TARGET_EXT] + "] / LIST_INDEX[" + varscope[VS_LIST_INDEX] + "] / MAP_KEY[" + varscope[VS_MAP_KEY] + "] / RESOLVED_MAP_KEY[" + varscope[VS_RESOLVED_MAP_KEY] + "] / RESOLVED_LIST_INDEX[" + varscope[VS_RESOLVED_LIST_INDEX] + "])"
	else
		return "(varscope.Length is only " + varscope.Length + ")"
	endif
EndFunction

; duplicated from sl_triggersCmd
int     Property RT_INVALID =   	0 AutoReadOnly
int     Property RT_STRING =    	1 AutoReadOnly
int     Property RT_BOOL =      	2 AutoReadOnly
int     Property RT_INT =       	3 AutoReadOnly
int     Property RT_FLOAT =     	4 AutoReadOnly
int     Property RT_FORM =      	5 AutoReadOnly
int		Property RT_LABEL =			6 AutoReadOnly
int		Property RT_MAP	=			7 AutoReadOnly
int		Property RT_ALIAS =			8 AutoReadOnly

int		Property RT_LIST_TYPE_OFFSET = 100 AutoReadOnly
int		Property RT_LIST_MIN = 		101 AutoReadOnly

int		Property RT_LIST_STRING =	101 AutoReadOnly
int		Property RT_LIST_BOOL =		102 AutoReadOnly
int		Property RT_LIST_INT =		103 AutoReadOnly
int		Property RT_LIST_FLOAT =	104 AutoReadOnly
int		Property RT_LIST_FORM =		105 AutoReadOnly
int		Property RT_LIST_LABEL = 	106 AutoReadOnly
int		Property RT_LIST_MAP = 		107 AutoReadOnly ; not actually valid, see the function
int		Property RT_LIST_ALIAS = 	108 AutoReadOnly

int		Property RT_LIST_MAX = 		108 AutoReadOnly

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
	elseif RT_MAP == rt_type
		return "RT_MAP"
	elseif RT_ALIAS == rt_type
		return "RT_ALIAS"
	elseif RT_LIST_STRING == rt_type
		return "RT_LIST_STRING"
	elseif RT_LIST_BOOL == rt_type
		return "RT_LIST_BOOL"
	elseif RT_LIST_INT == rt_type
		return "RT_LIST_INT"
	elseif RT_LIST_FLOAT == rt_type
		return "RT_LIST_FLOAT"
	elseif RT_LIST_FORM == rt_type
		return "RT_LIST_FORM"
	elseif RT_LIST_LABEL == rt_type
		return "RT_LIST_LABEL"
	;elseif RT_LIST_MAP == rt_type
	;	return "RT_LIST_MAP"
	elseif RT_LIST_ALIAS == rt_type
		return "RT_LIST_ALIAS"
    endif
    return "<invalid RT type: " + rt_type + ">"
EndFunction

bool Function RT_IsList(int rt_type)
	return RT_LIST_MIN <= rt_type && RT_LIST_MAX >= rt_type && RT_LIST_MAP != rt_type
EndFunction

int Function RT_ListSubType(int rt_type)
	if !RT_IsList(rt_type)
		return RT_INVALID
	endif
	return rt_type - RT_LIST_TYPE_OFFSET
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
bool Property Debug_Extension_List Auto Hidden
bool Property Debug_Extension_SexLab Auto Hidden
bool Property Debug_Extension_OStim Auto Hidden
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
	Debug_Extension_List				= GetFlag(Debug_Setup, fns, "Debug_Extension_List")
	Debug_Extension_SexLab				= GetFlag(Debug_Setup, fns, "Debug_Extension_SexLab")
	Debug_Extension_OStim				= GetFlag(Debug_Setup, fns, "Debug_Extension_OStim")
	Debug_Extension_CustomResolveScoped	= GetFlag(Debug_Setup, fns, "Debug_Extension_CustomResolveScoped")
EndFunction

Float Function GetTheGameTime()
	return GameDaysPassed.GetValue()
EndFunction

; Variables
int			SLTUpdateState
int			_registrationBeaconCount

string[] globalVarKeys
string[] globalVarVals
int[]    globalVarTypes

bool	__IsEnabled = true
bool				Property IsEnabled Hidden
	bool Function Get()
		return __IsEnabled
	EndFunction
	Function Set(bool value)
		if (value != __IsEnabled)
			__IsEnabled = value
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
	if bDebugMsg
		SLTDebugMsg("Main.DoPlayerLoadGame")
	endif

	SetupSettingsFlags()

	if !self
		return
	endif
	BootstrapSLTInit(false)
	
	SendEventSLTOnNewSession()
EndFunction

Function BootstrapSLTInit(bool bSetupFlags)
	if bDebugMsg
		SLTDebugMsg("Main.BootstrapSLTInit")
	endif
	
	if bSetupFlags
		SetupSettingsFlags()
	endif

	if !self
		return
	endif
	
	if !ActorTypeNPC
		ActorTypeNPC = GetForm_Skyrim_ActorTypeNPC() as Keyword
	endif
	if !ActorTypeUndead
		ActorTypeUndead = GetForm_Skyrim_ActorTypeUndead() as Keyword
	endif
	
	GameDaysPassed = sl_triggers.GetForm("GameDaysPassed") as GlobalVariable

	CheckVersionUpdates()

	if !globalVarKeys || !globalVarVals
		globalVarKeys = PapyrusUtil.StringArray(0)
		globalVarVals = PapyrusUtil.StringArray(0)
		globalVarTypes = PapyrusUtil.IntArray(0)
	endif

	SafeRegisterForModEvent_Quest(self, EVENT_SLT_RESET(), "OnSLTReset")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_DELAY_START_COMMAND(), "OnSLTDelayStartCommand")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REQUEST_COMMAND(), "OnSLTRequestCommand")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_REQUEST_LIST(), "OnSLTRequestList")
	
	SLTUpdateState = SLT_BOOTSTRAPPING
	_registrationBeaconCount = REGISTRATION_BEACON_COUNT
	
	StorageUtil.FormListRemove(self, SLTRExtensionListKey(), none, true)

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

			QueueUpdateLoop(0.01)
			return
		endif
	endif

	QueueUpdateLoop(60)
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

;/
Function DoRegistrationBeacon()
	if !self
		return
	endif
	SendSLTInternalReady()
EndFunction
/;

int Function GetNextInstanceId()
	if nextInstanceId < 0
		nextInstanceId = 0
	endif
	nextInstanceId += 1
	return nextInstanceId
EndFunction

Function DoInMemoryReset()
	if bDebugMsg
		SLTDebugMsg("Main: Sending SLT Reset event and clearing StorageUtil for SLTR objects")
	endif
	
	IsResetting = true

	; Clear all frame and thread contexts
	SendModEvent(EVENT_SLT_RESET())

EndFunction

Function SUClearQueuedScripts()
	StorageUtil.ClearAllPrefix(DOMAIN_PENDING_SCRIPT_FOR_TARGET_LIST())
EndFunction

Function SUClearSLTR()
	StorageUtil.ClearAllPrefix(DOMAIN_SLTR())
EndFunction

Event OnSLTReset(string eventName, string strArg, float numArg, Form sender)
	SUClearSLTR()

	; Clear global context
	globalVarKeys = none
	globalVarVals = none
	globalVarTypes = none
	
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
	Form[] sltrExtensions = GetExtensions()
	while i < sltrExtensions.Length
		sl_triggersExtension ext = sltrExtensions[i] as sl_triggersExtension
		if ext
			ext._slt_RefreshTriggers()
		endif
		
		i += 1
	endwhile
	SendSettingsUpdateBroadcast()
EndFunction

sl_triggersExtension Function GetExtensionByIndex(int _index)
	Form[] sltrExtensions = GetExtensions()
	return sltrExtensions[_index] as sl_triggersExtension
EndFunction

sl_triggersExtension Function GetExtensionByKey(string _extensionKey)
	int i = 0
	Form[] sltrExtensions = GetExtensions()
	while i < sltrExtensions.Length
		sl_triggersExtension slext = sltrExtensions[i] as sl_triggersExtension
		if slext && slext.SLTExtensionKey == _extensionKey
			return slext
		endif
		i += 1
	endwhile
	return none
EndFunction

sl_triggersExtension Function GetExtensionByScope(string _scope)
	int i = 0
	Form[] sltrExtensions = GetExtensions()
	while i < sltrExtensions.Length
		sl_triggersExtension slext = sltrExtensions[i] as sl_triggersExtension
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

Function IncrementRequestCounter(int requestId)
	string sukey = DOMAIN_DATA_REQUEST() + requestId
	int newcount = StorageUtil.AdjustIntValue(self, sukey, 1)
	if bDebugMsg
		SLTInfoMsg(">IncrementRequestCounter requestId(" + requestId + "): reached (" + newcount + "); sukey(" + sukey + ")")
	endif
EndFunction

Function DecrementRequestCounter(int requestId)
	string sukey = DOMAIN_DATA_REQUEST() + requestId
	int newcount = StorageUtil.AdjustIntValue(self, sukey, -1)
	if newcount < 1
		if bDebugMsg
			SLTInfoMsg("<DecrementRequestCounter requestId(" + requestId + "): reached (" + newcount + "); sukey prefix (" + sukey + "); clearing all")
		endif
		StorageUtil.ClearAllPrefix(sukey)
	else
		if bDebugMsg
			SLTInfoMsg("<DecrementRequestCounter requestId(" + requestId + "): reached (" + newcount + "); sukey prefix(" + sukey + "); unwinding")
		endif
	endif
EndFunction

Function EnqueueScriptForTarget(Form targetForm, int requestId, int threadid, string initialScriptName)
	If (!targetForm || !threadid || !initialScriptName || !requestId)
		SLTErrMsg("EnqueueScriptForTarget: Invalid arguments")
		return
	EndIf
	StorageUtil.StringListAdd(targetForm, DOMAIN_PENDING_SCRIPT_FOR_TARGET_LIST(), requestid + "|" + threadid + "|" + initialScriptName)
EndFunction

Function DequeueScriptForTarget(Form targetForm, int[] requestId, int[] threadid, string[] initialScriptName)
	If (!targetForm || !threadid.Length || !initialScriptName.Length || !requestId.Length)
		SLTErrMsg("DequeueScriptForTarget: Invalid arguments")
		return
	EndIf
	string requestString = StorageUtil.StringListShift(targetForm, DOMAIN_PENDING_SCRIPT_FOR_TARGET_LIST())
	string[] requestBits = PapyrusUtil.StringSplit(requestString, "|")
	requestid[0] = requestBits[0] as int
	threadid[0] = requestBits[1] as int
	initialScriptName[0] = requestBits[2]
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

	Form actualTargetForm
	Actor actualTarget
	if targetForm
		actualTarget = targetForm as Actor ; for now, only Actors
		if !actualTarget
			SLTErrMsg("Main.StartCommandWithThreadId: non-Actor targets are not supported at this time: targetForm(" + targetForm + ")")
			return
		endif
		actualTargetForm = targetForm
	else
		actualTarget = PlayerRef
		actualTargetForm = actualTarget
	endif

	EnqueueScriptForTarget(actualTargetForm, requestId, threadid, initialScriptName)
	
	if bDebugMsg
		SLTDebugMsg("Calling sl_triggers_internal.StartScript(actualTarget=<" + actualTarget + ">, initialScriptName=<" + initialScriptName + ">)")
	endif
	bool scriptStarted = sl_triggers_internal.StartScript(actualTarget, initialScriptName)
	if !scriptStarted
		SLTWarnMsg("Too many SLTR effects on actualTarget(" + actualTarget + "); attempting to delay script execution")
		actualTarget.SendModEvent(EVENT_SLT_DELAY_START_COMMAND(), initialScriptName, 0.0)
	else
		if bDebugMsg
			SLTDebugMsg("sl_triggers_internal.StartScript(actualTarget=<" + actualTarget + ">, initialScriptName=<" + initialScriptName + ">) reported success")
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
	if bDebugMsg
		SLTDebugMsg("Main.CheckVersionUpdates: oldVersion(" + SLTRVersion + ") newVersion(" + newVersion + ")")
	endif

	SLTRVersion = newVersion
EndFunction

; some helper methods
Int Function ActorRaceType(Actor _actor)
    if _actor == PlayerRef
        return 1
    endIf
	If _actor.HasKeyword(ActorTypeUndead)
		return 3
	EndIf
	If _actor.HasKeyword(ActorTypeNPC)
		return 2
	EndIf
	return 4
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;; Global
;;
bool Function HasGlobalVar(string[] varscope)
	return (globalVarKeys.Find(varscope[VS_NAME], 0) > -1)
EndFunction

string Function GetGlobalMapKey(string[] varscope)
	return kglobal_map_prefix + varscope[VS_NAME] + ":"
EndFunction

string Function GetGlobalListKey(string[] varscope)
	return kglobal_list_prefix + varscope[VS_NAME] + ":"
EndFunction

int Function GetGlobalVarType(string[] varscope)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	if i > -1
		int rt = globalVarTypes[i]
		if RT_MAP == rt
			if (varscope[VS_RESOLVED_MAP_KEY])
				return StorageUtil.GetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY])
			elseif (!varscope[VS_MAP_KEY])
				return RT_MAP
			endif
		elseIf RT_IsList(rt)
			if (varscope[VS_RESOLVED_LIST_INDEX])
				return rt - RT_LIST_TYPE_OFFSET
			endif
		    return rt
        else
		    return rt
		endif
	endif
    return RT_INVALID
EndFunction

string Function GetGlobalVarString(sl_triggersCmd cmdPrimary, string[] varscope, string missing)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	if i > -1
		int rt = globalVarTypes[i]
		if RT_BOOL == rt
			return (globalVarVals[i] != "")
		elseIf RT_MAP == rt
			If (varscope[VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY])
				if RT_BOOL == subrt
					return (StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) != "")
				endif
				return StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY])
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce map to string; did you forget a map key?")
				return missing
			EndIf
		elseIf RT_IsList(rt)
			if (varscope[VS_RESOLVED_LIST_INDEX])
				int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
				if RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) != "")
				endif
				return StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli)
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce list to string; did you forget a list index?")
				return missing
			endif
		endif
		return globalVarVals[i]
	endif
	return missing
EndFunction

string Function GetGlobalVarLabel(sl_triggersCmd cmdPrimary, string[] varscope, string missing)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	if i > -1
		int rt = globalVarTypes[i]
		if RT_BOOL == rt
			return (globalVarVals[i] != "")
		elseIf RT_MAP == rt
			If (varscope[VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY])
				if RT_BOOL == subrt
					return (StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) != "")
				endif
				return StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY])
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce map to label; did you forget a map key?")
				return missing
			EndIf
		elseIf RT_IsList(rt)
			if (varscope[VS_RESOLVED_LIST_INDEX])
				int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
				if RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) != "")
				endif
				return StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli)
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce list to label; did you forget a list index?")
				return missing
			endif
		endif
		return globalVarVals[i]
	endif
	return missing
EndFunction

bool Function GetGlobalVarBool(sl_triggersCmd cmdPrimary, string[] varscope, bool missing)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	if i > -1
        int rt = globalVarTypes[i]
        if RT_BOOL == rt
            return globalVarVals[i] != ""
        elseif RT_INT == rt
            return (globalVarVals[i] as int) != 0
        elseif RT_FLOAT == rt
            return (globalVarVals[i] as float) != 0
        elseif RT_STRING == rt
            return globalVarVals[i] != ""
        elseIf RT_FORM == rt
            return (globalVarVals[i] as int) != 0
		elseIf RT_MAP == rt
			If (varscope[VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY])
				if RT_BOOL == subrt
					return (StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) != "")
				elseif RT_INT == subrt
					return (StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as int) != 0
				elseif RT_FLOAT == subrt
					return (StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as float) != 0.0
				elseif RT_STRING == subrt
					return StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) != ""
				elseif RT_FORM == subrt
					return (StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as int) != 0
				else
					cmdPrimary.SFE("GetGlobalVar: mapped var found but not recognized type(" + RT_ToString(subrt) + ")")
				endif
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce map to bool; did you forget a map key?")
			EndIf
		elseIf RT_IsList(rt)
			if (varscope[VS_RESOLVED_LIST_INDEX])
				int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
				if RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) != "")
				elseif RT_LIST_INT == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as int) != 0
				elseif RT_LIST_FLOAT == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as float) != 0.0
				elseif RT_LIST_STRING == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) != "")
				elseif RT_LIST_FORM == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as int) != 0
				elseif RT_LIST_LABEL == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) != "")
				else
					cmdPrimary.SFE("GetGlobalVar: list var found but not recognized type(" + RT_ToString(rt - RT_LIST_TYPE_OFFSET) + ")")
				endif
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce list to bool; did you forget a list index?")
				return missing
			endif
		else
        	cmdPrimary.SFE("GetGlobalVar: var found but not recognized type(" + RT_ToString(rt) + ")")
        endif
	endif
	return missing
EndFunction

int Function GetGlobalVarInt(sl_triggersCmd cmdPrimary, string[] varscope, int missing)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	if i > -1
        int rt = globalVarTypes[i]
        if RT_BOOL == rt
            return globalVarVals[i] as int
        elseif RT_INT == rt
            return globalVarVals[i] as int
        elseif RT_FLOAT == rt
            return (globalVarVals[i] as float) as int
        elseif RT_STRING == rt
            return globalVarVals[i] as int
        elseIf RT_FORM == rt
            return globalVarVals[i] as int
		elseIf RT_MAP == rt
			If (varscope[VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY])
				if RT_BOOL == subrt
					return StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as int
				elseif RT_INT == subrt
					return StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as int
				elseif RT_FLOAT == subrt
					return (StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as float) as int
				elseif RT_STRING == subrt
					return StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as int
				elseif RT_FORM == subrt
					return StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as int
				else
					cmdPrimary.SFE("GetGlobalVar: mapped var found but not recognized type(" + RT_ToString(subrt) + ")")
				endif
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce map to int; did you forget a map key?")
			EndIf
		elseIf RT_IsList(rt)
			if (varscope[VS_RESOLVED_LIST_INDEX])
				int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
				if RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as int)
				elseif RT_LIST_INT == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as int)
				elseif RT_LIST_FLOAT == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as float) as int
				elseif RT_LIST_STRING == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as int)
				elseif RT_LIST_FORM == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as int)
				elseif RT_LIST_LABEL == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as int)
				else
					cmdPrimary.SFE("GetGlobalVar: list var found but not recognized type(" + RT_ToString(rt - RT_LIST_TYPE_OFFSET) + ")")
				endif
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce list to int; did you forget a list index?")
				return missing
			endif
		else
        	cmdPrimary.SFE("GetGlobalVar: var found but not recognized type(" + RT_ToString(rt) + ")")
        endif
	endif
	return missing
EndFunction

float Function GetGlobalVarFloat(sl_triggersCmd cmdPrimary, string[] varscope, float missing)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	if i > -1
        int rt = globalVarTypes[i]
        if RT_BOOL == rt
            return globalVarVals[i] as float
        elseif RT_INT == rt
            return globalVarVals[i] as float
        elseif RT_FLOAT == rt
            return globalVarVals[i] as float
        elseif RT_STRING == rt
            return globalVarVals[i] as float
        elseIf RT_FORM == rt
            return globalVarVals[i] as float
		elseIf RT_MAP == rt
			If (varscope[VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY])
				if RT_BOOL == subrt
					return StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as float
				elseif RT_INT == subrt
					return StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as float
				elseif RT_FLOAT == subrt
					return StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as float
				elseif RT_STRING == subrt
					return StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as float
				elseif RT_FORM == subrt
					return StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as float
				else
					cmdPrimary.SFE("GetGlobalVar: mapped var found but not recognized type(" + RT_ToString(subrt) + ")")
				endif
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce map to float; did you forget a map key?")
			EndIf
		elseIf RT_IsList(rt)
			if (varscope[VS_RESOLVED_LIST_INDEX])
				int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
				if RT_LIST_BOOL == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as float)
				elseif RT_LIST_INT == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as float)
				elseif RT_LIST_FLOAT == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as float)
				elseif RT_LIST_STRING == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as float)
				elseif RT_LIST_FORM == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as float)
				elseif RT_LIST_LABEL == rt
					return (StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as float)
				else
					cmdPrimary.SFE("GetGlobalVar: list var found but not recognized type(" + RT_ToString(rt - RT_LIST_TYPE_OFFSET) + ")")
				endif
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce list to float; did you forget a list index?")
				return missing
			endif
		else
        	cmdPrimary.SFE("GetGlobalVar: var found but not recognized type(" + RT_ToString(rt) + ")")
        endif
	endif
	return missing
EndFunction

Form Function GetGlobalVarForm(sl_triggersCmd cmdPrimary, string[] varscope, Form missing)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	if i > -1
        int rt = globalVarTypes[i]
        if RT_BOOL == rt
            return none
        elseif RT_INT == rt
            return sl_triggers.GetForm(globalVarVals[i])
        elseif RT_FLOAT == rt
            return sl_triggers.GetForm((globalVarVals[i] as float) as int)
        elseif RT_STRING == rt
            return sl_triggers.GetForm(globalVarVals[i])
        elseIf RT_FORM == rt
            return sl_triggers.GetForm(globalVarVals[i])
		elseIf RT_MAP == rt
			If (varscope[VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY])
				if RT_BOOL == subrt
					return none
				elseif RT_INT == subrt
					return sl_triggers.GetForm(StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]))
				elseif RT_FLOAT == subrt
					return sl_triggers.GetForm((StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]) as float) as int)
				elseif RT_STRING == subrt
					return sl_triggers.GetForm(StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]))
				elseif RT_FORM == subrt
					return sl_triggers.GetForm(StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]))
				else
					cmdPrimary.SFE("GetGlobalVar: mapped var found but not recognized type(" + RT_ToString(subrt) + ")")
				endif
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce map to Form; did you forget a map key?")
			EndIf
		elseIf RT_IsList(rt)
			if (varscope[VS_RESOLVED_LIST_INDEX])
				int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
				if RT_LIST_BOOL == rt
					return none
				elseif RT_LIST_INT == rt
					return sl_triggers.GetForm(StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli))
				elseif RT_LIST_FLOAT == rt
					return sl_triggers.GetForm((StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli) as float) as int)
				elseif RT_LIST_STRING == rt
					return sl_triggers.GetForm(StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli))
				elseif RT_LIST_FORM == rt
					return sl_triggers.GetForm(StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli))
				elseif RT_LIST_LABEL == rt
					return sl_triggers.GetForm(StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli))
				else
					cmdPrimary.SFE("GetGlobalVar: list var found but not recognized type(" + RT_ToString(rt - RT_LIST_TYPE_OFFSET) + ")")
				endif
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce list to Form; did you forget a list index?")
				return missing
			endif
		else
        	cmdPrimary.SFE("GetGlobalVar: var found but not recognized type(" + RT_ToString(rt) + ")")
        endif
	endif
	return missing
EndFunction

Alias Function GetGlobalVarAlias(sl_triggersCmd cmdPrimary, string[] varscope)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	if i > -1
        int rt = globalVarTypes[i]
		if RT_ALIAS == rt
			return AliasFromAliasPortableString(globalVarVals[i])
		elseif RT_MAP == rt
			If (varscope[VS_RESOLVED_MAP_KEY])
				int subrt = StorageUtil.GetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY])
				if RT_ALIAS == subrt
					return AliasFromAliasPortableString(StorageUtil.GetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY]))
				else
					cmdPrimary.SFE("GetGlobalVar: mapped var found but not recognized type(" + RT_ToString(subrt) + "); expecting RT_ALIAS")
				endif
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce map to Alias; did you forget a map key?")
			EndIf
		elseif RT_LIST_ALIAS == rt
			if (varscope[VS_RESOLVED_LIST_INDEX])
				int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
				return AliasFromAliasPortableString(StorageUtil.StringListGet(self, GetGlobalListKey(varscope), rli))
			else
        		cmdPrimary.SFW("GetGlobalVar: unable to coerce list to Alias; did you forget a list index?")
			endif
		else
        	cmdPrimary.SFE("GetGlobalVar: var found but not recognized type(" + RT_ToString(rt) + "); expecting RT_ALIAS")
		endif
	endif
	return none
EndFunction

function UnsetGlobalMapKey(sl_triggersCmd cmdPrimary, string[] varscope, string mapkey)
    if !mapkey
        cmdPrimary.SFW("Attempted to unset empty map key: varscope(" + VarScopeToString(varscope) + ") mapkey(" + mapkey + ")")
    else
        StorageUtil.UnsetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + mapkey)
        StorageUtil.UnsetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + mapkey)
        StorageUtil.StringListRemove(self, kglobal_map_prefix + varscope[VS_NAME] + ":", mapkey)
    endif
endfunction

Function SetGlobalVarType(string[] varscope, int newType)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	if i < 0
		globalVarKeys = PapyrusUtil.PushString(globalVarKeys, varscope[VS_NAME])
        globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
        globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, newType)
    else
        globalVarVals[i] = ""
        globalVarTypes[i] = newType
    endif
EndFunction

string Function SetGlobalVarString(string[] varscope, string value)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	if i < 0
		globalVarKeys = PapyrusUtil.PushString(globalVarKeys, varscope[VS_NAME])
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_STRING)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_MAP)
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_LIST_STRING)
		else
			globalVarVals = PapyrusUtil.PushString(globalVarVals, value)
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_STRING)
		EndIf
	else
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_STRING)
			globalVarTypes[i] = RT_MAP
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rt = GetGlobalVarType(varscope)
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			If (RT_STRING == rt)
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			elseif RT_BOOL == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value != "")
			elseif RT_INT == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value as int)
			elseif RT_FLOAT == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value as float)
			elseif RT_FORM == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value as int)
			elseif RT_LABEL == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			EndIf
		else
			globalVarVals[i] = value
			globalVarTypes[i] = RT_STRING
		EndIf
	endif
	return value
EndFunction

string Function SetGlobalVarLabel(string[] varscope, string value)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	if i < 0
		globalVarKeys = PapyrusUtil.PushString(globalVarKeys, varscope[VS_NAME])
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_LABEL)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_MAP)
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_LIST_LABEL)
		else
			globalVarVals = PapyrusUtil.PushString(globalVarVals, value)
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_LABEL)
		EndIf
	else
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_LABEL)
			globalVarTypes[i] = RT_MAP
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rt = GetGlobalVarType(varscope)
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			If (RT_STRING == rt)
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			elseif RT_BOOL == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value != "")
			elseif RT_INT == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value as int)
			elseif RT_FLOAT == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value as float)
			elseif RT_FORM == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value as int)
			elseif RT_LABEL == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			EndIf
		else
			globalVarVals[i] = value
			globalVarTypes[i] = RT_LABEL
		EndIf
	endif
	return value
EndFunction

bool Function SetGlobalVarBool(string[] varscope, bool boolvalue)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	string value
	if boolvalue
		value = "1"
	endif
	if i < 0
		globalVarKeys = PapyrusUtil.PushString(globalVarKeys, varscope[VS_NAME])
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_BOOL)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_MAP)
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_LIST_BOOL)
		else
			globalVarVals = PapyrusUtil.PushString(globalVarVals, value)
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_BOOL)
		EndIf
    else
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_BOOL)
			globalVarTypes[i] = RT_MAP
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rt = GetGlobalVarType(varscope)
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			If (RT_STRING == rt)
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, boolvalue)
			elseif RT_BOOL == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			elseif RT_INT == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value as int)
			elseif RT_FLOAT == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value as float)
			elseif RT_FORM == rt
				; bool->Form => none; always
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, "")
			elseif RT_LABEL == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, boolvalue)
			EndIf
		else
			globalVarVals[i] = value
			globalVarTypes[i] = RT_BOOL
		EndIf
	endif
	return boolvalue
EndFunction

int Function SetGlobalVarInt(string[] varscope, int value)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	if i < 0
		globalVarKeys = PapyrusUtil.PushString(globalVarKeys, varscope[VS_NAME])
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_INT)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_MAP)
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_LIST_INT)
		else
			globalVarVals = PapyrusUtil.PushString(globalVarVals, value)
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_INT)
		EndIf
    else
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_INT)
			globalVarTypes[i] = RT_MAP
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rt = GetGlobalVarType(varscope)
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			If (RT_STRING == rt)
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			elseif RT_BOOL == rt
				string boolstrval
				if (value != 0)
					boolstrval = "1"
				endif
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, boolstrval)
			elseif RT_INT == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			elseif RT_FLOAT == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			elseif RT_FORM == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			elseif RT_LABEL == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			EndIf
		else
			globalVarVals[i] = value
			globalVarTypes[i] = RT_BOOL
		EndIf
	endif
	return value
EndFunction

float Function SetGlobalVarFloat(string[] varscope, float value)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	if i < 0
		globalVarKeys = PapyrusUtil.PushString(globalVarKeys, varscope[VS_NAME])
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_FLOAT)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_MAP)
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_LIST_FLOAT)
		else
			globalVarVals = PapyrusUtil.PushString(globalVarVals, value)
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_FLOAT)
		EndIf
    else
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_FLOAT)
			globalVarTypes[i] = RT_MAP
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rt = GetGlobalVarType(varscope)
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			If (RT_STRING == rt)
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			elseif RT_BOOL == rt
				string boolstrval
				if (value != 0.0)
					boolstrval = "1"
				endif
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, boolstrval)
			elseif RT_INT == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value as int)
			elseif RT_FLOAT == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			elseif RT_FORM == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value as int)
			elseif RT_LABEL == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			EndIf
		else
			globalVarVals[i] = value
			globalVarTypes[i] = RT_FLOAT
		EndIf
	endif
	return value
EndFunction

Form Function SetGlobalVarForm(string[] varscope, Form formvalue)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	string value
	if formvalue
		value = FormPortableStringFromForm(formvalue) ; formvalue.GetFormID()
	endif
	if i < 0
		globalVarKeys = PapyrusUtil.PushString(globalVarKeys, varscope[VS_NAME])
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_FORM)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_MAP)
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_LIST_FORM)
		else
			globalVarVals = PapyrusUtil.PushString(globalVarVals, value)
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_FORM)
		EndIf
    else
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_FORM)
			globalVarTypes[i] = RT_MAP
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rt = GetGlobalVarType(varscope)
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			If (RT_STRING == rt)
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			elseif RT_BOOL == rt
				string boolstrval
				if (formvalue != none)
					boolstrval = "1"
				endif
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, boolstrval)
			elseif RT_INT == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			elseif RT_FLOAT == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			elseif RT_FORM == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			elseif RT_LABEL == rt
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			EndIf
		else
			globalVarVals[i] = value
			globalVarTypes[i] = RT_FORM
		EndIf
	endif
	return formvalue
EndFunction

Alias Function SetGlobalVarAlias(string[] varscope, Alias aliasvalue)
	int i = globalVarKeys.Find(varscope[VS_NAME], 0)
	string value
	if aliasvalue
		value = AliasPortableStringFromAlias(aliasvalue)
	endif
	if i < 0
		globalVarKeys = PapyrusUtil.PushString(globalVarKeys, varscope[VS_NAME])
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_ALIAS)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_MAP)
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			globalVarVals = PapyrusUtil.PushString(globalVarVals, "")
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_LIST_ALIAS)
		else
			globalVarVals = PapyrusUtil.PushString(globalVarVals, value)
			globalVarTypes = PapyrusUtil.PushInt(globalVarTypes, RT_ALIAS)
		EndIf
	else
		If (varscope[VS_RESOLVED_MAP_KEY])
			StorageUtil.SetStringValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], value)
			StorageUtil.StringListAdd(self, kglobal_map_prefix + varscope[VS_NAME] + ":", varscope[VS_RESOLVED_MAP_KEY], false)
			StorageUtil.SetIntValue(self, kglobal_map_prefix + varscope[VS_NAME] + ":" + varscope[VS_RESOLVED_MAP_KEY], RT_ALIAS)
			globalVarTypes[i] = RT_MAP
		elseif(varscope[VS_RESOLVED_LIST_INDEX])
			int rt = GetGlobalVarType(varscope)
			int rli = varscope[VS_RESOLVED_LIST_INDEX] as int
			If (RT_ALIAS == rt)
				SU_StringListSet(self, GetGlobalListKey(varscope), rli, value)
			EndIf
		else
			globalVarVals[i] = value
			globalVarTypes[i] = RT_ALIAS
		EndIf
	endif
	return aliasvalue
EndFunction