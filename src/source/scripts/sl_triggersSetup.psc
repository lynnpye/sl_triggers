scriptname sl_triggersSetup extends SKI_ConfigBase

import sl_triggersStatics
import sl_triggersFile
import sl_triggersHeap

; CONSTANTS
int			CARDS_PER_PAGE = 5
string		SLTSETUPCONST = "sl_triggersSetup"
string		ADD_BUTTON = "--ADDNEWITEM--"
string		DELETE_BUTTON = "--DELETETHISITEM--"
string		RESTORE_BUTTON = "--RESTORETHISITEM--"

; Properties
sl_TriggersMain		Property SLT Auto

string				Property CurrentExtensionKey Hidden
	string Function Get()
		return _currentExtensionKey
	EndFunction
EndProperty

string[] Property CommandsList Hidden
	string[] Function Get()
		return _commandsList
	EndFunction
EndProperty

int	Property WIDG_SLIDER Hidden
	int Function Get()
		return 1
	EndFunction
EndProperty

int	Property WIDG_MENU Hidden
	int Function Get()
		return 2
	EndFunction
EndProperty

int	Property WIDG_KEYMAP Hidden
	int Function Get()
		return 3
	EndFunction
EndProperty

int	Property WIDG_TOGGLE Hidden
	int Function Get()
		return 4
	EndFunction
EndProperty

int	Property WIDG_INPUT Hidden
	int Function Get()
		return 5
	EndFunction
EndProperty

int	Property WIDG_COMMANDLIST Hidden
	int Function Get()
		return 6
	EndFunction
EndProperty


; Variables
int			oidEnabled
int			oidDebugMsg
int			oidCardinatePrevious
int			oidCardinateNext
int			oidAddTop
int			oidAddBottom

string[]	headerPages
string[]	extensionPages
string[]	extensionKeys
string[]	attributeNames
string[]	_commandsList

string		currentSLTPage
string		_currentExtensionKey

;bool 		readinessCheck
int			headerIndex
int			extensionIndex
int			currentCardination

int Function GetVersion()
	return GetModVersion()
EndFunction

Event OnConfigInit()
	; set my pages
	headerPages = new string[1]
	headerPages[0] = "SL Triggers"
EndEvent

;/
Event OnVersionUpdate(int version)
EndEvent

Event OnGameReload
	parent.OnGameReload()
EndEvent
/;

Function SaveDirtyTrigger(string _extensionKey, string _triggerKey)
	JsonUtil.Save(ExtensionTriggerName(_extensionKey, _triggerKey))
EndFunction

Event OnConfigOpen()
	if extensionPages.Length > 0
		Pages = PapyrusUtil.MergeStringArray(headerPages, extensionPages)
	else
		Pages = headerPages
	endif
EndEvent

event OnConfigClose()
	SLT.SendInternalSettingsUpdateEvents()
endEvent

;/
Function SetMCMReady(bool _readiness = true)
	readinessCheck = _readiness
EndFunction
/;

int Function ClearSetupHeap()
	return Heap_ClearPrefixF(self, "sl_triggersSetup")
EndFunction

int Function ClearSetupOidHeap()
	return Heap_ClearPrefixF(self, "sl_triggersSetup:oid")
EndFunction

int Function ClearSetupExtensionKeyHeap(string extensionKey)
	if !extensionKey
		return 0
	endif
	return Heap_ClearPrefixF(self, "sl_triggersSetup:ek-" + extensionKey)
EndFunction

Function SetCommandsList(string[] __commandsList)
	_commandsList = __commandsList
EndFunction

Event OnPageReset(string page)
	SetSLTCurrentPage(page)
	
	if IsHeaderPage()
		ShowHeaderPage()
		return
	endif
	
	if IsExtensionPage()
		ShowExtensionPage()
		return
	endif
	
	; obviously it should be one or the other and yet here we are
	Debug.Trace("SLT: Setup: Page is neither header nor extension")
EndEvent

; All
Event OnOptionHighlight(int option)
	string extKey = CurrentExtensionKey
	string attrName = GetOidAttributeName(option)
	
	if HasAttrHighlight(extKey, attrName)
		SetInfoText(GetAttrHighlight(extKey, attrName))
	endif
EndEvent

; All
Event OnOptionDefault(int option)
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	int attrType = GetAttrType(extKey, attrName)
	int attrWidg = GetAttrWidget(extKey, attrName)
	int defInt
	float defFlt
	string defStr
	
	float	optFlt
	int		optInt
	string	optStr
	bool	optBool
	
	; set the trigger value
	if attrType == PTYPE_INT()
		defInt = GetAttrDefaultValue(extKey, attrName)
		Trigger_IntSetX(extKey, triKey, attrName, defInt)
	elseif attrType == PTYPE_STRING()
		defStr = GetAttrDefaultString(extKey, attrName)
		Trigger_StringSetX(extKey, triKey, attrName, defStr)
	elseif attrType == PTYPE_FLOAT()
		defFlt = GetAttrDefaultFloat(extKey, attrName)
		Trigger_FloatSetX(extKey, triKey, attrName, defFlt)
	endif
	
	; and set the option value
	if attrWidg == WIDG_SLIDER
		if attrType == PTYPE_INT()
			optFlt = defInt as float
		elseif attrType == PTYPE_STRING()
			optFlt = defStr as float
		elseif attrType == PTYPE_FLOAT()
			optFlt = defFlt
		endif
		
		SetSliderOptionValue(option, optFlt, GetAttrFormatString(extKey, attrName))
	elseif attrWidg == WIDG_MENU
		if attrType == PTYPE_INT()
			optInt = defInt
		elseif attrType == PTYPE_STRING()
			optInt = GetAttrMenuSelectionIndex(extKey, attrName, defStr)
		endif
		
		SetMenuOptionValue(option, optInt)
	elseif attrWidg == WIDG_KEYMAP
		SetKeyMapOptionValue(option, defInt)
	elseif attrWidg == WIDG_TOGGLE
		if attrType == PTYPE_INT()
			optBool = defInt != 0
		elseif attrType == PTYPE_STRING()
			optBool = defStr as bool
		elseif attrType == PTYPE_FLOAT()
			optBool = defFlt != 0.0
		endif
		
		SetToggleOptionValue(option, optBool)
	elseif attrWidg == WIDG_INPUT
		; not sent according to docs?
		Debug.Trace("Setup.OnOptionDefault: Input widget received, which was unexpected")
	elseif attrWidg == WIDG_COMMANDLIST
		SetMenuOptionValue(option, "")
	endif
	
	SaveDirtyTrigger(extKey, triKey)

	if IsOidVisibilityKey(option)
		ForcePageReset()
	endif
EndEvent

