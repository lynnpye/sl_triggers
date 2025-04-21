scriptname sl_triggersExtension extends Quest

import sl_triggersStatics
import sl_triggersFile
import sl_triggersHeap

; Properties
Actor               Property PlayerRef Auto

;/
Spell and Effect pools
OPTIONAL

You would only be required to assign spellPool and effectPool values
if you are adding new operations to be available in scripts, and those
cases you will also be extending the sl_triggersCmdBase script.

Each spell should be matched to an effect. The IDs don't matter so long
as your sl_triggersCmdBase script is appropriately attached and
configured for your use.

When a script calls for your operation, your CmdBase extension will be
added to the Actor and associated with the cluster of other CmdBase extension
(if any, but including the prime CmdBase) into it's own cluster to handle
all operations for that script execution. By doing this, which may end up
launching a cluster of ActiveMagicEffects all at once on one Actor, any
operation that is long running and might block other events from being handled
won't impact any other execution, as would happen if, for example,
the operations resided within the same script that handles the external events.

The purpose behind the pool is to allow multiple triggers to be running on
the same Actor at once. Without this, only a single ActiveMagicEffect would
get attached and would be responsible for, presumably, all script execution.
Even the best written such scenario would be rife with opportunity for
resource contention. Not good.
/;
Spell[]             Property SpellPool Auto
MagicEffect[]       Property EffectPool Auto

; sl_triggersMain SLT
; access to the sl_triggers API and framework
sl_triggersMain		Property SLT Auto Hidden ; will be populated on startup
Keyword				Property ActorTypeNPC Auto Hidden ; will be populated on startup
Keyword				Property ActorTypeUndead Auto Hidden ; will be populated on startup
sl_triggersSetup	Property SLTMCM Auto Hidden ; will be populated as needed

