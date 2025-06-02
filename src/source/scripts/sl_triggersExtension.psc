scriptname sl_triggersExtension extends Quest

import sl_triggersStatics

; These must be set by extending scripts
string				Property SLTExtensionKey Auto Hidden
string				Property SLTFriendlyName Auto Hidden
int					Property SLTPriority Auto Hidden

; Properties
Actor               Property PlayerRef Auto

; sl_triggersMain SLT
; access to the sl_triggers API and framework
sl_triggersMain		Property SLT Auto Hidden ; will be populated on startup
Keyword				Property ActorTypeNPC Auto Hidden ; will be populated on startup
Keyword				Property ActorTypeUndead Auto Hidden ; will be populated on startup


; bool IsEnabled
; enabled status for this extension
; returns - true if BOTH sl_triggers AND this extension are enabled; false otherwise
bool				Property IsEnabled = true Auto Hidden
bool				Property bEnabled = true Auto Hidden ; enable/disable our extension

Function SetEnabled(bool _newEnabledFlag)
	if bEnabled != _newEnabledFlag
		bEnabled = _newEnabledFlag
		JsonUtil.SetIntValue(FN_S, "enabled", bEnabled as int)
	endif
	sl_triggers.SetLibrariesForExtensionAllowed(SLTExtensionKey, bEnabled)
	IsEnabled = SLT.bEnabled && bEnabled
EndFunction