; Text (buttons?)
; Toggle
Event OnOptionSelect(int option)
	If option == oidEnabled
		SLT.bEnabled = !SLT.bEnabled
		SetToggleOptionValue(option, SLT.bEnabled)
		
		return
	elseIf option == oidDebugMsg
		SLT.bDebugMsg = !SLT.bDebugMsg
		SetToggleOptionValue(option, SLT.bDebugMsg)
		
		return
	elseIf option == oidCardinatePrevious
		currentCardination -= 1
		ForcePageReset()
		
		return
	elseIf option == oidCardinateNext
		currentCardination += 1
		ForcePageReset()
		
		return
	elseIf option == oidAddTop || option == oidAddBottom
		; add a record
		Trigger_CreateT(extensionKeys[extensionIndex])
		ForcePageReset()
	
		return
	endIf
	
	string extensionKey
	string triggerKey
	string attrName = GetOidAttributeName(option)
	if attrName == DELETE_BUTTON
		extensionKey = CurrentExtensionKey
		triggerKey = GetOidTriggerKey(option)
		
		Trigger_StringSetX(extensionKey, triggerKey, DELETED_ATTRIBUTE(), "true")
		ForcePageReset()
	elseif attrName == RESTORE_BUTTON
		extensionKey = CurrentExtensionKey
		triggerKey = GetOidTriggerKey(option)
		
		Trigger_StringUnsetX(extensionKey, triggerKey, DELETED_ATTRIBUTE())
		ForcePageReset()
	endif
EndEvent

; Slider
Event OnOptionSliderOpen(int option)
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	SetSliderDialogStartValue(Trigger_GetAsFloat(extKey, triKey, attrName))
	SetSliderDialogDefaultValue(GetAttrDefaultFloat(extKey, attrName))
	SetSliderDialogRange(GetAttrMinValue(extKey, attrName), GetAttrMaxValue(extKey, attrName))
	SetSliderDialogInterval(GetAttrInterval(extKey, attrName))
EndEvent

Event OnOptionSliderAccept(int option, float value)
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	Trigger_SetFromFloat(extKey, triKey, attrName, value)
	SetSliderOptionValue(option, value, GetAttrFormatString(extKey, attrName))
	
	SaveDirtyTrigger(extKey, triKey)

	if IsOidVisibilityKey(option)
		ForcePageReset()
	endif
EndEvent

; Menu
Event OnOptionMenuOpen(int option)
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	int attrType = GetAttrType(extKey, attrName)
	int attrWidg = GetAttrWidget(extKey, attrName)
	
	int defaultIndex = 0
	int menuIndex = 0
	string menuValue = ""
	string[] menuSelections = GetAttrMenuSelections(extKey, attrName)
	SetMenuDialogOptions(menuSelections)
	
	if attrWidg == WIDG_COMMANDLIST
		defaultIndex = -1
		if Trigger_StringHasX(extKey, triKey, attrName)
			menuValue = Trigger_StringGetX(extKey, triKey, attrName)
			menuIndex = menuSelections.find(menuValue)
		endif
	elseif attrWidg == WIDG_MENU
		if attrType == PTYPE_INT()
			defaultIndex = GetAttrDefaultValue(extKey, attrName)
			menuIndex = Trigger_IntGetX(extKey, triKey, attrName)
			menuValue = menuSelections[menuIndex]
		elseif attrType == PTYPE_STRING()
			defaultIndex = menuSelections.find(GetAttrDefaultString(extKey, attrName))
			menuValue = Trigger_StringGetX(extKey, triKey, attrName)
			menuIndex = menuSelections.find(menuValue)
		endif
	endif
	
	SetMenuDialogOptions(menuSelections)
	SetMenuDialogStartIndex(menuIndex)
	SetMenuDialogDefaultIndex(defaultIndex)
EndEvent

Event OnOptionMenuAccept(int option, int index)
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	int attrType = GetAttrType(extKey, attrName)
	
	string[] menuSelections = GetAttrMenuSelections(extKey, attrName)
	
	if index >= 0
		if attrType == PTYPE_INT()
			Trigger_IntSetX(extKey, triKey, attrName, index)
		elseif attrType == PTYPE_STRING()
			Trigger_StringSetX(extKey, triKey, attrName, menuSelections[index])
			string asdf = Trigger_StringGetX(extKey, triKey, attrName)
		endif
		SetMenuOptionValue(option, menuSelections[index])
	else
		if attrType == PTYPE_INT()
			Trigger_IntUnsetX(extKey, triKey, attrName)
		elseif attrType == PTYPE_STRING()
			Trigger_StringUnsetX(extKey, triKey, attrName)
		endif
		SetMenuOptionValue(option, "")
	endif
	
	SaveDirtyTrigger(extKey, triKey)

	if IsOidVisibilityKey(option)
		ForcePageReset()
	endif
EndEvent

; Keymap
Event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
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
		if keyCode >= 0
			Trigger_IntSetX(extKey, triKey, attrName, keyCode)
		else
			Trigger_IntUnsetX(extKey, triKey, attrName)
		endif
		SetKeyMapOptionValue(option, keyCode)
		
		SaveDirtyTrigger(extKey, triKey)

		if IsOidVisibilityKey(option)
			ForcePageReset()
		endif
	endif
EndEvent

; Input (string input dialog)
Event OnOptionInputOpen(int option)
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	string optVal
	if Trigger_HasAsString(extKey, triKey, attrName)
		optVal = Trigger_GetAsString(extKey, triKey, attrName)
	else
		optVal = GetAttrDefaultString(extKey, attrName)
	endif
	SetInputDialogStartText(optVal)
EndEvent

Event OnOptionInputAccept(int option, string _input)
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	Trigger_SetFromString(extKey, triKey, attrName, _input)
	SetInputOptionValue(option, _input)
	
	SaveDirtyTrigger(extKey, triKey)

	if IsOidVisibilityKey(option)
		ForcePageReset()
	endif
EndEvent

