scriptname sl_triggersSetup extends SKI_ConfigBase

import sl_triggersStatics
import sl_triggersFile
import sl_triggersHeap

; CONSTANTS
int			CARDS_PER_PAGE = 5
string		PSEUDO_INSTANCE_KEY = "sl_triggersSetup"

string		DELETE_BUTTON = "--DELETETHISITEM--"
string		RESTORE_BUTTON = "--RESTORETHISITEM--"



int			WIDG_SLIDER			= 1
int			WIDG_MENU			= 2
int			WIDG_KEYMAP			= 3
int			WIDG_TOGGLE			= 4
int			WIDG_INPUT			= 5
int			WIDG_COMMANDLIST	= 6


; Properties
sl_TriggersMain		Property SLT Auto

string				Property CurrentExtensionKey Auto Hidden

string	Property PARTITION_EMPTY Hidden
	string Function Get()
		return ""
	EndFunction
EndProperty
string	Property PARTITION_SETTINGS Hidden
	string Function Get()
		return "SETTINGS"
	EndFunction
EndProperty

string	Property DefaultPartition Auto Hidden

string[] Property CommandsList Auto Hidden


; Variables
bool		refreshOnClose
bool		displayExtensionSettings
bool		firstPageReset

string[]	headerPages
string[]	extensionPages
string[]	extensionKeys
string[]	attributeNames

string		currentSLTPage
int			currentCardination


int[]		xoidlist
string[]	xoidtriggerkeys
string[]	xoidattrnames

; These are used to cache "well-known" OIDs for the UI
; i.e. "standard" components used by SLT itself. They
; must be reset correctly OnPageReset, so make sure to update
; convenient function which is stored so very, very
; closely that you can't miss it, hextun, ol' chap, ol' buddy, ol' pal.
int			oidEnabled
int			oidDebugMsg
int			oidResetSLT
int			oidCardinatePrevious
int			oidCardinateNext
int			oidAddTop
int			oidAddBottom
int			oidExtensionSettings
int			oidExtensionEnabled
; Oh look, they are in the same order as the otherwise unremarkable
; and yet, clearly, obviously important variables declared just
; above.
;
; I wonder....
Function CallThisToResetTheOIDValuesHextun()
	oidEnabled				= 0
	oidDebugMsg				= 0
	oidResetSLT				= 0
	oidCardinatePrevious	= 0
	oidCardinateNext		= 0
	oidAddTop				= 0
	oidAddBottom			= 0
	oidExtensionSettings	= 0
	oidExtensionEnabled		= 0
	xoidlist				= PapyrusUtil.IntArray(0)
	xoidtriggerkeys			= PapyrusUtil.StringArray(0)
	xoidattrnames			= PapyrusUtil.StringArray(0)
EndFunction

int Function GetVersion()
	return GetModVersion()
EndFunction

Event OnConfigInit()
	headerPages = new string[1]
	headerPages[0] = "SL Triggers"
EndEvent

Event OnConfigOpen()
	if extensionPages.Length > 0
		Pages = PapyrusUtil.MergeStringArray(headerPages, extensionPages)
	else
		Pages = headerPages
	endif
	refreshOnClose = false
	firstPageReset = true
EndEvent

event OnConfigClose()
	SLT.SendInternalSettingsUpdateEvents()

	if refreshOnClose
		refreshOnClose = false
		SLT.DoInMemoryReset()
	endif
endEvent


; Breaking from my typical format, I moved a subset of Functions toward the top
; above a large number of, while of very slight technical interest, are, in fact, 
; rote, Event handlers.
; These Functions will be of use to use in crafting your own PopulateMCM().





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

; SetVisibilityKeyAttribute
; Tells setup the attribute that will be used to dynamically determine
; visibility of other attributes on the MCM. Note that this function
; will have no effect if SetVisibleOnlyIf() is not also called.
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


bool Function ShowAttribute(string attrName, int widgetOptions, string triggerKey)
	string extensionKey = CurrentExtensionKey
	bool allowedVisible
	string visibilityKeyAttribute = GetExtensionVisibilityKey(extensionKey)
	int _oid

	allowedVisible = true
	
	if visibilityKeyAttribute && HasAttrVisibleOnlyIf(extensionKey, attrName)
		string visibleOnlyIfValueIs = GetAttrVisibleOnlyIf(extensionKey, attrName)
		
		allowedVisible = false

		string tval
		if Data_IntHas(triggerKey, visibilityKeyAttribute)
			tval = Data_IntGet(triggerKey, visibilityKeyAttribute) as string
			allowedVisible = (tval == visibleOnlyIfValueIs)
		elseif Data_StringHas(triggerKey, visibilityKeyAttribute)
			tval = Data_StringGet(triggerKey, visibilityKeyAttribute)
			allowedVisible = (tval == visibleOnlyIfValueIs)
		else
			; they specified it, it somehow got past, and now we have to deal with it
			; or ignore it
		endif
	endif
	
	if allowedVisible
		
		int widg = GetAttrWidget(extensionKey, attrName)
		string label = GetAttrLabel(extensionKey, attrName)
		if widg == WIDG_SLIDER
			float _defval = GetAttrDefaultFloat(extensionKey, attrName)
			if Data_FloatHas(triggerKey, attrName)
				_defval = Data_FloatGet(triggerKey, attrName)
			endif
			_oid = AddSliderOption(label, _defval, GetAttrFormatString(extensionKey, attrName), widgetOptions)
			; add to list of oids to heap
			AddOid(_oid, triggerKey, attrName)
		elseif widg == WIDG_MENU
			string[] menuSelections = GetAttrMenuSelections(extensionKey, attrName)
			int ptype = GetAttrType(extensionKey, attrName)
			string menuValue = ""
			if (ptype == PTYPE_INT() && !Data_IntHas(triggerKey, attrName)) || (ptype == PTYPE_STRING() && !Data_StringHas(triggerKey, attrName))
				int midx = GetAttrDefaultIndex(extensionKey, attrName)
				if midx > -1
					menuValue = menuSelections[midx]
				endif
			else
				if ptype == PTYPE_INT()
					int midx = Data_IntGet(triggerKey, attrName)
					if midx > -1
						menuValue = menuSelections[midx]
					endif
				elseif ptype == PTYPE_STRING()
					string _tval = Data_StringGet(triggerKey, attrName)
					if menuSelections.find(_tval) > -1
						menuValue = _tval
					endif
				endif
			endif
			_oid = AddMenuOption(label, menuValue, widgetOptions)
			AddOid(_oid, triggerKey, attrName)
		elseif widg == WIDG_KEYMAP
			int _defmap = GetAttrDefaultValue(extensionKey, attrName)
			if Data_IntHas(triggerKey, attrName)
				_defmap = Data_IntGet(triggerKey, attrName)
			endif
			int keymapOptions = OPTION_FLAG_WITH_UNMAP
			if widgetOptions == OPTION_FLAG_DISABLED
				keymapOptions = OPTION_FLAG_DISABLED
			endif
			_oid = AddKeyMapOption(label, _defmap, keymapOptions)
			AddOid(_oid, triggerKey, attrName)
		elseif widg == WIDG_TOGGLE
			bool _defval = GetAttrDefaultValue(extensionKey, attrName) != 0
			if Data_IntHas(triggerKey, attrName)
				_defval = Data_IntGet(triggerKey, attrName) != 0
			endif
			_oid = AddToggleOption(label, _defval, widgetOptions)
			AddOid(_oid, triggerKey, attrName)
		elseif widg == WIDG_INPUT
			string _defval = GetAttrDefaultString(extensionKey, attrName)
			
			int ptype = GetAttrType(extensionKey, attrName)
			if ptype == PTYPE_INT()
				if Data_IntHas(triggerKey, attrName)
					_defval = Data_IntGet(triggerKey, attrName) as string
				endif
			elseif ptype == PTYPE_FLOAT()
				if Data_FloatHas(triggerKey, attrName)
					_defval = Data_FloatGet(triggerKey, attrName) as string
				endif
			elseif ptype == PTYPE_STRING()
				if Data_StringHas(triggerKey, attrName)
					_defval = Data_StringGet(triggerKey, attrName)
				endif
			elseif ptype == PTYPE_FORM()
				if Data_FormHas(triggerKey, attrName)
					_defval = Data_FormGet(triggerKey, attrName) as string
				endif
			endif
			
			_oid = AddInputOption(label, _defval, widgetOptions)
			AddOid(_oid, triggerKey, attrName)
		elseif widg == WIDG_COMMANDLIST
			string menuValue = ""
			if Data_StringHas(triggerKey, attrName)
				string _cval = Data_StringGet(triggerKey, attrName)
				if CommandsList.find(_cval) > -1
					menuValue = _cval
				endif
			endif
			
			_oid = AddMenuOption(label, menuValue, widgetOptions)
			AddOid(_oid, triggerKey, attrName)
		endif
	endif

	return allowedVisible
