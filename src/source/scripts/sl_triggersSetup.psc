Scriptname sl_TriggersSetup extends SKI_ConfigBase

sl_TriggersMain  Property mainQuest auto

int perPage = 5  ; slots per page
int perSlot = 12 ; no of params per slot

Int oidEnabled
Int oidDebugMsg

string settingsName = "../sl_triggers/settings"
string commandsPath = "../sl_triggers/commands"

string[] triggerParamNames
string[] triggerIfEventNames
string[] triggerIfRaceNames
string[] triggerIfRoleNames
string[] triggerIfGenderNames
string[] triggerIfTagNames
string[] triggerIfDaytimeNames
string[] triggerIfLocationNames

string[] commandList


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

Function init()
    initPages()
    
	triggerParamNames = new string[12]
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
	
	triggerIfEventNames = new string[4]
	triggerIfEventNames[0] = "Begin"
	triggerIfEventNames[1] = "Orgasm"
	triggerIfEventNames[2] = "End"
	triggerIfEventNames[3] = "Orgasm(SLSO)"
	
	triggerIfRaceNames = new string[11]
	triggerIfRaceNames[ 0] = "Any"
	triggerIfRaceNames[ 1] = "Humanoid"
	triggerIfRaceNames[ 2] = "Creature"
	triggerIfRaceNames[ 3] = "Player"
	triggerIfRaceNames[ 4] = "Not Player"
	triggerIfRaceNames[ 5] = "Undead"
	triggerIfRaceNames[ 6] = "Partner Humanoid"
	triggerIfRaceNames[ 7] = "Partner Creature"
	triggerIfRaceNames[ 8] = "Partner Player"
	triggerIfRaceNames[ 9] = "Partner Not Player"
	triggerIfRaceNames[10] = "Partner Undead"
	
	triggerIfRoleNames = new string[4]
	triggerIfRoleNames[0] = "Any"
	triggerIfRoleNames[1] = "Aggressor"
	triggerIfRoleNames[2] = "Victim"
	triggerIfRoleNames[3] = "Not part of rape"
	
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
	
EndFunction

int Function GetVersion()
	return 12
EndFunction

Event OnConfigInit()
	init()
EndEvent

Event OnVersionUpdate(int version)
	init()
    if version < GetVersion()
        mainQuest.setMaxSlots()
    endIf
EndEvent

Event OnGameReload()
	parent.OnGameReload() ; Don't forget to call the parent!
	
	mainQuest.on_reload()
EndEvent

event OnConfigOpen()
	;MiscUtil.PrintConsole("OnConfigOpen")
	commandList = _getCommands()
    settingsName = mainQuest.getSettingsName()
    commandsPath = mainQuest.getCommandsPath()
	
	;string fName = commandsPath + "/Heal (+100).json"
	;int    idx
	;string ss
	;string[] cmdLine
    
	;JsonUtil.Load(fName)
	;ss = JsonUtil.GetErrors(fName)
	;MiscUtil.PrintConsole("Errors: " + ss)
    
	;idx = JsonUtil.PathCount(fName, ".cmd")
	;MiscUtil.PrintConsole("Lines: " + idx as string)
    
    ;cmdLine = JsonUtil.PathStringElements(fName, ".cmd[0]")
    ;MiscUtil.PrintConsole("1: " + cmdLine[0])
    
    ;cmdLine = JsonUtil.PathStringElements(fName, ".cmd[1]")
    ;MiscUtil.PrintConsole("2: " + cmdLine[0])
	
endEvent

event OnConfigClose()
	;MiscUtil.PrintConsole("OnConfigClose")
	JsonUtil.Save(settingsName)
endEvent