Function ShowExtensionPage()
	if extensionPages.Length < 1
		return
	endif
	; I have an extensionIndex with which I can retrieve an extensionKey
	; if I'm going to paginate I need to have a concept of where in the order
	; I am in for triggerKeys
	string extensionKey = extensionKeys[extensionIndex]
	int triggerCount = GetTriggerCount(extensionKey)
	
	bool cardinate = false
	bool hasNextCardinate = false
	
	if triggerCount > CARDS_PER_PAGE
		cardinate = true
	endif
	
	; what do we want this to look like?
	SetCursorFillMode(LEFT_TO_RIGHT)
	
	int startIndex = 0
	int displayCount = CARDS_PER_PAGE
	if !cardinate
		displayCount = triggerCount
	else
		displayCount = triggerCount - currentCardination * displayCount
		if displayCount > CARDS_PER_PAGE
			displayCount = CARDS_PER_PAGE
			hasNextCardinate = true
		endif
	endif
	
	if cardinate
		; set startIndex appropriately
		startIndex = currentCardination * CARDS_PER_PAGE
		
		; display cardination buttons
		if currentCardination > 0
			oidCardinatePrevious = AddTextOption("&lt;&lt; Previous", "")
		else
			oidCardinatePrevious = AddTextOption("&lt;&lt; Previous", "", OPTION_FLAG_DISABLED)
		endif
		
		if hasNextCardinate
			oidCardinateNext = AddTextOption("Next &gt;&gt;", "")
		else
			oidCardinateNext = AddTextOption("Next &gt;&gt;", "", OPTION_FLAG_DISABLED)
		endif
	endif
	
	oidAddTop = AddTextOption("Add New Item", "")
	AddEmptyOption()
	
	int displayIndexer = 0
	bool needsEmpty = false
	int _oid
	string visibilityKeyAttribute = GetExtensionVisibilityKey(extensionKey)
	bool allowedVisible
	bool triggerIsSoftDeleted
	string triggerKey
	
	while displayIndexer < displayCount
		triggerKey = GetTrigger(extensionKey, displayIndexer + startIndex)
		triggerIsSoftDeleted = Trigger_IsDeletedT(extensionKey, triggerKey)
		;if !Trigger_IsDeletedT(extensionKey, triggerKey)
			AddHeaderOption("==] " + triggerKey + " [==")
			AddEmptyOption()

			needsEmpty = false
			int widgetOptions = OPTION_FLAG_NONE
			if triggerIsSoftDeleted
				widgetOptions = OPTION_FLAG_DISABLED
				AddHeaderOption("This trigger has been soft deleted.")
				AddHeaderOption("It can be restored.")
				AddHeaderOption("Or it can be fully removed by removing the file between games.")
				AddHeaderOption("Until restored, the trigger will not run.")
			endif

			;if !triggerIsSoftDeleted
				int aidx = 0
				while aidx < attributeNames.Length
					string attrName = attributeNames[aidx]
					allowedVisible = true
					
					if visibilityKeyAttribute && HasAttrVisibleOnlyIf(extensionKey, attrName)
						string visibleOnlyIfValueIs = GetAttrVisibleOnlyIf(extensionKey, attrName)
						
						string tval
						if Trigger_IntHasX(extensionKey, triggerKey, visibilityKeyAttribute)
							tval = Trigger_IntGetX(extensionKey, triggerKey, visibilityKeyAttribute) as string
						elseif Trigger_StringHasX(extensionKey, triggerKey, visibilityKeyAttribute)
							tval = Trigger_StringGetX(extensionKey, triggerKey, visibilityKeyAttribute)
						else
							; they specified it, it somehow got past, and now we have to deal with it
							; or ignore it
							Debug.Trace("MCM: visibilityKeyAttribute (" + visibilityKeyAttribute + ") specified but neither int nor string available for current trigger")
						endif
						
						if !tval || tval != visibleOnlyIfValueIs
							allowedVisible = false
						endif
					endif
					
					if allowedVisible
						needsEmpty = !needsEmpty
						
						int widg = GetAttrWidget(extensionKey, attrName)
						string label = GetAttrLabel(extensionKey, attrName)
						if widg == WIDG_SLIDER
							float _defval = GetAttrDefaultFloat(extensionKey, attrName)
							if Trigger_FloatHasX(extensionKey, triggerKey, attrName)
								_defval = Trigger_FloatGetX(extensionKey, triggerKey, attrName)
							endif
							_oid = AddSliderOption(label, _defval, GetAttrFormatString(extensionKey, attrName), widgetOptions)
							; add to list of oids to heap
							AddOid(_oid, extensionKey, triggerKey, attrName)
						elseif widg == WIDG_MENU
							string[] menuSelections = GetAttrMenuSelections(extensionKey, attrName)
							int ptype = GetAttrType(extensionKey, attrName)
							string menuValue = ""
							if (ptype == PTYPE_INT() && !Trigger_IntHasX(extensionKey, triggerKey, attrName)) || (ptype == PTYPE_STRING() && !Trigger_StringHasX(extensionKey, triggerKey, attrName))
								int midx = GetAttrDefaultIndex(extensionKey, attrName)
								if midx > -1
									menuValue = menuSelections[midx]
								endif
							else
								if ptype == PTYPE_INT()
									int midx = Trigger_IntGetX(extensionKey, triggerKey, attrName)
									if midx > -1
										menuValue = menuSelections[midx]
									endif
								elseif ptype == PTYPE_STRING()
									string _tval = Trigger_StringGetX(extensionKey, triggerKey, attrName)
									if menuSelections.find(_tval) > -1
										menuValue = _tval
									endif
								endif
							endif
							_oid = AddMenuOption(label, menuValue, widgetOptions)
							AddOid(_oid, extensionKey, triggerKey, attrName)
						elseif widg == WIDG_KEYMAP
							int _defmap = GetAttrDefaultValue(extensionKey, attrName)
							if Trigger_IntHasX(extensionKey, triggerKey, attrName)
								_defmap = Trigger_IntGetX(extensionKey, triggerKey, attrName)
							endif
							int keymapOptions = OPTION_FLAG_WITH_UNMAP
							if triggerIsSoftDeleted
								keymapOptions = OPTION_FLAG_DISABLED
							endif
							_oid = AddKeyMapOption(label, _defmap, keymapOptions)
							AddOid(_oid, extensionKey, triggerKey, attrName)
						elseif widg == WIDG_TOGGLE
							bool _defval = GetAttrDefaultValue(extensionKey, attrName) != 0
							if Trigger_IntHasX(extensionKey, triggerKey, attrName)
								_defval = Trigger_IntGetX(extensionKey, triggerKey, attrName) != 0
							endif
							_oid = AddToggleOption(label, _defval, widgetOptions)
							AddOid(_oid, extensionKey, triggerKey, attrName)
						elseif widg == WIDG_INPUT
							string _defval = GetAttrDefaultString(extensionKey, attrName)
							
							int ptype = GetAttrType(extensionKey, attrName)
							if ptype == PTYPE_INT()
								if Trigger_IntHasX(extensionKey, triggerKey, attrName)
									_defval = Trigger_IntGetX(extensionKey, triggerKey, attrName) as string
								endif
							elseif ptype == PTYPE_FLOAT()
								if Trigger_FloatHasX(extensionKey, triggerKey, attrName)
									_defval = Trigger_FloatGetX(extensionKey, triggerKey, attrName) as string
								endif
							elseif ptype == PTYPE_STRING()
								if Trigger_StringHasX(extensionKey, triggerKey, attrName)
									_defval = Trigger_StringGetX(extensionKey, triggerKey, attrName)
								endif
							elseif ptype == PTYPE_FORM()
								if Trigger_FormHasX(extensionKey, triggerKey, attrName)
									_defval = Trigger_FormGetX(extensionKey, triggerKey, attrName) as string
								endif
							endif
							
							_oid = AddInputOption(label, _defval, widgetOptions)
							AddOid(_oid, extensionKey, triggerKey, attrName)
						elseif widg == WIDG_COMMANDLIST
							string menuValue = ""
							if Trigger_StringHasX(extensionKey, triggerKey, attrName)
								string _cval = Trigger_StringGetX(extensionKey, triggerKey, attrName)
								if CommandsList.find(_cval) > -1
									menuValue = _cval
								endif
							endif
							
							_oid = AddMenuOption(label, menuValue, widgetOptions)
							AddOid(_oid, extensionKey, triggerKey, attrName)
						endif
					endif
					
					aidx += 1
				endwhile
			;endif
			
			; for two column layout
			if needsEmpty
				AddEmptyOption()
			endif
			
			; blank row
			AddEmptyOption()
			AddEmptyOption()
			
			AddEmptyOption()
			if !triggerIsSoftDeleted
				; and option to delete
				_oid = AddTextOption("Delete", "")
				AddOid(_oid, extensionKey, triggerKey, DELETE_BUTTON)
			else
				; and option to undelete
				_oid = AddTextOption("Restore", "")
				AddOid(_oid, extensionKey, triggerKey, RESTORE_BUTTON)
			endif
		;endif
	
		displayIndexer += 1
	endwhile
	
	if displayCount > 2
		; blank row
		AddEmptyOption()
		AddEmptyOption()
		
		oidAddBottom = AddTextOption("Add New Item", "")
		AddEmptyOption()
	endif
	