; string[] TriggerKeys
; Holds the current known list of filenames (triggerKeys) representing triggers
; Transient; refreshed in OnInit()
; DO NOT MODIFY (I mean, unless you know what you're doing, right)
string[]			Property TriggerKeys Auto Hidden

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
; PopulateMCM
; OPTIONAL
; Override if you wish to have the MCM automatically manage your trigger attributes. Will automatically
; be called as needed.
/;
Function PopulateMCM()
EndFunction

; bool IsEnabled
; enabled status for this extension
; returns - true if BOTH sl_triggers AND this extension are enabled; false otherwise
bool				Property IsEnabled
	bool Function Get()
		return bEnabled && SLT.bEnabled
	EndFunction
	
	Function Set(bool value)
		bEnabled = value
	EndFunction
EndProperty

; bool IsDebugMsg
; debug logging status for this extension
; returns - true if BOTH sl_triggers AND this extension have debug logging enabled; false otherwise
bool				Property IsDebugMsg
	bool Function Get()
		return bDebugMsg && SLT.bDebugMsg
	EndFunction
	
	Function Set(bool value)
		bDebugMsg = value
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
	
	return SLT.StartCommand(_theActor, _theCommand, self)
EndFunction

; DescribeSliderAttribute
; Tells setup to render the attribute via a Slider
; _formatString is optional
; _ptype accepted values: PTYPE_INT(), PTYPE_FLOAT()
Function DescribeSliderAttribute(string _attributeName, int _ptype, string _label, float _minValue, float _maxValue, float _interval, string _formatString = "", float _defaultValue = 0.0)
	SLTMCM.DescribeSliderAttribute(GetExtensionKey(), _attributeName, _ptype, _label, _minValue, _maxValue, _interval, _formatString, _defaultValue)
EndFunction

; DescribeMenuAttribute
; Tells setup to render the attribute via a menu
; _ptype accepted values: PTYPE_INT(), PTYPE_STRING()
Function DescribeMenuAttribute(string _attributeName, int _ptype, string _label, int _defaultIndex, string[] _menuSelections)
	SLTMCM.DescribeMenuAttribute(GetExtensionKey(), _attributeName, _ptype, _label, _defaultIndex, _menuSelections)
EndFunction

; DescribeKeymapAttribute
; Tells setup to render the attribute via a keymap
; _ptype accepted values: PTYPE_INT()
Function DescribeKeymapAttribute(string _attributeName, int _ptype, string _label, int _defaultValue = -1)
	SLTMCM.DescribeKeymapAttribute(GetExtensionKey(), _attributeName, _ptype, _label, _defaultValue)
EndFunction

; DescribeToggleAttribute
; Tells setup to render the attribute via a toggle
; _ptype accepted values: PTYPE_INT()
Function DescribeToggleAttribute(string _attributeName, int _ptype, string _label, int _defaultValue = 0)
	SLTMCM.DescribeToggleAttribute(GetExtensionKey(), _attributeName, _ptype, _label, _defaultValue)
EndFunction

; DescribeInputAttribute
; Tells setup to render the attribute via an input
; _ptype accepted values: Any
Function DescribeInputAttribute(string _attributeName, int _ptype, string _label, string _defaultValue = "")
	SLTMCM.DescribeInputAttribute(GetExtensionKey(), _attributeName, _ptype, _label, _defaultValue)
EndFunction

; AddCommandList
; Tells setup to render a dropdown list of available commands.
; You can call this multiple times to add the option of running
; multiple commands from the same trigger (i.e. 3 was legacy setting)
Function AddCommandList(string _attributeName, string _label)
	SLTMCM.AddCommandList(GetExtensionKey(), _attributeName, _label)
EndFunction

; SetVisibilityKeyAttribute
; Tells setup that the indicated attribute, _attributeName, will be used during
; MCM rendering to selectively render some of the attributes. This allows you
; to change how the MCM looks depending on what the user selects e.g. event
; types.
;
; This is NOT required if, for example, the same set of attributes will be displayed 
; for each trigger.
Function SetVisibilityKeyAttribute(string _attributeName)
	SLTMCM.SetVisibilityKeyAttribute(GetExtensionKey(), _attributeName)
EndFunction

; SetVisibleOnlyIf
; Tells setup that the specified attribute should only be displayed in the MCM if the
; visibility key attribute has the specified value. Note that this function will
; have no effect if SetVisibilityKeyAttribute() is not also called.
;
; If the PTYPE of the key attribute is int, cast to string for this call.
Function SetVisibleOnlyIf(string _attributeName, string _requiredKeyAttributeValue)
	SLTMCM.SetVisibleOnlyIf(GetExtensionKey(), _attributeName, _requiredKeyAttributeValue)
EndFunction

; SetHighlightText
; Tells setup what to display when the attribute is highlighted in the MCM.
Function SetHighlightText(string _attributeName, string _highlightText)
	SLTMCM.SetHighlightText(GetExtensionKey(), _attributeName, _highlightText)
EndFunction

; SetCurrentTriggerId
; OPTIONAL
; This is a potentially dangerous convenience option. When you set it, your extension keeps a pointer
; to the specified triggerKey. Any Trigger_ function that does not specify a triggerKey will use this value.
; Note the concerns about reentrancy if you do this.
Function SetCurrentTriggerId(string _newTriggerId)
	currentTriggerId = _newTriggerId
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
bool				Property bEnabled = true Auto Hidden ; enable/disable our extension
bool				Property bDebugMsg = false Auto Hidden ; enable/disable debug logging for our extension
string				Property currentTriggerId Auto Hidden ; used for simple iteration

; used to generate a stream of unique ids for each sl_triggersCmd
int		oneupnumber
;string	heartbeatEvent 
string	settingsUpdateEvent 
string	gameLoadedEvent 
string internalReadyEvent 

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
	UnregisterForModEvent("SLT_INTERNAL_READY_EVENT")

	_slt_RefreshTriggers()
	_slt_RegisterExtension()

	SLTReady()
EndEvent

Event OnSLTSettingsUpdated(string eventName, string strArg, float numArg, Form sender)
	if !self
		return
	endif
EndEvent

Function _slt_BootstrapSLTInit()
	if !self
		return
	endif
	; fetch and store some key properties dynamically
	if !SLT
		SLT = Game.GetFormFromFile(0xD62, "sl_triggers.esp") as sl_triggersMain
	endif
	if !ActorTypeNPC
		ActorTypeNPC = Game.GetFormFromFile(0x13794, "Skyrim.esm") as Keyword
	endif
	if !ActorTypeUndead
		ActorTypeUndead = Game.GetFormFromFile(0x13796, "Skyrim.esm") as Keyword
	endif

	;SafeRegisterForModEvent_Quest(self, _slt_GetHeartbeatEvent(), "_slt_OnSLTHeartbeat")
	
	;SafeRegisterForModEvent_Quest(self, _slt_GetInternalReadyEvent(), "_slt_OnSLTInternalReady")
	SafeRegisterForModEvent_Quest(self, "SLT_INTERNAL_READY_EVENT", "_slt_OnSLTInternalReady")
	SafeRegisterForModEvent_Quest(self, EVENT_SLT_SETTINGS_UPDATED(), "OnSLTSettingsUpdated")
	SafeRegisterForModEvent_Quest(self, _slt_GetSettingsUpdateEvent(), "_slt_OnSLTSettingsUpdated")
EndFunction

Function _slt_RegisterExtension()
	if !self
		return
	endif

	if !SLT
		Debug.Trace("Extension.RegisterExtension: cannot locate global SLT instance, unable to register extension (" + GetExtensionKey() + ")")
	endif
	Heap_FormSetX(SLT, PSEUDO_INSTANCE_KEY(), SUKEY_EXTENSION_REGISTRATION_QUEUE() + GetExtensionKey(), self)
	;Heap_FormListAddX(SLT, PSEUDO_INSTANCE_KEY(), SUKEY_EXTENSION_REGISTRATION_QUEUE(), self, false)
	SendModEvent(EVENT_SLT_REGISTER_EXTENSION(), GetExtensionKey())
EndFunction

Function _slt_PopulateMCM()
	if !self
		return
	endif
	SLTMCM.ClearSetupExtensionKeyHeap(GetExtensionKey())
	PopulateMCM()
EndFunction

;/
string Function _slt_GetHeartbeatEvent()
	if !heartbeatEvent
		heartbeatEvent = "_slt_SLT_HEARTBEAT_" + (Utility.RandomInt(100000, 999999) as string)
	endif
	return heartbeatEvent
EndFunction
/;

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

bool Function _slt_HasPool()
	return SpellPool.Length > 0 && EffectPool.Length > 0
EndFunction

bool Function _slt_HasTriggers()
	return TriggerKeys.Length > 0
EndFunction

Spell Function _slt_NextPooledSpellForActor(Actor _theActor)
	if !_theActor
		Debug.Trace("sl_triggersExtension.NextPooledSpellForActor: _theActor is none")
		return none
	endif
	
	int _i = 0
	while _i < SpellPool.Length && _i < EffectPool.Length
		if !_theActor.HasMagicEffect(EffectPool[_i])
			return SpellPool[_i]
		endif
	
		_i += 1
	endwhile
	
	Debug.Trace("sl_triggersExtension.NextPooledSpellForActor: No core effects available.")
	return none
EndFunction

; NextCycledInstanceNumber
; DO NOT OVERRIDE
; int oneupmin = -30000
; int oneupmax = 30000
; returns: the next value in the cycle; if the max is exceeded, the cycle resets to min
; 	if you get 60000 of these launched in your game, you win /sarcasm
int Function _slt_NextCycledInstanceNumber(int oneupmin = -30000, int oneupmax = 30000)
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
string Function _slt_NextInstanceId()
	return GetExtensionKey() + "(" + _slt_NextCycledInstanceNumber() + ")"
EndFunction

Function _slt_RefreshTriggers()
	if !self
		return
	endif
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;; Triggers and Settings
;; these are convenience routines which will
;; tie into the SLT framework
;; 
;; Trigger data will be stored in an
;; extension specific subfolder, one per
;; file.
;;
;; Settings will reside in a file alongside
;; the standard settings.json, named
;; <extensionkey>.json. These will be
;; settings specific to your mod.
;;
;; Strongly recommended that you DO NOT
;; override anything below this line.
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Trigger Data Convenience Functions
; Deleted status
bool Function Trigger_IsDeletedT(string _triggerKey)
	return JsonUtil.HasStringValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), DELETED_ATTRIBUTE())
