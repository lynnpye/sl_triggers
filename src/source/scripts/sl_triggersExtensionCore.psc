;/
You can use this as a reference for building your own sl_triggers Extension.
Required and Optional overrides have been noted.
/;
scriptname sl_triggersExtensionCore extends sl_triggersExtension

import sl_triggersStatics

string	EVENT_TOP_OF_THE_HOUR					= "TopOfTheHour"
string	EVENT_TOP_OF_THE_HOUR_HANDLER			= "OnTopOfTheHour"
string	SETTINGS_DYNAMICACTIVATIONKEY_MODNAME 	= "DynamicActivationKey_modname"
string	DEFAULT_DYNAMICACTIVATIONKEY_MODFILE 	= "Dynamic Activation Key.esp"

string	EVENT_ID_KEYMAPPING 					= "1"
string	EVENT_ID_TOP_OF_THE_HOUR				= "2"
string	ATTR_EVENT								= "event"
string	ATTR_KEYMAPPING							= "keymapping"
string	ATTR_MODIFIERKEYMAPPING 				= "modifierkeymapping"
string	ATTR_USEDAK								= "usedak"
string	ATTR_CHANCE								= "chance"
string	ATTR_DO_1								= "do_1"
string	ATTR_DO_2								= "do_2"
string	ATTR_DO_3								= "do_3"

GlobalVariable		Property DAKStatus				Auto Hidden
Bool				Property DAKAvailable			Auto Hidden
GlobalVariable		Property DAKHotKey				Auto Hidden
float				Property TohElapsedTime			Auto Hidden
float				Property LastTopOfTheHour		Auto Hidden
float				Property NextTopOfTheHour		Auto Hidden


; Variables
bool	handlingTopOfTheHour = false ; only because the check is in a sensitive event handler

; this will contain a deduplicated list of all keycodes of interest, including modifiers
; so with 4 keycodes and 2 modifiers (assuming none of the modifiers are themselves also keycodes) this would be 6 in length
int[]		_keycodes_of_interest
; matching length boolean state array for fast lookup
bool[]		_keycode_status

; onInit we will refresh these with what we find
; and edit them during MCM updates as needed
string[]	triggerKeys_topOfTheHour
string[]	triggerKeys_keyDown

; GetExtensionKey
; OVERRIDE REQUIRED
; returns: the unique string identifier for this extension
string Function GetExtensionKey()
	return "sl_triggersExtensionCore"
EndFunction

; GetFriendlyName
; OVERRIDE RECOMMENDED
string Function GetFriendlyName()
	return "SLT Core"
EndFunction

;/
I chose 10000 here because I am adding minor functionality and not
overriding anything in core. There is plenty of room between me
and core for other extensions to slide in.
/;
; GetPriority
; OPTIONAL
; 0 is roughly "built-in"
; <0 has higher priority (think first in line to take a crack at the operation)
int Function GetPriority()
	return 10000
EndFunction

Event OnInit()
	if !self
		return
	endif
	; REQUIRED CALL
	SLTInit()
EndEvent

