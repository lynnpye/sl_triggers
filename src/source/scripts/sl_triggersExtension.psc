scriptname sl_triggersExtension extends Quest

import sl_triggersStatics

; These must be set by extending scripts
string				Property SLTExtensionKey Auto
string				Property SLTFriendlyName Auto
int					Property SLTPriority Auto
string				Property SLTScope Auto

; Properties
Actor               Property PlayerRef Auto

; sl_triggersMain SLT
; access to the sl_triggers API and framework
sl_triggersMain		Property SLT Auto Hidden ; will be populated on startup
Keyword				Property ActorTypeNPC Auto Hidden ; will be populated on startup
Keyword				Property ActorTypeUndead Auto Hidden ; will be populated on startup

int Property SLTRVersion = 0 Auto Hidden

; bool IsEnabled
; enabled status for this extension
; returns - true if BOTH sl_triggers AND this extension are enabled; false otherwise
bool				Property IsEnabled Hidden
	bool Function Get()
		return SLT.IsEnabled && bEnabled
	EndFunction
EndProperty
bool				Property bEnabled = true Auto Hidden ; enable/disable our extension

; optional override for additional real-time enabled requirements
bool Function _slt_AdditionalRequirementsSatisfied()
	return true
EndFunction

Function SetEnabled(bool _newEnabledFlag)
	bEnabled = UpdateFlag(SLT.Debug_Setup || SLT.Debug_Extension, FN_S, "enabled", _newEnabledFlag) && _slt_AdditionalRequirementsSatisfied()
	if SLT.Debug_Extension_SexLab
		SLTDebugMsg("SexLab.SetEnabled => (" + IsEnabled + ") vs bEnabled(" + bEnabled + ")")
	endif
	;IsEnabled = SLT.IsEnabled && bEnabled
	sl_triggers_internal.SetExtensionEnabled(SLTExtensionKey, bEnabled)
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

;/
bool Function CustomResolveForm(string token, Actor targetActor, int threadContextHandle)
	return false
EndFunction
/;

; SLTReady
; OPTIONAL
; This stub gets called at the point the extension is registered. You can insert your own logic here.
Function SLTReady()
EndFunction

;/
SLTSettingsUpdated
OPTIONAL
All necessary updates relevant to the standard operation of the MCM is already handled.
If you want to do anything extra though, you can override this handler. It will
be registered at bootstrap.
/;
Function SLTSettingsUpdated()
EndFunction

;/
bool Function CustomResolve(sl_triggersCmd CmdPrimary, string token)
	return false
EndFunction

bool Function CustomResolveForm(sl_triggersCmd CmdPrimary, string token)
	return false
EndFunction
/;

bool Function CustomResolveScoped(sl_triggersCmd CmdPrimary, string scope, string token)
	return false
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

bool Function DayTime()
	float dayTime = Utility.GetCurrentGameTime()
 
	dayTime -= Math.Floor(dayTime)
	dayTime *= 24
	return (dayTime >= 7 && dayTime <= 19)
EndFunction


; note: SLT also has these properties defined
bool				Property _bDebugMsg = false Auto Hidden ; enable/disable debug logging for our extension
string				Property currentTriggerId Auto Hidden ; used for simple iteration

; used to generate a stream of unique ids for each sl_triggersCmd
int		oneupnumber
string	settingsUpdateEvent 
string	gameLoadedEvent 
string 	internalReadyEvent


Event OnSLTSettingsUpdated(string eventName, string strArg, float numArg, Form sender)
	SLTReady()
	SLTSettingsUpdated()
EndEvent

; SLTInit
; DO NOT OVERRIDE
; REQUIRED CALL
; This function performs necessary setup for the extension and must be called at the start of each
; play session, i.e. from your OnInit()/OnPlayerLoadGame(). While there is no specific requirement for the call
; to be first or last at the time of this writing, take that into consideration if you
; run into problems.
Function SLTInit()
	FN_S = FN_X_Settings(SLTExtensionKey)
	bEnabled = GetFlag(SLT.Debug_Setup || SLT.Debug_Extension, FN_S, "enabled", true)  && _slt_AdditionalRequirementsSatisfied()

	if !SLT
		SLT = GetSLTMain()
	endif
	if !ActorTypeNPC
		ActorTypeNPC = GetForm_Skyrim_ActorTypeNPC() as Keyword
	endif
	if !ActorTypeUndead
		ActorTypeUndead = GetForm_Skyrim_ActorTypeUndead() as Keyword
	endif

	sl_triggers_internal.SetExtensionEnabled(SLTExtensionKey, bEnabled)
	
	CheckVersionUpdates()
	
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_INTERNAL_READY_EVENT(), "OnSLTInternalReady")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_SETTINGS_UPDATED(), "OnSLTSettingsUpdated")
	
	_slt_RefreshTriggers()

	SLTReady()
EndFunction

; RequestCommand
; Actor _theActor: the Actor who will receive the magic effect to run the script
; string _theCommand: the SLT command file to execute
; This queues up a command to an Actor.
; returns: the instanceId created
bool Function RequestCommand(Actor _theActor, string _theScript)
	return SLT.StartCommand(_theActor, _theScript)
EndFunction

bool Function RequestCommandWithThreadId(Actor _theActor, string _theScript, int _requestId, int _threadid)
	return SLT.StartCommandWithThreadId(_theActor, _theScript, _requestId, _threadid)
EndFunction

Event OnSLTInternalReady(string eventName, string strArg, float numArg, Form sender)
	if !self
		return
	endif
	UnregisterForModEvent(EVENT_SLT_INTERNAL_READY_EVENT())

	sl_triggersAPI.RegisterExtension(self)
EndEvent

Function _slt_RefreshTriggers()
	TriggerKeys = sl_triggers_internal.GetTriggerKeys(SLTExtensionKey)
	If (SLT.Debug_Cmd_RunScript || SLT.Debug_Extension || SLT.Debug_Setup || SLT.Debug_Extension_Core_Keymapping)
		SLTDebugMsg("_slt_RefreshTriggers: TriggerKeys(" + PapyrusUtil.StringJoin(TriggerKeys, "),(") + ")")
	EndIf
	RefreshTriggerCache()
EndFunction

Function RefreshTriggerCache()
EndFunction

Function CheckVersionUpdates()
	int newVersion = GetModVersion()
	If (SLT.Debug_Extension || SLT.Debug_Setup)
		SLTDebugMsg("Extension(" + SLTExtensionKey + ").CheckVersionUpdates: oldVersion(" + SLTRVersion + ") newVersion(" + newVersion + ")")
	EndIf
	int oldVersion = SLTRVersion
	SLTRVersion = newVersion

	if (newVersion > oldVersion)
		HandleVersionUpdate(oldVersion, newVersion)
	endif
EndFunction

Function HandleVersionUpdate(int oldVersion, int newVersion)
	If (SLT.Debug_Extension || SLT.Debug_Setup)
		SLTDebugMsg("Extension(" + SLTExtensionKey + ").HandleVersionUpdate: oldVersion(" + SLTRVersion + ") newVersion(" + newVersion + "): no override defined")
	EndIf
EndFunction