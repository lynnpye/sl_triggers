Scriptname sl_TriggersSetup extends SKI_ConfigBase

sl_TriggersMain  Property SLT auto

function DebMsg(string msg)
	SLT.DebMsg(msg)
endfunction

; CONSTANTS
int CARDS_PER_PAGE = 5  ; slots per page

; Properties
int			Property	EVENT_ID_NOT_SELECTED		= 0 Auto
int			Property	EVENT_ID_SEXLAB_START		= 1 Auto
int			Property	EVENT_ID_SEXLAB_ORGASM		= 2 Auto
int			Property	EVENT_ID_SEXLAB_STOP		= 3 Auto
int			Property	EVENT_ID_SEXLAB_ORGASMS		= 4 Auto
int			Property	EVENT_ID_TOP_OF_THE_HOUR	= 5 Auto
int			Property	EVENT_ID_KEYMAPPING			= 6 Auto
string		Property	SettingsName = "../sl_triggers/settings" Auto
string		Property	CommandsFolder = "../sl_triggers/commands" Auto

; Internal variables
Int oidEnabled
Int oidDebugMsg

string[] triggerParamNames
string[] triggerIfEventNames
string[] triggerIfRaceNames
string[] triggerIfPlayerNames
string[] triggerIfRoleNames
string[] triggerIfPosition
string[] triggerIfGenderNames
string[] triggerIfTagNames
string[] triggerIfDaytimeNames
string[] triggerIfLocationNames

string[] commandList

int		 slt_currentpage ; will be zero-based (first page of triggers is page 0 though it is displayed as page 1)

bool checkingVersion = false ; locking variable for version checks


int Function GetVersion()
	return 23
EndFunction

Event OnConfigInit()
	init()
EndEvent

Event OnVersionUpdate(int version)
	init()
EndEvent

Event OnGameReload()
	parent.OnGameReload() ; Don't forget to call the parent!
	init()
	SLT.on_reload()
EndEvent

event OnConfigOpen()
	init()
	commandList = _getCommands()
endEvent

event OnConfigClose()
	;CleanTriggerData()
	JsonUtil.Save(settingsName)
	SLT.HandleSettingsUpdated()
endEvent

;/
; Commenting this out for now to focus on stability before moving forward with this feature.
; Besides, v100 is coming.
Function CleanTriggerData()
	int i
	int j
	
	; Remove anything that evaluates to an empty string
	i = 1
	while i < 81
		j = 0
		while j < triggerParamNames.Length
			if "" == JsonUtil.GetStringValue(SettingsName, _makeSlotId(i, j))
				JsonUtil.UnsetStringValue(SettingsName, _makeSlotId(i, j))
			endif
			j += 1
		endwhile
		i += 1
	endwhile
	
	; Remove triggers with invalid events
	i = 1
	while i < 81
		if !JsonUtil.HasStringValue(settingsName, _makeSlotId(i, 2)) || "0" == JsonUtil.GetStringValue(settingsName, _makeSlotId(i, 2))
			;; clear everything out
			JsonUtil.ClearPath(settingsName, _makeSlotNoPrefix(i))
		endif
		i += 1
	endwhile
EndFunction
/;

Event OnPageReset(string page)
	If page == ""
        int ver = GetVersion()
		AddHeaderOption("Sexlab Triggers (" + (ver as string) + ")")
		return
	elseIf page == "Main"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Global settings")
		oidEnabled    = AddToggleOption("Enable", SLT.bEnabled)
		oidDebugMsg   = AddToggleOption("Debug messages", SLT.bDebugMsg)
		if SLT.DAKAvailable
			AddHeaderOption("Dynamic Activation Key: FOUND")
			AddKeyMapOption("Dynamic Activation HotKey:", SLT.DAKHotKey.GetValue() as int, OPTION_FLAG_DISABLED)
		else
			AddHeaderOption("Dynamic Activation Key: NOT FOUND")
		endif
		if SLT.SexLab
			AddHeaderOption("SexLab: FOUND version: " + SLT.SexLab.GetVersion())
		else
			AddHeaderOption("SexLab: NOT FOUND")
		endif
		;oidTimer      = AddSliderOption("Timer", iTimer, "{0}")
		return
	endif
	
	int i = 0
	while i < Pages.Length
		if page == Pages[i + 1]
			_makePageOptions(i)
			return
		endif
		i += 1
	endwhile
EndEvent

Event OnOptionSelect(int option)
	If option == oidEnabled
		SLT.bEnabled = !SLT.bEnabled
		SetToggleOptionValue(option, SLT.bEnabled)
	elseIf option == oidDebugMsg
		SLT.bDebugMsg = !SLT.bDebugMsg
		SetToggleOptionValue(option, SLT.bDebugMsg)
	endIf
EndEvent

Function init()
    initPages()
    initParamNames()
	initVersionCheck()
EndFunction

