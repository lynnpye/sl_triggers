scriptname sl_triggersSetup extends SKI_ConfigBase

import sl_triggersStatics

; CONSTANTS
int			CARDS_PER_PAGE = 5
string		PSEUDO_INSTANCE_KEY = "sl_triggersSetup"

string		DELETE_BUTTON = "--DELETETHISITEM--"
string		RESTORE_BUTTON = "--RESTORETHISITEM--"
string		HARD_DELETE_BUTTON = "--HARDDELETETHISITEM--"


int	WIDG_ERROR			= 0
int	WIDG_SLIDER			= 1
int	WIDG_MENU			= 2
int	WIDG_KEYMAP			= 3
int	WIDG_TOGGLE			= 4
int	WIDG_INPUT			= 5
int	WIDG_COMMANDLIST	= 6
int	WIDG_LABEL			= 7


; Properties
sl_TriggersMain		Property SLT Auto

string				Property CurrentExtensionKey Auto Hidden

string[] Property ScriptsList Auto Hidden


; Variables
bool		refreshOnClose
bool		displayExtensionSettings
bool		previousDisplayExtensionSettings
bool		firstPageReset

string[]	headerPages
string[]	extensionPages
string[]	extensionKeys
;string[]	attributeNames

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
int 		oidDebug_Cmd
int 		oidDebug_Cmd_Functions
int 		oidDebug_Cmd_InternalResolve
int 		oidDebug_Cmd_InternalResolve_Literals
int 		oidDebug_Cmd_ResolveForm
int 		oidDebug_Cmd_RunScript
int			oidDebug_Cmd_RunScript_Blocks
int			oidDebug_Cmd_RunScript_If
int			oidDebug_Cmd_RunScript_Labels
int 		oidDebug_Cmd_RunScript_Set
int 		oidDebug_Cmd_RunScript_While
int 		oidDebug_Extension
int 		oidDebug_Extension_Core
int 		oidDebug_Extension_Core_Keymapping
int 		oidDebug_Extension_Core_Timer
int 		oidDebug_Extension_Core_TopOfTheHour
int 		oidDebug_Extension_SexLab
int 		oidDebug_Extension_OStim
int 		oidDebug_Extension_CustomResolveScoped
int 		oidDebug_Setup
int			oidResetSLT
int			oidCardinatePrevious
int			oidCardinateNext
int			oidAddTop
int			oidAddBottom
int			oidExtensionSettings
int			oidExtensionBack
int			oidExtensionEnabled
int[]		oidForcePageReset
; Oh look, they are in the same order as the otherwise unremarkable
; and yet, clearly, obviously important variables declared just
; above.
;
; I wonder....
Function CallThisToResetTheOIDValuesHextun()
	oidEnabled								= 0
	oidDebugMsg								= 0
	oidDebug_Cmd							= 0
	oidDebug_Cmd_Functions					= 0
	oidDebug_Cmd_InternalResolve			= 0
	oidDebug_Cmd_InternalResolve_Literals	= 0
	oidDebug_Cmd_ResolveForm				= 0
	oidDebug_Cmd_RunScript					= 0
	oidDebug_Cmd_RunScript_Blocks			= 0
	oidDebug_Cmd_RunScript_If				= 0
	oidDebug_Cmd_RunScript_Labels			= 0
	oidDebug_Cmd_RunScript_Set				= 0
	oidDebug_Cmd_RunScript_While			= 0
	oidDebug_Extension						= 0
	oidDebug_Extension_Core					= 0
	oidDebug_Extension_Core_Keymapping		= 0
	oidDebug_Extension_Core_Timer			= 0
	oidDebug_Extension_Core_TopOfTheHour	= 0
	oidDebug_Extension_SexLab				= 0
	oidDebug_Extension_OStim				= 0
	oidDebug_Extension_CustomResolveScoped	= 0
	oidDebug_Setup							= 0
	oidResetSLT								= 0
	oidCardinatePrevious					= 0
	oidCardinateNext						= 0
	oidAddTop								= 0
	oidAddBottom							= 0
	oidExtensionSettings					= 0
	oidExtensionBack						= 0
	oidExtensionEnabled						= 0
	oidForcePageReset						= PapyrusUtil.IntArray(0)
	xoidlist								= PapyrusUtil.IntArray(0)
	xoidtriggerkeys							= PapyrusUtil.StringArray(0)
	xoidattrnames							= PapyrusUtil.StringArray(0)
EndFunction

int Function GetVersion()
	return GetModVersion()
EndFunction

Event OnConfigInit()
	If (SLT.Debug_Setup)
		SLTDebugMsg("Setup.OnConfigInit")
	EndIf
	headerPages = new string[1]
	headerPages[0] = "SLTriggers Redux"
EndEvent

Event OnConfigOpen()
	If (SLT.Debug_Setup)
		SLTDebugMsg("Setup.OnConfigOpen")
	EndIf
	ScriptsList = sl_triggers.GetScriptsList()
	if SLT.Extensions.Length > 0
		extensionPages = PapyrusUtil.StringArray(0)
		extensionKeys = PapyrusUtil.StringArray(0)
		int i = 0
		while i < SLT.Extensions.Length
			sl_triggersExtension slext = SLT.Extensions[i] as sl_triggersExtension
			If (slext && slext.IsMCMConfigurable())
				extensionPages = PapyrusUtil.PushString(extensionPages, slext.SLTFriendlyName)
				extensionKeys = PapyrusUtil.PushString(extensionKeys, slext.SLTExtensionKey)
			EndIf
			i += 1
		endwhile
		Pages = PapyrusUtil.MergeStringArray(headerPages, extensionPages)
	else
		Pages = headerPages
	endif
	refreshOnClose = false
	firstPageReset = true
	displayExtensionSettings = false
	previousDisplayExtensionSettings = false
EndEvent

event OnConfigClose()
	If (SLT.Debug_Setup)
		SLTDebugMsg("Setup.OnConfigClose")
	EndIf
	SLT.SendInternalSettingsUpdateEvents()

	if refreshOnClose
		refreshOnClose = false
		SLT.DoInMemoryReset()
	endif
endEvent