;/
; PopulateMCM
; OVERRIDE HIGHLY RECOMMENDED
Function PopulateMCM()
	if !self
		return
	endif
	string[] triggerIfEventNames	= PapyrusUtil.StringArray(3)
	triggerIfEventNames[0]			= "- Select an Event -"
	triggerIfEventNames[1]			= "Key Mapping"
	triggerIfEventNames[2]			= "Top of the Hour"
	DescribeMenuAttribute(ATTR_EVENT, PTYPE_INT(), "Event:", 0, triggerIfEventNames)
	SetHighlightText(ATTR_EVENT, "Choose which type of event this trigger will use.")
	
	; Only for Keymapping
	DescribeKeymapAttribute(ATTR_KEYMAPPING, PTYPE_INT(), "Keymapping: ")
	SetHighlightText(ATTR_KEYMAPPING, "Choose the key to map to the action.")
	DescribeKeymapAttribute(ATTR_MODIFIERKEYMAPPING, PTYPE_INT(), "Modifier Key: ")
	SetHighlightText(ATTR_MODIFIERKEYMAPPING, "(Optional) If specified, will be required to be pressed to trigger the action.")
	DescribeToggleAttribute(ATTR_USEDAK, PTYPE_INT(), "Use DAK? ")
	SetHighlightText(ATTR_USEDAK, "(Optional) If enabled, will use the Dynamic Activation Key instead of the Modifier key (if selected)")
	
	; Only for Top of the Hour
	DescribeSliderAttribute(ATTR_CHANCE, PTYPE_FLOAT(), "Chance: ", 0.0, 100.0, 1.0, "{0}")
	SetHighlightText(ATTR_CHANCE, "The chance the trigger will run when all prerequisites are met.")
	
	; technically you could add as many as you wanted here but of course
	; that could cause performance issues
	AddCommandList(ATTR_DO_1, "Command 1:")
	SetHighlightText(ATTR_DO_1, "You can run up to 3 commands associated with this keymapping. This is the first.")
	AddCommandList(ATTR_DO_2, "Command 2:")
	SetHighlightText(ATTR_DO_2, "You can run up to 3 commands associated with this keymapping. This is the second.")
	AddCommandList(ATTR_DO_3, "Command 3:")
	SetHighlightText(ATTR_DO_3, "You can run up to 3 commands associated with this keymapping. This is the third.")
	
	; placing these at the end just to point out that the position of the calls doesn't matter, so feel free 
	; to place these calls wherever in this function call you would want for organizational purposes
	SetVisibilityKeyAttribute(ATTR_EVENT)
	
	SetVisibleOnlyIf(ATTR_KEYMAPPING, 			EVENT_ID_KEYMAPPING)
	SetVisibleOnlyIf(ATTR_MODIFIERKEYMAPPING, 	EVENT_ID_KEYMAPPING)
	SetVisibleOnlyIf(ATTR_USEDAK, 				EVENT_ID_KEYMAPPING)
	
	SetVisibleOnlyIf(ATTR_CHANCE, EVENT_ID_TOP_OF_THE_HOUR)
EndFunction

string ATTR_TEST_TOGGLE = "testtoggle"
Function PopulateMCMSettings()
	if !self
		return
	endif

	DescribeToggleAttribute(ATTR_TEST_TOGGLE, PTYPE_INT(), "Test: ")
	SetHighlightText(ATTR_TEST_TOGGLE, "This is test text for your simple testing test.")
EndFunction
/;

Function SLTReady()
	UpdateDAKStatus()
	RefreshData()
EndFunction

Function RefreshData()
	RefreshTriggerCache()
	RegisterEvents()
EndFunction

; configuration was updated mid-game
Event OnSLTSettingsUpdated(string eventName, string strArg, float numArg, Form sender)
	if !self
		return
	endif
	RefreshData()
EndEvent

Event OnUpdateGameTime()
	if !self
		return
	endif
	If !IsEnabled
		Return
	EndIf
	
	if handlingTopOfTheHour
		float currentTime = Utility.GetCurrentGameTime() ; Days as float
		
		If currentTime >= nextTopOfTheHour
			tohElapsedTime = currentTime - lastTopOfTheHour
			lastTopOfTheHour = currentTime
			
			SendModEvent(EVENT_TOP_OF_THE_HOUR, "", tohElapsedTime)
			AlignToNextHour(currentTime)
		else
			RegisterForSingleUpdateGameTime((nextTopOfTheHour - currentTime) * 24.0 * 1.04)
		EndIf
	EndIf
EndEvent

Event OnTopOfTheHour(String eventName, string strArg, Float fltArg, Form sender)
	if !self
		Debug.Notification("Triggers: Critical error")
		Return
	endif
	
	If !IsEnabled
		Return
	EndIf
	
	HandleTopOfTheHour()
	;checkEvents(-1, 4, PlayerRef)
EndEvent