Function initPages()
	Pages = new string[17]
	Pages[ 0] = "Main"
	Pages[ 1] = "Triggers 1-5"
	Pages[ 2] = "Triggers 6-10"
	Pages[ 3] = "Triggers 11-15"
	Pages[ 4] = "Triggers 16-20"
	Pages[ 5] = "Triggers 21-25"
	Pages[ 6] = "Triggers 26-30"
	Pages[ 7] = "Triggers 31-35"
	Pages[ 8] = "Triggers 36-40"
	Pages[ 9] = "Triggers 41-45"
	Pages[10] = "Triggers 46-50"
	Pages[11] = "Triggers 51-55"
	Pages[12] = "Triggers 56-60"
	Pages[13] = "Triggers 61-65"
	Pages[14] = "Triggers 66-70"
	Pages[15] = "Triggers 71-75"
	Pages[16] = "Triggers 76-80"
EndFunction

function initParamNames()
	triggerParamNames = new string[17]
	triggerParamNames[ 0] = ""
	triggerParamNames[ 1] = "if_chance"
	triggerParamNames[ 2] = "if_event"
	triggerParamNames[ 3] = "if_race"
	triggerParamNames[ 4] = "if_role"
	triggerParamNames[ 5] = "if_gender"
	triggerParamNames[ 6] = "if_tag"
	triggerParamNames[ 7] = "if_daytime"
	triggerParamNames[ 8] = "if_location"
	triggerParamNames[ 9] = "do_1"
	triggerParamNames[10] = "do_2"
	triggerParamNames[11] = "do_3"
	triggerParamNames[12] = "if_player"
	triggerParamNames[13] = "if_keymap"
	triggerParamNames[14] = "if_keymap_modifier"
	triggerParamNames[15] = "if_use_dak"
	triggerParamNames[16] = "if_position"
	
	; the awkwardness
	triggerIfEventNames								= PapyrusUtil.StringArray(7)
	triggerIfEventNames[EVENT_ID_NOT_SELECTED]		= "- Select an Event -"
	triggerIfEventNames[EVENT_ID_SEXLAB_START]		= "Begin"
	triggerIfEventNames[EVENT_ID_SEXLAB_ORGASM]		= "Orgasm"
	triggerIfEventNames[EVENT_ID_SEXLAB_STOP]		= "End"
	triggerIfEventNames[EVENT_ID_SEXLAB_ORGASMS]	= "Orgasm(SLSO)"
	triggerIfEventNames[EVENT_ID_TOP_OF_THE_HOUR]	= "TopOfTheHour"
	triggerIfEventNames[EVENT_ID_KEYMAPPING]		= "Keymapping"
	
	triggerIfRaceNames = new string[7]
	triggerIfRaceNames[0] = "Any"
	triggerIfRaceNames[1] = "Humanoid"
	triggerIfRaceNames[2] = "Creature"
	triggerIfRaceNames[3] = "Undead"
	triggerIfRaceNames[4] = "Partner Humanoid"
	triggerIfRaceNames[5] = "Partner Creature"
	triggerIfRaceNames[6] = "Partner Undead"
	
	triggerIfPlayerNames = new string[5]
	triggerIfPlayerNames[0] = "Any"
	triggerIfPlayerNames[1] = "Player"
	triggerIfPlayerNames[2] = "Not Player"
	triggerIfPlayerNames[3] = "Partner Player"
	triggerIfPlayerNames[4] = "Partner Not Player"
	
	triggerIfRoleNames = new string[4]
	triggerIfRoleNames[0] = "Any"
	triggerIfRoleNames[1] = "Aggressor"
	triggerIfRoleNames[2] = "Victim"
	triggerIfRoleNames[3] = "Not part of rape"
	
	triggerIfPosition = new string[6]
	triggerIfPosition[0] = "Any"
	triggerIfPosition[1] = "1"
	triggerIfPosition[2] = "2"
	triggerIfPosition[3] = "3"
	triggerIfPosition[4] = "4"
	triggerIfPosition[5] = "5"
	
	triggerIfGenderNames = new string[3]
	triggerIfGenderNames[0] = "Any"
	triggerIfGenderNames[1] = "Male"
	triggerIfGenderNames[2] = "Female"
	
	triggerIfTagNames = new String[4]
	triggerIfTagNames[0] = "Any"
	triggerIfTagNames[1] = "Vaginal"
	triggerIfTagNames[2] = "Anal"
	triggerIfTagNames[3] = "Oral"
	
	triggerIfDaytimeNames = new String[3]
	triggerIfDaytimeNames[0] = "Any"
	triggerIfDaytimeNames[1] = "Day"
	triggerIfDaytimeNames[2] = "Night"
	
	triggerIfLocationNames = new String[3]
	triggerIfLocationNames[0] = "Any"
	triggerIfLocationNames[1] = "Inside"
	triggerIfLocationNames[2] = "Outside"
endfunction

Function initVersionCheck()
	Utility.Wait(0.0)
	if checkingVersion
		return
	endif
	checkingVersion = true
	
	; just go ahead and avoid anyone else trying this while we are in here
	int fromVersion = _getConfigVersion()
	if fromVersion == GetVersion()
		checkingVersion = false
		return
	endif
	JsonUtil.SetIntValue(SettingsName, _makeVersionConfigSlotId(), GetVersion())
    if fromVersion < 16
		; reset event ids
		int i = 1
		while i < 81
			string slotEventId =  _makeSlotId(i, 2)
			if JsonUtil.HasStringValue(settingsName, slotEventId)
				int value = JsonUtil.GetStringValue(settingsName, slotEventId) as int
				JsonUtil.SetStringValue(settingsName, slotEventId, value + 1)
			endif
			i += 1
		endwhile
    endIf
	checkingVersion = false