Event OnPageReset(string page)
	If (SLT.Debug_Setup)
		SLTDebugMsg("Setup.OnPageReset page(" + page + ")  currentSLTPage(" + currentSLTPage + ") firstPageReset(" + firstPageReset + ") extensionPages(" + PapyrusUtil.StringJoin(extensionPages, "), (") + ")")
	EndIf

	CallThisToResetTheOIDValuesHextun()
	bool doPageChanged = false

	if !page
		firstPageReset = true
	endif

	if page != currentSLTPage
		doPageChanged = true
	endif
	currentSLTPage = page

	bool doDisplayExtensionSettingsChanged = false
	if displayExtensionSettings != previousDisplayExtensionSettings
		previousDisplayExtensionSettings = displayExtensionSettings
		oidExtensionBack = 0
		oidExtensionSettings = 0
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

	int extensionIndex = extensionPages.find(page)
	if extensionIndex > -1
		CurrentExtensionKey = extensionKeys[extensionIndex]
	
		If (SLT.Debug_Setup)
			SLTDebugMsg("Setup.OnPageReset: Displaying extension page: displayExtensionSettings(" + displayExtensionSettings + ") extensionIndex(" + extensionIndex + ") CurrentExtensionKey(" + CurrentExtensionKey + ")")
		EndIf

		if displayExtensionSettings
			;attributeNames = sl_triggers_internal.MCMGetAttributeNames(false, CurrentExtensionKey) ;GetAttributeNames(false)
			ShowExtensionSettings()
		else
			;attributeNames = sl_triggers_internal.MCMGetAttributeNames(true, CurrentExtensionKey) ;GetAttributeNames(true)
			ShowExtensionPage()
		endif
		return
	else
		If (SLT.Debug_Setup)
			SLTDebugMsg("Setup.OnPageReset: Displaying header page: extensionIndex(" + extensionIndex + ") CurrentExtensionKey(" + CurrentExtensionKey + ")")
		EndIf
		; needs special SLT level attribute names
		;attributeNames = sl_triggers_internal.MCMGetAttributeNames(false, CurrentExtensionKey) ;GetAttributeNames(false)
		ShowHeaderPage()
		return
	endif
	
	; obviously it should be one or the other and yet here we are
	Debug.Trace("SLT: Setup: Page is neither header nor extension")
EndEvent

;;;;;;;;;
; Simple constants for Papyrus types
int Property PTYPE_STRING = 1 AutoReadOnly Hidden
int Property PTYPE_INT = 2 AutoReadOnly Hidden
int Property PTYPE_FLOAT = 3 AutoReadOnly Hidden
int Property PTYPE_FORM = 4 AutoReadOnly Hidden

int Function ShowAttribute(string attrName, int widgetOptions, string triggerKey, string _dataFile, bool _isTriggerAttributes)
	string extensionKey = CurrentExtensionKey
	int _oid = 0
		
	int widg = GetAttrWidget(_isTriggerAttributes, attrName)
	string label = GetAttrLabel(_isTriggerAttributes, attrName)
	if widg == WIDG_SLIDER
		float _defval = GetAttrDefaultFloat(_isTriggerAttributes, attrName)
		if JsonUtil.HasFloatValue(_dataFile, attrName)
			_defval = JsonUtil.GetFloatValue(_dataFile, attrName)
		endif
		_oid = AddSliderOption(label, _defval, GetAttrFormatString(_isTriggerAttributes, attrName), widgetOptions)
		; add to list of oids to heap
		AddOid(_oid, triggerKey, attrName)
	elseif widg == WIDG_MENU
		string[] menuSelections = GetAttrMenuSelections(_isTriggerAttributes, attrName)
		int ptype = GetAttrType(_isTriggerAttributes, attrName)
		string menuValue = ""
		if (ptype == PTYPE_INT && !JsonUtil.HasIntValue(_dataFile, attrName)) || (ptype == PTYPE_STRING && !JsonUtil.HasStringValue(_dataFile, attrName))
			int midx = GetAttrDefaultIndex(_isTriggerAttributes, attrName)
			if midx > -1
				menuValue = menuSelections[midx]
			endif
		else
			if ptype == PTYPE_INT
				int midx = JsonUtil.GetIntValue(_dataFile, attrName)
				if midx > -1
					menuValue = menuSelections[midx]
				endif
			elseif ptype == PTYPE_STRING
				string _tval = JsonUtil.GetStringValue(_dataFile, attrName)
				if menuSelections.find(_tval) > -1
					menuValue = _tval
				endif
			endif
		endif
		_oid = AddMenuOption(label, menuValue, widgetOptions)
		AddOid(_oid, triggerKey, attrName)
	elseif widg == WIDG_KEYMAP
		int _defmap = GetAttrDefaultValue(_isTriggerAttributes, attrName)
		if JsonUtil.HasIntValue(_dataFile, attrName)
			_defmap = JsonUtil.GetIntValue(_dataFile, attrName)
		endif
		int keymapOptions = OPTION_FLAG_WITH_UNMAP
		if widgetOptions == OPTION_FLAG_DISABLED
			keymapOptions = OPTION_FLAG_DISABLED
		endif
		_oid = AddKeyMapOption(label, _defmap, keymapOptions)
		AddOid(_oid, triggerKey, attrName)
	elseif widg == WIDG_TOGGLE
		bool _defval = GetAttrDefaultValue(_isTriggerAttributes, attrName) != 0
		if JsonUtil.HasIntValue(_dataFile, attrName)
			_defval = JsonUtil.GetIntValue(_dataFile, attrName) != 0
		endif
		_oid = AddToggleOption(label, _defval, widgetOptions)
		AddOid(_oid, triggerKey, attrName)
	elseif widg == WIDG_INPUT
		string _defval = GetAttrDefaultString(_isTriggerAttributes, attrName)
		
		int ptype = GetAttrType(_isTriggerAttributes, attrName)
		if ptype == PTYPE_INT
			if JsonUtil.HasIntValue(_dataFile, attrName)
				_defval = JsonUtil.GetIntValue(_dataFile, attrName) as string
			endif
		elseif ptype == PTYPE_FLOAT
			if JsonUtil.HasFloatValue(_dataFile, attrName)
				_defval = JsonUtil.GetFloatValue(_dataFile, attrName) as string
			endif
		elseif ptype == PTYPE_STRING
			if JsonUtil.HasStringValue(_dataFile, attrName)
				_defval = JsonUtil.GetStringValue(_dataFile, attrName)
			endif
		elseif ptype == PTYPE_FORM
			if JsonUtil.HasFormValue(_dataFile, attrName)
				_defval = JsonUtil.GetFormValue(_dataFile, attrName) as string
			endif
		endif
		
		_oid = AddInputOption(label, _defval, widgetOptions)
		AddOid(_oid, triggerKey, attrName)
	elseif widg == WIDG_COMMANDLIST
		string menuValue = ""
		if JsonUtil.HasStringValue(_dataFile, attrName)
			string _cval = JsonUtil.GetStringValue(_dataFile, attrName)
			if ScriptsList.find(_cval) > -1
				menuValue = _cval
			endif
		endif
		
		_oid = AddMenuOption(label, menuValue, widgetOptions)
		AddOid(_oid, triggerKey, attrName)
	elseif widg == WIDG_LABEL
		string labeltext = GetAttrHighlight(_isTriggerAttributes, attrName)
		; purposefully not returning the _oid as this is just supposed to behave like a simple label
		; headers expand across both rows and this avoids that
		AddTextOption(labeltext, "")
	else
		Debug.Trace("This should not be reachable attrName(" + attrName + ") widg(" + widg + ") label(" + label + ") widgetOptions(" + widgetOptions + ") triggerKey(" + triggerKey + ") _dataFile(" + _dataFile + ") _isTriggerAttributes(" + _isTriggerAttributes + ")")
		AddEmptyOption()
	endif
	return _oid