Event OnPageReset(string page)
	If page == ""
        int ver = GetVersion()
		AddHeaderOption("Sexlab Triggers (" + (ver as string) + ")")
	elseIf page == "Main"
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Global settings")
		oidEnabled    = AddToggleOption("Enable", mainQuest.bEnabled)
		oidDebugMsg   = AddToggleOption("Debug messages", mainQuest.bDebugMsg)
		;oidTimer      = AddSliderOption("Timer", iTimer, "{0}")
	elseIf page == "Triggers 1-5"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(1)
		_makeSlotOptions(2)
		_makeSlotOptions(3)
		_makeSlotOptions(4)
		_makeSlotOptions(5)
	elseIf page == "Triggers 6-10"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(6)
		_makeSlotOptions(7)
		_makeSlotOptions(8)
		_makeSlotOptions(9)
		_makeSlotOptions(10)
	elseIf page == "Triggers 11-15"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(11)
		_makeSlotOptions(12)
		_makeSlotOptions(13)
		_makeSlotOptions(14)
		_makeSlotOptions(15)
	elseIf page == "Triggers 16-20"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(16)
		_makeSlotOptions(17)
		_makeSlotOptions(18)
		_makeSlotOptions(19)
		_makeSlotOptions(20)
	elseIf page == "Triggers 21-25"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(21)
		_makeSlotOptions(22)
		_makeSlotOptions(23)
		_makeSlotOptions(24)
		_makeSlotOptions(25)
	elseIf page == "Triggers 26-30"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(26)
		_makeSlotOptions(27)
		_makeSlotOptions(28)
		_makeSlotOptions(29)
		_makeSlotOptions(30)
	elseIf page == "Triggers 31-35"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(31)
		_makeSlotOptions(32)
		_makeSlotOptions(33)
		_makeSlotOptions(34)
		_makeSlotOptions(35)
	elseIf page == "Triggers 36-40"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(36)
		_makeSlotOptions(37)
		_makeSlotOptions(38)
		_makeSlotOptions(39)
		_makeSlotOptions(40)
	elseIf page == "Triggers 41-45"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(41)
		_makeSlotOptions(42)
		_makeSlotOptions(43)
		_makeSlotOptions(44)
		_makeSlotOptions(45)
	elseIf page == "Triggers 46-50"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(46)
		_makeSlotOptions(47)
		_makeSlotOptions(48)
		_makeSlotOptions(49)
		_makeSlotOptions(50)
	elseIf page == "Triggers 51-55"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(51)
		_makeSlotOptions(55)
		_makeSlotOptions(56)
		_makeSlotOptions(57)
		_makeSlotOptions(58)
	elseIf page == "Triggers 56-60"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(56)
		_makeSlotOptions(57)
		_makeSlotOptions(58)
		_makeSlotOptions(59)
		_makeSlotOptions(60)
	elseIf page == "Triggers 61-65"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(61)
		_makeSlotOptions(62)
		_makeSlotOptions(63)
		_makeSlotOptions(64)
		_makeSlotOptions(65)
	elseIf page == "Triggers 66-70"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(66)
		_makeSlotOptions(67)
		_makeSlotOptions(68)
		_makeSlotOptions(68)
		_makeSlotOptions(70)
	elseIf page == "Triggers 71-75"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(71)
		_makeSlotOptions(72)
		_makeSlotOptions(73)
		_makeSlotOptions(74)
		_makeSlotOptions(75)
	elseIf page == "Triggers 76-80"
		SetCursorFillMode(LEFT_TO_RIGHT)
		_makeSlotOptions(76)
		_makeSlotOptions(77)
		_makeSlotOptions(78)
		_makeSlotOptions(79)
		_makeSlotOptions(80)
	EndIf
EndEvent

Event OnOptionSelect(int option)
	If option == oidEnabled
		mainQuest.bEnabled = !mainQuest.bEnabled
		SetToggleOptionValue(option, mainQuest.bEnabled)
	elseIf option == oidDebugMsg
		mainQuest.bDebugMsg = !mainQuest.bDebugMsg
		SetToggleOptionValue(option, mainQuest.bDebugMsg)
	endIf
EndEvent