EndFunction

; assumes zero-based pageNo
Function _makePageOptions(int pageNo)
	slt_currentpage = pageNo
	
	SetCursorFillMode(LEFT_TO_RIGHT)
	int i = 0
	while i < CARDS_PER_PAGE
		_makeSlotOptions(i, (pageNo * CARDS_PER_PAGE) + i + 1)
		i = i + 1
	endwhile
EndFunction

bool Function isEventIdChanceable(int _eventId)
	return _eventId != EVENT_ID_NOT_SELECTED && _eventId != EVENT_ID_KEYMAPPING
EndFunction

Function _makeSlotOptions(int cardNo, int _slotNo)
	bool hasEventIndex = JsonUtil.HasStringValue(settingsName, _makeEventIdSlotId(_slotNo))
	int eventIndex = _getEventIdxForSlotNo(_slotNo)
	
	; row 1
	AddHeaderOption("<font color='#FFFFFF'>slot-" + (_slotNo as string) + "</font>")
	AddEmptyOption()
	
	; row 2
	AddMenuOptionSt  ("oid_event_" + cardNo, "on event",       _getSlotValue(_slotNo, 2))
	if hasEventIndex && isEventIdChanceable(eventIndex)
		AddSliderOptionSt("oid_chance_" + cardNo, "chance",         _getSlotValue(_slotNo, 1) as float, "{0}%") ;0-100
	else
		AddEmptyOption()
	endif
	
	If hasEventIndex && eventIndex != EVENT_ID_NOT_SELECTED
		if eventIndex == EVENT_ID_SEXLAB_START || eventIndex == EVENT_ID_SEXLAB_ORGASM || eventIndex == EVENT_ID_SEXLAB_STOP || eventIndex == EVENT_ID_SEXLAB_ORGASMS
			; if SexLab
			; row -1
			AddMenuOptionSt  ("oid_race_" + cardNo, "if actor race",  _getSlotValue(_slotNo, 3))
			AddMenuOptionSt  ("oid_role_" + cardNo, "if actor",       _getSlotValue(_slotNo, 4))
			; row -2
			AddMenuOptionSt  ("oid_player_" + cardNo, "if player",       _getSlotValue(_slotNo, 12))
			AddMenuOptionSt  ("oid_gender_" + cardNo, "if gender",      _getSlotValue(_slotNo, 5))
			; row -3
			AddMenuOptionSt  ("oid_tag_" + cardNo, "if sex type",    _getSlotValue(_slotNo, 6))
			AddMenuOptionSt  ("oid_daytime_" + cardNo, "if day time",    _getSlotValue(_slotNo, 7))
			; row -4
			AddMenuOptionSt  ("oid_location_" + cardNo, "if location",    _getSlotValue(_slotNo, 8))
			AddMenuOptionSt  ("oid_position_" + cardNo, "if scene position", _getSlotValue(_slotNo, 16))
		elseif eventIndex == EVENT_ID_KEYMAPPING
			; if Keymapping
			; row -1
			AddKeyMapOptionSt("oid_keymap_" + cardNo, "on key up", _getSlotValue(_slotNo, 13) as int, OPTION_FLAG_WITH_UNMAP)
			AddEmptyOption()
			
			; row -2
			bool usedak = _isUseDAKForSlotNo(_slotNo)
			int optionFlags = OPTION_FLAG_WITH_UNMAP
			if usedak
				optionFlags = OPTION_FLAG_DISABLED
			endif
			AddKeyMapOptionSt("oid_keymap_modifier_" + cardNo, "modifier key", _getSlotValue(_slotNo, 14) as int, optionFlags)
			AddToggleOptionSt("oid_use_dak_" + cardNo, "use DAK if present", usedak)
		EndIf
		
		; the final gang of four, almost want to add a fourth for visual balance
		; row -1
		AddMenuOptionSt  ("oid_do_1_" + cardNo, "command 1",   _getSlotValue(_slotNo, 9))
		AddMenuOptionSt  ("oid_do_2_" + cardNo, "command 2",   _getSlotValue(_slotNo, 10))
		; row -2
		AddMenuOptionSt  ("oid_do_3_" + cardNo, "command 3",   _getSlotValue(_slotNo, 11))
		AddEmptyOption()
	EndIf
EndFunction