EndFunction


Function ShowExtensionSettings()
	If (SLT.Debug_Setup)
		SLTDebugMsg("Setup.ShowExtensionSettings")
	EndIf
	SetCursorFillMode(TOP_TO_BOTTOM)

	string _dataFile = FN_X_Settings(CurrentExtensionKey)

	oidExtensionBack = AddTextOption("$SLT_BTN_BACK", "")
	AddEmptyOption()

	int _oid

	; blank row
	AddHeaderOption(currentSLTPage)
	bool _extensionEnabledInSettings = true
	
	_extensionEnabledInSettings = GetFlag(SLT.Debug_Setup || SLT.Debug_Extension, _dataFile, "enabled", true)
	oidExtensionEnabled = AddToggleOption("$SLT_LBL_ENABLED_QUESTION", _extensionEnabledInSettings)

	int widgetOptions = OPTION_FLAG_NONE
	if !_extensionEnabledInSettings
		widgetOptions = OPTION_FLAG_DISABLED
		; row
		AddHeaderOption("$SLT_MSG_EXTENSION_DISABLED_0")
		AddHeaderOption("$SLT_MSG_EXTENSION_DISABLED_1")
	endif

	string[] _layoutData = sl_triggers_internal.MCMGetLayout(false, CurrentExtensionKey) ;GetLayout(false, _dataFile)

	string _layout = _layoutData[0]

	int tlidx = 0
	string[] tlattributes

	tlattributes = sl_triggers_internal.MCMGetLayoutData(false, CurrentExtensionKey, _layout, tlidx) ;GetExtensionLayoutData(false, _layout, tlidx)
	tlidx = 0
	while tlidx < tlattributes.Length
		string elem = tlattributes[tlidx]
		if elem != "/"
			If (elem)
				_oid = ShowAttribute(elem, widgetOptions, "", _dataFile, false)
				if _layoutData[1] && _layoutData[1] == elem
					oidForcePageReset = PapyrusUtil.PushInt(oidForcePageReset, _oid)
				endif
			else
				AddEmptyOption()
			EndIf

			tlidx += 1
			if (tlidx < tlattributes.Length)
				elem = tlattributes[tlidx]
				if elem && elem != "/"
					_oid = ShowAttribute(elem, widgetOptions, "", _dataFile, false)
					if _layoutData[1] && _layoutData[1] == elem
						oidForcePageReset = PapyrusUtil.PushInt(oidForcePageReset, _oid)
					endif
				else
					AddEmptyOption()
				endif
			else
				AddEmptyOption()
			endif
		endif

		tlidx += 1
	endwhile
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
	If (SLT.Debug_Setup)
		SLTDebugMsg("Setup.ShowExtensionPage")
	EndIf

	if extensionPages.Length < 1
		return
	endif
	; I have an extensionIndex with which I can retrieve an extensionKey
	; if I'm going to paginate I need to have a concept of where in the order
	; I am in for triggerKeys
	string extensionKey = CurrentExtensionKey
	string[] extensionTriggerKeys = GetExtensionTriggerKeys()
	int triggerCount = extensionTriggerKeys.Length
	
	bool cardinate = false
	bool hasNextCardinate = false
	
	if triggerCount > CARDS_PER_PAGE
		cardinate = true
	endif
	
	; what do we want this to look like?
	SetCursorFillMode(LEFT_TO_RIGHT)
	
	; row
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
		
		;row
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
	int _oid
	bool triggerIsSoftDeleted
	string triggerKey
	while displayIndexer < displayCount
		int etkidx = displayIndexer + startIndex
		triggerKey = extensionTriggerKeys[etkidx]
		string _triggerFile = FN_Trigger(extensionKey, triggerKey)
		triggerIsSoftDeleted = JsonUtil.HasStringValue(_triggerFile, DELETED_ATTRIBUTE())
		
		AddHeaderOption("==] " + triggerKey + " [==")
		AddEmptyOption()

		int widgetOptions = OPTION_FLAG_NONE
		if triggerIsSoftDeleted
			widgetOptions = OPTION_FLAG_DISABLED
			; row
			AddHeaderOption("$SLT_MSG_SOFT_DELETE_0")
			AddHeaderOption("$SLT_MSG_SOFT_DELETE_1")
			; row
			AddHeaderOption("$SLT_MSG_SOFT_DELETE_2")
			AddHeaderOption("$SLT_MSG_SOFT_DELETE_3")
		endif

		;string _dataFile = FN_Trigger(CurrentExtensionKey, triggerKey)
		string[] _layoutData = sl_triggers_internal.MCMGetLayout(true, CurrentExtensionKey, triggerKey) ;GetLayout(true, _dataFile)
		string _triggerLayout = _layoutData[0]
		int tlidx = 0
		string[] tlattributes

		tlattributes = sl_triggers_internal.MCMGetLayoutData(true, CurrentExtensionKey, _triggerLayout, tlidx) ;GetExtensionLayoutData(false, _layout, tlidx)
		tlidx = 0
		while tlidx < tlattributes.Length
			string elem = tlattributes[tlidx]
			if elem != "/"
				If (elem)
					_oid = ShowAttribute(elem, widgetOptions, triggerKey, _triggerFile, true)
					if _layoutData[1] && _layoutData[1] == elem
						oidForcePageReset = PapyrusUtil.PushInt(oidForcePageReset, _oid)
					endif
				else
					AddEmptyOption()
				EndIf

				tlidx += 1
				if (tlidx < tlattributes.Length)
					elem = tlattributes[tlidx]
					if elem && elem != "/"
						_oid = ShowAttribute(elem, widgetOptions, triggerKey, _triggerFile, true)
						if _layoutData[1] && _layoutData[1] == elem
							oidForcePageReset = PapyrusUtil.PushInt(oidForcePageReset, _oid)
						endif
					else
						AddEmptyOption()
					endif
				else
					AddEmptyOption()
				endif
			endif

			tlidx += 1
		endwhile
		
		; blank row
		AddEmptyOption()
		AddEmptyOption()

		if !triggerIsSoftDeleted
			AddEmptyOption()

			; and option to delete
			_oid = AddTextOption("$SLT_BTN_DELETE", "")
			AddOid(_oid, triggerKey, DELETE_BUTTON)
		else
			_oid = AddTextOption("$SLT_BTN_HARD_DELETE", "")
			AddOid(_oid, triggerKey, HARD_DELETE_BUTTON)
			
			; and option to undelete
			_oid = AddTextOption("$SLT_BTN_RESTORE", "")
			AddOid(_oid, triggerKey, RESTORE_BUTTON)
		endif
	
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