;/

[=======  Extension Settings ======]
[=======  Add  Trigger       ======]
[= Prev =]				  [= Next =]
[=======  Trigger-foo        ======]
 asdf asdf
 asdf asdf
						[= Delete =]
[=======  Trigger-bar        ======]
 asdf asdf
 asdf asdf
						[= Delete =]
	
/;

	
EndFunction


Function ShowHeaderPage()
	SetCursorFillMode(TOP_TO_BOTTOM)
	int ver = GetVersion()
	AddHeaderOption("SL Triggers (" + (ver as string) + ")")
	AddHeaderOption("Global settings")
	oidEnabled    = AddToggleOption("Enable", SLT.bEnabled)
	oidDebugMsg   = AddToggleOption("Debug messages", SLT.bDebugMsg)
EndFunction

Function PageChanged()
	currentCardination = 0
EndFunction

Function SetSLTCurrentPage(string _page)
	bool pageDidChange
	if _page != currentSLTPage
		pageDidChange = true
		PageChanged()
	endif
	
	currentSLTPage = _page
	
	if currentSLTPage == ""
		extensionIndex = -1
		headerIndex = 0
		_currentExtensionKey = ""
	else
		extensionIndex = extensionPages.find(currentSLTPage)
		if extensionIndex > -1
			headerIndex = -1
			_currentExtensionKey = extensionKeys[extensionIndex]
		else
			headerIndex = headerPages.find(_page)
			_currentExtensionKey = ""
		endif
	endif
	
	if pageDidChange && IsExtensionPage()
		attributeNames = GetAttributeNames(extensionKeys[extensionIndex])
	endif
	
EndFunction

bool Function IsHeaderPage()
	return headerIndex > -1
EndFunction

bool Function IsExtensionPage()
	return extensionIndex > -1
EndFunction


Function SetExtensionPages(string[] _extensionFriendlyNames, string[] _extensionKeys)
	extensionPages = _extensionFriendlyNames
	extensionKeys = _extensionKeys
EndFunction




; Trigger Data Convenience Functions
bool Function Trigger_IsDeletedT(string _extensionKey, string _triggerKey)
	return JsonUtil.HasStringValue(ExtensionTriggerName(_extensionKey, _triggerKey), DELETED_ATTRIBUTE())
EndFunction

string Function Trigger_CreateT(string _extensionKey)
	string triggerKey
	string triggerFileName
	int triggerNum = 1
	bool found = true
	while found && triggerNum < 1000
		if triggerNum < 10
			triggerKey = "trigger00" + triggerNum
		elseif triggerNum < 100
			triggerKey = "trigger0" + triggerNum
		else ; more than 1000 for a single extension seems.... unlikely
			triggerKey = "trigger" + triggerNum
		endif
		
		triggerFileName = ExtensionTriggerName(_extensionKey, triggerKey)
		if !JsonUtil.JsonExists(triggerFileName)
			found = false
		else
			triggerNum += 1
		endif
	endwhile
	
	if found
		Debug.Trace("SLT: Setup: Unable to create new trigger: '" + triggerFileName + "'")
	else
		AddTrigger(_extensionKey, triggerKey)
		Trigger_IntSetX(_extensionKey, triggerKey, "__slt_mod_version__", GetModVersion())
		SaveDirtyTrigger(_extensionKey, triggerKey)
	endif
	
	return triggerKey
EndFunction

; DescribeSliderAttribute
; Tells setup to render the attribute via a Slider
; _formatString is optional
; _ptype accepted values: PTYPE_INT(), PTYPE_FLOAT()
Function DescribeSliderAttribute(string _extensionKey, string _attributeName, int _ptype, string _label, float _minValue, float _maxValue, float _interval, string _formatString = "", float _defaultFloat = 0.0)
	if !_extensionKey
		Debug.Trace("Setup: _extensionKey is required but was not provided")
		return
	endif
	if !_attributeName
		Debug.Trace("Setup: _attributeName is required but was not provided")
		return
	endif
	if _ptype != PTYPE_INT() && _ptype != PTYPE_FLOAT()
		Debug.Trace("Setup: Slider: requires int or float")
		return
	endif
	if !_label
		Debug.Trace("Setup: _label is required but was not provided")
		return
	endif
	if _minValue >= _maxValue
		Debug.Trace("Setup: Slider: _minValue >= _maxValue is not allowed")
		return
	endif
	if _minValue > _defaultFloat || _defaultFloat > _maxValue
		Debug.Trace("Setup: Slider: _defaultFloat outside of _min/_max range")
		return
	endif
	
	SetAttrWidget(_extensionKey, _attributeName, WIDG_SLIDER)
	SetAttrType(_extensionKey, _attributeName, _ptype)
	SetAttrLabel(_extensionKey, _attributeName, _label)
	SetAttrMinValue(_extensionKey, _attributeName, _minValue)
	SetAttrMaxValue(_extensionKey, _attributeName, _maxValue)
	SetAttrInterval(_extensionKey, _attributeName, _interval)
	SetAttrDefaultFloat(_extensionKey, _attributeName, _defaultFloat)
	if _formatString
		SetAttrFormatString(_extensionKey, _attributeName, _formatString)
	endif