string Function _getSlotValue(int slotNo, int paramNo)
	string slotId = _makeSlotId(slotNo, paramNo)
	string paramId = triggerParamNames[paramNo]	
	string value
	int index
	
	value = JsonUtil.GetStringValue(settingsName, slotId)
	; float		if_chance
	; string	do_1
	; string	do_2
	; string	do_3
	; int		if_keymap
	; int		if_keymap_modifier
	; int		if_use_dak
	if paramNo == 1 || paramNo == 9 || paramNo == 10 || paramNo == 11 || paramNo == 13 || paramNo == 14 || paramNo == 15
		return value
	else
		index = value as int
		if index < 0
			index = 0
		endIf
		If paramId == "if_event"
			return triggerIfEventNames[index]
		elseIf paramId == "if_race"
			return triggerIfRaceNames[index]
		elseIf paramId == "if_role"
			return triggerIfRoleNames[index]
		elseIf paramId == "if_position"
			return triggerIfPosition[index]
		elseIf paramId == "if_gender"
			return triggerIfGenderNames[index]
		elseIf paramId == "if_tag"
			return triggerIfTagNames[index]
		elseIf paramId == "if_daytime"
			return triggerIfDaytimeNames[index]
		elseIf paramId == "if_location"
			return triggerIfLocationNames[index]
		elseIf paramId == "if_player"
			return triggerIfPlayerNames[index]
		endIf
	endIf
	return ""
EndFunction


string Function _makeSlotId(int slotNo, int paramNo)
	return _makeSlotIdFromPrefix(_makeSlotNoPrefix(slotNo), paramNo)
EndFunction

string Function _makeSlotIdFromPrefix(string slotNoPrefix, int paramNo)
	return slotNoPrefix + "." + triggerParamNames[paramNo]
endfunction

string Function _makeSlotNoPrefix(int slotNo)
	return "slot" + slotNo
endfunction

bool Function _isUseDAKForSlotNo(int slotNo)
	int iv = JsonUtil.GetStringValue(settingsName, _makeUseDAKSlotId(slotNo)) as int
	return iv != 0
EndFunction

int Function _getEventIdxForSlotNo(int slotNo)
	return JsonUtil.GetStringValue(settingsName, _makeEventIdSlotId(slotNo)) as int
EndFunction

string[] Function _getCommands()
	return JsonUtil.JsonInFolder(CommandsFolder)
EndFunction

int Function _getConfigVersion()
	return JsonUtil.GetIntValue(SettingsName, _makeVersionConfigSlotId())
EndFunction

string Function _getDAKModname()
	string slotid = _makeDAKModnameConfigSlotId()
	string defmodname = "Dynamic Activation Key.esp"
	if !JsonUtil.HasStringValue(SettingsName, slotid)
		JsonUtil.SetStringValue(SettingsName, slotid, defmodname)
	endif
	; yes, I know what I just did
	; yes, I know what the default will be used for (nothing)
	; go ahead... ask yourself if I care :D
	return JsonUtil.GetStringValue(SettingsName, slotid, defmodname)
endfunction

string Function _makeVersionConfigSlotId() global
	return _makeConfigSlotId("version")
endfunction

string Function _makeDAKModnameConfigSlotId() global
	return _makeConfigSlotId("DynamicActivationKey_modname")
endfunction

string Function _makeConfigSlotId(string configOption) global
	if !configOption
		return none
	endif
	return "slot-config." + configOption
EndFunction

string Function _makeEventIdSlotId(int slotNo)
	return _makeSlotId(slotNo, 2)
EndFunction

string Function _makeUseDAKSlotId(int slotNo)
	return _makeSlotId(slotNo, 15)
EndFunction











;;;;;
;; State based configs, because OIDs are hard

; so, for starters, I use a little app/script/whatever locally (it's a Java app but it's as complex as a batch file)
; to generate the repeated bits down below, so that's all generated.

; it also all counts on having exactly 5 "cards" (slots) per page, no more, no less
; change that and the setup below has to change


Function DoKeymapChange(int cardIndex, int paramNo, int newKeyCode, string conflictControl, string conflictName)
	bool proceed = true
	if conflictControl
		string msg
		if conflictName
			msg = "This key is already mapped to:\n\"" + conflictControl + "\"\n(" + conflictName + ")\n\nAre you sure you want to continue?"
		else
			msg = "This key is already mapped to:\n\"" + conflictControl + "\"\n\nAre you sure you want to continue?"
		endIf
		
		proceed = ShowMessage(msg, true, "$Yes", "$No")
	endif
	
	if proceed
		int slotNo = slt_currentpage * CARDS_PER_PAGE + cardIndex + 1
		string slotId = _makeSlotId(slotNo, paramNo)
		
		JsonUtil.SetStringValue(settingsName, slotId, newKeyCode)
		SetKeyMapOptionValueSt(newKeyCode)
	endif
EndFunction

Function DoToggleSelect(int cardIndex, int paramNo)
	int slotNo = slt_currentpage * CARDS_PER_PAGE + cardIndex + 1
	string slotId = _makeSlotId(slotNo, paramNo)
	int value = JsonUtil.GetStringValue(settingsName, slotId) as int
	value = (value == 0) as int
	JsonUtil.SetStringValue(settingsName, slotId, value)
	SetToggleOptionValueSt(value)
EndFunction

Function DoSliderOpen(int cardIndex, int paramNo)
	int slotNo = slt_currentpage * CARDS_PER_PAGE + cardIndex + 1
	string value = JsonUtil.GetStringValue(settingsName, _makeSlotId(slotNo, paramNo))
	SetSliderDialogStartValue(value as float)
	SetSliderDialogDefaultValue(0.0)
	SetSliderDialogRange(0.0, 100.0)
	SetSliderDialogInterval(1.0)
Endfunction