EndFunction

; Specifying both triggerId and attributeName
; string
bool Function Trigger_StringHasT(string _triggerKey, string _attributeName)
	return JsonUtil.HasStringValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName)
EndFunction

string Function Trigger_StringGetT(string _triggerKey, string _attributeName, string _defaultValue = "")
	return JsonUtil.GetStringValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName, _defaultValue)
EndFunction

string Function Trigger_StringSetT(string _triggerKey, string _attributeName, string _value = "")
	return JsonUtil.SetStringValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName, _value)
EndFunction

bool Function Trigger_StringUnsetT(string _triggerKey, string _attributeName)
	return JsonUtil.UnsetStringValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName)
EndFunction


; Form
bool Function Trigger_FormHasT(string _triggerKey, string _attributeName)
	return JsonUtil.HasFormValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName)
EndFunction

Form Function Trigger_FormGetT(string _triggerKey, string _attributeName, Form _defaultValue = None)
	return JsonUtil.GetFormValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName, _defaultValue)
EndFunction

Form Function Trigger_FormSetT(string _triggerKey, string _attributeName, Form _value = None)
	return JsonUtil.SetFormValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName, _value)
EndFunction

bool Function Trigger_FormUnsetT(string _triggerKey, string _attributeName)
	return JsonUtil.UnsetFormValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName)