EndFunction


Function ShowExtensionSettings()
	SetCursorFillMode(TOP_TO_BOTTOM)

	DefaultPartition = PARTITION_SETTINGS
	oidExtensionSettings = AddTextOption("$SLT_BTN_BACK", "")
	AddEmptyOption()

	int _oid

	; blank row
	AddHeaderOption(currentSLTPage)
	oidExtensionEnabled = AddToggleOption("$SLT_LBL_ENABLED_QUESTION", true)



EndFunction

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
Function ShowExtensionPage()
	if extensionPages.Length < 1
		return
	endif
	DefaultPartition = PARTITION_EMPTY
	; I have an extensionIndex with which I can retrieve an extensionKey
	; if I'm going to paginate I need to have a concept of where in the order
	; I am in for triggerKeys
	string extensionKey = CurrentExtensionKey
	int triggerCount = GetTriggerCount(extensionKey)
	
	bool cardinate = false
	bool hasNextCardinate = false
	
	if triggerCount > CARDS_PER_PAGE
		cardinate = true
	endif
	
	; what do we want this to look like?
	SetCursorFillMode(LEFT_TO_RIGHT)
	
	oidAddTop = AddTextOption("$SLT_BTN_ADD_NEW_ITEM", "")
	oidExtensionSettings = AddTextOption("$SLT_BTN_EXTENSION_SETTINGS", "")
	
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
		; blank row to avoid accidentally creating new items
		AddEmptyOption()
		AddEmptyOption()

		; set startIndex appropriately
		startIndex = currentCardination * CARDS_PER_PAGE
		
		; display cardination buttons
		if currentCardination > 0
			oidCardinatePrevious = AddTextOption("$SLT_BTN_PREVIOUS", "")
		else
			oidCardinatePrevious = AddTextOption("$SLT_BTN_PREVIOUS", "", OPTION_FLAG_DISABLED)
		endif
		
		if hasNextCardinate
			oidCardinateNext = AddTextOption("$SLT_BTN_NEXT", "")
		else
			oidCardinateNext = AddTextOption("$SLT_BTN_NEXT", "", OPTION_FLAG_DISABLED)
		endif
	endif
	
	int displayIndexer = 0
	bool needsEmpty = false
	int _oid
	bool triggerIsSoftDeleted
	string triggerKey
	
	while displayIndexer < displayCount
		triggerKey = GetTrigger(extensionKey, displayIndexer + startIndex)
		triggerIsSoftDeleted = Trigger_IsDeleted(triggerKey)
		;if !Trigger_IsDeleted(triggerKey)
			AddHeaderOption("==] " + triggerKey + " [==")
			AddEmptyOption()

			needsEmpty = false
			int widgetOptions = OPTION_FLAG_NONE
			if triggerIsSoftDeleted
				widgetOptions = OPTION_FLAG_DISABLED
				AddHeaderOption("$SLT_MSG_SOFT_DELETE_0")
				AddHeaderOption("$SLT_MSG_SOFT_DELETE_1")
				AddHeaderOption("$SLT_MSG_SOFT_DELETE_2")
				AddHeaderOption("$SLT_MSG_SOFT_DELETE_3")
			endif

			;if !triggerIsSoftDeleted
				int aidx = 0
				while aidx < attributeNames.Length
					if ShowAttribute(attributeNames[aidx], widgetOptions, triggerKey)
						needsEmpty = !needsEmpty
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
				_oid = AddTextOption("$SLT_BTN_DELETE", "")
				AddOid(_oid, triggerKey, DELETE_BUTTON)
			else
				; and option to undelete
				_oid = AddTextOption("$SLT_BTN_RESTORE", "")
				AddOid(_oid, triggerKey, RESTORE_BUTTON)
			endif
		;endif
	
		displayIndexer += 1
	endwhile
	
	if displayCount > 2
		; blank row
		AddEmptyOption()
		AddEmptyOption()
		
		oidAddBottom = AddTextOption("$SLT_BTN_ADD_NEW_ITEM", "")
		AddEmptyOption()
	endif
	
EndFunction


Function SaveDirtyTrigger(string _extensionKey, string _triggerKey)
	JsonUtil.Save(ExtensionTriggerName(_extensionKey, _triggerKey))
EndFunction

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