Function ShowHeaderPage()
	SetCursorFillMode(TOP_TO_BOTTOM)
	int ver = GetVersion()
	AddHeaderOption("SLTriggers Redux")
	AddHeaderOption("(" + sl_triggers.GetTranslatedString("$SLT_LBL_VERSION") + " " + (ver as string) + ")")
	
	AddHeaderOption("$SLT_LBL_GLOBAL_SETTINGS")
	AddEmptyOption()
	oidEnabled    							= AddToggleOption("$SLT_LBL_ENABLED_QUESTION", 				SLT.IsEnabled)
	oidDebugMsg   							= AddToggleOption("$SLT_LBL_DEBUG_MESSAGES", 				SLT.bDebugMsg)
	AddEmptyOption()
	AddHeaderOption("$SLT_LBL_DEBUG_FLAGS")
	oidDebug_Cmd							= AddToggleOption("Debug_Cmd", 								SLT.Debug_Cmd)
	oidDebug_Cmd_Functions					= AddToggleOption("Debug_Cmd_Functions", 					SLT.Debug_Cmd_Functions)
	oidDebug_Cmd_InternalResolve			= AddToggleOption("Debug_Cmd_InternalResolve", 				SLT.Debug_Cmd_InternalResolve)
	oidDebug_Cmd_ResolveForm				= AddToggleOption("Debug_Cmd_ResolveForm", 					SLT.Debug_Cmd_ResolveForm)
	oidDebug_Cmd_RunScript					= AddToggleOption("Debug_Cmd_RunScript", 					SLT.Debug_Cmd_RunScript)
	oidDebug_Cmd_RunScript_Blocks 			= AddToggleOption("Debug_Cmd_RunScript_Blocks", 			SLT.Debug_Cmd_RunScript_Blocks)
	oidDebug_Cmd_RunScript_Set				= AddToggleOption("Debug_Cmd_RunScript_Set", 				SLT.Debug_Cmd_RunScript_Set)
	oidDebug_Cmd_RunScript_While			= AddToggleOption("Debug_Cmd_RunScript_While",				SLT.Debug_Cmd_RunScript_While)
	oidDebug_Extension						= AddToggleOption("Debug_Extension", 						SLT.Debug_Extension)
	oidDebug_Extension_Core					= AddToggleOption("Debug_Extension_Core", 					SLT.Debug_Extension_Core)
	oidDebug_Extension_Core_Keymapping		= AddToggleOption("Debug_Extension_Core_Keymapping",		SLT.Debug_Extension_Core_Keymapping)
	oidDebug_Extension_Core_Timer			= AddToggleOption("Debug_Extension_Core_Timer",				SLT.Debug_Extension_Core_Timer)
	oidDebug_Extension_Core_TopOfTheHour	= AddToggleOption("Debug_Extension_Core_TopOfTheHour",		SLT.Debug_Extension_Core_TopOfTheHour)
	oidDebug_Extension_SexLab				= AddToggleOption("Debug_Extension_SexLab", 				SLT.Debug_Extension_SexLab)
	oidDebug_Extension_OStim				= AddToggleOption("Debug_Extension_OStim",	 				SLT.Debug_Extension_OStim)
	oidDebug_Extension_CustomResolveScoped	= AddToggleOption("Debug_Extension_CustomResolveScoped",	SLT.Debug_Extension_CustomResolveScoped)
	oidDebug_Setup							= AddToggleOption("Debug_Setup",							SLT.Debug_Setup)
	AddEmptyOption()
	AddEmptyOption()
	oidResetSLT		= AddTextOption("$SLT_BTN_RESET_SL_TRIGGERS", "")
EndFunction

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
	elseif option == oidExtensionBack
		SetInfoText("$SLT_HIGHLIGHT_OID_EXTENSIONBACK")
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
		elseif attrName == HARD_DELETE_BUTTON
			SetInfoText("$SLT_HIGHLIGHT_OID_HARDDELETEITEM")
			return
		endif
	endif

	if IsExtensionPage()
		
		string triKey = GetOidTriggerKey(option)
		string attrName = GetOidAttributeName(option)
	
		string _dataFile
		bool _istk = (triKey != "")
	
		if !CurrentExtensionKey
			; global settings page right?
			_dataFile = FN_Settings()
		else
			if displayExtensionSettings
				; extension settings page
				_dataFile = FN_X_Settings(CurrentExtensionKey)
			else
				; extension triggers data
				_dataFile = FN_Trigger(CurrentExtensionKey, triKey)
				_istk = true
			endif
		endif
		
		if HasAttrHighlight(_istk, attrName)
			SetInfoText(GetAttrHighlight(_istk, attrName))
		endif
	endif
EndEvent