EndFunction


; float
bool Function Trigger_FloatHasT(string _triggerKey, string _attributeName)
	return JsonUtil.HasFloatValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName)
EndFunction

float Function Trigger_FloatGetT(string _triggerKey, string _attributeName, float _defaultValue = 0.0)
	return JsonUtil.GetFloatValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName, _defaultValue)
EndFunction

float Function Trigger_FloatSetT(string _triggerKey, string _attributeName, float _value = 0.0)
	return JsonUtil.SetFloatValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName, _value)
EndFunction

bool Function Trigger_FloatUnsetT(string _triggerKey, string _attributeName)
	return JsonUtil.UnsetFloatValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName)
EndFunction


; int
bool Function Trigger_IntHasT(string _triggerKey, string _attributeName)
	return JsonUtil.HasIntValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName)
EndFunction

int Function Trigger_IntGetT(string _triggerKey, string _attributeName, int _defaultValue = 0)
	return JsonUtil.GetIntValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName, _defaultValue)
EndFunction

int Function Trigger_IntSetT(string _triggerKey, string _attributeName, int _value = 0)
	return JsonUtil.SetIntValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName, _value)
EndFunction

bool Function Trigger_IntUnsetT(string _triggerKey, string _attributeName)
	return JsonUtil.UnsetIntValue(ExtensionTriggerName(GetExtensionKey(), _triggerKey), _attributeName)
EndFunction


; Using SetCurrentTriggerId with attributeName only
; string
bool Function Trigger_StringHas(string _attributeName)
	return Trigger_StringHasT(currentTriggerId, _attributeName)
EndFunction

string Function Trigger_StringGet(string _attributeName, string _defaultValue = "")
	return Trigger_StringGetT(currentTriggerId, _attributeName, _defaultValue)
EndFunction

string Function Trigger_StringSet(string _attributeName, string _value = "")
	return Trigger_StringSetT(currentTriggerId, _attributeName, _value)
EndFunction

bool Function Trigger_StringUnset(string _attributeName)
	return Trigger_StringUnsetT(currentTriggerId, _attributeName)
EndFunction


; Form
bool Function Trigger_FormHas(string _attributeName)
	return Trigger_FormHasT(currentTriggerId, _attributeName)
EndFunction

Form Function Trigger_FormGet(string _attributeName, Form _defaultValue = None)
	return Trigger_FormGetT(currentTriggerId, _attributeName, _defaultValue)
EndFunction

Form Function Trigger_FormSet(string _attributeName, Form _value = None)
	return Trigger_FormSetT(currentTriggerId, _attributeName, _value)
EndFunction

bool Function Trigger_FormUnset(string _attributeName)
	return Trigger_FormUnsetT(currentTriggerId, _attributeName)