Event OnPageReset(string page)
	CallThisToResetTheOIDValuesHextun()

	bool doPageChanged = false

	if page != currentSLTPage
		doPageChanged = true
	endif

	if firstPageReset
		doPageChanged = true
		firstPageReset = false
	endif

	if doPageChanged
		CurrentExtensionKey = ""
		currentCardination = 0
		displayExtensionSettings = false
		extensionIndex = -1
	endif
	
	if page == ""
		ShowHeaderPage()
		return
	endif

	int extensionIndex = extensionPages.find(page)
	if extensionIndex > -1
		CurrentExtensionKey = extensionKeys[extensionIndex]

		attributeNames = GetAttributeNames(CurrentExtensionKey)

		if displayExtensionSettings
			ShowExtensionSettings()
		else
			ShowExtensionPage()
		endif
		return
	endif
	
	; obviously it should be one or the other and yet here we are
	Debug.Trace("SLT: Setup: Page is neither header nor extension")
EndEvent

;/
oidEnabled				= 0
oidDebugMsg				= 0
oidResetSLT				= 0
oidCardinatePrevious	= 0
oidCardinateNext		= 0
oidAddTop				= 0
oidAddBottom			= 0
oidExtensionSettings	= 0
oidExtensionEnabled		= 0
/;

; All
Event OnOptionHighlight(int option)
	if !option
		Return
	endif
	if option == oidEnabled
		SetInfoText("$SLT_HIGHLIGHT_OID_ENABLED")
		return
	elseif option == oidDebugMsg
		SetInfoText("$SLT_HIGHLIGHT_OID_DEBUGMSG")
		return
	elseif option == oidResetSLT
		SetInfoText("$SLT_HIGHLIGHT_OID_RESETSLT")
		return
	elseif option == oidCardinatePrevious
		SetInfoText("$SLT_HIGHLIGHT_OID_CARDINATEPREVIOUS")
		return
	elseif option == oidCardinateNext
		SetInfoText("$SLT_HIGHLIGHT_OID_CARDINATENEXT")
		return
	elseif (option == oidAddTop || option == oidAddBottom)
		SetInfoText("$SLT_HIGHLIGHT_OID_ADDNEWITEM")
		return
	elseif option == oidExtensionSettings
		SetInfoText("$SLT_HIGHLIGHT_OID_EXTENSIONSETTINGS")
		return
	elseif option == oidExtensionEnabled
		SetInfoText("$SLT_HIGHLIGHT_OID_EXTENSIONENABLED")
		return
	else
		string attrName = GetOidAttributeName(option)
		if attrName == DELETE_BUTTON
			SetInfoText("$SLT_HIGHLIGHT_OID_DELETEITEM")
			return
		elseif attrName == RESTORE_BUTTON
			SetInfoText("$SLT_HIGHLIGHT_OID_RESTOREITEM")
			return
		endif
	endif

	if IsExtensionPage()
		string extKey = CurrentExtensionKey
		string attrName = GetOidAttributeName(option)
		
		if HasAttrHighlight(extKey, attrName)
			SetInfoText(GetAttrHighlight(extKey, attrName))
		endif
	endif
EndEvent

; All
Event OnOptionDefault(int option)
	if !option
		Return
	endif
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
		Data_IntSet(triKey, attrName, defInt)
	elseif attrType == PTYPE_STRING()
		defStr = GetAttrDefaultString(extKey, attrName)
		Data_StringSet(triKey, attrName, defStr)
	elseif attrType == PTYPE_FLOAT()
		defFlt = GetAttrDefaultFloat(extKey, attrName)
		Data_FloatSet(triKey, attrName, defFlt)
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
	if !option
		Return
	endif
	If option == oidEnabled
		SLT.bEnabled = !SLT.bEnabled
		SetToggleOptionValue(option, SLT.bEnabled)
		
		return
	elseIf option == oidDebugMsg
		SLT.bDebugMsg = !SLT.bDebugMsg
		SetToggleOptionValue(option, SLT.bDebugMsg)
		
		return
	elseIf option == oidResetSLT
		refreshOnClose = ShowMessage("$SLT_MSG_SOFT_DELETE_WARNING", true, "$Yes", "$No")

		if refreshOnClose
			ShowMessage("$SLT_MSG_SOFT_DELETE_CONFIRMATION", false)
		endif

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
		Trigger_Create()
		ForcePageReset()
	
		return
	elseIf option == oidExtensionSettings
		displayExtensionSettings = displayExtensionSettings != true
		ForcePageReset()

		return
	elseIf option == oidExtensionEnabled
		return
	endIf
	
	string extensionKey
	string triggerKey
	string attrName = GetOidAttributeName(option)
	if attrName == DELETE_BUTTON
		extensionKey = CurrentExtensionKey
		triggerKey = GetOidTriggerKey(option)
		
		Data_StringSet(triggerKey, DELETED_ATTRIBUTE(), "true")
		ForcePageReset()
	elseif attrName == RESTORE_BUTTON
		extensionKey = CurrentExtensionKey
		triggerKey = GetOidTriggerKey(option)
		
		Data_StringUnset(triggerKey, DELETED_ATTRIBUTE())
		ForcePageReset()
	endif
EndEvent

; Slider
Event OnOptionSliderOpen(int option)
	if !option
		Return
	endif
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	SetSliderDialogStartValue(Data_GetAsFloat(triKey, attrName))
	SetSliderDialogDefaultValue(GetAttrDefaultFloat(extKey, attrName))
	SetSliderDialogRange(GetAttrMinValue(extKey, attrName), GetAttrMaxValue(extKey, attrName))
	SetSliderDialogInterval(GetAttrInterval(extKey, attrName))
EndEvent

Event OnOptionSliderAccept(int option, float value)
	if !option
		Return
	endif
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	Data_SetFromFloat(triKey, attrName, value)
	SetSliderOptionValue(option, value, GetAttrFormatString(extKey, attrName))
	
	SaveDirtyTrigger(extKey, triKey)

	if IsOidVisibilityKey(option)
		ForcePageReset()
	endif
EndEvent