; All
Event OnOptionDefault(int option)
	if !option
		Return
	endif
	
	string triKey = GetOidTriggerKey(option)
	bool _istk = (triKey != "")
	string attrName = GetOidAttributeName(option)
	int attrType = GetAttrType(_istk, attrName)
	int attrWidg = GetAttrWidget(_istk, attrName)
	int defInt
	float defFlt
	string defStr
	
	float	optFlt
	int		optInt
	string	optStr
	bool	optBool
	
	string _dataFile

	if !CurrentExtensionKey
		; global settings page right?
		_dataFile = FN_Settings()
	else
		if displayExtensionSettings
			; extension settings page
			_dataFile = FN_X_Settings(CurrentExtensionKey)
		else
			; extension triggers data
			_dataFile = FN_Trigger(CurrentExtensionKey, triKey)
			_istk = true
		endif
	endif
	
	; set the trigger value
	if attrType == PTYPE_INT
		defInt = GetAttrDefaultValue(_istk, attrName)
		JsonUtil.SetIntValue(_dataFile, attrName, defInt)
	elseif attrType == PTYPE_STRING
		defStr = GetAttrDefaultString(_istk, attrName)
		JsonUtil.SetStringValue(_dataFile, attrName, defStr)
	elseif attrType == PTYPE_FLOAT
		defFlt = GetAttrDefaultFloat(_istk, attrName)
		JsonUtil.SetFloatValue(_dataFile, attrName, defFlt)
	endif
	
	; and set the option value
	if attrWidg == WIDG_SLIDER
		if attrType == PTYPE_INT
			optFlt = defInt as float
		elseif attrType == PTYPE_STRING
			optFlt = defStr as float
		elseif attrType == PTYPE_FLOAT
			optFlt = defFlt
		endif
		
		SetSliderOptionValue(option, optFlt, GetAttrFormatString(_istk, attrName))
	elseif attrWidg == WIDG_MENU
		if attrType == PTYPE_INT
			optInt = defInt
		elseif attrType == PTYPE_STRING
			optInt = GetAttrMenuSelectionIndex(_istk, attrName, defStr)
		endif
		
		SetMenuOptionValue(option, optInt)
	elseif attrWidg == WIDG_KEYMAP
		SetKeyMapOptionValue(option, defInt)
	elseif attrWidg == WIDG_TOGGLE
		if attrType == PTYPE_INT
			optBool = defInt != 0
		elseif attrType == PTYPE_STRING
			optBool = defStr as bool
		elseif attrType == PTYPE_FLOAT
			optBool = defFlt != 0.0
		endif
		
		SetToggleOptionValue(option, optBool)
	elseif attrWidg == WIDG_INPUT
		; not sent according to docs?
		Debug.Trace("Setup.OnOptionDefault: Input widget received, which was unexpected")
	elseif attrWidg == WIDG_COMMANDLIST
		SetMenuOptionValue(option, "")
	endif
	
	JsonUtil.Save(_dataFile)

	if oidForcePageReset.Find(option) > -1
		ForcePageReset()
	endif
EndEvent

bool Function DoSaveAndReset(int option, string jkey, bool value)
	bool storedValue = UpdateFlag(SLT.Debug_Setup, FN_Settings(), jkey, value)

	SetToggleOptionValue(option, storedValue)

	ForcePageReset()

	return storedValue
EndFunction

; Text (buttons?)
; Toggle
Event OnOptionSelect(int option)
	if !option
		Return
	endif
	string _strVal
	bool _boolVal
	If option == oidEnabled
		; this should have ramifications
		_strVal = "enabled"
		_boolVal = !SLT.IsEnabled
		SLT.IsEnabled = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebugMsg
		_strVal = "debugmsg"
		_boolVal = !SLT.bDebugMsg
		SLT.bDebugMsg = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Cmd
		_strVal = "Debug_Cmd"
		_boolVal = !SLT.Debug_Cmd
		SLT.Debug_Cmd = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Cmd_Functions
		_strVal = "Debug_Cmd_Functions"
		_boolVal = !SLT.Debug_Cmd_Functions
		SLT.Debug_Cmd_Functions = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Cmd_InternalResolve
		_strVal = "Debug_Cmd_InternalResolve"
		_boolVal = !SLT.Debug_Cmd_InternalResolve
		SLT.Debug_Cmd_InternalResolve = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Cmd_InternalResolve_Literals
		_strVal = "Debug_Cmd_InternalResolve_Literals"
		_boolVal = !SLT.Debug_Cmd_InternalResolve_Literals
		SLT.Debug_Cmd_InternalResolve_Literals = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Cmd_ResolveForm
		_strVal = "Debug_Cmd_ResolveForm"
		_boolVal = !SLT.Debug_Cmd_ResolveForm
		SLT.Debug_Cmd_ResolveForm = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Cmd_RunScript
		_strVal = "Debug_Cmd_RunScript"
		_boolVal = !SLT.Debug_Cmd_RunScript
		SLT.Debug_Cmd_RunScript = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Cmd_RunScript_Blocks
		_strVal = "Debug_Cmd_RunScript_Blocks"
		_boolVal = !SLT.Debug_Cmd_RunScript_Blocks
		SLT.Debug_Cmd_RunScript_Blocks = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Cmd_RunScript_If
		_strVal = "Debug_Cmd_RunScript_If"
		_boolVal = !SLT.Debug_Cmd_RunScript_If
		SLT.Debug_Cmd_RunScript_If = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Cmd_RunScript_Labels
		_strVal = "Debug_Cmd_RunScript_Labels"
		_boolVal = !SLT.Debug_Cmd_RunScript_Labels
		SLT.Debug_Cmd_RunScript_Labels = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Cmd_RunScript_Set
		_strVal = "Debug_Cmd_RunScript_Set"
		_boolVal = !SLT.Debug_Cmd_RunScript_Set
		SLT.Debug_Cmd_RunScript_Set = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Cmd_RunScript_While
		_strVal = "Debug_Cmd_RunScript_While"
		_boolVal = !SLT.Debug_Cmd_RunScript_While
		SLT.Debug_Cmd_RunScript_While = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Extension
		_strVal = "Debug_Extension"
		_boolVal = !SLT.Debug_Extension
		SLT.Debug_Extension = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Extension_Core
		_strVal = "Debug_Extension_Core"
		_boolVal = !SLT.Debug_Extension_Core
		SLT.Debug_Extension_Core = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Extension_Core_Keymapping
		_strVal = "Debug_Extension_Core_Keymapping"
		_boolVal = !SLT.Debug_Extension_Core_Keymapping
		SLT.Debug_Extension_Core_Keymapping = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Extension_Core_Timer
		_strVal = "Debug_Extension_Core_Timer"
		_boolVal = !SLT.Debug_Extension_Core_Timer
		SLT.Debug_Extension_Core_Timer = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Extension_Core_TopOfTheHour
		_strVal = "Debug_Extension_Core_TopOfTheHour"
		_boolVal = !SLT.Debug_Extension_Core_TopOfTheHour
		SLT.Debug_Extension_Core_TopOfTheHour = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Extension_SexLab
		_strVal = "Debug_Extension_SexLab"
		_boolVal = !SLT.Debug_Extension_SexLab
		SLT.Debug_Extension_SexLab = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Extension_OStim
		_strVal = "Debug_Extension_OStim"
		_boolVal = !SLT.Debug_Extension_OStim
		SLT.Debug_Extension_OStim = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Extension_CustomResolveScoped
		_strVal = "Debug_Extension_CustomResolveScoped"
		_boolVal = !SLT.Debug_Extension_CustomResolveScoped
		SLT.Debug_Extension_CustomResolveScoped = DoSaveAndReset(option, _strVal, _boolVal)
		return
	elseIf option == oidDebug_Setup
		_strVal = "Debug_Setup"
		_boolVal = !SLT.Debug_Setup
		SLT.Debug_Setup = DoSaveAndReset(option, _strVal, _boolVal)
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
		displayExtensionSettings = true
		ForcePageReset()

		return
	elseIf option == oidExtensionBack
		displayExtensionSettings = false
		ForcePageReset()

		return
	elseIf option == oidExtensionEnabled
		; this should have ramifications
		sl_triggersExtension ext = SLT.GetExtensionByKey(CurrentExtensionKey)
		if ext
			ext.SetEnabled(!ext.bEnabled)
			SetToggleOptionValue(option, ext.bEnabled)
			JsonUtil.Save(ext.FN_S)
		endif
		
		ForcePageReset()
		return
	endIf

	if oidForcePageReset.Find(option) > -1
		ForcePageReset()
	endif

	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	string _dataFile
	bool _istk = (triKey != "")

	if !CurrentExtensionKey
		; global settings page right?
		_dataFile = FN_Settings()
	else
		if displayExtensionSettings
			; extension settings page
			_dataFile = FN_X_Settings(CurrentExtensionKey)
		else
			; extension triggers data
			_dataFile = FN_Trigger(CurrentExtensionKey, triKey)
			_istk = true
		endif
	endif
	
	if attrName == DELETE_BUTTON
		JsonUtil.SetStringValue(_dataFile, DELETED_ATTRIBUTE(), "true")
		JsonUtil.Save(_dataFile)
		ForcePageReset()
		return
	elseif attrName == RESTORE_BUTTON
		JsonUtil.UnsetStringValue(_dataFile, DELETED_ATTRIBUTE())
		JsonUtil.Save(_dataFile)
		ForcePageReset()
		return
	elseif attrName == HARD_DELETE_BUTTON
		sl_triggers_internal.DeleteTrigger(CurrentExtensionKey, triKey)
		ForcePageReset()
		return
	endif

	;; else...
	
	int val = JsonUtil.GetIntValue(_dataFile, attrName)
	if val == 0
		val = 1
	else
		val = 0
	endif
	bool togval = (val != 0)
	JsonUtil.SetIntValue(_dataFile, attrName, val)
	JsonUtil.Save(_dataFile)

	;; assumptions galore
	SetToggleOptionValue(option, togval)