Event OnKeyDown(Int KeyCode)
	if !self
		Debug.Notification("Triggers: Critical error")
		Return
	endif
	
	If !IsEnabled
		Return
	Endif
	
	; update our statii
	; please don't say it
	;/
	for the record, because I feel this is the kind of choice that could easily be picked apart and second guessed
	I'm doing this for convenience, obviously
	my assumption is that there won't be a ton of these, so grabbing state and updating each time we get a keystroke
	we have registered for seems like a very small burden, particularly since we already went through the effort
	of caching the keycodes we care about and popping out a little bool[] for it too
	/;
	int i = 0
	while i < _keycodes_of_interest.Length
		int kcode = _keycodes_of_interest[i]
		_keycode_status[i] = Input.IsKeyPressed(kcode)
		i += 1
	endwhile
	
	HandleOnKeyDown()
EndEvent

Function RefreshTriggerCache()
	triggerKeys_topOfTheHour = PapyrusUtil.StringArray(0)
	triggerKeys_keyDown = PapyrusUtil.StringArray(0)
	int i = 0
	while i < TriggerKeys.Length
		string _triggerFile = FN_T(TriggerKeys[i])
		int eventCode = JsonUtil.GetIntValue(_triggerFile, ATTR_EVENT)

		if eventCode == 2 ; topofthehour
			triggerKeys_topOfTheHour = PapyrusUtil.PushString(triggerKeys_topOfTheHour, TriggerKeys[i])
		elseif eventCode == 1
			triggerKeys_keyDown = PapyrusUtil.PushString(triggerKeys_keyDown, TriggerKeys[i])
		endif
		i += 1
	endwhile

	_keycodes_of_interest = PapyrusUtil.IntArray(0)
	_keycode_status = PapyrusUtil.BoolArray(0)
	if triggerKeys_keyDown.Length > 0
		i = 0

		while i < triggerKeys_keyDown.Length
			string triggerKey = triggerKeys_keyDown[i]
			string _triggerFile = FN_T(triggerKey)
			
			int keycode = JsonUtil.GetIntValue(_triggerFile, ATTR_KEYMAPPING)

			if _keycodes_of_interest.Find(keycode) < 0
				_keycodes_of_interest = PapyrusUtil.PushInt(_keycodes_of_interest, keycode)
			endif
			if JsonUtil.HasIntValue(_triggerFile, ATTR_MODIFIERKEYMAPPING)
				keycode = JsonUtil.GetIntValue(_triggerFile, ATTR_MODIFIERKEYMAPPING)
				if _keycodes_of_interest.Find(keycode) < 0
					_keycodes_of_interest = PapyrusUtil.PushInt(_keycodes_of_interest, keycode)
				endif
			endif
			i += 1
		endwhile

		_keycode_status = PapyrusUtil.BoolArray(_keycodes_of_interest.Length)
	endif
EndFunction

; this function attempts to trigger a SingleUpdateGameTime just in time for the 
; next game-time top of the hour
; the 1.04 multiplier is to intentionally overshoot a tiny bit to ensure our trigger works
Function AlignToNextHour(float _curTime = -1.0)
	if triggerKeys_topOfTheHour.Length <= 0
		return
	endif
	
	; days
    float currentTime = _curTime
	if currentTime < 0.0
		currentTime = Utility.GetCurrentGameTime() ; Days as float
	endif
	; days
	float daysPassed = Math.Floor(currentTime) as float
	; hours
	float hoursToday = (currentTime - daysPassed) * 24.0
	float nextHourToday = Math.Floor(hoursToday + 1.0) as float
	float untilNextHour = nextHourToday - hoursToday
	
	nextTopOfTheHour = currentTime + (untilNextHour / 24.0)
	
	; because the timing for this has been ornery to say the least
    RegisterForSingleUpdateGameTime(untilNextHour * 1.04)
EndFunction

string Function GetDAKModname()
	return JsonUtil.GetStringValue(FN_S, SETTINGS_DYNAMICACTIVATIONKEY_MODNAME, DEFAULT_DYNAMICACTIVATIONKEY_MODFILE)
endfunction

