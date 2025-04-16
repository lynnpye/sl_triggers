scriptname sl_triggersSetup extends SKI_ConfigBase

import sl_triggersStatics
import sl_triggersFile
import sl_triggersHeap

; CONSTANTS
int			CARDS_PER_PAGE = 5
string		SLTSETUPCONST = "sl_triggersSetup"
int			WIDG_SLIDER = 1
int			WIDG_MENU = 2
int			WIDG_KEYMAP = 3
int			WIDG_TOGGLE = 4
int			WIDG_INPUT = 5
int			WIDG_COMMANDLIST = 6
string		ADD_BUTTON = "--ADDNEWITEM--"
string		DELETE_BUTTON = "--DELETETHISITEM--"

; Properties
sl_TriggersMain		Property SLT Auto

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
string[]	commandsList

string		currentSLTPage
string		currentExtensionKey

bool 		readinessCheck
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

Event OnVersionUpdate(int version)
EndEvent

;/
Event OnGameReload
	parent.OnGameReload()
EndEvent
/;

Event OnConfigOpen()
	if extensionPages.Length > 0
		Pages = PapyrusUtil.MergeStringArray(headerPages, extensionPages)
	else
		Pages = headerPages
	endif
EndEvent

event OnConfigClose()
	DebMsg("Setup.OnConfigClose")
	;MiscUtil.PrintConsole("OnConfigClose")
	SLT.SendSettingsUpdateEvents()
endEvent

Function SetMCMReady(bool _readiness = true)
	readinessCheck = _readiness
EndFunction

Function ClearSetupHeap()
	Heap_ClearPrefixF(self, "sl_triggersSetup")
EndFunction

Function SetCommandsList(string[] _commandsList)
	commandsList = _commandsList
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
		DebMsg("Setup: addtop or addbottom clicked, trying to add item")
		Trigger_CreateT(extensionKeys[extensionIndex])
		ForcePageReset()
	
		return
	endIf
	
	string extensionKey
	string triggerKey
	string attrName = GetOidAttributeName(option)
	if attrName == DELETE_BUTTON
		extensionKey = GetOidExtensionKey(option)
		triggerKey = GetOidTriggerKey(option)
		JsonUtil.ClearAll(ExtensionTriggersFolder(extensionKey) + triggerKey)
		
		Trigger_StringSetX(extensionKey, triggerKey, DELETED_ATTRIBUTE(), "true")
	endif
EndEvent

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

string Function GetOidExtensionKey(int _oid)
	return Heap_StringGetX(self, SLTSETUPCONST, "oid-" + _oid + "-ext")
EndFunction

string Function GetOidTriggerKey(int _oid)
	return Heap_StringGetX(self, SLTSETUPCONST, "oid-" + _oid + "-tri")
EndFunction

string Function GetOidAttributeName(int _oid)
	return Heap_StringGetX(self, SLTSETUPCONST, "oid-" + _oid + "-att")
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

; setters
int Function AddOid(int _oid, string _extensionKey, string _triggerKey, string _attrName)
	Heap_StringSetX(self, SLTSETUPCONST, "oid-" + _oid + "-ext", _extensionKey)
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
; done