EndEvent

; Slider
Event OnOptionSliderOpen(int option)
	if !option
		Return
	endif
	
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	string _dataFile
	bool _istk = (triKey != "")

	if !CurrentExtensionKey
		; global settings page right?
		_dataFile = FN_Settings()
	else
		if displayExtensionSettings
			; extension settings page
			_dataFile = FN_X_Settings(CurrentExtensionKey)
		else
			; extension triggers data
			_dataFile = FN_Trigger(CurrentExtensionKey, triKey)
			_istk = true
		endif
	endif

	float startValue
	int attrType = GetAttrType(_istk, attrName)
	if attrType == PTYPE_STRING && JsonUtil.HasStringValue(_dataFile, attrName)
		startValue = JsonUtil.GetFloatValue(_dataFile, attrName) as float
	elseif attrType == PTYPE_INT && JsonUtil.HasIntValue(_dataFile, attrName)
		startValue = JsonUtil.GetIntValue(_dataFile, attrName) as float
	elseif attrType == PTYPE_FLOAT && JsonUtil.HasFloatValue(_dataFile, attrName)
		startValue = JsonUtil.GetFloatValue(_dataFile, attrName)
	endif


	SetSliderDialogStartValue(startValue)
	SetSliderDialogDefaultValue(GetAttrDefaultFloat(_istk, attrName))
	SetSliderDialogRange(GetAttrMinValue(_istk, attrName), GetAttrMaxValue(_istk, attrName))
	SetSliderDialogInterval(GetAttrInterval(_istk, attrName))
EndEvent

Event OnOptionSliderAccept(int option, float value)
	if !option
		Return
	endif
	
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	string _dataFile
	bool _istk = (triKey != "")

	if !CurrentExtensionKey
		; global settings page right?
		_dataFile = FN_Settings()
	else
		if displayExtensionSettings
			; extension settings page
			_dataFile = FN_X_Settings(CurrentExtensionKey)
		else
			; extension triggers data
			_dataFile = FN_Trigger(CurrentExtensionKey, triKey)
			_istk = true
		endif
	endif

	int attrType = GetAttrType(_istk, attrName)

	if attrType == PTYPE_STRING
		JsonUtil.SetFloatValue(_dataFile, attrName, value)
	elseif attrType == PTYPE_INT
		JsonUtil.SetIntValue(_dataFile, attrName, value as int)
	elseif attrType == PTYPE_FLOAT
		JsonUtil.SetFloatValue(_dataFile, attrName, value as float)
	endif

	SetSliderOptionValue(option, value, GetAttrFormatString(_istk, attrName))
	
	JsonUtil.Save(_dataFile)

	if oidForcePageReset.Find(option) > -1
		ForcePageReset()
	endif
EndEvent