EndFunction


; float
bool Function Trigger_FloatHas(string _attributeName)
	return Trigger_FloatHasT(currentTriggerId, _attributeName)
EndFunction

float Function Trigger_FloatGet(string _attributeName, float _defaultValue = 0.0)
	return Trigger_FloatGetT(currentTriggerId, _attributeName, _defaultValue)
EndFunction

float Function Trigger_FloatSet(string _attributeName, float _value = 0.0)
	return Trigger_FloatSetT(currentTriggerId, _attributeName, _value)
EndFunction

bool Function Trigger_FloatUnset(string _attributeName)
	return Trigger_FloatUnsetT(currentTriggerId, _attributeName)
EndFunction


; int
bool Function Trigger_IntHas(string _attributeName)
	return Trigger_IntHasT(currentTriggerId, _attributeName)
EndFunction

int Function Trigger_IntGet(string _attributeName, int _defaultValue = 0)
	return Trigger_IntGetT(currentTriggerId, _attributeName, _defaultValue)
EndFunction

int Function Trigger_IntSet(string _attributeName, int _value = 0)
	return Trigger_IntSetT(currentTriggerId, _attributeName, _value)
EndFunction

bool Function Trigger_IntUnset(string _attributeName)
	return Trigger_IntUnsetT(currentTriggerId, _attributeName)
EndFunction