Function DoSliderAccept(int cardIndex, int paramNo, float value)
	int slotNo = slt_currentpage * CARDS_PER_PAGE + cardIndex + 1
	string slotId = _makeSlotId(slotNo, paramNo)
	float chkValue = value
	if chkValue > 0.0
        JsonUtil.SetStringValue(settingsName, slotId, value as string)
	else
		chkValue = 0.0
        JsonUtil.UnsetStringValue(settingsName, slotId)
	endif
	SetSliderOptionValueST(chkValue, "{0}%")
EndFunction

Function DoMenuOpen(int cardIndex, string[] optionList, int paramNo)
	SetMenuDialogOptions(optionList)
	int slotNo = slt_currentpage * CARDS_PER_PAGE + cardIndex + 1
	string slotId =  _makeSlotId(slotNo, paramNo)
	if JsonUtil.HasStringValue(settingsName, slotId)
		string value = JsonUtil.GetStringValue(settingsName, slotId)
		SetMenuDialogStartIndex(value as int)
	endif
	SetMenuDialogDefaultIndex(0)
EndFunction

Function DoMenuAccept(int cardIndex, string[] optionList, int paramNo, int selIndex)
	int slotNo = slt_currentpage * CARDS_PER_PAGE + cardIndex + 1
	string slotId = _makeSlotId(slotNo, paramNo)
	if selIndex >= 0
		string val = optionList[selIndex]
		string realval = selIndex as string
		SetMenuOptionValueSt(val)
		JsonUtil.SetStringValue(settingsName, slotId, realval)
	else
		SetMenuOptionValueSt("")
		JsonUtil.UnsetStringValue(settingsName, slotId)
	endif
EndFunction

Function DoCommandMenuOpen(int cardIndex, int paramNo)
	SetMenuDialogOptions(commandList)
	int slotNo = slt_currentpage * CARDS_PER_PAGE + cardIndex + 1
	string slotId =  _makeSlotId(slotNo, paramNo)
	if JsonUtil.HasStringValue(settingsName, slotId)
		string value = JsonUtil.GetStringValue(settingsName, slotId)
		if value
			int idx = commandList.Find(value)
			if idx >= 0
				SetMenuDialogStartIndex(idx)
			endIf
		endIf
	EndIf
	SetMenuDialogDefaultIndex(-1)
EndFunction

Function DoCommandMenuAccept(int cardIndex, int paramNo, int selIndex)
	int slotNo = slt_currentpage * CARDS_PER_PAGE + cardIndex + 1
	string slotId = _makeSlotId(slotNo, paramNo)
	if selIndex < 0
		SetMenuOptionValueSt("")
		JsonUtil.SetStringValue(settingsName,  slotId, "")
	endif
	
	string val
	if selIndex >= 0
		val = commandList[selIndex]
	endIf
	SetMenuOptionValueSt(val)
	JsonUtil.SetStringValue(settingsName, slotId, val)
EndFunction

; chance cards 0-4 per page
state oid_chance_0
	event OnSliderOpenST()
		DoSliderOpen(0, 1)
	endevent
	
	event OnSliderAcceptST(float value)
		DoSliderAccept(0, 1, value)
	endevent
endstate

state oid_chance_1
	event OnSliderOpenST()
		DoSliderOpen(1, 1)
	endevent
	
	event OnSliderAcceptST(float value)
		DoSliderAccept(1, 1, value)
	endevent
endstate

state oid_chance_2
	event OnSliderOpenST()
		DoSliderOpen(2, 1)
	endevent
	
	event OnSliderAcceptST(float value)
		DoSliderAccept(2, 1, value)
	endevent
endstate

state oid_chance_3
	event OnSliderOpenST()
		DoSliderOpen(3, 1)
	endevent
	
	event OnSliderAcceptST(float value)
		DoSliderAccept(3, 1, value)
	endevent
endstate

state oid_chance_4
	event OnSliderOpenST()
		DoSliderOpen(4, 1)
	endevent
	
	event OnSliderAcceptST(float value)
		DoSliderAccept(4, 1, value)
	endevent
endstate

; BEGIN event cards 0-4 per page
state oid_event_0
	Event OnMenuOpenSt()
		DoMenuOpen(0, triggerIfEventNames, 2)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(0, triggerIfEventNames, 2, index)
		ForcePageReset()
	EndEvent
endstate

state oid_event_1
	Event OnMenuOpenSt()
		DoMenuOpen(1, triggerIfEventNames, 2)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(1, triggerIfEventNames, 2, index)
		ForcePageReset()
	EndEvent
endstate

state oid_event_2
	Event OnMenuOpenSt()
		DoMenuOpen(2, triggerIfEventNames, 2)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(2, triggerIfEventNames, 2, index)
		ForcePageReset()
	EndEvent
endstate

state oid_event_3
	Event OnMenuOpenSt()
		DoMenuOpen(3, triggerIfEventNames, 2)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(3, triggerIfEventNames, 2, index)
		ForcePageReset()
	EndEvent
endstate

state oid_event_4
	Event OnMenuOpenSt()
		DoMenuOpen(4, triggerIfEventNames, 2)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(4, triggerIfEventNames, 2, index)
		ForcePageReset()
	EndEvent