; Menu
Event OnOptionMenuOpen(int option)
	if !option
		Return
	endif
	
	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)

	bool _istk = (triKey != "")

	int attrType = GetAttrType(_istk, attrName)
	int attrWidg = GetAttrWidget(_istk, attrName)
	
	int defaultIndex = 0
	int menuIndex = 0
	string menuValue = ""
	string[] menuSelections
	if attrWidg == WIDG_COMMANDLIST
		menuSelections = ScriptsList
	elseif attrWidg == WIDG_MENU
		menuSelections = GetAttrMenuSelections(_istk, attrName)
	endif
	SetMenuDialogOptions(menuSelections)
	
	string _dataFile

	if !CurrentExtensionKey
		; global settings page right?
		_dataFile = FN_Settings()
	else
		if displayExtensionSettings
			; extension settings page
			_dataFile = FN_X_Settings(CurrentExtensionKey)
		else
			; extension triggers data
			_dataFile = FN_Trigger(CurrentExtensionKey, triKey)
			_istk = true
		endif
	endif

	if attrWidg == WIDG_COMMANDLIST
		defaultIndex = -1
		if JsonUtil.HasStringValue(_dataFile, attrName)
			menuValue = JsonUtil.GetStringValue(_dataFile, attrName)
			menuIndex = menuSelections.find(menuValue)
		endif
	elseif attrWidg == WIDG_MENU
		if attrType == PTYPE_INT
			defaultIndex = GetAttrDefaultValue(_istk, attrName)
			menuIndex = JsonUtil.GetIntValue(_dataFile, attrName)
			menuValue = menuSelections[menuIndex]
		elseif attrType == PTYPE_STRING
			defaultIndex = menuSelections.find(GetAttrDefaultString(_istk, attrName))
			menuValue = JsonUtil.GetStringValue(_dataFile, attrName)
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

	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	bool _istk = (triKey != "")

	int attrType = GetAttrType(_istk, attrName)
	int attrWidg = GetAttrWidget(_istk, attrName)
	
	string[] menuSelections
	if attrWidg == WIDG_MENU
		menuSelections = GetAttrMenuSelections(_istk, attrName)
	elseif attrWidg == WIDG_COMMANDLIST
		menuSelections = ScriptsList
	endif
	
	string _dataFile

	if !CurrentExtensionKey
		; global settings page right?
		_dataFile = FN_Settings()
	else
		if displayExtensionSettings
			; extension settings page
			_dataFile = FN_X_Settings(CurrentExtensionKey)
		else
			; extension triggers data
			_dataFile = FN_Trigger(CurrentExtensionKey, triKey)
			_istk = true
		endif
	endif

	if index >= 0
		if attrType == PTYPE_INT
			JsonUtil.SetIntValue(_dataFile, attrName, index)
		elseif attrType == PTYPE_STRING
			JsonUtil.SetStringValue(_dataFile, attrName, menuSelections[index])
		endif
		SetMenuOptionValue(option, menuSelections[index])
	else
		if attrType == PTYPE_INT
			JsonUtil.UnsetIntValue(_dataFile, attrName)
		elseif attrType == PTYPE_STRING
			JsonUtil.UnsetStringValue(_dataFile, attrName)
		endif
		SetMenuOptionValue(option, "")
	endif

	JsonUtil.Save(_dataFile)

	if oidForcePageReset.Find(option) > -1
		ForcePageReset()
	endif
EndEvent

; Keymap
Event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	if !option
		Return
	endif

	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	bool proceed = true
	if conflictControl
		string msg
		string msg_thisKeyIsAlreadyMappedTo = sl_triggers.GetTranslatedString("$SLT_MSG_KEYMAP_CONFIRM_0")
		string msg_areYouSureYouWantToContinue = sl_triggers.GetTranslatedString("$SLT_MSG_KEYMAP_CONFIRM_1")
		if conflictName
			msg = msg_thisKeyIsAlreadyMappedTo + "\n\"" + conflictControl + "\"\n(" + conflictName + ")\n\n" + msg_areYouSureYouWantToContinue
		else
			msg = msg_thisKeyIsAlreadyMappedTo + "\n\"" + conflictControl + "\"\n\n" + msg_areYouSureYouWantToContinue
		endIf
		
		proceed = ShowMessage(msg, true, "$Yes", "$No")
	endif
	
	if proceed
		string _dataFile
		bool _istk = (triKey != "")
	
		if !CurrentExtensionKey
			; global settings page right?
			_dataFile = FN_Settings()
		else
			if displayExtensionSettings
				; extension settings page
				_dataFile = FN_X_Settings(CurrentExtensionKey)
			else
				; extension triggers data
				_dataFile = FN_Trigger(CurrentExtensionKey, triKey)
				_istk = true
			endif
		endif
		
		if keyCode >= 0
			JsonUtil.SetIntValue(_dataFile, attrName, keyCode)
		else
			JsonUtil.UnsetIntValue(_dataFile, attrName)
		endif
		SetKeyMapOptionValue(option, keyCode)
		
		JsonUtil.Save(_dataFile)

		if oidForcePageReset.Find(option) > -1
			ForcePageReset()
		endif
	endif
EndEvent

; Input (string input dialog)
Event OnOptionInputOpen(int option)
	if !option
		Return
	endif

	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	string optVal

	int hasTheData
	string _dataFile
	bool _istk = (triKey != "")

	if !CurrentExtensionKey
		; global settings page right?
		_dataFile = FN_Settings()
	else
		if displayExtensionSettings
			; extension settings page
			_dataFile = FN_X_Settings(CurrentExtensionKey)
		else
			; extension triggers data
			_dataFile = FN_Trigger(CurrentExtensionKey, triKey)
			_istk = true
		endif
	endif

	int attrType = GetAttrType(_istk, attrName)
	if attrType == PTYPE_STRING && JsonUtil.HasStringValue(_dataFile, attrName)
		hasTheData = 1
	elseif attrType == PTYPE_INT && JsonUtil.HasIntValue(_dataFile, attrName)
		hasTheData = 2
	elseif attrType == PTYPE_FLOAT && JsonUtil.HasFloatValue(_dataFile, attrName)
		hasTheData = 3
	endif

	if hasTheData > 0
		if hasTheData == 1
			optVal = JsonUtil.GetStringValue(_dataFile, attrName)
		elseif hasTheData == 2
			optVal = JsonUtil.GetIntValue(_dataFile, attrName)
		elseif hasTheData == 3
			optVal = JsonUtil.GetFloatValue(_dataFile, attrName)
		endif
	else
		optVal = GetAttrDefaultString(_istk, attrName)
	endif
	SetInputDialogStartText(optVal)
EndEvent