Event OnOptionMenuOpen(int option)
	string slotId
	string value
	string paramId
	int    idx
	
	paramId = _getParamFromOID(option)
	slotId = _getSlotFromOID(option)
	
	if paramId == "if_chance"
	elseIf paramId == "if_event"
		SetMenuDialogOptions(triggerIfEventNames)
		value = JsonUtil.GetStringValue(settingsName, slotId)
		SetMenuDialogStartIndex(value as int)
		SetMenuDialogDefaultIndex(0)
	elseIf paramId == "if_race"
		SetMenuDialogOptions(triggerIfRaceNames)
		value = JsonUtil.GetStringValue(settingsName, slotId)
		SetMenuDialogStartIndex(value as int)
		SetMenuDialogDefaultIndex(0)
	elseIf paramId == "if_role"
		SetMenuDialogOptions(triggerIfRoleNames)
		value = JsonUtil.GetStringValue(settingsName, slotId)
		SetMenuDialogStartIndex(value as int)
		SetMenuDialogDefaultIndex(0)
	elseIf paramId == "if_gender"
		SetMenuDialogOptions(triggerIfGenderNames)
		value = JsonUtil.GetStringValue(settingsName, slotId)
		SetMenuDialogStartIndex(value as int)
		SetMenuDialogDefaultIndex(0)
	elseIf paramId == "if_tag"
		SetMenuDialogOptions(triggerIfTagNames)
		value = JsonUtil.GetStringValue(settingsName, slotId)
		SetMenuDialogStartIndex(value as int)
		SetMenuDialogDefaultIndex(0)
	elseIf paramId == "if_daytime"
		SetMenuDialogOptions(triggerIfDaytimeNames)
		value = JsonUtil.GetStringValue(settingsName, slotId)
		SetMenuDialogStartIndex(value as int)
		SetMenuDialogDefaultIndex(0)
	elseIf paramId == "if_location"
		SetMenuDialogOptions(triggerIfLocationNames)
		value = JsonUtil.GetStringValue(settingsName, slotId)
		SetMenuDialogStartIndex(value as int)
		SetMenuDialogDefaultIndex(0)
	elseIf paramId == "do_1"
		SetMenuDialogOptions(commandList)
		value = JsonUtil.GetStringValue(settingsName, slotId)
        if value
            idx = commandList.Find(value)
            if idx >= 0
                SetMenuDialogStartIndex(idx)
            endIf
        endIf
		SetMenuDialogDefaultIndex(-1)
	elseIf paramId == "do_2"
		SetMenuDialogOptions(commandList)
		value = JsonUtil.GetStringValue(settingsName, slotId)
        if value
            idx = commandList.Find(value)
            if idx >= 0
                SetMenuDialogStartIndex(idx)
            endIf
        endIf
		SetMenuDialogDefaultIndex(-1)
	elseIf paramId == "do_3"
		SetMenuDialogOptions(commandList)
		value = JsonUtil.GetStringValue(settingsName, slotId)
        if value
            idx = commandList.Find(value)
            if idx >= 0
                SetMenuDialogStartIndex(idx)
            endIf
        endIf
		SetMenuDialogDefaultIndex(-1)
	endIf
EndEvent

Event OnOptionMenuAccept(int option, int index)
	string slotId
	string paramId
	
	paramId = _getParamFromOID(option)
	slotId = _getSlotFromOID(option)
	if slotId
		if index >= 0
			if paramId == "if_chance"
			elseIf paramId == "if_event"
				SetMenuOptionValue(option, triggerIfEventNames[index])
				JsonUtil.SetStringValue(settingsName, slotId, index as string)
			elseIf paramId == "if_race"
				SetMenuOptionValue(option, triggerIfRaceNames[index])
				JsonUtil.SetStringValue(settingsName, slotId, index as string)
			elseIf paramId == "if_role"
				SetMenuOptionValue(option, triggerIfRoleNames[index])
				JsonUtil.SetStringValue(settingsName, slotId, index as string)
			elseIf paramId == "if_gender"
				SetMenuOptionValue(option, triggerIfGenderNames[index])
				JsonUtil.SetStringValue(settingsName, slotId, index as string)
			elseIf paramId == "if_tag"
				SetMenuOptionValue(option, triggerIfTagNames[index])
				JsonUtil.SetStringValue(settingsName, slotId, index as string)
			elseIf paramId == "if_daytime"
				SetMenuOptionValue(option, triggerIfDaytimeNames[index])
				JsonUtil.SetStringValue(settingsName, slotId, index as string)
			elseIf paramId == "if_location"
				SetMenuOptionValue(option, triggerIfLocationNames[index])
				JsonUtil.SetStringValue(settingsName, slotId, index as string)
			elseIf paramId == "do_1"
                string val
                if index >= 0
                    val = commandList[index]
                endIf
				SetMenuOptionValue(option, val)
				JsonUtil.SetStringValue(settingsName, slotId, val)
			elseIf paramId == "do_2"
                string val
                if index >= 0
                    val = commandList[index]
                endIf
				SetMenuOptionValue(option, commandList[index])
				JsonUtil.SetStringValue(settingsName, slotId, commandList[index])
			elseIf paramId == "do_3"
                string val
                if index >= 0
                    val = commandList[index]
                endIf
				SetMenuOptionValue(option, val)
				JsonUtil.SetStringValue(settingsName, slotId, val)
			endIf
		else
			SetMenuOptionValue(option, "")
			JsonUtil.SetStringValue(settingsName, slotId, "")
		endIf
	endIf
		