; Menu
Event OnOptionMenuOpen(int option)
	if !option
		Return
	endif
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	int attrType = GetAttrType(extKey, attrName)
	int attrWidg = GetAttrWidget(extKey, attrName)
	
	int defaultIndex = 0
	int menuIndex = 0
	string menuValue = ""
	string[] menuSelections
	if attrWidg == WIDG_COMMANDLIST
		menuSelections = CommandsList
	elseif attrWidg == WIDG_MENU
		menuSelections = GetAttrMenuSelections(extKey, attrName)
	endif
	SetMenuDialogOptions(menuSelections)
	
	if attrWidg == WIDG_COMMANDLIST
		defaultIndex = -1
		if Data_StringHas(triKey, attrName)
			menuValue = Data_StringGet(triKey, attrName)
			menuIndex = menuSelections.find(menuValue)
		endif
	elseif attrWidg == WIDG_MENU
		if attrType == PTYPE_INT()
			defaultIndex = GetAttrDefaultValue(extKey, attrName)
			menuIndex = Data_IntGet(triKey, attrName)
			menuValue = menuSelections[menuIndex]
		elseif attrType == PTYPE_STRING()
			defaultIndex = menuSelections.find(GetAttrDefaultString(extKey, attrName))
			menuValue = Data_StringGet(triKey, attrName)
			menuIndex = menuSelections.find(menuValue)
		endif
	endif
	
	SetMenuDialogOptions(menuSelections)
	SetMenuDialogStartIndex(menuIndex)
	SetMenuDialogDefaultIndex(defaultIndex)
EndEvent

Event OnOptionMenuAccept(int option, int index)
	if !option
		Return
	endif
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	int attrType = GetAttrType(extKey, attrName)
	int attrWidg = GetAttrWidget(extKey, attrName)
	
	string[] menuSelections
	if attrWidg == WIDG_MENU
		menuSelections = GetAttrMenuSelections(extKey, attrName)
	elseif attrWidg == WIDG_COMMANDLIST
		menuSelections = CommandsList
	endif
	
	if index >= 0
		if attrType == PTYPE_INT()
			Data_IntSet(triKey, attrName, index)
		elseif attrType == PTYPE_STRING()
			Data_StringSet(triKey, attrName, menuSelections[index])
			string asdf = Data_StringGet(triKey, attrName)
		endif
		SetMenuOptionValue(option, menuSelections[index])
	else
		if attrType == PTYPE_INT()
			Data_IntUnset(triKey, attrName)
		elseif attrType == PTYPE_STRING()
			Data_StringUnset(triKey, attrName)
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
	if !option
		Return
	endif
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	bool proceed = true
	if conflictControl
		string msg
		string msg_thisKeyIsAlreadyMappedTo = sl_triggers_internal.SafeGetTranslatedString("$SLT_MSG_KEYMAP_CONFIRM_0")
		string msg_areYouSureYouWantToContinue = sl_triggers_internal.SafeGetTranslatedString("$SLT_MSG_KEYMAP_CONFIRM_1")
		if conflictName
			msg = msg_thisKeyIsAlreadyMappedTo + "\n\"" + conflictControl + "\"\n(" + conflictName + ")\n\n" + msg_areYouSureYouWantToContinue
		else
			msg = msg_thisKeyIsAlreadyMappedTo + "\n\"" + conflictControl + "\"\n\n" + msg_areYouSureYouWantToContinue
		endIf
		
		proceed = ShowMessage(msg, true, "$Yes", "$No")
	endif
	
	if proceed
		if keyCode >= 0
			Data_IntSet(triKey, attrName, keyCode)
		else
			Data_IntUnset(triKey, attrName)
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
	if !option
		Return
	endif
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	string optVal
	if Data_HasAsString(triKey, attrName)
		optVal = Data_GetAsString(triKey, attrName)
	else
		optVal = GetAttrDefaultString(extKey, attrName)
	endif
	SetInputDialogStartText(optVal)
EndEvent

Event OnOptionInputAccept(int option, string _input)
	if !option
		Return
	endif
	string extKey = CurrentExtensionKey
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	Data_SetFromString(triKey, attrName, _input)
	SetInputOptionValue(option, _input)
	
	SaveDirtyTrigger(extKey, triKey)

	if IsOidVisibilityKey(option)
		ForcePageReset()
	endif
EndEvent



Function ShowHeaderPage()
	SetCursorFillMode(TOP_TO_BOTTOM)
	int ver = GetVersion()
	AddHeaderOption("SL Triggers")
	AddHeaderOption("(" + sl_triggers_internal.SafeGetTranslatedString("$SLT_LBL_VERSION") + " " + (ver as string) + ")")
	
	AddHeaderOption("$SLT_LBL_GLOBAL_SETTINGS")
	oidEnabled    = AddToggleOption("$SLT_LBL_ENABLED_QUESTION", SLT.bEnabled)
	oidDebugMsg   = AddToggleOption("$SLT_LBL_DEBUG_MESSAGES", SLT.bDebugMsg)
	AddEmptyOption()
	AddEmptyOption()
	oidResetSLT		= AddTextOption("$SLT_BTN_RESET_SL_TRIGGERS", "")
EndFunction

bool Function IsExtensionPage()
	return (CurrentExtensionKey != "")
EndFunction


Function SetExtensionPages(string[] _extensionFriendlyNames, string[] _extensionKeys)
	extensionPages = _extensionFriendlyNames
	extensionKeys = _extensionKeys
EndFunction




; Trigger Data Convenience Functions
bool Function Trigger_IsDeleted(string _triggerKey)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.HasStringValue(_filename, DELETED_ATTRIBUTE())
EndFunction

string Function Trigger_Create()
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
		
		triggerFileName = ExtensionTriggerName(CurrentExtensionKey, triggerKey)
		if !JsonUtil.JsonExists(triggerFileName)
			found = false
		else
			triggerNum += 1
		endif
	endwhile
	
	if found
		Debug.Trace("SLT: Setup: Unable to create new trigger: '" + triggerFileName + "'")
	else
		AddTrigger(CurrentExtensionKey, triggerKey)
		Data_IntSet(triggerKey, "__slt_mod_version__", GetModVersion())
		SaveDirtyTrigger(CurrentExtensionKey, triggerKey)
	endif
	
	return triggerKey
EndFunction
; Specifying both triggerId and attributeName

; some conversion convenience wrappers
float Function Data_GetAsFloat(string _triggerKey, string _attributeName)
	int attrType = GetAttrType(CurrentExtensionKey, _attributeName)
	if attrType == PTYPE_FLOAT()
		return Data_FloatGet(_triggerKey, _attributeName)
	elseif attrType == PTYPE_INT()
		return Data_IntGet(_triggerKey, _attributeName) as float
	elseif attrType == PTYPE_STRING()
		return Data_StringGet(_triggerKey, _attributeName) as float
	endif
	return 0.0
EndFunction

string Function Data_GetAsString(string _triggerKey, string _attributeName)
	int attrType = GetAttrType(CurrentExtensionKey, _attributeName)
	if attrType == PTYPE_STRING()
		return Data_StringGet(_triggerKey, _attributeName)
	elseif attrType == PTYPE_INT()
		return Data_IntGet(_triggerKey, _attributeName) as string
	elseif attrType == PTYPE_FLOAT()
		return Data_FloatGet(_triggerKey, _attributeName) as string
	endif
	return ""