endstate
; END event cards 0-4 per page


; BEGIN race cards 0-4 per page
state oid_race_0
	Event OnMenuOpenSt()
		DoMenuOpen(0, triggerIfRaceNames, 3)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(0, triggerIfRaceNames, 3, index)
	EndEvent
endstate

state oid_race_1
	Event OnMenuOpenSt()
		DoMenuOpen(1, triggerIfRaceNames, 3)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(1, triggerIfRaceNames, 3, index)
	EndEvent
endstate

state oid_race_2
	Event OnMenuOpenSt()
		DoMenuOpen(2, triggerIfRaceNames, 3)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(2, triggerIfRaceNames, 3, index)
	EndEvent
endstate

state oid_race_3
	Event OnMenuOpenSt()
		DoMenuOpen(3, triggerIfRaceNames, 3)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(3, triggerIfRaceNames, 3, index)
	EndEvent
endstate

state oid_race_4
	Event OnMenuOpenSt()
		DoMenuOpen(4, triggerIfRaceNames, 3)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(4, triggerIfRaceNames, 3, index)
	EndEvent
endstate
; END race cards 0-4 per page


; BEGIN role cards 0-4 per page
state oid_role_0
	Event OnMenuOpenSt()
		DoMenuOpen(0, triggerIfRoleNames, 4)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(0, triggerIfRoleNames, 4, index)
	EndEvent
endstate

state oid_role_1
	Event OnMenuOpenSt()
		DoMenuOpen(1, triggerIfRoleNames, 4)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(1, triggerIfRoleNames, 4, index)
	EndEvent
endstate

state oid_role_2
	Event OnMenuOpenSt()
		DoMenuOpen(2, triggerIfRoleNames, 4)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(2, triggerIfRoleNames, 4, index)
	EndEvent
endstate

state oid_role_3
	Event OnMenuOpenSt()
		DoMenuOpen(3, triggerIfRoleNames, 4)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(3, triggerIfRoleNames, 4, index)
	EndEvent
endstate

state oid_role_4
	Event OnMenuOpenSt()
		DoMenuOpen(4, triggerIfRoleNames, 4)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(4, triggerIfRoleNames, 4, index)
	EndEvent
endstate
; END role cards 0-4 per page


; BEGIN gender cards 0-4 per page
state oid_gender_0
	Event OnMenuOpenSt()
		DoMenuOpen(0, triggerIfGenderNames, 5)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(0, triggerIfGenderNames, 5, index)
	EndEvent
endstate

state oid_gender_1
	Event OnMenuOpenSt()
		DoMenuOpen(1, triggerIfGenderNames, 5)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(1, triggerIfGenderNames, 5, index)
	EndEvent
endstate

state oid_gender_2
	Event OnMenuOpenSt()
		DoMenuOpen(2, triggerIfGenderNames, 5)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(2, triggerIfGenderNames, 5, index)
	EndEvent
endstate

state oid_gender_3
	Event OnMenuOpenSt()
		DoMenuOpen(3, triggerIfGenderNames, 5)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(3, triggerIfGenderNames, 5, index)
	EndEvent
endstate

state oid_gender_4
	Event OnMenuOpenSt()
		DoMenuOpen(4, triggerIfGenderNames, 5)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(4, triggerIfGenderNames, 5, index)
	EndEvent
endstate
; END gender cards 0-4 per page


; BEGIN tag cards 0-4 per page
state oid_tag_0
	Event OnMenuOpenSt()
		DoMenuOpen(0, triggerIfTagNames, 6)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(0, triggerIfTagNames, 6, index)
	EndEvent
endstate

state oid_tag_1
	Event OnMenuOpenSt()
		DoMenuOpen(1, triggerIfTagNames, 6)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(1, triggerIfTagNames, 6, index)
	EndEvent
endstate

state oid_tag_2
	Event OnMenuOpenSt()
		DoMenuOpen(2, triggerIfTagNames, 6)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(2, triggerIfTagNames, 6, index)
	EndEvent
endstate

state oid_tag_3
	Event OnMenuOpenSt()
		DoMenuOpen(3, triggerIfTagNames, 6)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(3, triggerIfTagNames, 6, index)
	EndEvent
endstate

state oid_tag_4
	Event OnMenuOpenSt()
		DoMenuOpen(4, triggerIfTagNames, 6)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(4, triggerIfTagNames, 6, index)
	EndEvent
endstate
; END tag cards 0-4 per page


; BEGIN daytime cards 0-4 per page
state oid_daytime_0
	Event OnMenuOpenSt()
		DoMenuOpen(0, triggerIfDaytimeNames, 7)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(0, triggerIfDaytimeNames, 7, index)
	EndEvent
endstate

state oid_daytime_1
	Event OnMenuOpenSt()
		DoMenuOpen(1, triggerIfDaytimeNames, 7)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(1, triggerIfDaytimeNames, 7, index)
	EndEvent
endstate

state oid_daytime_2
	Event OnMenuOpenSt()
		DoMenuOpen(2, triggerIfDaytimeNames, 7)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(2, triggerIfDaytimeNames, 7, index)
	EndEvent
endstate