EndEvent

Event OnOptionSliderOpen(int option)
	string slotId
	string value
	string paramId
	
	paramId = _getParamFromOID(option)
	slotId = _getSlotFromOID(option)
	
	if paramId == "if_chance"
		value = JsonUtil.GetStringValue(settingsName, slotId)
		SetSliderDialogStartValue(value as float)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	endIf	
EndEvent

Event OnOptionSliderAccept(int option, float value)
	string slotId
	string paramId
	
	paramId = _getParamFromOID(option)
	slotId = _getSlotFromOID(option)
	if paramId == "if_chance"
        if value > 0.0
            JsonUtil.SetStringValue(settingsName, slotId, value as string)
        else
            JsonUtil.UnsetStringValue(settingsName, slotId)
        endIf
		SetSliderOptionValue(option, value, "{0}%")
        mainQuest.setMaxSlots()
	endIf
	
EndEvent

Event OnOptionHighlight(int option)
EndEvent


Function _makeSlotOptions(int _slotNo)
	AddHeaderOption("<font color='#FFFFFF'>slot-" + (_slotNo as string) + "</font>")
	AddSliderOption("chance",         _getSlotValue(_slotNo, 1) as float, "{0}%") ;0-100
	AddMenuOption  ("on event",       _getSlotValue(_slotNo, 2)) 
	AddMenuOption  ("if actor race",  _getSlotValue(_slotNo, 3)) 
	AddMenuOption  ("if actor",       _getSlotValue(_slotNo, 4))
	AddMenuOption  ("if gender",      _getSlotValue(_slotNo, 5))
	AddMenuOption  ("if sex type",    _getSlotValue(_slotNo, 6))
	AddMenuOption  ("if day time",    _getSlotValue(_slotNo, 7))
	AddMenuOption  ("if location",    _getSlotValue(_slotNo, 8))
	AddMenuOption  ("command 1",   _getSlotValue(_slotNo, 9))
	AddMenuOption  ("command 2",   _getSlotValue(_slotNo, 10))
	AddMenuOption  ("command 3",   _getSlotValue(_slotNo, 11))
EndFunction

string Function _getSlotValue(int slotNo, int paramNo)
	string slotId = _makeSlotId(slotNo, paramNo)
	string paramId = triggerParamNames[paramNo]	
	string value
	int index
	
	value = JsonUtil.GetStringValue(settingsName, slotId)
	if paramId == "if_chance"
		return value
	elseIf paramId == "do_1"
		return value
	elseIf paramId == "do_2"
		return value
	elseIf paramId == "do_3"
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
		elseIf paramId == "if_gender"
			return triggerIfGenderNames[index]
		elseIf paramId == "if_tag"
			return triggerIfTagNames[index]
		elseIf paramId == "if_daytime"
			return triggerIfDaytimeNames[index]
		elseIf paramId == "if_location"
			return triggerIfLocationNames[index]
		endIf
	endIf
	return ""
EndFunction

string Function _makeSlotId(int slotId, int paramNo)
	return "slot" + slotId + "." + triggerParamNames[paramNo]
EndFunction

string Function _getSlotFromOID(int _oid)
	int idx
	int pageNo
	int slotId
	int paramNo
	
	idx = _oid % 0x100
	pageNo = ((_oid / 0x100) as int) - 1
	slotId = (((pageNo - 1) * perPage) + ((idx / perSlot) as int)) + 1
	paramNo = idx % perSlot
	
	if slotId > 0 && paramNo > 0
		return "slot" + slotId + "." + triggerParamNames[paramNo]
	endif
	
	MiscUtil.PrintConsole("Bad id: " + slotId as string + ", " + paramNo as string)
	return ""
EndFunction

string Function _getParamFromOID(int _oid)
	int idx
	int paramNo
	
	idx = _oid % 0x100
	paramNo = idx % perSlot
	
	return triggerParamNames[paramNo]
EndFunction

string[] Function _getCommands()
	return JsonUtil.JsonInFolder(commandsPath)
EndFunction