EndFunction

bool Function Data_HasAsString(string _triggerKey, string _attributeName)
	int attrType = GetAttrType(CurrentExtensionKey, _attributeName)
	if attrType == PTYPE_STRING()
		return Data_StringHas(_triggerKey, _attributeName)
	elseif attrType == PTYPE_INT()
		return Data_IntHas(_triggerKey, _attributeName)
	elseif attrType == PTYPE_FLOAT()
		return Data_FloatHas(_triggerKey, _attributeName)
	endif
	return false
EndFunction

Function Data_SetFromFloat(string _triggerKey, string _attributeName, float _value)
	int attrType = GetAttrType(CurrentExtensionKey, _attributeName)
	if attrType == PTYPE_FLOAT()
		Data_FloatSet(_triggerKey, _attributeName, _value)
	elseif attrType == PTYPE_INT()
		Data_IntSet(_triggerKey, _attributeName, _value as int)
	elseif attrType == PTYPE_STRING()
		Data_StringSet(_triggerKey, _attributeName, _value as string)
	endif
EndFunction

Function Data_SetFromString(string _triggerKey, string _attributeName, string _value)
	int attrType = GetAttrType(CurrentExtensionKey, _attributeName)
	if attrType == PTYPE_STRING()
		if !_value
			Data_StringUnset(_triggerKey, _attributeName)
		else
			Data_StringSet(_triggerKey, _attributeName, _value)
		endif
	elseif attrType == PTYPE_INT()
		if !_value
			Data_IntUnset(_triggerKey, _attributeName)
		else
			Data_IntSet(_triggerKey, _attributeName, _value as int)
		endif
	elseif attrType == PTYPE_FLOAT()
		if !_value
			Data_FloatUnset(_triggerKey, _attributeName)
		else
			Data_FloatSet(_triggerKey, _attributeName, _value as float)
		endif
	endif
EndFunction