EndFunction

; DescribeMenuAttribute
; Tells setup to render the attribute via a menu
; _ptype accepted values: PTYPE_INT(), PTYPE_STRING()
Function DescribeMenuAttribute(string _extensionKey, string _attributeName, int _ptype, string _label, int _defaultIndex, string[] _menuSelections)
	if !_extensionKey
		Debug.Trace("Setup: _extensionKey is required but was not provided")
		return
	endif
	if !_attributeName
		Debug.Trace("Setup: _attributeName is required but was not provided")
		return
	endif
	if _ptype != PTYPE_INT() && _ptype != PTYPE_STRING()
		Debug.Trace("Setup: Menu requires int or string")
		return
	endif
	if !_label
		Debug.Trace("Setup: _label is required but was not provided")
		return
	endif
	
	SetAttrWidget(_extensionKey, _attributeName, WIDG_MENU)
	SetAttrType(_extensionKey, _attributeName, _ptype)
	SetAttrLabel(_extensionKey, _attributeName, _label)
	SetAttrDefaultIndex(_extensionKey, _attributeName, _defaultIndex)
	SetAttrMenuSelections(_extensionKey, _attributeName, _menuSelections)
EndFunction

; DescribeKeymapAttribute
; Tells setup to render the attribute via a keymap
; _ptype accepted values: PTYPE_INT()
Function DescribeKeymapAttribute(string _extensionKey, string _attributeName, int _ptype, string _label, int _defaultValue = -1)
	if !_extensionKey
		Debug.Trace("Setup: _extensionKey is required but was not provided")
		return
	endif
	if !_attributeName
		Debug.Trace("Setup: _attributeName is required but was not provided")
		return
	endif
	if _ptype != PTYPE_INT()
		Debug.Trace("Setup: Keymap requires int")
		return
	endif
	if !_label
		Debug.Trace("Setup: _label is required but was not provided")
		return
	endif
	
	SetAttrWidget(_extensionKey, _attributeName, WIDG_KEYMAP)
	SetAttrLabel(_extensionKey, _attributeName, _label)
	SetAttrDefaultValue(_extensionKey, _attributeName, _defaultValue)
EndFunction

; DescribeToggleAttribute
; Tells setup to render the attribute via a toggle
; _ptype accepted values: PTYPE_INT()
Function DescribeToggleAttribute(string _extensionKey, string _attributeName, int _ptype, string _label, int _defaultValue = 0)
	if !_extensionKey
		Debug.Trace("Setup: _extensionKey is required but was not provided")
		return
	endif
	if !_attributeName
		Debug.Trace("Setup: _attributeName is required but was not provided")
		return
	endif
	if _ptype != PTYPE_INT()
		Debug.Trace("Setup: Toggle requires int")
		return
	endif
	if !_label
		Debug.Trace("Setup: _label is required but was not provided")
		return
	endif
	
	SetAttrWidget(_extensionKey, _attributeName, WIDG_TOGGLE)
	SetAttrLabel(_extensionKey, _attributeName, _label)
	SetAttrDefaultValue(_extensionKey, _attributeName, _defaultValue)
EndFunction

; DescribeInputAttribute
; Tells setup to render the attribute via an input
; _ptype accepted values: Any
Function DescribeInputAttribute(string _extensionKey, string _attributeName, int _ptype, string _label, string _defaultValue = "")
	if !_extensionKey
		Debug.Trace("Setup: _extensionKey is required but was not provided")
		return
	endif
	if !_attributeName
		Debug.Trace("Setup: _attributeName is required but was not provided")
		return
	endif
	if !_label
		Debug.Trace("Setup: _label is required but was not provided")
		return
	endif
	
	SetAttrWidget(_extensionKey, _attributeName, WIDG_INPUT)
	SetAttrLabel(_extensionKey, _attributeName, _label)
	SetAttrDefaultString(_extensionKey, _attributeName, _defaultValue)
EndFunction

; AddCommandList
; Tells setup to render a dropdown list of available commands.
; You can call this multiple times to add the option of running
; multiple commands from the same trigger (i.e. 3 was legacy setting)
Function AddCommandList(string _extensionKey, string _attributeName, string _label)
	if !_extensionKey
		Debug.Trace("Setup: _extensionKey is required but was not provided")
		return
	endif
	if !_attributeName
		Debug.Trace("Setup: _attributeName is required but was not provided")
		return
	endif
	if !_label
		Debug.Trace("Setup: _label is required but was not provided")
		return
	endif
	
	SetAttrWidget(_extensionKey, _attributeName, WIDG_COMMANDLIST)
	SetAttrType(_extensionKey, _attributeName, PTYPE_STRING())
	SetAttrLabel(_extensionKey, _attributeName, _label)
	SetAttrDefaultIndex(_extensionKey, _attributeName, -1)
	SetAttrMenuSelections(_extensionKey, _attributeName, CommandsList)
EndFunction

Function SetVisibilityKeyAttribute(string _extensionKey, string _attributeName)
	if !_extensionKey
		Debug.Trace("Setup: _extensionKey is required but was not provided")
		return
	endif
	if !_attributeName
		Debug.Trace("Setup: _attributeName is required but was not provided")
		return
	endif
	int _attrType = GetAttrType(_extensionKey, _attributeName)
	if _attrType != PTYPE_INT() && _attrType != PTYPE_STRING()
		Debug.Trace("Setup: _attributeName must be PTYPE_INT or PTYPE_STRING")
		return
	endif
	
	SetExtensionVisibilityKey(_extensionKey, _attributeName)
EndFunction

; SetVisibleOnlyIf
; Tells setup that the specified attribute should only be displayed in the MCM if the
; visibility key attribute has the specified value. Note that this function will
; have no effect if SetVisibilityKeyAttribute() is not also called.
;
; If the PTYPE of the key attribute is int, cast to string for this call.
Function SetVisibleOnlyIf(string _extensionKey, string _attributeName, string _requiredKeyAttributeValue)
	if !_extensionKey
		Debug.Trace("Setup: _extensionKey is required but was not provided")
		return
	endif
	if !_attributeName
		Debug.Trace("Setup: _attributeName is required but was not provided")
		return
	endif
	if !_requiredKeyAttributeValue
		Debug.Trace("Setup: _requiredKeyAttributeValue is required but was not provided")
		return
	endif
	
	SetAttrVisibleOnlyIf(_extensionKey, _attributeName, _requiredKeyAttributeValue)
EndFunction