state oid_daytime_3
	Event OnMenuOpenSt()
		DoMenuOpen(3, triggerIfDaytimeNames, 7)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(3, triggerIfDaytimeNames, 7, index)
	EndEvent
endstate

state oid_daytime_4
	Event OnMenuOpenSt()
		DoMenuOpen(4, triggerIfDaytimeNames, 7)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(4, triggerIfDaytimeNames, 7, index)
	EndEvent
endstate
; END daytime cards 0-4 per page


; BEGIN location cards 0-4 per page
state oid_location_0
	Event OnMenuOpenSt()
		DoMenuOpen(0, triggerIfLocationNames, 8)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(0, triggerIfLocationNames, 8, index)
	EndEvent
endstate

state oid_location_1
	Event OnMenuOpenSt()
		DoMenuOpen(1, triggerIfLocationNames, 8)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(1, triggerIfLocationNames, 8, index)
	EndEvent
endstate

state oid_location_2
	Event OnMenuOpenSt()
		DoMenuOpen(2, triggerIfLocationNames, 8)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(2, triggerIfLocationNames, 8, index)
	EndEvent
endstate

state oid_location_3
	Event OnMenuOpenSt()
		DoMenuOpen(3, triggerIfLocationNames, 8)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(3, triggerIfLocationNames, 8, index)
	EndEvent
endstate

state oid_location_4
	Event OnMenuOpenSt()
		DoMenuOpen(4, triggerIfLocationNames, 8)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(4, triggerIfLocationNames, 8, index)
	EndEvent
endstate
; END location cards 0-4 per page

; BEGIN do_1 cards 0-4 per page
state oid_do_1_0
	Event OnMenuOpenSt()
		DoCommandMenuOpen(0, 9)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(0, 9, index)
	EndEvent
endstate

state oid_do_1_1
	Event OnMenuOpenSt()
		DoCommandMenuOpen(1, 9)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(1, 9, index)
	EndEvent
endstate

state oid_do_1_2
	Event OnMenuOpenSt()
		DoCommandMenuOpen(2, 9)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(2, 9, index)
	EndEvent
endstate

state oid_do_1_3
	Event OnMenuOpenSt()
		DoCommandMenuOpen(3, 9)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(3, 9, index)
	EndEvent
endstate

state oid_do_1_4
	Event OnMenuOpenSt()
		DoCommandMenuOpen(4, 9)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(4, 9, index)
	EndEvent
endstate
; END do_1 cards 0-4 per page


; BEGIN do_2 cards 0-4 per page
state oid_do_2_0
	Event OnMenuOpenSt()
		DoCommandMenuOpen(0, 10)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(0, 10, index)
	EndEvent
endstate

state oid_do_2_1
	Event OnMenuOpenSt()
		DoCommandMenuOpen(1, 10)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(1, 10, index)
	EndEvent
endstate

state oid_do_2_2
	Event OnMenuOpenSt()
		DoCommandMenuOpen(2, 10)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(2, 10, index)
	EndEvent
endstate

state oid_do_2_3
	Event OnMenuOpenSt()
		DoCommandMenuOpen(3, 10)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(3, 10, index)
	EndEvent
endstate

state oid_do_2_4
	Event OnMenuOpenSt()
		DoCommandMenuOpen(4, 10)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(4, 10, index)
	EndEvent
endstate
; END do_2 cards 0-4 per page


; BEGIN do_3 cards 0-4 per page
state oid_do_3_0
	Event OnMenuOpenSt()
		DoCommandMenuOpen(0, 11)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(0, 11, index)
	EndEvent
endstate

state oid_do_3_1
	Event OnMenuOpenSt()
		DoCommandMenuOpen(1, 11)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(1, 11, index)
	EndEvent
endstate

state oid_do_3_2
	Event OnMenuOpenSt()
		DoCommandMenuOpen(2, 11)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(2, 11, index)
	EndEvent
endstate

state oid_do_3_3
	Event OnMenuOpenSt()
		DoCommandMenuOpen(3, 11)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(3, 11, index)
	EndEvent
endstate

state oid_do_3_4
	Event OnMenuOpenSt()
		DoCommandMenuOpen(4, 11)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoCommandMenuAccept(4, 11, index)
	EndEvent
endstate
; END do_3 cards 0-4 per page


; BEGIN player cards 0-4 per page
state oid_player_0
	Event OnMenuOpenSt()
		DoMenuOpen(0, triggerIfPlayerNames, 12)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(0, triggerIfPlayerNames, 12, index)
	EndEvent
endstate

state oid_player_1
	Event OnMenuOpenSt()
		DoMenuOpen(1, triggerIfPlayerNames, 12)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(1, triggerIfPlayerNames, 12, index)
	EndEvent
endstate

state oid_player_2
	Event OnMenuOpenSt()
		DoMenuOpen(2, triggerIfPlayerNames, 12)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(2, triggerIfPlayerNames, 12, index)
	EndEvent
endstate

state oid_player_3
	Event OnMenuOpenSt()
		DoMenuOpen(3, triggerIfPlayerNames, 12)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(3, triggerIfPlayerNames, 12, index)
	EndEvent
endstate