Function UpdateDAKStatus()
	dakavailable = false
	DAKStatus = Game.GetFormFromFile(0x801, GetDAKModname()) as GlobalVariable
	DAKHotKey = Game.GetFormFromFile(0x804, GetDAKModname()) as GlobalVariable
	
	if DAKStatus
		dakavailable = true
	endif
EndFunction

; selectively enables only events with triggers
Function RegisterEvents()
    if IsDebugMsg
        Debug.Notification("SL Triggers Core: register events")
    endIf
	
	UnregisterForModEvent(EVENT_TOP_OF_THE_HOUR)
	handlingTopOfTheHour = false
	if IsEnabled && triggerKeys_topOfTheHour.Length > 0
		SafeRegisterForModEvent_Quest(self, EVENT_TOP_OF_THE_HOUR, EVENT_TOP_OF_THE_HOUR_HANDLER)
		AlignToNextHour()
		handlingTopOfTheHour = true
	endif
	
	UnregisterForKeyEvents()
	if IsEnabled && triggerKeys_keyDown.Length > 0
		RegisterForKeyEvents()
	endif
EndFunction


Function RegisterForKeyEvents()
	int i = 0
	while i < _keycodes_of_interest.Length
		RegisterForKey(_keycodes_of_interest[i])
		i += 1
	endwhile
EndFunction

Function UnregisterForKeyEvents()
	UnregisterForAllKeys()
EndFunction

Function HandleTopOfTheHour()
	int i = 0
	string triggerKey
	string command
	while i < triggerKeys_topOfTheHour.Length
		triggerKey = triggerKeys_topOfTheHour[i]
		string _triggerFile = FN_T(triggerKey)
		command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
		if command
			RequestCommand(PlayerRef, command)
		endIf
		command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
		if command
			RequestCommand(PlayerRef, command)
		endIf
		command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
		if command
			RequestCommand(PlayerRef, command)
		endIf
		i += 1
	endwhile
EndFunction

Function HandleOnKeyDown()
	; all we know at this point is that at least one of the keys of interest were pressed
	; now we iterate all of the triggers (by slotnoprefix), check the status array against their
	; settings, and execute or skip
	int i = 0
	bool doRun
	bool dakused
	int ival
	int statusidx
	string value
	string triggerKey
	string command
	
	while i < triggerKeys_keyDown.Length
		triggerKey = triggerKeys_keyDown[i]

		string _triggerFile = FN_T(triggerKey)
		
		doRun = true
		dakused = false
		
		ival = JsonUtil.GetIntValue(_triggerFile, ATTR_KEYMAPPING)
		statusidx = _keycodes_of_interest.Find(ival)
		
		; check keycode status, must be true
		if statusidx < 0
			doRun = false
		else
			doRun = _keycode_status[statusidx]
		endif
		
		; check dynamic activation key if in use and specified
		if doRun && DAKAvailable && JsonUtil.HasIntValue(_triggerFile, ATTR_USEDAK)
			doRun = (JsonUtil.GetIntValue(_triggerFile, ATTR_USEDAK) != 0)
			if doRun
				; if they had DAK setting AND it was true, then dakused is true
				; and doRun is determined by DAK status
				dakused = true
				doRun = DAKStatus.GetValue() as bool
			endif
		endif
		
		; check modifier status only if specified
		; if dakused, we do not try to manage via modifier
		if doRun && !dakused && JsonUtil.HasIntValue(_triggerFile, ATTR_MODIFIERKEYMAPPING)
			ival = JsonUtil.GetIntValue(_triggerFile, ATTR_MODIFIERKEYMAPPING)
			
			; only if mapped
			if ival > -1
				statusidx = _keycodes_of_interest.Find(ival)
				
				if statusidx < 0
					doRun = false
				else
					doRun = _keycode_status[statusidx]
				endif
			endif
		endif
		
		if doRun
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_1)
			if command
				RequestCommand(PlayerRef, command)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_2)
			if command
				RequestCommand(PlayerRef, command)
			endIf
			command = JsonUtil.GetStringValue(_triggerFile, ATTR_DO_3)
			if command
				RequestCommand(PlayerRef, command)
			endIf
		endif
		
		i += 1
	endwhile
EndFunction