; SetHighlightText
; Tells setup what to display when the attribute is highlighted in the MCM.
Function SetHighlightText(string _extensionKey, string _attributeName, string _highlightText)
	if !_extensionKey
		Debug.Trace("Setup: _extensionKey is required but was not provided")
		return
	endif
	if !_attributeName
		Debug.Trace("Setup: _attributeName is required but was not provided")
		return
	endif
	if !_highlightText
		Debug.Trace("Setup: _highlightText is required but was not provided")
		return
	endif
	
	SetAttrHighlight(_extensionKey, _attributeName, _highlightText)
EndFunction

; Specifying both triggerId and attributeName

; some conversion convenience wrappers
float Function Trigger_GetAsFloat(string _extensionKey, string _triggerKey, string _attributeName)
	int attrType = GetAttrType(_extensionKey, _attributeName)
	if attrType == PTYPE_FLOAT()
		return Trigger_FloatGetX(_extensionKey, _triggerKey, _attributeName)
	elseif attrType == PTYPE_INT()
		return Trigger_IntGetX(_extensionKey, _triggerKey, _attributeName) as float
	elseif attrType == PTYPE_STRING()
		return Trigger_StringGetX(_extensionKey, _triggerKey, _attributeName) as float
	endif
	return 0.0
EndFunction

string Function Trigger_GetAsString(string _extensionKey, string _triggerKey, string _attributeName)
	int attrType = GetAttrType(_extensionKey, _attributeName)
	if attrType == PTYPE_STRING()
		return Trigger_StringGetX(_extensionKey, _triggerKey, _attributeName)
	elseif attrType == PTYPE_INT()
		return Trigger_IntGetX(_extensionKey, _triggerKey, _attributeName) as string
	elseif attrType == PTYPE_FLOAT()
		return Trigger_FloatGetX(_extensionKey, _triggerKey, _attributeName) as string
	endif
	return ""
EndFunction

bool Function Trigger_HasAsString(string _extensionKey, string _triggerKey, string _attributeName)
	int attrType = GetAttrType(_extensionKey, _attributeName)
	if attrType == PTYPE_STRING()
		return Trigger_StringHasX(_extensionKey, _triggerKey, _attributeName)
	elseif attrType == PTYPE_INT()
		return Trigger_IntHasX(_extensionKey, _triggerKey, _attributeName)
	elseif attrType == PTYPE_FLOAT()
		return Trigger_FloatHasX(_extensionKey, _triggerKey, _attributeName)
	endif
	return false
EndFunction

Function Trigger_SetFromFloat(string _extensionKey, string _triggerKey, string _attributeName, float _value)
	int attrType = GetAttrType(_extensionKey, _attributeName)
	if attrType == PTYPE_FLOAT()
		Trigger_FloatSetX(_extensionKey, _triggerKey, _attributeName, _value)
	elseif attrType == PTYPE_INT()
		Trigger_IntSetX(_extensionKey, _triggerKey, _attributeName, _value as int)
	elseif attrType == PTYPE_STRING()
		Trigger_StringSetX(_extensionKey, _triggerKey, _attributeName, _value as string)
	endif
EndFunction

Function Trigger_SetFromString(string _extensionKey, string _triggerKey, string _attributeName, string _value)
	int attrType = GetAttrType(_extensionKey, _attributeName)
	if attrType == PTYPE_STRING()
		if !_value
			Trigger_StringUnsetX(_extensionKey, _triggerKey, _attributeName)
		else
			Trigger_StringSetX(_extensionKey, _triggerKey, _attributeName, _value)
		endif
	elseif attrType == PTYPE_INT()
		if !_value
			Trigger_IntUnsetX(_extensionKey, _triggerKey, _attributeName)
		else
			Trigger_IntSetX(_extensionKey, _triggerKey, _attributeName, _value as int)
		endif
	elseif attrType == PTYPE_FLOAT()
		if !_value
			Trigger_FloatUnsetX(_extensionKey, _triggerKey, _attributeName)
		else
			Trigger_FloatSetX(_extensionKey, _triggerKey, _attributeName, _value as float)
		endif
	endif
EndFunction

; string
bool Function Trigger_StringHasX(string _extensionKey, string _triggerKey, string _attributeName)
	return JsonUtil.HasStringValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName)
EndFunction

string Function Trigger_StringGetX(string _extensionKey, string _triggerKey, string _attributeName, string _defaultValue = "")
	return JsonUtil.GetStringValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName, _defaultValue)
EndFunction

string Function Trigger_StringSetX(string _extensionKey, string _triggerKey, string _attributeName, string _value = "")
	return JsonUtil.SetStringValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName, _value)
EndFunction

bool Function Trigger_StringUnsetX(string _extensionKey, string _triggerKey, string _attributeName)
	return JsonUtil.UnsetStringValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName)
EndFunction


; Form
bool Function Trigger_FormHasX(string _extensionKey, string _triggerKey, string _attributeName)
	return JsonUtil.HasFormValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName)
EndFunction

Form Function Trigger_FormGetX(string _extensionKey, string _triggerKey, string _attributeName, Form _defaultValue = None)
	return JsonUtil.GetFormValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName, _defaultValue)
EndFunction

Form Function Trigger_FormSetX(string _extensionKey, string _triggerKey, string _attributeName, Form _value = None)
	return JsonUtil.SetFormValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName, _value)
EndFunction

bool Function Trigger_FormUnsetX(string _extensionKey, string _triggerKey, string _attributeName)
	return JsonUtil.UnsetFormValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName)
EndFunction


; float
bool Function Trigger_FloatHasX(string _extensionKey, string _triggerKey, string _attributeName)
	return JsonUtil.HasFloatValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName)
EndFunction

float Function Trigger_FloatGetX(string _extensionKey, string _triggerKey, string _attributeName, float _defaultValue = 0.0)
	return JsonUtil.GetFloatValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName, _defaultValue)
EndFunction

float Function Trigger_FloatSetX(string _extensionKey, string _triggerKey, string _attributeName, float _value = 0.0)
	return JsonUtil.SetFloatValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName, _value)
EndFunction

bool Function Trigger_FloatUnsetX(string _extensionKey, string _triggerKey, string _attributeName)
	return JsonUtil.UnsetFloatValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName)
EndFunction


; int
bool Function Trigger_IntHasX(string _extensionKey, string _triggerKey, string _attributeName)
	return JsonUtil.HasIntValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName)
EndFunction

int Function Trigger_IntGetX(string _extensionKey, string _triggerKey, string _attributeName, int _defaultValue = 0)
	return JsonUtil.GetIntValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName, _defaultValue)
EndFunction

int Function Trigger_IntSetX(string _extensionKey, string _triggerKey, string _attributeName, int _value = 0)
	return JsonUtil.SetIntValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName, _value)
