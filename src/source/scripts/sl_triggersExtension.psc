scriptname sl_triggersExtension extends Quest

import sl_triggersStatics
import sl_triggersHeap

; Properties
Actor               Property PlayerRef Auto

; sl_triggersMain SLT
; access to the sl_triggers API and framework
sl_triggersMain		Property SLT Auto Hidden ; will be populated on startup
Keyword				Property ActorTypeNPC Auto Hidden ; will be populated on startup
Keyword				Property ActorTypeUndead Auto Hidden ; will be populated on startup

; string[] TriggerKeys
; Holds the current known list of filenames (triggerKeys) representing triggers
; Transient; refreshed in OnInit()
; DO NOT MODIFY (I mean, unless you know what you're doing, right)
string[]			Property TriggerKeys Auto Hidden

string				Property FN_S Hidden
	string Function Get()
		return FN_X_Settings(GetExtensionKey())
	EndFunction
EndProperty

string Function FN_T(string _triggerKey)
	return FN_Trigger(GetExtensionKey(), _triggerKey)
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

; GetExtensionKey
; OVERRIDE REQUIRED
; returns: the unique string identifier for this extension
;
; NOTE: This string will be used to generate and access a .JSON file tied
; to the extension and a folder to hold the extension's triggers. As such,
; it must adhere to filesystem standards.
string Function GetExtensionKey()
	return none
EndFunction

; GetFriendlyName
; OPTIONAL, OVERRIDE SUGGESTED
; returns: a human readable friendly name for your mod; if not specified, your extension key will be used
string Function GetFriendlyName()
	return GetExtensionKey()
EndFunction

; GetPriority
; OVERRIDE OPTIONAL
; returns: an integer priority value indicating where in the callchain any of this extensions
; 		added operations will take
; 	effectively provides the ability for an extension to override another extension's (including core's)
;		operations
;	lower priority wins; core is priority 0
int Function GetPriority()
	return 1000
EndFunction

bool Function CustomResolve(sl_triggersCmd CmdPrimary, string _code)
	return false
EndFunction

bool Function CustomResolveActor(sl_triggersCmd CmdPrimary, string _code)
	return false
EndFunction

bool Function CustomResolveCond(sl_triggersCmd CmdPrimary, string _p1, string _p2, string _oper)
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
; play session, i.e. from your OnInit(). While there is no specific requirement for the call
; to be first or last at the time of this writing, take that into consideration if you
; run into problems.
Function SLTInit()
	if !self
		return
	endif

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
	if !self
		return
	endif
EndEvent

; bool IsEnabled
; enabled status for this extension
; returns - true if BOTH sl_triggers AND this extension are enabled; false otherwise
bool				Property IsEnabled
	bool Function Get()
		return __bEnabled && SLT.bEnabled && _slt_AdditionalEnabledRequirements()
	EndFunction
	
	Function Set(bool value)
		__bEnabled = value
	EndFunction
EndProperty

Function SLTBootstrapInit()
EndFunction

bool Function _slt_AdditionalEnabledRequirements()
	return true
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
string Function RequestCommand(Actor _theActor, string _theCommand)
	if !self
		return ""
	endif
	
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
bool				Property __bEnabled = true Auto Hidden ; enable/disable our extension
bool				Property _bDebugMsg = false Auto Hidden ; enable/disable debug logging for our extension
string				Property currentTriggerId Auto Hidden ; used for simple iteration

; used to generate a stream of unique ids for each sl_triggersCmd
int		oneupnumber
string	settingsUpdateEvent 
string	gameLoadedEvent 
string 	internalReadyEvent 

Event _slt_OnSLTSettingsUpdated(string eventName, string strArg, float numArg, Form sender)
	if !self
		return
	endif
	_slt_RefreshTriggers()
EndEvent

Event _slt_OnSLTInternalReady(string eventName, string strArg, float numArg, Form sender)
	if !self
		return
	endif
	UnregisterForModEvent(EVENT_SLT_INTERNAL_READY_EVENT())

	_slt_RegisterExtension()

	SLTReady()
EndEvent

Function _slt_BootstrapSLTInit()
	if !self
		return
	endif
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

	InitSettingsFile(FN_X_Settings(GetExtensionKey()))
	
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_INTERNAL_READY_EVENT(), "_slt_OnSLTInternalReady")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_SETTINGS_UPDATED(), "OnSLTSettingsUpdated")
	SafeRegisterForModEvent_Quest(self, _slt_GetSettingsUpdateEvent(), "_slt_OnSLTSettingsUpdated")
	
	_slt_RefreshTriggers()

	SLTBootstrapInit()
EndFunction

Function _slt_RegisterExtension()
	if !self
		return
	endif

	if !SLT
		Debug.Trace("Extension.RegisterExtension: cannot locate global SLT instance, unable to register extension (" + GetExtensionKey() + ")")
		DebMsg("Extension.RegisterExtension: cannot locate global SLT instance, unable to register extension (" + GetExtensionKey() + ")")
	endif
	sl_triggersMain.SelfRegisterExtension(self)
EndFunction

string Function _slt_GetSettingsUpdateEvent()
	if !settingsUpdateEvent
		settingsUpdateEvent = "_slt_SLT_SETTINGS_UPDATE_" + (Utility.RandomInt(100000, 999999) as string)
	endif
	return settingsUpdateEvent
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

Function _slt_RefreshTriggers()
	if !self
		return
	endif

	; the settings
	JsonUtil.Load(FN_X_Settings(GetExtensionKey()))

	; the triggers
	string triggerFolder = ExtensionTriggersFolder(GetExtensionKey())
	TriggerKeys = JsonUtil.JsonInFolder(triggerFolder)
	
	if TriggerKeys
		int i = 0
		while i < TriggerKeys.Length
			JsonUtil.Load(triggerFolder + TriggerKeys[i])

			i += 1
		endwhile
	endif
EndFunction