; Data - int
bool Function Data_IntHas(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.HasIntValue(_filename, _attributeName)
EndFunction

int Function Data_IntGet(string _triggerKey, string _attributeName, int _defaultValue = 0)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.GetIntValue(_filename, _attributeName, _defaultValue)
EndFunction

int Function Data_IntSet(string _triggerKey, string _attributeName, int _value = 0)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.SetIntValue(_filename, _attributeName, _value)
EndFunction

bool Function Data_IntUnset(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.UnsetIntValue(_filename, _attributeName)
EndFunction


; Data - int[]
int Function Data_IntListAdd(string _triggerKey, string _attributeName, int _theValue, bool _allowDuplicate = true)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListAdd(_filename, _attributeName, _theValue, _allowDuplicate)
EndFunction

int Function Data_IntListGet(string _triggerKey, string _attributeName, int _theIndex)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListGet(_filename, _attributeName, _theIndex)
EndFunction

int Function Data_IntListSet(string _triggerKey, string _attributeName, int _theIndex, int _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListSet(_filename, _attributeName, _theIndex, _theValue)
EndFunction

int Function Data_IntListRemove(string _triggerKey, string _attributeName, int _theValue, bool _allInstaces = true)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListRemove(_filename, _attributeName, _theValue, _allInstaces)
EndFunction

bool Function Data_IntListInsertAt(string _triggerKey, string _attributeName, int _theIndex, int _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListInsertAt(_filename, _attributeName, _theIndex, _theValue)
EndFunction

bool Function Data_IntListRemoveAt(string _triggerKey, string _attributeName, int _theIndex)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListRemoveAt(_filename, _attributeName, _theIndex)
EndFunction

int Function Data_IntListClear(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListClear(_filename, _attributeName)
EndFunction

int Function Data_IntListCount(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListCount(_filename, _attributeName)
EndFunction

int Function Data_IntListCountValue(string _triggerKey, string _attributeName, int _theValue, bool _exclude = false)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListCountValue(_filename, _attributeName, _theValue, _exclude)
EndFunction

int Function Data_IntListFind(string _triggerKey, string _attributeName, int _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListFind(_filename, _attributeName, _theValue)
EndFunction

bool Function Data_IntListHas(string _triggerKey, string _attributeName, int _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListHas(_filename, _attributeName, _theValue)
EndFunction

Function Data_IntListSlice(string _triggerKey, string _attributeName, int[] slice, int startIndex = 0)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	JsonUtil.IntListSlice(_filename, _attributeName, slice, startIndex)
EndFunction

int Function Data_IntListResize(string _triggerKey, string _attributeName, int _toLength, int _theFiller = 0)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListResize(_filename, _attributeName, _toLength, _theFiller)
EndFunction

bool Function Data_IntListCopy(string _triggerKey, string _attributeName, int[] _theCopy)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListCopy(_filename, _attributeName, _theCopy)
EndFunction

int[] Function Data_IntListToArray(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.IntListToArray(_filename, _attributeName)
EndFunction

int function Data_IntCountPrefix(string _triggerKey, string _attributeNamePrefix)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.CountIntListPrefix(_filename, _attributeNamePrefix)
EndFunction

; Data - float
bool Function Data_FloatHas(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.HasFloatValue(_filename, _attributeName)
EndFunction

float Function Data_FloatGet(string _triggerKey, string _attributeName, float _defaultValue = 0.0)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.GetFloatValue(_filename, _attributeName, _defaultValue)
EndFunction

float Function Data_FloatSet(string _triggerKey, string _attributeName, float _value = 0.0)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.SetFloatValue(_filename, _attributeName, _value)
EndFunction

bool Function Data_FloatUnset(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.UnsetFloatValue(_filename, _attributeName)
EndFunction


; Data - float[]
int Function Data_FloatListAdd(string _triggerKey, string _attributeName, float _theValue, bool _allowDuplicate = true)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListAdd(_filename, _attributeName, _theValue, _allowDuplicate)
EndFunction

float Function Data_FloatListGet(string _triggerKey, string _attributeName, int _theIndex)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListGet(_filename, _attributeName, _theIndex)
EndFunction

float Function Data_FloatListSet(string _triggerKey, string _attributeName, int _theIndex, float _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListSet(_filename, _attributeName, _theIndex, _theValue)
EndFunction

int Function Data_FloatListRemove(string _triggerKey, string _attributeName, float _theValue, bool _allInstaces = true)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListRemove(_filename, _attributeName, _theValue, _allInstaces)
EndFunction

bool Function Data_FloatListInsertAt(string _triggerKey, string _attributeName, int _theIndex, float _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListInsertAt(_filename, _attributeName, _theIndex, _theValue)
EndFunction

bool Function Data_FloatListRemoveAt(string _triggerKey, string _attributeName, int _theIndex)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListRemoveAt(_filename, _attributeName, _theIndex)
EndFunction

int Function Data_FloatListClear(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListClear(_filename, _attributeName)
EndFunction

int Function Data_FloatListCount(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListCount(_filename, _attributeName)
EndFunction

int Function Data_FloatListCountValue(string _triggerKey, string _attributeName, float _theValue, bool _exclude = false)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListCountValue(_filename, _attributeName, _theValue, _exclude)
EndFunction

int Function Data_FloatListFind(string _triggerKey, string _attributeName, float _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListFind(_filename, _attributeName, _theValue)
EndFunction

bool Function Data_FloatListHas(string _triggerKey, string _attributeName, float _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListHas(_filename, _attributeName, _theValue)
EndFunction

Function Data_FloatListSlice(string _triggerKey, string _attributeName, float[] slice, int startIndex = 0)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	JsonUtil.FloatListSlice(_filename, _attributeName, slice, startIndex)
EndFunction

int Function Data_FloatListResize(string _triggerKey, string _attributeName, int _toLength, float _theFiller = 0.0)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListResize(_filename, _attributeName, _toLength, _theFiller)
EndFunction

bool Function Data_FloatListCopy(string _triggerKey, string _attributeName, float[] _theCopy)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListCopy(_filename, _attributeName, _theCopy)
EndFunction

float[] Function Data_FloatListToArray(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FloatListToArray(_filename, _attributeName)
EndFunction

int function Data_FloatCountPrefix(string _triggerKey, string _attributeNamePrefix)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.CountFloatListPrefix(_filename, _attributeNamePrefix)
EndFunction

; Data - string
bool Function Data_StringHas(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.HasStringValue(_filename, _attributeName)
EndFunction

string Function Data_StringGet(string _triggerKey, string _attributeName, string _defaultValue = "")
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.GetStringValue(_filename, _attributeName, _defaultValue)
EndFunction

string Function Data_StringSet(string _triggerKey, string _attributeName, string _value = "")
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.SetStringValue(_filename, _attributeName, _value)
EndFunction

bool Function Data_StringUnset(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.UnsetStringValue(_filename, _attributeName)
EndFunction


; Data - string[]
int Function Data_StringListAdd(string _triggerKey, string _attributeName, string _theValue, bool _allowDuplicate = true)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListAdd(_filename, _attributeName, _theValue, _allowDuplicate)
EndFunction

string Function Data_StringListGet(string _triggerKey, string _attributeName, int _theIndex)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListGet(_filename, _attributeName, _theIndex)
EndFunction

string Function Data_StringListSet(string _triggerKey, string _attributeName, int _theIndex, string _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListSet(_filename, _attributeName, _theIndex, _theValue)
EndFunction

int Function Data_StringListRemove(string _triggerKey, string _attributeName, string _theValue, bool _allInstaces = true)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListRemove(_filename, _attributeName, _theValue, _allInstaces)
EndFunction

bool Function Data_StringListInsertAt(string _triggerKey, string _attributeName, int _theIndex, string _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListInsertAt(_filename, _attributeName, _theIndex, _theValue)
EndFunction

bool Function Data_StringListRemoveAt(string _triggerKey, string _attributeName, int _theIndex)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListRemoveAt(_filename, _attributeName, _theIndex)
EndFunction

int Function Data_StringListClear(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListClear(_filename, _attributeName)
EndFunction

int Function Data_StringListCount(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListCount(_filename, _attributeName)
EndFunction

int Function Data_StringListCountValue(string _triggerKey, string _attributeName, string _theValue, bool _exclude = false)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListCountValue(_filename, _attributeName, _theValue, _exclude)
EndFunction

int Function Data_StringListFind(string _triggerKey, string _attributeName, string _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListFind(_filename, _attributeName, _theValue)
EndFunction

bool Function Data_StringListHas(string _triggerKey, string _attributeName, string _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListHas(_filename, _attributeName, _theValue)
EndFunction

Function Data_StringListSlice(string _triggerKey, string _attributeName, string[] slice, int startIndex = 0)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	JsonUtil.StringListSlice(_filename, _attributeName, slice, startIndex)
EndFunction

int Function Data_StringListResize(string _triggerKey, string _attributeName, int _toLength, string _theFiller = "")
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListResize(_filename, _attributeName, _toLength, _theFiller)
EndFunction

bool Function Data_StringListCopy(string _triggerKey, string _attributeName, string[] _theCopy)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListCopy(_filename, _attributeName, _theCopy)
EndFunction

string[] Function Data_StringListToArray(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.StringListToArray(_filename, _attributeName)
EndFunction

int function Data_StringCountPrefix(string _triggerKey, string _attributeNamePrefix)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.CountStringListPrefix(_filename, _attributeNamePrefix)
EndFunction

; Data - Form
bool Function Data_FormHas(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.HasFormValue(_filename, _attributeName)
EndFunction

Form Function Data_FormGet(string _triggerKey, string _attributeName, Form _defaultValue = none)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.GetFormValue(_filename, _attributeName, _defaultValue)
EndFunction

Form Function Data_FormSet(string _triggerKey, string _attributeName, Form _value = none)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.SetFormValue(_filename, _attributeName, _value)
EndFunction

bool Function Data_FormUnset(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.UnsetFormValue(_filename, _attributeName)
EndFunction


; Data - Form[]
int Function Data_FormListAdd(string _triggerKey, string _attributeName, Form _theValue, bool _allowDuplicate = true)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListAdd(_filename, _attributeName, _theValue, _allowDuplicate)
EndFunction

Form Function Data_FormListGet(string _triggerKey, string _attributeName, int _theIndex)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListGet(_filename, _attributeName, _theIndex)
EndFunction

Form Function Data_FormListSet(string _triggerKey, string _attributeName, int _theIndex, Form _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListSet(_filename, _attributeName, _theIndex, _theValue)
EndFunction

int Function Data_FormListRemove(string _triggerKey, string _attributeName, Form _theValue, bool _allInstaces = true)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListRemove(_filename, _attributeName, _theValue, _allInstaces)
EndFunction

bool Function Data_FormListInsertAt(string _triggerKey, string _attributeName, int _theIndex, Form _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListInsertAt(_filename, _attributeName, _theIndex, _theValue)
EndFunction

bool Function Data_FormListRemoveAt(string _triggerKey, string _attributeName, int _theIndex)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListRemoveAt(_filename, _attributeName, _theIndex)
EndFunction

int Function Data_FormListClear(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListClear(_filename, _attributeName)
EndFunction

int Function Data_FormListCount(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListCount(_filename, _attributeName)
EndFunction

int Function Data_FormListCountValue(string _triggerKey, string _attributeName, Form _theValue, bool _exclude = false)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListCountValue(_filename, _attributeName, _theValue, _exclude)
EndFunction

int Function Data_FormListFind(string _triggerKey, string _attributeName, Form _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListFind(_filename, _attributeName, _theValue)
EndFunction

bool Function Data_FormListHas(string _triggerKey, string _attributeName, Form _theValue)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListHas(_filename, _attributeName, _theValue)
EndFunction

Function Data_FormListSlice(string _triggerKey, string _attributeName, Form[] slice, int startIndex = 0)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	JsonUtil.FormListSlice(_filename, _attributeName, slice, startIndex)
EndFunction

int Function Data_FormListResize(string _triggerKey, string _attributeName, int _toLength, Form _theFiller = none)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListResize(_filename, _attributeName, _toLength, _theFiller)
EndFunction

bool Function Data_FormListCopy(string _triggerKey, string _attributeName, Form[] _theCopy)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListCopy(_filename, _attributeName, _theCopy)
EndFunction

Form[] Function Data_FormListToArray(string _triggerKey, string _attributeName)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.FormListToArray(_filename, _attributeName)
EndFunction

int function Data_FormCountPrefix(string _triggerKey, string _attributeNamePrefix)
	string _filename
	if _triggerKey
		_filename = SettingsFolder() + CurrentExtensionKey + "/" + _triggerKey
	else
		_filename = SettingsFolder() + CurrentExtensionKey
	endif
	return JsonUtil.CountFormListPrefix(_filename, _attributeNamePrefix)
EndFunction





;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Accessors and functions for handling the automated MCM plumbing
string Function TK_extension(string _extensionKey, string _partitionName = "")
	string ek = "ek-" + _extensionKey
	if !_partitionName
		if DefaultPartition
			ek += "-pn-" + DefaultPartition
		endif
	else
		ek += "-pn-" + _partitionName
	endif
	return ek
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


string Function GetOidTriggerKey(int _oid)
	string value = ""

	int oidx = xoidlist.Find(_oid)
	if oidx > -1 && oidx < xoidlist.Length && xoidlist.Length == xoidtriggerkeys.Length
		value = xoidtriggerkeys[oidx]
	endif

	return value
EndFunction

string Function GetOidAttributeName(int _oid)
	string value = ""

	int oidx = xoidlist.Find(_oid)
	if oidx > -1 && oidx < xoidlist.Length && xoidlist.Length == xoidattrnames.Length
		value = xoidattrnames[oidx]
	endif

	return value
EndFunction

bool Function IsOidVisibilityKey(int _oid)
	if !IsExtensionPage()
		return false
	endif
	string extensionKey = CurrentExtensionKey
	if !HasExtensionVisibilityKey(extensionKey)
		return false
	endif
	string visibilityKeyAttrName = GetExtensionVisibilityKey(extensionKey)
	string _oidAttrName = GetOidAttributeName(_oid)
	return _oidAttrName == visibilityKeyAttrName
EndFunction

bool Function HasExtensionVisibilityKey(string _extensionKey)
	return Heap_StringHasX(self, PSEUDO_INSTANCE_KEY, TK_visibilityKey(_extensionKey))
EndFunction

string Function GetExtensionVisibilityKey(string _extensionKey)
	return Heap_StringGetX(self, PSEUDO_INSTANCE_KEY, TK_visibilityKey(_extensionKey))
EndFunction

int Function GetTriggerCount(string _extensionKey)
	return Heap_StringListCountX(self, PSEUDO_INSTANCE_KEY, TK_triggerKeys(_extensionKey))
EndFunction

;/
string[] Function GetTriggers(string _extensionKey)
	return Heap_StringListToArrayX(self, PSEUDO_INSTANCE_KEY, TK_triggerKeys(_extensionKey))
EndFunction
/;

string Function GetTrigger(string _extensionKey, int _triggerIndex)
	return Heap_StringListGetX(self, PSEUDO_INSTANCE_KEY, TK_triggerKeys(_extensionKey), _triggerIndex)
EndFunction

int Function GetAttributeNameCount(string _extensionKey)
	return Heap_StringListCountX(self, PSEUDO_INSTANCE_KEY, TK_attributeNames(_extensionKey))
EndFunction

string[] Function GetAttributeNames(string _extensionKey)
	return Heap_StringListToArrayX(self, PSEUDO_INSTANCE_KEY, TK_attributeNames(_extensionKey))
EndFunction

bool Function HasAttrVisibleOnlyIf(string _extensionKey, string _attributeName)
	return Heap_StringHasX(self, PSEUDO_INSTANCE_KEY, TK_attr_visibleOnlyIf(_extensionKey, _attributeName))
EndFunction

string Function GetAttrVisibleOnlyIf(string _extensionKey, string _attributeName)
	return Heap_StringGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_visibleOnlyIf(_extensionKey, _attributeName))
EndFunction

int Function GetAttrWidget(string _ext, string _attr)
	return Heap_IntGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_widget(_ext, _attr))
EndFunction

int Function GetAttrType(string _ext, string _attr)
	return Heap_IntGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_type(_ext, _attr))
EndFunction

float Function GetAttrMinValue(string _ext, string _attr)
	return Heap_FloatGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_minValue(_ext, _attr))
EndFunction

float Function GetAttrMaxValue(string _ext, string _attr)
	return Heap_FloatGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_maxValue(_ext, _attr))
EndFunction

float Function GetAttrInterval(string _ext, string _attr)
	return Heap_FloatGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_interval(_ext, _attr))
EndFunction

int Function GetAttrDefaultValue(string _ext, string _attr)
	return Heap_IntGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_defaultValue(_ext, _attr))
EndFunction

float Function GetAttrDefaultFloat(string _ext, string _attr)
	return Heap_FloatGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_defaultFloat(_ext, _attr))
EndFunction

string Function GetAttrDefaultString(string _ext, string _attr)
	return Heap_StringGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_defaultString(_ext, _attr))
EndFunction

string Function GetAttrLabel(string _ext, string _attr)
	return Heap_StringGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_label(_ext, _attr))
EndFunction

string Function GetAttrFormatString(string _ext, string _attr)
	return Heap_StringGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_formatString(_ext, _attr))
EndFunction

int Function GetAttrDefaultIndex(string _ext, string _attr)
	return Heap_IntGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_defaultIndex(_ext, _attr))
EndFunction

int Function GetAttrMenuSelectionsCount(string _ext, string _attr)
	return Heap_StringListCountX(self, PSEUDO_INSTANCE_KEY, TK_attr_menuSelections(_ext, _attr))
EndFunction

string[] Function GetAttrMenuSelections(string _ext, string _attr)
	return Heap_StringListToArrayX(self, PSEUDO_INSTANCE_KEY, TK_attr_menuSelections(_ext, _attr))
EndFunction

string Function GetAttrMenuSelectionAt(string _ext, string _attr, int _index)
	return Heap_StringListGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_menuSelections(_ext, _attr), _index)
EndFunction

int Function GetAttrMenuSelectionIndex(string _ext, string _attr, string _selection)
	return Heap_StringListFindX(self, PSEUDO_INSTANCE_KEY, TK_attr_menuSelections(_ext, _attr), _selection)
EndFunction

bool Function HasAttrHighlight(string _ext, string _attr)
	return Heap_StringHasX(self, PSEUDO_INSTANCE_KEY, TK_attr_highlight(_ext, _attr))
EndFunction

string Function GetAttrHighlight(string _ext, string _attr)
	return Heap_StringGetX(self, PSEUDO_INSTANCE_KEY, TK_attr_highlight(_ext, _attr))
EndFunction

; setters
Function AddOid(int _oid, string _triggerKey, string _attrName)
	xoidlist		= PapyrusUtil.PushInt(xoidlist, _oid)
	xoidtriggerkeys	= PapyrusUtil.PushString(xoidtriggerkeys, _triggerKey)
	xoidattrnames	= PapyrusUtil.PushString(xoidattrnames, _attrName)
EndFunction

int Function AddTrigger(string _extensionKey, string _value)
	return Heap_StringListAddX(self, PSEUDO_INSTANCE_KEY, TK_triggerKeys(_extensionKey), _value, false)
EndFunction

string Function SetExtensionVisibilityKey(string _extensionKey, string _attributeName)
	return Heap_StringSetX(self, PSEUDO_INSTANCE_KEY, TK_visibilityKey(_extensionKey), _attributeName)
EndFunction

; SetTriggers
; Tells setup the triggerKeys specific to your extension.
; Overwrites any previous values.
bool Function SetTriggers(string _extensionKey, string[] _triggerKeys)
	return Heap_StringListCopyX(self, PSEUDO_INSTANCE_KEY, TK_triggerKeys(_extensionKey), _triggerKeys)
EndFunction

int Function AddAttributeName(string _extensionKey, string _value)
	return Heap_StringListAddX(self, PSEUDO_INSTANCE_KEY, TK_attributeNames(_extensionKey), _value, false)
EndFunction

bool Function SetAttributeNames(string _extensionKey, string[] _values)
	return Heap_StringListCopyX(self, PSEUDO_INSTANCE_KEY, TK_attributeNames(_extensionKey), _values)
EndFunction

string Function SetAttrVisibleOnlyIf(string _extensionKey, string _attributeName, string _requiredKeyAttributeValue)
	return Heap_StringSetX(self, PSEUDO_INSTANCE_KEY, TK_attr_visibleOnlyIf(_extensionKey, _attributeName), _requiredKeyAttributeValue)
EndFunction

int Function SetAttrWidget(string _ext, string _attr, int _value)
	AddAttributeName(_ext, _attr)
	return Heap_IntSetX(self, PSEUDO_INSTANCE_KEY, TK_attr_widget(_ext, _attr), _value)
EndFunction

int Function SetAttrType(string _ext, string _attr, int _value)
	AddAttributeName(_ext, _attr)
	return Heap_IntSetX(self, PSEUDO_INSTANCE_KEY, TK_attr_type(_ext, _attr), _value)
EndFunction

float Function SetAttrMinValue(string _ext, string _attr, float _value)
	AddAttributeName(_ext, _attr)
	return Heap_FloatSetX(self, PSEUDO_INSTANCE_KEY, TK_attr_minValue(_ext, _attr), _value)
EndFunction

float Function SetAttrMaxValue(string _ext, string _attr, float _value)
	AddAttributeName(_ext, _attr)
	return Heap_FloatSetX(self, PSEUDO_INSTANCE_KEY, TK_attr_maxValue(_ext, _attr), _value)
EndFunction

float Function SetAttrInterval(string _ext, string _attr, float _value)
	AddAttributeName(_ext, _attr)
	return Heap_FloatSetX(self, PSEUDO_INSTANCE_KEY, TK_attr_interval(_ext, _attr), _value)
EndFunction

int Function SetAttrDefaultValue(string _ext, string _attr, int _value)
	AddAttributeName(_ext, _attr)
	return Heap_IntSetX(self, PSEUDO_INSTANCE_KEY, TK_attr_defaultValue(_ext, _attr), _value)
EndFunction

float Function SetAttrDefaultFloat(string _ext, string _attr, float _value)
	AddAttributeName(_ext, _attr)
	return Heap_FloatSetX(self, PSEUDO_INSTANCE_KEY, TK_attr_defaultFloat(_ext, _attr), _value)
EndFunction

string Function SetAttrDefaultString(string _ext, string _attr, string _value)
	AddAttributeName(_ext, _attr)
	return Heap_StringSetX(self, PSEUDO_INSTANCE_KEY, TK_attr_defaultString(_ext, _attr), _value)
EndFunction

string Function SetAttrLabel(string _ext, string _attr, string _value)
	AddAttributeName(_ext, _attr)
	return Heap_StringSetX(self, PSEUDO_INSTANCE_KEY, TK_attr_label(_ext, _attr), _value)
EndFunction

string Function SetAttrFormatString(string _ext, string _attr, string _value)
	AddAttributeName(_ext, _attr)
	return Heap_StringSetX(self, PSEUDO_INSTANCE_KEY, TK_attr_formatString(_ext, _attr), _value)
EndFunction

int Function SetAttrDefaultIndex(string _ext, string _attr, int _value)
	AddAttributeName(_ext, _attr)
	return Heap_IntSetX(self, PSEUDO_INSTANCE_KEY, TK_attr_defaultIndex(_ext, _attr), _value)
EndFunction

bool Function SetAttrMenuSelections(string _ext, string _attr, string[] _values)
	AddAttributeName(_ext, _attr)
	return Heap_StringListCopyX(self, PSEUDO_INSTANCE_KEY, TK_attr_menuSelections(_ext, _attr), _values)
EndFunction

string Function SetAttrHighlight(string _ext, string _attr, string _value)
	AddAttributeName(_ext, _attr)
	return Heap_StringSetX(self, PSEUDO_INSTANCE_KEY, TK_attr_highlight(_ext, _attr), _value)
EndFunction
; done