Function ShowExtensionPage()
	if extensionPages.Length < 1
		return
	endif
	; I have an extensionIndex with which I can retrieve an extensionKey
	; if I'm going to paginate I need to have a concept of where in the order
	; I am in for triggerKeys
	;
	; Heap_StringListAddX(self, "sl_triggersSetup", "extensionKey-" + extensionKey + "-triggerKeys", triggerKey)
	; Heap_StringListAddX(self, "sl_triggersSetup", "extensionKey-" + extensionKey + "-attributeNames", attributeName)
	; Heap_StringListAddX(self, "sl_triggersSetup", "extensionKey-" + extensionKey + "-attributeTypes", attributeType)
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
		startIndex = currentCardination * displayCount
		
		; display cardination buttons
		if currentCardination > 0
			oidCardinatePrevious = AddTextOption("<< Prev", "")
		else
			oidCardinatePrevious = AddTextOption("<< Prev", "", OPTION_FLAG_DISABLED)
		endif
		
		if hasNextCardinate
			oidCardinateNext = AddTextOption("Next >>", "")
		else
			oidCardinateNext = AddTextOption("Next >>", "", OPTION_FLAG_DISABLED)
		endif
	endif
	
	oidAddTop = AddTextOption("Add New Item", "")
	AddEmptyOption()
	
	int i = startIndex
	bool needsEmpty = false
	int _oid
	string visibilityKeyAttribute = GetExtensionVisibilityKey(extensionKey)
	bool allowedVisible
	
	while i < displayCount
		string triggerKey = GetTrigger(extensionKey, i)
		if !Trigger_IsDeletedT(extensionKey, triggerKey)
			if i > startIndex
				; blank row
				AddEmptyOption()
				AddEmptyOption()
			endif
			
			SetCursorFillMode(TOP_TO_BOTTOM)
			
			AddHeaderOption("==] " + triggerKey + " [==")
			
			SetCursorFillMode(LEFT_TO_RIGHT)
			
			int aidx = 0
			while aidx < attributeNames.Length
				string attrName = attributeNames[aidx]
				allowedVisible = true
				
				if visibilityKeyAttribute && HasAttrVisibleOnlyIf(extensionKey, attrName)
					string visibleOnlyIfValueIs = GetAttrVisibleOnlyIf(extensionKey, attrName)
					; arbitrarily prefer int over string if for some reason they specified two 
					; attributes with the same and types int and string
					string attrVal
					if Trigger_IntHasX(extensionKey, triggerKey, attrName)
						attrVal = Trigger_IntGetX(extensionKey, triggerKey, attrName)
					elseif Trigger_StringHasX(extensionKey, triggerKey, attrName)
						attrVal = Trigger_StringGetX(extensionKey, triggerKey, attrName)
					endif
					
					string tval
					if Trigger_IntHasX(extensionKey, triggerKey, visibilityKeyAttribute)
						tval = Trigger_IntGetX(extensionKey, triggerKey, visibilityKeyAttribute) as string
					elseif Trigger_StringHasX(extensionKey, triggerKey, visibilityKeyAttribute)
						tval = Trigger_StringGetX(extensionKey, triggerKey, visibilityKeyAttribute)
					else
						; they specified it, it somehow got past, and now we have to deal with it
						; or ignore it
						Debug.Trace("MCM: visibilityKeyAttribute (" + visibilityKeyAttribute + ") specified but neither int nor string available for current trigger")
						allowedVisible = false
					endif
					if allowedVisible && tval && tval != attrVal
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
						_oid = AddSliderOption(label, _defval, GetAttrFormatString(extensionKey, attrName))
						; add to list of oids to heap
						AddOid(_oid, extensionKey, triggerKey, attrName)
					elseif widg == WIDG_MENU
						string[] menuSelections = GetAttrMenuSelections(extensionKey, attrName)
						int ptype = GetAttrType(extensionKey, attrName)
						string menuValue
						if (ptype == PTYPE_INT() && !Trigger_IntHasX(extensionKey, triggerKey, attrName)) || (ptype == PTYPE_STRING() && !Trigger_StringHasX(extensionKey, triggerKey, attrName))
							menuValue = menuSelections[GetAttrDefaultIndex(extensionKey, attrName)]
						else
							if ptype == PTYPE_INT()
								menuValue = menuSelections[Trigger_IntGetX(extensionKey, triggerKey, attrName)]
							elseif ptype == PTYPE_STRING()
								string _tval = Trigger_StringGetX(extensionKey, triggerKey, attrName)
								if menuSelections.find(_tval) > -1
									menuValue = _tval
								endif
							endif
						endif
						_oid = AddMenuOption(label, menuValue)
						AddOid(_oid, extensionKey, triggerKey, attrName)
					elseif widg == WIDG_KEYMAP
						int _defmap = GetAttrDefaultValue(extensionKey, attrName)
						if Trigger_IntHasX(extensionKey, triggerKey, attrName)
							_defmap = Trigger_IntGetX(extensionKey, triggerKey, attrName)
						endif
						_oid = AddKeyMapOption(label, _defmap)
						AddOid(_oid, extensionKey, triggerKey, attrName)
					elseif widg == WIDG_TOGGLE
						bool _defval = GetAttrDefaultValue(extensionKey, attrName) != 0
						if Trigger_IntHasX(extensionKey, triggerKey, attrName)
							_defval = Trigger_IntGetX(extensionKey, triggerKey, attrName) != 0
						endif
						_oid = AddToggleOption(label, _defval)
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
						
						_oid = AddInputOption(label, _defval)
						AddOid(_oid, extensionKey, triggerKey, attrName)
					elseif widg == WIDG_COMMANDLIST
						string menuValue = ""
						if !Trigger_StringHasX(extensionKey, triggerKey, attrName)
							menuValue = commandsList[0]
						else
							string _cval = Trigger_StringGetX(extensionKey, triggerKey, attrName)
							if commandsList.find(_cval) > -1
								menuValue = _cval
							endif
						endif
						
						_oid = AddMenuOption(label, menuValue)
						AddOid(_oid, extensionKey, triggerKey, attrName)
					endif
				endif
				
				aidx += 1
			endwhile
			
			; for two column layout
			if needsEmpty
				AddEmptyOption()
			endif
			
			; blank row
			AddEmptyOption()
			AddEmptyOption()
			
			; and option to delete
			AddEmptyOption()
			_oid = AddTextOption("Delete", "")
			AddOid(_oid, extensionKey, triggerKey, DELETE_BUTTON)
		endif
	
		i += 1
	endwhile
	
	; blank row
	AddEmptyOption()
	AddEmptyOption()
	
	oidAddBottom = AddTextOption("Add New Item", "")
	AddEmptyOption()
	
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
		pageDidChange
		PageChanged()
	endif
	
	currentSLTPage = _page
	
	if currentSLTPage == ""
		extensionIndex = -1
		headerIndex = 0
	else
		extensionIndex = extensionPages.find(currentSLTPage)
		if extensionIndex > -1
			headerIndex = -1
		else
			headerIndex = headerPages.find(_page)
		endif
	endif
	
	if pageDidChange && IsExtensionPage()
		attributeNames = GetAttributeNames(extensionKeys[extensionIndex])
	endif
	
	DebMsg("set current SLT page: extensionIndex(" + extensionIndex + ") extensionKey(" + extensionKeys[extensionIndex] + ")")
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
	SetAttrLabel(_extensionKey, _attributeName, _label)
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
	int _attrType = GetAttrType(_extensionKey, _attributeName)
	if _attrType != PTYPE_INT() && _attrType != PTYPE_STRING()
		Debug.Trace("Setup: _requiredKeyAttribute must be PTYPE_INT or PTYPE_STRING")
		return
	endif
	
	SetAttrVisibleOnlyIf(_extensionKey, _attributeName, _requiredKeyAttributeValue)
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
		DebMsg("Trigger_CreateT: extensionKey(" + _extensionKey + ") triggerKey(" + triggerKey + ")")
		AddTrigger(_extensionKey, triggerKey)
	endif
EndFunction

; Specifying both triggerId and attributeName
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