Event OnOptionInputAccept(int option, string _input)
	if !option
		Return
	endif

	string triKey = GetOidTriggerKey(option)
	string attrName = GetOidAttributeName(option)
	
	string _dataFile
	bool _istk = (triKey != "")

	if !CurrentExtensionKey
		; global settings page right?
		_dataFile = FN_Settings()
	else
		if displayExtensionSettings
			; extension settings page
			_dataFile = FN_X_Settings(CurrentExtensionKey)
		else
			; extension triggers data
			_dataFile = FN_Trigger(CurrentExtensionKey, triKey)
			_istk = true
		endif
	endif

	int attrType = GetAttrType(_istk, attrName)
	if attrType == PTYPE_STRING
		if !_input
			JsonUtil.UnsetStringValue(_dataFile, attrName)
		else
			JsonUtil.SetStringValue(_dataFile, attrName, _input)
		endif
	elseif attrType == PTYPE_INT
		if !_input
			JsonUtil.UnsetIntValue(_dataFile, attrName)
		else
			JsonUtil.SetIntValue(_dataFile, attrName, _input as int)
		endif
	elseif attrType == PTYPE_FLOAT
		if !_input
			JsonUtil.UnsetFloatValue(_dataFile, attrName)
		else
			JsonUtil.SetFloatValue(_dataFile, attrName, _input as float)
		endif
	endif


	SetInputOptionValue(option, _input)
	
	JsonUtil.Save(_dataFile)

	if oidForcePageReset.Find(option) > -1
		ForcePageReset()
	endif
EndEvent

bool Function IsExtensionPage()
	return (CurrentExtensionKey != "")
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
		
		triggerFileName = FN_Trigger(CurrentExtensionKey, triggerKey)
		if !JsonUtil.JsonExists(triggerFileName)
			found = false
		else
			triggerNum += 1
		endif
	endwhile
	
	if found
		Debug.Trace("SLT: Setup: Unable to create new trigger: '" + triggerFileName + "'")
	else
		JsonUtil.SetIntValue(triggerFileName, "__slt_mod_version__", GetModVersion())
		JsonUtil.Save(triggerFileName)
	endif
	
	return triggerKey
EndFunction

string[] Function GetExtensionTriggerKeys()
	return JsonUtil.JsonInFolder(ExtensionTriggersFolder(CurrentExtensionKey))
EndFunction

Function AddOid(int _oid, string _triggerKey, string _attrName)
	xoidlist		= PapyrusUtil.PushInt(xoidlist, _oid)
	xoidtriggerkeys	= PapyrusUtil.PushString(xoidtriggerkeys, _triggerKey)
	xoidattrnames	= PapyrusUtil.PushString(xoidattrnames, _attrName)
EndFunction

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

;;;;;;;;;;;;;;;
;; Attribute related functions

int Function GetAttrWidget(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "widget")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "widget")
	if data.Length > 0
		string strwidg = data[0]
		if strwidg == "slider"
			return WIDG_SLIDER
		elseif strwidg == "menu"
			return WIDG_MENU
		elseif strwidg == "keymapping"
			return WIDG_KEYMAP
		elseif strwidg == "toggle"
			return WIDG_TOGGLE
		elseif strwidg == "input"
			return WIDG_INPUT
		elseif strwidg == "command"
			return WIDG_COMMANDLIST
		elseif strwidg == "header"
			return WIDG_LABEL
		endif
	endif
	return WIDG_ERROR
EndFunction

int Function GetAttrType(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "type")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "type")
	int ptype = -1
	if data.Length > 0
		string strtype = data[0]
		if strtype == "int"
			ptype = PTYPE_INT
		elseif strtype == "float"
			ptype = PTYPE_FLOAT
		elseif strtype == "string"
			ptype = PTYPE_STRING
		elseif strtype == "form"
			ptype = PTYPE_FORM
		endif
	endif
	return ptype
EndFunction

float Function GetAttrMinValue(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "widget")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "widget")
	float info
	if data.Length >= 5 && data[0] == "slider"
		info = data[2] as float
	endif
	return info
EndFunction

float Function GetAttrMaxValue(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "widget")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "widget")
	float info
	if data.Length >= 5 && data[0] == "slider"
		info = data[3] as float
	endif
	return info
EndFunction

float Function GetAttrInterval(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "widget")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "widget")
	float info
	if data.Length >= 5 && data[0] == "slider"
		info = data[4] as float
	endif
	return info
EndFunction

int Function GetAttrDefaultValue(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "type")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "type")
	int info
	if data.Length > 1 && data[0] == "int"
		info = data[1] as int
	endif
	return info
EndFunction

float Function GetAttrDefaultFloat(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "type")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "type")
	float info
	if data.Length > 1 && data[0] == "float"
		info = data[1] as float
	endif
	return info
EndFunction

string Function GetAttrDefaultString(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "type")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "type")
	string info
	if data.Length > 1 && data[0] == "string"
		info = data[1]
	endif
	return info
EndFunction

string Function GetAttrLabel(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "widget")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "widget")
	string info
	if data.Length > 1
		info = data[1]
	endif
	return info
EndFunction

string Function GetAttrFormatString(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "widget")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "widget")
	string info
	if data.Length > 5 && data[0] == "slider"
		info = data[5] as string
	endif
	return info
EndFunction

int Function GetAttrDefaultIndex(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "widget")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "widget")
	int info
	if data.Length >= 2 && data[0] == "menu"
		info = data[2] as int
	endif
	return info
EndFunction

string[] Function GetAttrMenuSelections(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "widget")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "widget")
	string[] info
	if data.Length > 3 && data[0] == "menu"
		info = PapyrusUtil.SliceStringArray(data, 3)
	endif
	return info
EndFunction


int Function GetAttrMenuSelectionIndex(bool _istk, string _attr, string _selection)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "widget")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "widget")
	int info
	if data.Length > 0
		info = data.Find(_selection, 3)
	endif
	return info
EndFunction

bool Function HasAttrHighlight(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "info")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "info")
	string info
	if data.Length > 0
		info = data[0]
	endif
	return (info != "")
EndFunction

string Function GetAttrHighlight(bool _istk, string _attr)
	;string[] data = GetExtensionAttributeData(_istk, _attr, "info")
	string[] data = sl_triggers_internal.MCMGetAttributeData(_istk, CurrentExtensionKey, _attr, "info")
	string info
	if data.Length > 0
		info = data[0]
	endif
	return info
EndFunction