EndFunction

bool Function Trigger_IntUnsetX(string _extensionKey, string _triggerKey, string _attributeName)
	return JsonUtil.UnsetIntValue(ExtensionTriggerName(_extensionKey, _triggerKey), _attributeName)
EndFunction



string Function TK_extension(string _extensionKey)
	return "ek-" + _extensionKey
EndFunction

string Function TK_visibilityKey(string _extensionKey)
	return TK_extension(_extensionKey) + "-viskey"
EndFunction

string Function TK_triggerKeys(string _extensionKey)
	return TK_extension(_extensionKey) + "-tkeys"
EndFunction

string Function TK_attributeNames(string _extensionKey)
	return TK_extension(_extensionKey) + "-anames"
EndFunction

string Function TK_attr(string _extensionKey, string _attributeName)
	return TK_extension(_extensionKey) + "-attr-" + _attributeName
EndFunction

string Function TK_attr_visibleOnlyIf(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-onlyif"
EndFunction

string Function TK_attr_widget(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-widget"
EndFunction

string Function TK_attr_type(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-type"
EndFunction

string Function TK_attr_minValue(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-minValue"
EndFunction

string Function TK_attr_maxValue(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-maxValue"
EndFunction

string Function TK_attr_interval(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-interval"
EndFunction

string Function TK_attr_defaultValue(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-defaultValue"
EndFunction

string Function TK_attr_defaultFloat(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-defaultFloat"
EndFunction

string Function TK_attr_defaultString(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-defaultString"
EndFunction

string Function TK_attr_label(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-label"
EndFunction

string Function TK_attr_formatString(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-formatString"
EndFunction

string Function TK_attr_defaultIndex(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-defaultIndex"
EndFunction

string Function TK_attr_menuSelections(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-menuSelections"
EndFunction

string Function TK_attr_highlight(string _extensionKey, string _attributeName)
	return TK_attr(_extensionKey, _attributeName) + "-highlight"
EndFunction

; getters

int Function GetOidCount()
	return Heap_IntListCountX(self, SLTSETUPCONST, "oidlist")
EndFunction

int[] Function GetOids()
	return Heap_IntListToArrayX(self, SLTSETUPCONST, "oidlist")
EndFunction

int Function GetOid(int _oidIndex)
	return Heap_IntListGetX(self, SLTSETUPCONST, "oidlist", _oidIndex)
EndFunction

string Function GetOidTriggerKey(int _oid)
	return Heap_StringGetX(self, SLTSETUPCONST, "oid-" + _oid + "-tri")
EndFunction

string Function GetOidAttributeName(int _oid)
	return Heap_StringGetX(self, SLTSETUPCONST, "oid-" + _oid + "-att")
EndFunction

bool Function IsOidVisibilityKey(int _oid)
	if extensionIndex < 0
		return false
	endif
	string extensionKey = extensionKeys[extensionIndex]
	if !HasExtensionVisibilityKey(extensionKey)
		return false
	endif
	string visibilityKeyAttrName = GetExtensionVisibilityKey(extensionKey)
	string _oidAttrName = GetOidAttributeName(_oid)
	return _oidAttrName == visibilityKeyAttrName
EndFunction

bool Function HasExtensionVisibilityKey(string _extensionKey)
	return Heap_StringHasX(self, SLTSETUPCONST, TK_visibilityKey(_extensionKey))
EndFunction

string Function GetExtensionVisibilityKey(string _extensionKey)
	return Heap_StringGetX(self, SLTSETUPCONST, TK_visibilityKey(_extensionKey))
EndFunction

int Function GetTriggerCount(string _extensionKey)
	return Heap_StringListCountX(self, SLTSETUPCONST, TK_triggerKeys(_extensionKey))
EndFunction

string[] Function GetTriggers(string _extensionKey)
	return Heap_StringListToArrayX(self, SLTSETUPCONST, TK_triggerKeys(_extensionKey))
EndFunction

string Function GetTrigger(string _extensionKey, int _triggerIndex)
	return Heap_StringListGetX(self, SLTSETUPCONST, TK_triggerKeys(_extensionKey), _triggerIndex)
EndFunction

int Function GetAttributeNameCount(string _extensionKey)
	return Heap_StringListCountX(self, SLTSETUPCONST, TK_attributeNames(_extensionKey))
EndFunction

string[] Function GetAttributeNames(string _extensionKey)
	return Heap_StringListToArrayX(self, SLTSETUPCONST, TK_attributeNames(_extensionKey))
EndFunction

bool Function HasAttrVisibleOnlyIf(string _extensionKey, string _attributeName)
	return Heap_StringHasX(self, SLTSETUPCONST, TK_attr_visibleOnlyIf(_extensionKey, _attributeName))
EndFunction

string Function GetAttrVisibleOnlyIf(string _extensionKey, string _attributeName)
	return Heap_StringGetX(self, SLTSETUPCONST, TK_attr_visibleOnlyIf(_extensionKey, _attributeName))
EndFunction

int Function GetAttrWidget(string _ext, string _attr)
	return Heap_IntGetX(self, SLTSETUPCONST, TK_attr_widget(_ext, _attr))
EndFunction

int Function GetAttrType(string _ext, string _attr)
	return Heap_IntGetX(self, SLTSETUPCONST, TK_attr_type(_ext, _attr))
EndFunction

float Function GetAttrMinValue(string _ext, string _attr)
	return Heap_FloatGetX(self, SLTSETUPCONST, TK_attr_minValue(_ext, _attr))
EndFunction

float Function GetAttrMaxValue(string _ext, string _attr)
	return Heap_FloatGetX(self, SLTSETUPCONST, TK_attr_maxValue(_ext, _attr))
EndFunction

float Function GetAttrInterval(string _ext, string _attr)
	return Heap_FloatGetX(self, SLTSETUPCONST, TK_attr_interval(_ext, _attr))
EndFunction

int Function GetAttrDefaultValue(string _ext, string _attr)
	return Heap_IntGetX(self, SLTSETUPCONST, TK_attr_defaultValue(_ext, _attr))
EndFunction

float Function GetAttrDefaultFloat(string _ext, string _attr)
	return Heap_FloatGetX(self, SLTSETUPCONST, TK_attr_defaultFloat(_ext, _attr))
EndFunction

string Function GetAttrDefaultString(string _ext, string _attr)
	return Heap_StringGetX(self, SLTSETUPCONST, TK_attr_defaultString(_ext, _attr))
EndFunction

string Function GetAttrLabel(string _ext, string _attr)
	return Heap_StringGetX(self, SLTSETUPCONST, TK_attr_label(_ext, _attr))
EndFunction

string Function GetAttrFormatString(string _ext, string _attr)
	return Heap_StringGetX(self, SLTSETUPCONST, TK_attr_formatString(_ext, _attr))
EndFunction

int Function GetAttrDefaultIndex(string _ext, string _attr)
	return Heap_IntGetX(self, SLTSETUPCONST, TK_attr_defaultIndex(_ext, _attr))
EndFunction

int Function GetAttrMenuSelectionsCount(string _ext, string _attr)
	return Heap_StringListCountX(self, SLTSETUPCONST, TK_attr_menuSelections(_ext, _attr))
EndFunction

string[] Function GetAttrMenuSelections(string _ext, string _attr)
	return Heap_StringListToArrayX(self, SLTSETUPCONST, TK_attr_menuSelections(_ext, _attr))
EndFunction

string Function GetAttrMenuSelectionAt(string _ext, string _attr, int _index)
	return Heap_StringListGetX(self, SLTSETUPCONST, TK_attr_menuSelections(_ext, _attr), _index)
EndFunction

int Function GetAttrMenuSelectionIndex(string _ext, string _attr, string _selection)
	return Heap_StringListFindX(self, SLTSETUPCONST, TK_attr_menuSelections(_ext, _attr), _selection)
EndFunction

bool Function HasAttrHighlight(string _ext, string _attr)
	return Heap_StringHasX(self, SLTSETUPCONST, TK_attr_highlight(_ext, _attr))
EndFunction

string Function GetAttrHighlight(string _ext, string _attr)
	return Heap_StringGetX(self, SLTSETUPCONST, TK_attr_highlight(_ext, _attr))
EndFunction

; setters
int Function AddOid(int _oid, string _extensionKey, string _triggerKey, string _attrName)
	Heap_StringSetX(self, SLTSETUPCONST, "oid-" + _oid + "-tri", _triggerKey)
	Heap_StringSetX(self, SLTSETUPCONST, "oid-" + _oid + "-att", _attrName)
	return Heap_IntListAddX(self, SLTSETUPCONST, "oidlist", _oid)
EndFunction

int Function AddTrigger(string _extensionKey, string _value)
	return Heap_StringListAddX(self, SLTSETUPCONST, TK_triggerKeys(_extensionKey), _value, false)
EndFunction

; SetTriggers
; Tells setup the triggerKeys specific to your extension.
; Overwrites any previous values.
string Function SetExtensionVisibilityKey(string _extensionKey, string _attributeName)
	return Heap_StringSetX(self, SLTSETUPCONST, TK_visibilityKey(_extensionKey), _attributeName)
EndFunction

bool Function SetTriggers(string _extensionKey, string[] _triggerKeys)
	return Heap_StringListCopyX(self, SLTSETUPCONST, TK_triggerKeys(_extensionKey), _triggerKeys)
EndFunction

int Function AddAttributeName(string _extensionKey, string _value)
	return Heap_StringListAddX(self, SLTSETUPCONST, TK_attributeNames(_extensionKey), _value, false)
EndFunction

bool Function SetAttributeNames(string _extensionKey, string[] _values)
	return Heap_StringListCopyX(self, SLTSETUPCONST, TK_attributeNames(_extensionKey), _values)
EndFunction

string Function SetAttrVisibleOnlyIf(string _extensionKey, string _attributeName, string _requiredKeyAttributeValue)
	return Heap_StringSetX(self, SLTSETUPCONST, TK_attr_visibleOnlyIf(_extensionKey, _attributeName), _requiredKeyAttributeValue)
EndFunction

int Function SetAttrWidget(string _ext, string _attr, int _value)
	AddAttributeName(_ext, _attr)
	return Heap_IntSetX(self, SLTSETUPCONST, TK_attr_widget(_ext, _attr), _value)
EndFunction

int Function SetAttrType(string _ext, string _attr, int _value)
	AddAttributeName(_ext, _attr)
	return Heap_IntSetX(self, SLTSETUPCONST, TK_attr_type(_ext, _attr), _value)
EndFunction

float Function SetAttrMinValue(string _ext, string _attr, float _value)
	AddAttributeName(_ext, _attr)
	return Heap_FloatSetX(self, SLTSETUPCONST, TK_attr_minValue(_ext, _attr), _value)
EndFunction

float Function SetAttrMaxValue(string _ext, string _attr, float _value)
	AddAttributeName(_ext, _attr)
	return Heap_FloatSetX(self, SLTSETUPCONST, TK_attr_maxValue(_ext, _attr), _value)
EndFunction

float Function SetAttrInterval(string _ext, string _attr, float _value)
	AddAttributeName(_ext, _attr)
	return Heap_FloatSetX(self, SLTSETUPCONST, TK_attr_interval(_ext, _attr), _value)
EndFunction

int Function SetAttrDefaultValue(string _ext, string _attr, int _value)
	AddAttributeName(_ext, _attr)
	return Heap_IntSetX(self, SLTSETUPCONST, TK_attr_defaultValue(_ext, _attr), _value)
EndFunction

float Function SetAttrDefaultFloat(string _ext, string _attr, float _value)
	AddAttributeName(_ext, _attr)
	return Heap_FloatSetX(self, SLTSETUPCONST, TK_attr_defaultFloat(_ext, _attr), _value)
EndFunction

string Function SetAttrDefaultString(string _ext, string _attr, string _value)
	AddAttributeName(_ext, _attr)
	return Heap_StringSetX(self, SLTSETUPCONST, TK_attr_defaultString(_ext, _attr), _value)
EndFunction

string Function SetAttrLabel(string _ext, string _attr, string _value)
	AddAttributeName(_ext, _attr)
	return Heap_StringSetX(self, SLTSETUPCONST, TK_attr_label(_ext, _attr), _value)
EndFunction

string Function SetAttrFormatString(string _ext, string _attr, string _value)
	AddAttributeName(_ext, _attr)
	return Heap_StringSetX(self, SLTSETUPCONST, TK_attr_formatString(_ext, _attr), _value)
EndFunction

int Function SetAttrDefaultIndex(string _ext, string _attr, int _value)
	AddAttributeName(_ext, _attr)
	return Heap_IntSetX(self, SLTSETUPCONST, TK_attr_defaultIndex(_ext, _attr), _value)
EndFunction

bool Function SetAttrMenuSelections(string _ext, string _attr, string[] _values)
	AddAttributeName(_ext, _attr)
	return Heap_StringListCopyX(self, SLTSETUPCONST, TK_attr_menuSelections(_ext, _attr), _values)
EndFunction

string Function SetAttrHighlight(string _ext, string _attr, string _value)
	AddAttributeName(_ext, _attr)
	return Heap_StringSetX(self, SLTSETUPCONST, TK_attr_highlight(_ext, _attr), _value)
EndFunction
; done