; string[] TriggerKeys
; Holds the current known list of filenames (triggerKeys) representing triggers
; Transient; refreshed in OnInit()
; DO NOT MODIFY (I mean, unless you know what you're doing, right)
string[]			Property TriggerKeys Auto Hidden

string				Property FN_S Auto Hidden

string Function FN_T(string _triggerKey)
	return FN_Trigger(SLTExtensionKey, _triggerKey)
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;; The following section represents functions you either are
;; REQUIRED to override or that you are allowed to override if
;; you want custom functionality.
;;
;; Function names are "normal" here (no underscores or anything).
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bool Function CustomResolve(sl_triggersCmd CmdPrimary, string _code)
	return false
EndFunction

bool Function CustomResolveForm(sl_triggersCmd CmdPrimary, string _code)
	return false
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;; The following section represents functions you either are
;; REQUIRED to call at some point during lifecycle or that
;; you are likely to call while implementing your commands.
;;
;; Function names are "normal" here (no underscores or anything).
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; SLTInit
; DO NOT OVERRIDE
; REQUIRED CALL
; This function performs necessary setup for the extension and must be called at the start of each
; play session, i.e. from your OnInit()/OnPlayerLoadGame(). While there is no specific requirement for the call
; to be first or last at the time of this writing, take that into consideration if you
; run into problems.
Function SLTInit()
	FN_S = FN_X_Settings(SLTExtensionKey)
	_slt_BootstrapSLTInit()
EndFunction

; SLTReady
; OPTIONAL
; This stub gets called at the point the extension is registered. You can insert your own logic here.
Function SLTReady()
EndFunction


;/
OnSLTSettingsUpdated
OPTIONAL
All necessary updates relevant to the standard operation of the MCM is already handled.
If you want to do anything extra though, you can override this handler. It will
be registered at bootstrap.
/;
Event OnSLTSettingsUpdated(string eventName, string strArg, float numArg, Form sender)
EndEvent

Function SLTBootstrapInit()
EndFunction

; bool IsDebugMsg
; debug logging status for this extension
; returns - true if BOTH sl_triggers AND this extension have debug logging enabled; false otherwise
bool				Property IsDebugMsg
	bool Function Get()
		return _bDebugMsg && SLT.bDebugMsg
	EndFunction
	
	Function Set(bool value)
		_bDebugMsg = value
	EndFunction
EndProperty

; some helper methods
Int Function ActorRace(Actor _actor)
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

int Function ActorPos(int idx, int count)
    if idx >= count
        return 0
    elseif idx < 0 && count > 0
        return count - 1
    endIf
    return idx
endFunction

Int Function DayTime()
	float dayTime = Utility.GetCurrentGameTime()
 
	dayTime -= Math.Floor(dayTime)
	dayTime *= 24
	If dayTime >= 7 && dayTime <= 19
		return 1
	EndIf
	Return 2
EndFunction

; RequestCommand
; Actor _theActor: the Actor who will receive the magic effect to run the script
; string _theCommand: the SLT command file to execute
; This queues up a command to an Actor.
; returns: the instanceId created
bool Function RequestCommand(Actor _theActor, string _theCommand)
	return SLT.StartCommand(_theActor, _theCommand)
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;; Skip to the Triggers and Settings section
;; It is very large and was placed at the end.
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;;
;; Pay no attention to the main behind the curtain...
;; Function names below are prefixed with _slt_ to avoid naming collisions
;;
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; note: SLT also has these properties defined
bool				Property _bDebugMsg = false Auto Hidden ; enable/disable debug logging for our extension
string				Property currentTriggerId Auto Hidden ; used for simple iteration

; used to generate a stream of unique ids for each sl_triggersCmd
int		oneupnumber
string	settingsUpdateEvent 
string	gameLoadedEvent 
string 	internalReadyEvent

Event _slt_OnSLTInternalReady(string eventName, string strArg, float numArg, Form sender)
	if !self
		return
	endif
	UnregisterForModEvent(EVENT_SLT_INTERNAL_READY_EVENT())

	_slt_RegisterExtension()

	SLTReady()
EndEvent

Function _slt_PreSettingsUpdate()
	_slt_RefreshTriggers()
EndFunction

Function _slt_RefreshTriggers()
	TriggerKeys = sl_triggers.GetTriggerKeys(SLTExtensionKey)
EndFunction

Function _slt_BootstrapSLTInit()
	; fetch and store some key properties dynamically
	if !SLT
		SLT = GetForm_SLT_Main() as sl_triggersMain
	endif
	if !ActorTypeNPC
		ActorTypeNPC = GetForm_Skyrim_ActorTypeNPC() as Keyword
	endif
	if !ActorTypeUndead
		ActorTypeUndead = GetForm_Skyrim_ActorTypeUndead() as Keyword
	endif

	InitSettingsFile(FN_X_Settings(SLTExtensionKey))

	bEnabled = JsonUtil.GetIntValue(FN_S, "enabled") as bool
	SetEnabled(bEnabled)
	
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_INTERNAL_READY_EVENT(), "_slt_OnSLTInternalReady")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_SETTINGS_UPDATED(), "OnSLTSettingsUpdated")
	
	_slt_RefreshTriggers()

	SLTBootstrapInit()
EndFunction

Function _slt_RegisterExtension()
	if !SLT
		Debug.Trace("Extension.RegisterExtension: cannot locate global SLT instance, unable to register extension (" + SLTExtensionKey + ")")
		DebMsg("Extension.RegisterExtension: cannot locate global SLT instance, unable to register extension (" + SLTExtensionKey + ")")
		return
	endif
	int handle = ModEvent.Create(EVENT_SLT_REGISTER_EXTENSION())
	if !handle
		Debug.Trace("Extension.RegisterExtension: cannot create new modevent, unable to register extension (" + SLTExtensionKey + ")")
		DebMsg("Extension.RegisterExtension: cannot create new modevent, unable to register extension (" + SLTExtensionKey + ")")
		return
	endif
	ModEvent.PushForm(handle, self)
	ModEvent.Send(handle)
EndFunction

string Function _slt_GetInternalReadyEvent()
	if !internalReadyEvent
		internalReadyEvent = "_slt_SLT_INTERNAL_READY_" + (Utility.RandomInt(100000, 999999) as string)
	endif
	return internalReadyEvent
EndFunction

bool Function _slt_HasTriggers()
	return TriggerKeys.Length > 0
EndFunction