; Settings Convenience Functions
; Using extensionId for settingsFileName as shortcut
; Settings - string
bool Function Settings_StringHasS(string _theKey)
	return JsonUtil.HasStringValue(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

string Function Settings_StringGetS(string _theKey, string _defaultValue = "")
	return JsonUtil.GetStringValue(SettingsFolder() + GetExtensionKey(), _theKey, _defaultValue)
EndFunction

string Function Settings_StringSetS(string _theKey, string _value = "")
	return JsonUtil.SetStringValue(SettingsFolder() + GetExtensionKey(), _theKey, _value)
EndFunction

bool Function Settings_StringUnsetS(string _theKey)
	return JsonUtil.UnsetStringValue(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction




; Settings - string[]
int Function Settings_StringListAddS(string _theKey, string _theValue, bool _allowDuplicate = true)
	return JsonUtil.StringListAdd(SettingsFolder() + GetExtensionKey(), _theKey, _theValue, _allowDuplicate)
EndFunction

string Function Settings_StringListGetS(string _theKey, int _theIndex)
	return JsonUtil.StringListGet(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex)
EndFunction

string Function Settings_StringListSetS(string _theKey, int _theIndex, string _theValue)
	return JsonUtil.StringListSet(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex, _theValue)
EndFunction

int Function Settings_StringListRemoveS(string _theKey, string _theValue, bool _allInstaces = true)
	return JsonUtil.StringListRemove(SettingsFolder() + GetExtensionKey(), _theKey, _theValue, _allInstaces)
EndFunction

bool Function Settings_StringListInsertAtS(string _theKey, int _theIndex, string _theValue)
	return JsonUtil.StringListInsertAt(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex, _theValue)
EndFunction

bool Function Settings_StringListRemoveAtS(string _theKey, int _theIndex)
	return JsonUtil.StringListRemoveAt(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex)
EndFunction

int Function Settings_StringListClearS(string _theKey)
	return JsonUtil.StringListClear(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int Function Settings_StringListCountS(string _theKey)
	return JsonUtil.StringListCount(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int Function Settings_StringListCountValueS(string _theKey, string _theValue, bool _exclude = false)
	return JsonUtil.StringListCountValue(SettingsFolder() + GetExtensionKey(), _theKey, _theValue, _exclude)
EndFunction

int Function Settings_StringListFindS(string _theKey, string _theValue)
	return JsonUtil.StringListFind(SettingsFolder() + GetExtensionKey(), _theKey, _theValue)
EndFunction

bool Function Settings_StringListHasS(string _theKey, string _theValue)
	return JsonUtil.StringListHas(SettingsFolder() + GetExtensionKey(), _theKey, _theValue)
EndFunction

Function Settings_StringListSliceS(string _theKey, string[] slice, int startIndex = 0)
	JsonUtil.StringListSlice(SettingsFolder() + GetExtensionKey(), _theKey, slice, startIndex)
EndFunction

int Function Settings_StringListResizeS(string _theKey, int toLength, string filler = "")
	return JsonUtil.StringListResize(SettingsFolder() + GetExtensionKey(), _theKey, toLength, filler)
EndFunction

bool Function Settings_StringListCopyS(string _theKey, string[] copy)
	return JsonUtil.StringListCopy(SettingsFolder() + GetExtensionKey(), _theKey, copy)
EndFunction

string[] Function Settings_StringListToArrayS(string _theKey)
	return JsonUtil.StringListToArray(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int function Settings_StringCountPrefixS(string _theKeyPrefix)
	return JsonUtil.CountStringListPrefix(SettingsFolder() + GetExtensionKey(), _theKeyPrefix)
EndFunction

; Settings - Form
bool Function Settings_FormHasS(string _theKey)
	return JsonUtil.HasFormValue(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

Form Function Settings_FormGetS(string _theKey, Form _defaultValue = None)
	return JsonUtil.GetFormValue(SettingsFolder() + GetExtensionKey(), _theKey, _defaultValue)
EndFunction

Form Function Settings_FormSetS(string _theKey, Form _value = None)
	return JsonUtil.SetFormValue(SettingsFolder() + GetExtensionKey(), _theKey, _value)
EndFunction

bool Function Settings_FormUnsetS(string _theKey)
	return JsonUtil.UnsetFormValue(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction




; Settings - Form[]
int Function Settings_FormListAddS(string _theKey, Form _theValue, bool _allowDuplicate = true)
	return JsonUtil.FormListAdd(SettingsFolder() + GetExtensionKey(), _theKey, _theValue, _allowDuplicate)
EndFunction

Form Function Settings_FormListGetS(string _theKey, int _theIndex)
	return JsonUtil.FormListGet(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex)
EndFunction

Form Function Settings_FormListSetS(string _theKey, int _theIndex, Form _theValue)
	return JsonUtil.FormListSet(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex, _theValue)
EndFunction

int Function Settings_FormListRemoveS(string _theKey, Form _theValue, bool _allInstaces = true)
	return JsonUtil.FormListRemove(SettingsFolder() + GetExtensionKey(), _theKey, _theValue, _allInstaces)
EndFunction

bool Function Settings_FormListInsertAtS(string _theKey, int _theIndex, Form _theValue)
	return JsonUtil.FormListInsertAt(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex, _theValue)
EndFunction

bool Function Settings_FormListRemoveAtS(string _theKey, int _theIndex)
	return JsonUtil.FormListRemoveAt(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex)
EndFunction

int Function Settings_FormListClearS(string _theKey)
	return JsonUtil.FormListClear(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int Function Settings_FormListCountS(string _theKey)
	return JsonUtil.FormListCount(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int Function Settings_FormListCountValueS(string _theKey, Form _theValue, bool _exclude = false)
	return JsonUtil.FormListCountValue(SettingsFolder() + GetExtensionKey(), _theKey, _theValue, _exclude)
EndFunction

int Function Settings_FormListFindS(string _theKey, Form _theValue)
	return JsonUtil.FormListFind(SettingsFolder() + GetExtensionKey(), _theKey, _theValue)
EndFunction

bool Function Settings_FormListHasS(string _theKey, Form _theValue)
	return JsonUtil.FormListHas(SettingsFolder() + GetExtensionKey(), _theKey, _theValue)
EndFunction

Function Settings_FormListSliceS(string _theKey, Form[] slice, int startIndex = 0)
	JsonUtil.FormListSlice(SettingsFolder() + GetExtensionKey(), _theKey, slice, startIndex)
EndFunction

int Function Settings_FormListResizeS(string _theKey, int toLength, Form filler = None)
	return JsonUtil.FormListResize(SettingsFolder() + GetExtensionKey(), _theKey, toLength, filler)
EndFunction

bool Function Settings_FormListCopyS(string _theKey, Form[] copy)
	return JsonUtil.FormListCopy(SettingsFolder() + GetExtensionKey(), _theKey, copy)
EndFunction

Form[] Function Settings_FormListToArrayS(string _theKey)
	return JsonUtil.FormListToArray(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int function Settings_FormCountPrefixS(string _theKeyPrefix)
	return JsonUtil.CountFormListPrefix(SettingsFolder() + GetExtensionKey(), _theKeyPrefix)
EndFunction

; Settings - float
bool Function Settings_FloatHasS(string _theKey)
	return JsonUtil.HasFloatValue(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

float Function Settings_FloatGetS(string _theKey, float _defaultValue = 0.0)
	return JsonUtil.GetFloatValue(SettingsFolder() + GetExtensionKey(), _theKey, _defaultValue)
EndFunction

float Function Settings_FloatSetS(string _theKey, float _value = 0.0)
	return JsonUtil.SetFloatValue(SettingsFolder() + GetExtensionKey(), _theKey, _value)
EndFunction

bool Function Settings_FloatUnsetS(string _theKey)
	return JsonUtil.UnsetFloatValue(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

float Function Settings_FloatAdjust(string _settingsFileName, string _theKey, float _amount) global
	return JsonUtil.AdjustFloatValue(SettingsFolder() + _settingsFileName, _theKey, _amount)
EndFunction



; Settings - float[]
int Function Settings_FloatListAddS(string _theKey, float _theValue, bool _allowDuplicate = true)
	return JsonUtil.FloatListAdd(SettingsFolder() + GetExtensionKey(), _theKey, _theValue, _allowDuplicate)
EndFunction

float Function Settings_FloatListGetS(string _theKey, int _theIndex)
	return JsonUtil.FloatListGet(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex)
EndFunction

float Function Settings_FloatListSetS(string _theKey, int _theIndex, float _theValue)
	return JsonUtil.FloatListSet(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex, _theValue)
EndFunction

int Function Settings_FloatListRemoveS(string _theKey, float _theValue, bool _allInstaces = true)
	return JsonUtil.FloatListRemove(SettingsFolder() + GetExtensionKey(), _theKey, _theValue, _allInstaces)
EndFunction

bool Function Settings_FloatListInsertAtS(string _theKey, int _theIndex, float _theValue)
	return JsonUtil.FloatListInsertAt(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex, _theValue)
EndFunction

bool Function Settings_FloatListRemoveAtS(string _theKey, int _theIndex)
	return JsonUtil.FloatListRemoveAt(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex)
EndFunction

int Function Settings_FloatListClearS(string _theKey)
	return JsonUtil.FloatListClear(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int Function Settings_FloatListCountS(string _theKey)
	return JsonUtil.FloatListCount(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int Function Settings_FloatListCountValueS(string _theKey, float _theValue, bool _exclude = false)
	return JsonUtil.FloatListCountValue(SettingsFolder() + GetExtensionKey(), _theKey, _theValue, _exclude)
EndFunction

int Function Settings_FloatListFindS(string _theKey, float _theValue)
	return JsonUtil.FloatListFind(SettingsFolder() + GetExtensionKey(), _theKey, _theValue)
EndFunction

bool Function Settings_FloatListHasS(string _theKey, float _theValue)
	return JsonUtil.FloatListHas(SettingsFolder() + GetExtensionKey(), _theKey, _theValue)
EndFunction

Function Settings_FloatListSliceS(string _theKey, float[] slice, int startIndex = 0)
	JsonUtil.FloatListSlice(SettingsFolder() + GetExtensionKey(), _theKey, slice, startIndex)
EndFunction

int Function Settings_FloatListResizeS(string _theKey, int toLength, float filler = 0.0)
	return JsonUtil.FloatListResize(SettingsFolder() + GetExtensionKey(), _theKey, toLength, filler)
EndFunction

bool Function Settings_FloatListCopyS(string _theKey, float[] copy)
	return JsonUtil.FloatListCopy(SettingsFolder() + GetExtensionKey(), _theKey, copy)
EndFunction

float[] Function Settings_FloatListToArrayS(string _theKey)
	return JsonUtil.FloatListToArray(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int function Settings_FloatCountPrefixS(string _theKeyPrefix)
	return JsonUtil.CountFloatListPrefix(SettingsFolder() + GetExtensionKey(), _theKeyPrefix)
EndFunction

; Settings - int
bool Function Settings_IntHasS(string _theKey)
	return JsonUtil.HasIntValue(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int Function Settings_IntGetS(string _theKey, int _defaultValue = 0)
	return JsonUtil.GetIntValue(SettingsFolder() + GetExtensionKey(), _theKey, _defaultValue)
EndFunction

int Function Settings_IntSetS(string _theKey, int _value = 0)
	return JsonUtil.SetIntValue(SettingsFolder() + GetExtensionKey(), _theKey, _value)
EndFunction

bool Function Settings_IntUnsetS(string _theKey)
	return JsonUtil.UnsetIntValue(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int Function Settings_IntAdjust(string _settingsFileName, string _theKey, int _amount) global
	return JsonUtil.AdjustIntValue(SettingsFolder() + _settingsFileName, _theKey, _amount)
EndFunction



; Settings - int[]
int Function Settings_IntListAddS(string _theKey, int _theValue, bool _allowDuplicate = true)
	return JsonUtil.IntListAdd(SettingsFolder() + GetExtensionKey(), _theKey, _theValue, _allowDuplicate)
EndFunction

int Function Settings_IntListGetS(string _theKey, int _theIndex)
	return JsonUtil.IntListGet(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex)
EndFunction

int Function Settings_IntListSetS(string _theKey, int _theIndex, int _theValue)
	return JsonUtil.IntListSet(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex, _theValue)
EndFunction

int Function Settings_IntListRemoveS(string _theKey, int _theValue, bool _allInstaces = true)
	return JsonUtil.IntListRemove(SettingsFolder() + GetExtensionKey(), _theKey, _theValue, _allInstaces)
EndFunction

bool Function Settings_IntListInsertAtS(string _theKey, int _theIndex, int _theValue)
	return JsonUtil.IntListInsertAt(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex, _theValue)
EndFunction

bool Function Settings_IntListRemoveAtS(string _theKey, int _theIndex)
	return JsonUtil.IntListRemoveAt(SettingsFolder() + GetExtensionKey(), _theKey, _theIndex)
EndFunction

int Function Settings_IntListClearS(string _theKey)
	return JsonUtil.IntListClear(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int Function Settings_IntListCountS(string _theKey)
	return JsonUtil.IntListCount(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int Function Settings_IntListCountValueS(string _theKey, int _theValue, bool _exclude = false)
	return JsonUtil.IntListCountValue(SettingsFolder() + GetExtensionKey(), _theKey, _theValue, _exclude)
EndFunction

int Function Settings_IntListFindS(string _theKey, int _theValue)
	return JsonUtil.IntListFind(SettingsFolder() + GetExtensionKey(), _theKey, _theValue)
EndFunction

bool Function Settings_IntListHasS(string _theKey, int _theValue)
	return JsonUtil.IntListHas(SettingsFolder() + GetExtensionKey(), _theKey, _theValue)
EndFunction

Function Settings_IntListSliceS(string _theKey, int[] slice, int startIndex = 0)
	JsonUtil.IntListSlice(SettingsFolder() + GetExtensionKey(), _theKey, slice, startIndex)
EndFunction

int Function Settings_IntListResizeS(string _theKey, int toLength, int filler = 0)
	return JsonUtil.IntListResize(SettingsFolder() + GetExtensionKey(), _theKey, toLength, filler)
EndFunction

bool Function Settings_IntListCopyS(string _theKey, int[] copy)
	return JsonUtil.IntListCopy(SettingsFolder() + GetExtensionKey(), _theKey, copy)
EndFunction

int[] Function Settings_IntListToArrayS(string _theKey)
	return JsonUtil.IntListToArray(SettingsFolder() + GetExtensionKey(), _theKey)
EndFunction

int function Settings_IntCountPrefixS(string _theKeyPrefix)
	return JsonUtil.CountIntListPrefix(SettingsFolder() + GetExtensionKey(), _theKeyPrefix)
EndFunction