state oid_player_4
	Event OnMenuOpenSt()
		DoMenuOpen(4, triggerIfPlayerNames, 12)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(4, triggerIfPlayerNames, 12, index)
	EndEvent
endstate
; END player cards 0-4 per page


; BEGIN keymap cards 0-4 per page
state oid_keymap_0
	Event OnKeyMapChangeSt(int newKeyCode, string conflictControl, string conflictName)
		DoKeymapChange(0, 13, newKeyCode, conflictControl, conflictName)
	EndEvent
endstate

state oid_keymap_1
	Event OnKeyMapChangeSt(int newKeyCode, string conflictControl, string conflictName)
		DoKeymapChange(1, 13, newKeyCode, conflictControl, conflictName)
	EndEvent
endstate

state oid_keymap_2
	Event OnKeyMapChangeSt(int newKeyCode, string conflictControl, string conflictName)
		DoKeymapChange(2, 13, newKeyCode, conflictControl, conflictName)
	EndEvent
endstate

state oid_keymap_3
	Event OnKeyMapChangeSt(int newKeyCode, string conflictControl, string conflictName)
		DoKeymapChange(3, 13, newKeyCode, conflictControl, conflictName)
	EndEvent
endstate

state oid_keymap_4
	Event OnKeyMapChangeSt(int newKeyCode, string conflictControl, string conflictName)
		DoKeymapChange(4, 13, newKeyCode, conflictControl, conflictName)
	EndEvent
endstate
; END keymap cards 0-4 per page


; BEGIN keymap_modifier cards 0-4 per page
state oid_keymap_modifier_0
	Event OnKeyMapChangeSt(int newKeyCode, string conflictControl, string conflictName)
		DoKeymapChange(0, 14, newKeyCode, conflictControl, conflictName)
	EndEvent
endstate

state oid_keymap_modifier_1
	Event OnKeyMapChangeSt(int newKeyCode, string conflictControl, string conflictName)
		DoKeymapChange(1, 14, newKeyCode, conflictControl, conflictName)
	EndEvent
endstate

state oid_keymap_modifier_2
	Event OnKeyMapChangeSt(int newKeyCode, string conflictControl, string conflictName)
		DoKeymapChange(2, 14, newKeyCode, conflictControl, conflictName)
	EndEvent
endstate

state oid_keymap_modifier_3
	Event OnKeyMapChangeSt(int newKeyCode, string conflictControl, string conflictName)
		DoKeymapChange(3, 14, newKeyCode, conflictControl, conflictName)
	EndEvent
endstate

state oid_keymap_modifier_4
	Event OnKeyMapChangeSt(int newKeyCode, string conflictControl, string conflictName)
		DoKeymapChange(4, 14, newKeyCode, conflictControl, conflictName)
	EndEvent
endstate
; END keymap_modifier cards 0-4 per page


; BEGIN use_dak cards 0-4 per page
state oid_use_dak_0
	Event OnSelectSt()
		DoToggleSelect(0, 15)
	EndEvent

	Event OnDefaultSt()
		SetToggleOptionValueSt(false)
	EndEvent
endstate

state oid_use_dak_1
	Event OnSelectSt()
		DoToggleSelect(1, 15)
	EndEvent

	Event OnDefaultSt()
		SetToggleOptionValueSt(false)
	EndEvent
endstate

state oid_use_dak_2
	Event OnSelectSt()
		DoToggleSelect(2, 15)
	EndEvent

	Event OnDefaultSt()
		SetToggleOptionValueSt(false)
	EndEvent
endstate

state oid_use_dak_3
	Event OnSelectSt()
		DoToggleSelect(3, 15)
	EndEvent

	Event OnDefaultSt()
		SetToggleOptionValueSt(false)
	EndEvent
endstate

state oid_use_dak_4
	Event OnSelectSt()
		DoToggleSelect(4, 15)
	EndEvent

	Event OnDefaultSt()
		SetToggleOptionValueSt(false)
	EndEvent
endstate
; END use_dak cards 0-4 per page


; BEGIN position cards 0-4 per page
state oid_position_0
	Event OnMenuOpenSt()
		DoMenuOpen(0, triggerIfPosition, 16)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(0, triggerIfPosition, 16, index)
	EndEvent
endstate

state oid_position_1
	Event OnMenuOpenSt()
		DoMenuOpen(1, triggerIfPosition, 16)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(1, triggerIfPosition, 16, index)
	EndEvent
endstate

state oid_position_2
	Event OnMenuOpenSt()
		DoMenuOpen(2, triggerIfPosition, 16)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(2, triggerIfPosition, 16, index)
	EndEvent
endstate

state oid_position_3
	Event OnMenuOpenSt()
		DoMenuOpen(3, triggerIfPosition, 16)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(3, triggerIfPosition, 16, index)
	EndEvent
endstate

state oid_position_4
	Event OnMenuOpenSt()
		DoMenuOpen(4, triggerIfPosition, 16)
	EndEvent

	Event OnMenuAcceptSt(int index)
		DoMenuAccept(4, triggerIfPosition, 16, index)
	EndEvent
endstate
; END position cards 0-4 per page





;;;;;
;; End state based configs (I mean, don't really, they seem pretty cool