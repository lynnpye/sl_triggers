Scriptname sl_TriggersMain extends Quest

sl_triggersSetup	Property SLTCFG Auto

function DebMsg(string msg, bool shouldIDoAnything = false)
	if !shouldIDoAnything
		return
	endif
	
	MiscUtil.WriteToFile("data/skse/plugins/sl_triggers/debugmsg.log", msg + "\n", true)
	MiscUtil.PrintConsole(msg)
	Debug.Notification(msg)
endfunction

; CONSTANTS
string EVENT_TOP_OF_THE_HOUR			= "TopOfTheHour"
string EVENT_TOP_OF_THE_HOUR_HANDLER	= "OnTopOfTheHour"
string TEMP_KEYCODE_LIST				= "sl_triggers:::KEYCODE_LIST"
string SUMO_EXTENSION_LIST				= "slt:sumoextensionlist"

; Properties
Actor               Property PlayerRef				Auto
SexLabFramework     Property SexLab					Auto Hidden
Faction	            Property SexLabAnimatingFaction Auto Hidden
Keyword				Property ActorTypeNPC			Auto
Keyword				Property ActorTypeUndead		Auto
Spell[]             Property customSpells			Auto
MagicEffect[]       Property customEffects			Auto
float				Property tohElapsedTime			Auto
float				Property lastTopOfTheHour		Auto
float				Property nextTopOfTheHour		Auto
Bool				Property bEnabled = true 		Auto Hidden
Bool				Property bDebugMsg = false 		Auto Hidden
GlobalVariable		Property DAKStatus				Auto
Bool				Property DAKAvailable			Auto
GlobalVariable		Property DAKHotKey				Auto

; internal variables
int		oneupnumber = -30000 ; used to generate a stream of unique ids for each sl_triggersCmd
bool	handlingTopOfTheHour = false ; only because the check is in a sensitive event handler

; this will contain a deduplicated list of all keycodes of interest, including modifiers
; so with 4 keycodes and 2 modifiers (assuming none of the modifiers are themselves also keycodes) this would be 6 in length
int[]		_keycodes_of_interest
; matching length boolean state array for fast lookup
bool[]		_keycode_status

; these will contain cached copies of the slot prefixes for each event type for a little boost in speed
string[]	_trigger_cache_OnSexLabStart
string[]	_trigger_cache_OnSexLabOrgasm
string[]	_trigger_cache_OnSexLabEnd
string[]	_trigger_cache_OnSexLabOrgasmS
string[]	_trigger_cache_OnTopOfTheHour
string[]	_trigger_cache_OnKeyDown

; simple get handler for infini-globals
string Function globalvars_get(int varsindex)
	return SUMO_StringGetF(self, SUMO_MakeKey("sl_triggers_global", "globalvars" + varsindex))
EndFunction

; simple set handler for infini-globals
string Function globalvars_set(int varsindex, string value)
	return SUMO_StringSetF(self, SUMO_MakeKey("sl_triggers_global", "globalvars" + varsindex), value)
EndFunction

; twins, basil... twins!
; cycles from -30000 to 30000 and back through
; they get released when each effect ends
; if you get 60000 of these launched in your game, you win
int Function NextOneUp(int oneupmin = -30000, int oneupmax = 30000)
	Utility.Wait(0)
	
	int nextup = oneupnumber
	oneupnumber += 1
	if oneupnumber > oneupmax
		oneupnumber = oneupmin
	endif
	return nextup
EndFunction

Event OnInit()
	; now using sl_triggersSetup as a sort of... configuration repo
	SLTCFG.init()
	on_reload()
	RegisterForSingleUpdate(10)
EndEvent

Event OnUpdate()
	if !self
		return
	endif
	RegisterForSingleUpdate(30)
EndEvent

;/
Ultimately this one handler might get called on to handle multiple different
game time update cadences. So, in the spirit of thinking ahead while hacking to pieces...
/;
Event OnUpdateGameTime()
	If !bEnabled
		Return
	EndIf
	
	if handlingTopOfTheHour
		float currentTime = Utility.GetCurrentGameTime() ; Days as float
		
		If currentTime >= nextTopOfTheHour
			tohElapsedTime = currentTime - lastTopOfTheHour
			lastTopOfTheHour = currentTime
			
			SendModEvent(EVENT_TOP_OF_THE_HOUR)
			AlignToNextHour(currentTime)
		else
			RegisterForSingleUpdateGameTime((nextTopOfTheHour - currentTime) * 24.0 * 1.04)
		EndIf
	EndIf
EndEvent

Function on_reload()
	UpdateDAKStatus()
	UpdateSexLabStatus()
	RefreshTriggerCaches()
	UnregisterForUpdate()
	RegisterForSingleUpdate(10)
EndFunction

Function UpdateDAKStatus()
	dakavailable = false
	DAKStatus = Game.GetFormFromFile(0x801, SLTCFG._getDAKModname()) as GlobalVariable
	DAKHotKey = Game.GetFormFromFile(0x804, SLTCFG._getDAKModname()) as GlobalVariable
	
	if DAKStatus
		dakavailable = true
	endif
EndFunction

Function UpdateSexLabStatus()
	SexLabAnimatingFaction = none
	SexLab = Game.GetFormFromFile(0xD62, "SexLab.esm") as SexLabFramework
	
	if SexLab
		SexLabAnimatingFaction = Game.GetFormFromFile(0xE50F, "SexLab.esm") as Faction
	endif
EndFunction

; this function should be called at player start and any time configs change
; requests sl_triggersSetup perform initialization, including version checks
; caches a list for each event type of the slotids that target it, to speed execution
Function RefreshTriggerCaches()
	; ensure data is up to date if any conversions/updates need to happen
	;SLTCFG.init()
	
	if bDebugMsg
		MiscUtil.PrintConsole("SL_TRIGGERS: reset max slots")
	endif
	
	int slotCounter = 1
	
	_trigger_cache_OnSexLabStart = PapyrusUtil.StringArray(0)
	_trigger_cache_OnSexLabOrgasm = PapyrusUtil.StringArray(0)
	_trigger_cache_OnSexLabEnd = PapyrusUtil.StringArray(0)
	_trigger_cache_OnSexLabOrgasmS = PapyrusUtil.StringArray(0)
	_trigger_cache_OnTopOfTheHour = PapyrusUtil.StringArray(0)
	_trigger_cache_OnKeyDown = PapyrusUtil.StringArray(0)
	StorageUtil.IntListClear(self, TEMP_KEYCODE_LIST)
	
	while slotCounter < 81
		string slotNoPrefix = SLTCFG._makeSlotNoPrefix(slotCounter)
		string slotEventId = SLTCFG._makeSlotIdFromPrefix(slotNoPrefix, 2)
		bool hsv = JsonUtil.HasStringValue(SLTCFG.SettingsName, slotEventId)
		if JsonUtil.HasStringValue(SLTCFG.SettingsName, slotEventId)
			int eventIdx = JsonUtil.GetStringValue(SLTCFG.SettingsName, slotEventId) as int
			if eventIdx		== SLTCFG.EVENT_ID_SEXLAB_START
				_trigger_cache_OnSexLabStart = PapyrusUtil.PushString(_trigger_cache_OnSexLabStart, slotNoPrefix)
			elseif eventIdx	== SLTCFG.EVENT_ID_SEXLAB_ORGASM
				_trigger_cache_OnSexLabOrgasm = PapyrusUtil.PushString(_trigger_cache_OnSexLabOrgasm, slotNoPrefix)
			elseif eventIdx == SLTCFG.EVENT_ID_SEXLAB_STOP
				_trigger_cache_OnSexLabEnd = PapyrusUtil.PushString(_trigger_cache_OnSexLabEnd, slotNoPrefix)
			elseif eventIdx == SLTCFG.EVENT_ID_SEXLAB_ORGASMS
				_trigger_cache_OnSexLabOrgasmS = PapyrusUtil.PushString(_trigger_cache_OnSexLabOrgasmS, slotNoPrefix)
			elseif eventIdx == SLTCFG.EVENT_ID_TOP_OF_THE_HOUR
				_trigger_cache_OnTopOfTheHour = PapyrusUtil.PushString(_trigger_cache_OnTopOfTheHour, slotNoPrefix)
			elseif eventIdx == SLTCFG.EVENT_ID_KEYMAPPING
				_trigger_cache_OnKeyDown = PapyrusUtil.PushString(_trigger_cache_OnKeyDown, slotNoPrefix)
				
				; some extra caching to make OnKeyDown faster
				; keycode
				int thekeycode = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefix, 13)) as int
				StorageUtil.IntListAdd(self, TEMP_KEYCODE_LIST, thekeycode, false)
				; modifier
				thekeycode = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefix, 14)) as int
				StorageUtil.IntListAdd(self, TEMP_KEYCODE_LIST, thekeycode, false)
			endif
		endif
		
		slotCounter += 1
	endwhile
	
	If _trigger_cache_OnKeyDown.Length > 0
		_keycodes_of_interest = StorageUtil.IntListToArray(self, TEMP_KEYCODE_LIST)
		_keycode_status = PapyrusUtil.BoolArray(_keycodes_of_interest.Length, false)
		StorageUtil.IntListClear(self, TEMP_KEYCODE_LIST)
	else
		_keycodes_of_interest = none
		_keycode_status = none
	EndIf
	
	; and update our event registration appropriately
	_registerEvents()
EndFunction

; this function attempts to trigger a SingleUpdateGameTime just in time for the 
; next game-time top of the hour
; the 1.04 multiplier is to intentionally overshoot a tiny bit to ensure our trigger works
Function AlignToNextHour(float _curTime = -1.0)
	if _trigger_cache_OnTopOfTheHour.Length <= 0
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

; selectively enables only events with triggers
Function _registerEvents()
    if bDebugMsg
        Debug.Notification("SL Triggers: register events")
    endIf
	
	UnregisterForModEvent("AnimationStart")
	if bEnabled && _trigger_cache_OnSexLabStart.Length > 0 && SexLab
		RegisterForModEvent("AnimationStart", "OnSexLabStart")
	endif
	
	UnregisterForModEvent("AnimationEnd")
	if bEnabled && _trigger_cache_OnSexLabEnd.Length > 0 && SexLab
		RegisterForModEvent("AnimationEnd", "OnSexLabEnd")
	endif
	
	UnregisterForModEvent("OrgasmStart")
	if bEnabled && _trigger_cache_OnSexLabOrgasm.Length > 0 && SexLab
		RegisterForModEvent("OrgasmStart", "OnSexLabOrgasm")
	endif
    
	UnregisterForModEvent("SexLabOrgasmSeparate")
	if bEnabled && _trigger_cache_OnSexLabOrgasmS.Length > 0 && SexLab
		RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmS")
	endif
	
	UnregisterForModEvent(EVENT_TOP_OF_THE_HOUR)
	handlingTopOfTheHour = false
	if bEnabled && _trigger_cache_OnTopOfTheHour.Length > 0
		RegisterForModEvent(EVENT_TOP_OF_THE_HOUR, EVENT_TOP_OF_THE_HOUR_HANDLER)
		AlignToNextHour()
		handlingTopOfTheHour = true
	endif
	
	UnregisterForKeyEvents()
	if bEnabled && _trigger_cache_OnKeyDown.Length > 0
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

; meh, technically could do something.. else? after settings are updated
; but for now it's just a passthrough
Function HandleSettingsUpdated()
	RefreshTriggerCaches()
EndFunction

; some helper methods
Int Function actorRace(Actor _actor)
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

int Function _actorPos(int idx, int count)
    if idx >= count
        return 0
    elseif idx < 0 && count > 0
        return count - 1
    endIf
    return idx
endFunction

Int Function dayTime()
	float dayTime = Utility.GetCurrentGameTime()
 
	dayTime -= Math.Floor(dayTime)
	dayTime *= 24
	If dayTime >= 7 && dayTime <= 19
		return 1
	EndIf
	Return 2
EndFunction

bool Function CheckEventChance(string slotNoPrefix)
	float eventchance = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefix, 1)) as float
	if eventchance >= 100.0
		return true
	elseif eventchance <= 0.0
		return false
	else
		return Utility.RandomFloat(0.0, 100.0) <= eventchance
	endif
EndFunction

;; StorageUtil Memory Object wrappers...
;; repeated here
Form Function SUMO_FormGetF(Form _theActor, string sumokey) global
	return StorageUtil.GetFormValue(_theActor, sumokey)
EndFunction

Form Function SUMO_FormSetF(Form _theActor, string sumokey, Form value) global
	return StorageUtil.SetFormValue(_theActor, sumokey, value)
EndFunction

bool Function SUMO_FormHasF(Form _theActor, string sumokey) global
	return StorageUtil.HasFormValue(_theActor, sumokey)
EndFunction

int Function SUMO_IntGetF(Form _theActor, string sumokey) global
	return StorageUtil.GetIntValue(_theActor, sumokey)
EndFunction

int Function SUMO_IntSetF(Form _theActor, string sumokey, int value) global
	return StorageUtil.SetIntValue(_theActor, sumokey, value)
EndFunction

string Function SUMO_StringGetF(Form _theActor, string sumokey) global
	return StorageUtil.GetStringValue(_theActor, sumokey)
EndFunction

string Function SUMO_StringSetF(Form _theActor, string sumokey, string value) global
	return StorageUtil.SetStringValue(_theActor, sumokey, value)
EndFunction

string Function SUMO_MakeKeyPrefix(string extension) global
	return "sl_triggers:" + extension
EndFunction

string Function SUMO_MakeKey(string extension, string keyname) global
	return SUMO_MakeKeyPrefix(extension) + ":" + keyname
EndFunction

int Function SUMO_ClearPrefixF(Form _theActor, string sumoprefix) global
	return StorageUtil.ClearAllObjPrefix(_theActor, sumoprefix)
EndFunction

string Function PopSUMOExtensionF(Form _theActor) global
	string popped = StorageUtil.StringListShift(_theActor, "slt:sumoextensionlist")
	
	return popped
EndFunction

Function PushSUMOExtensionF(Actor _theActor, string sumotoken) global
	StorageUtil.StringListAdd(_theActor, "slt:sumoextensionlist", sumotoken)
EndFunction


; EXTERNAL EVENT HANDLERS
Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLab
		Debug.Notification("Triggers: Critical error")
		Return
	EndIf
	
	If !bEnabled
		Return
	EndIf
	
    int tid = _args as int
    ;sslThreadController thread = Sexlab.GetController(tid)
	
	HandleSexLabCheckEvents(tid, none, _trigger_cache_OnSexLabStart)
    ;checkEvents(tid, 0, none)
    
EndEvent

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLab
		Debug.Notification("Triggers: Critical error")
		Return
	EndIf
	
	If !bEnabled
		Return
	EndIf
	
    int tid = _args as int
    ;sslThreadController thread = Sexlab.GetController(tid)
    
	HandleSexLabCheckEvents(tid, none, _trigger_cache_OnSexLabOrgasm)
    ;checkEvents(tid, 1, none)
	
EndEvent

Event OnSexLabEnd(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLab
		Debug.Notification("Triggers: Critical error")
		Return
	EndIf
	
	If !bEnabled
		Return
	EndIf
	
    int tid = _args as int
    ;sslThreadController thread = Sexlab.GetController(tid)
    
	HandleSexLabCheckEvents(tid, none, _trigger_cache_OnSexLabEnd)
    ;checkEvents(tid, 2, none)

EndEvent

Event OnSexLabOrgasmS(Form ActorRef, Int Thread)
;(String _eventName, String _args, Float _argc, Form _sender)
	if !Self || !SexLab
		Debug.Notification("Triggers: Critical error")
		Return
	EndIf
	
	If !bEnabled
		Return
	EndIf
	
    int tid = Thread
    ;sslThreadController thread = Sexlab.GetController(tid)
    
	HandleSexLabCheckEvents(tid, ActorRef as Actor, _trigger_cache_OnSexLabOrgasmS)
    ;checkEvents(tid, 3, ActorRef as Actor)
	
EndEvent

Event OnTopOfTheHour(String eventName, string strArg, Float fltArg, Form sender)
	if !self
		Debug.Notification("Triggers: Critical error")
		Return
	endif
	
	If !bEnabled
		Return
	EndIf
	
	HandleTopOfTheHour(_trigger_cache_OnTopOfTheHour)
	;checkEvents(-1, 4, PlayerRef)
EndEvent


Event OnKeyDown(Int KeyCode)
	if !self
		Debug.Notification("Triggers: Critical error")
		Return
	endif
	
	If !bEnabled
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
	
	HandleOnKeyDown(_trigger_cache_OnKeyDown)
EndEvent

; WHERE WE ACTUALLY GET DOWN TO BUSINESS
Function HandleTopOfTheHour(string[] slotNoPrefixList)
	int i = 0
	string value
	while i < slotNoPrefixList.Length
		if CheckEventChance(slotNoPrefixList[i])
			value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 9))
			if value
				startCommand(PlayerRef, value)
			endIf
			value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 10))
			if value
				startCommand(PlayerRef, value)
			endIf
			value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 11))
			if value
				startCommand(PlayerRef, value)
			endIf
		endif
		i += 1
	endwhile
EndFunction

Function HandleSexLabCheckEvents(int tid, Actor specActor, string[] slotNoPrefixList)
	sslThreadController thread = Sexlab.GetController(tid)
	;MiscUtil.PrintConsole("Chance:" + slotPre)
	int actorCount = thread.Positions.Length
	
	int i = 0
	bool triggerChanceSucceeded
	while i < slotNoPrefixList.Length
		string value
		int    ival
		bool   doRun
		int    actorIdx = 0
		
		if CheckEventChance(slotNoPrefixList[i])
			while actorIdx < actorCount
				Actor theSelf = thread.Positions[actorIdx]
				Actor theOther = none
				
				if actorCount > 1
					theOther = thread.Positions[_actorPos(actorIdx + 1, actorCount)]
				endIf
				
				;MiscUtil.PrintConsole("Actor:" + theSelf)
				doRun = true
				if doRun
					;if eventId == 3 ; spec check for separate orgasm
						; no need for the eventId, if you use 'specActor' it will only operate for that
						; actor in the scene
						if specActor && theSelf != specActor
							doRun = false
						endIf
					;endIf
				endIf
				
				;/
				; no longer necessary as a) we isolate only SexLab events here 
				; and b) the only event specific check is right above us, go read the note
				if doRun
					ival = JsonUtil.GetStringValue(SLTCFG.SettingsName, _makeSlotIdFromPrefix(slotNoPrefixList[i], 2)) as int
					if ival != eventId
						doRun = false
					endIf
				endIf
				/;
				
				if doRun
					value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 3))
					ival = value as int
					if value && ival != 0 ; 0 is Any
						if ival == 1 && actorRace(theSelf) != 2 ; should be humanoid
							doRun = false
						elseIf ival == 2 && actorRace(theSelf) != 4 ; should be creature
							doRun = false
						elseIf ival == 3 && actorRace(theSelf) != 3 ; should be undead
							doRun = false
						else
							;check other
							if actorCount <= 1 ; is solo, Partner is auto-false
								doRun = false
							else
								if ival == 4 && actorRace(theOther) != 2 ; should be humanoid
									doRun = false
								elseIf ival == 5 && actorRace(theOther) != 4 ; should be creature
									doRun = false
								elseIf ival == 6 && actorRace(theOther) != 3 ; should be undead
									doRun = false
								endIf
							endIf
						endIf
					endIf
				endIf
				
				if doRun
					value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 12))
					ival = value as int
					if value && ival != 0 ; 0 is Any
						if ival == 1 && actorRace(theSelf) != 1 ; should be player
							doRun = false
						elseIf ival == 2 && actorRace(theSelf) == 1 ; should be not-player
							doRun = false
						else
							; check other
							if actorCount <= 1
								doRun = false
							else
								if ival == 3 && actorRace(theOther) != 1 ; should be player
									doRun = false
								elseIf ival == 4 && actorRace(theOther) == 1 ; should be not-player
									doRun = false
								endIf
							endIf
						endIf
					endIf
				endIf
				
				if doRun
					value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 4))
					;MiscUtil.PrintConsole("Role: " + slotPre + ", " + value)
					ival = value as int
					if value && ival != 0 ; 0 is Any
						if value == 1 && !thread.IsAggressor(theSelf) ; aggresor
							doRun = false
						elseIf value == 2 && !thread.IsVictim(theSelf) ; victim
							doRun = false
						elseIf value == 3 && thread.IsAggressive ; not
							doRun = false
						endIf
					endIf
				endIf
				
				if doRun
					value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 5))
					ival = value as int
					if value && ival != 0 ; 0 is Any
						if ival == 1 && Sexlab.GetGender(theSelf) != 0
							doRun = false
						elseIf ival == 2 && Sexlab.GetGender(theSelf) != 1
							doRun = false
						endIf
					endIf
				endIf
				if doRun
					value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 6))
					ival = value as int
					if value && ival != 0 ; 0 is Any
						if ival == 1 && !thread.IsVaginal
							doRun = false
						elseIf ival == 2 && !thread.IsAnal
							doRun = false
						elseIf ival == 3 && !thread.IsOral
							doRun = false
						endIf
					endIf
				endIf
				if doRun
					value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 7))
					ival = value as int
					if value && ival != 0 ; 0 is Any
						if ival == 1 && dayTime() != 1
							doRun = false
						elseIf ival == 2 && dayTime() != 2
							doRun = false
						endIf
					endIf
				endIf
				if doRun
					value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 8))
					ival = value as int
					if value && ival != 0 ; 0 is Any
						if ival == 1 && !theSelf.IsInInterior()
							doRun = false
						elseIf ival == 2 && theSelf.IsInInterior()
							doRun = false
						endIf
					endIf
				endIf
				if doRun
					value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 16))
					ival = value as int
					if value && ival != 0 ; 0 is Any
						int _slposition = 0
						while doRun && _slposition < thread.Positions.Length
							if (_slposition + 1) > ival
								doRun = false
							else
								Actor slActor = thread.Positions[_slposition]
								; the assumption is that ival is 1-based and _slposition is 0-based
								if slActor == theSelf
									if (_slposition + 1) != ival
										doRun = false
									endif
								endif
							endif
							_slposition += 1
						endwhile
					endIf
				endIf
				
				if doRun ;do doRun
					value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 9))
					if value
						startCommand(theSelf, value, tid)
					endIf
					value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 10))
					if value
						startCommand(theSelf, value, tid)
					endIf
					value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 11))
					if value
						startCommand(theSelf, value, tid)
					endIf
				endIf
					
				actorIdx += 1
			endWhile
		endif
		
		i += 1
	endwhile
EndFunction

Function HandleOnKeyDown(string[] slotNoPrefixList)
	; all we know at this point is that at least one of the keys of interest were pressed
	; now we iterate all of the triggers (by slotnoprefix), check the status array against their
	; settings, and execute or skip
	int i = 0
	bool doRun
	bool dakused
	int ival
	int statusidx
	string value
	
	while i < slotNoPrefixList.Length
		doRun = true
		dakused = false
		
		ival = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 13)) as int
		statusidx = _keycodes_of_interest.Find(ival)
		
		; check keycode status, must be true
		if statusidx < 0
			doRun = false
		else
			doRun = _keycode_status[statusidx]
		endif
		
		; check dynamic activation key if in use and specified
		if doRun && DAKAvailable && JsonUtil.HasStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 15))
			ival = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 15)) as int
			doRun = ival as bool
			if doRun
				; if they had DAK setting AND it was true, then dakused is true
				; and doRun is determined by DAK status
				dakused = true
				doRun = DAKStatus.GetValue() as bool
			endif
		endif
		
		; check modifier status only if specified
		; if dakused, we do not try to manage via modifier
		if doRun && !dakused && JsonUtil.HasStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 14))
			ival = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 14)) as int
			
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
			value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 9))
			if value
				startCommand(PlayerRef, value)
			endIf
			value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 10))
			if value
				startCommand(PlayerRef, value)
			endIf
			value = JsonUtil.GetStringValue(SLTCFG.SettingsName, SLTCFG._makeSlotIdFromPrefix(slotNoPrefixList[i], 11))
			if value
				startCommand(PlayerRef, value)
			endIf
		endif
		
		i += 1
	endwhile
EndFunction

Int Function getNextCSpell(Actor _actor)
	Int idx
	
	idx = 0
	While idx < customEffects.Length
		If !_actor.HasMagicEffect(customEffects[idx])
			Return idx
		EndIf
		idx += 1
	EndWhile
	
	Return -1
EndFunction

Function PushAMEValues(Actor _theActor, string cmd, int tid = -1)
	string sumoextension = "sl_triggersCmd(" + NextOneUp() + ")"
	
	SUMO_IntSetF(_theActor, SUMO_MakeKey(sumoextension, "tid"), tid)
	SUMO_StringSetF(_theActor, SUMO_MakeKey(sumoextension, "cmd"), cmd)
	
	if SexLab
		SUMO_FormSetF(_theActor, SUMO_MakeKey(sumoextension, "sexlab"), SexLab)
		SUMO_FormSetF(_theActor, SUMO_MakeKey(sumoextension, "sexlabanimatingfaction"), SexLabAnimatingFaction)
	endif
	
	PushSUMOExtensionF(_theActor, sumoextension)
EndFunction

Function startCommand(Actor _actor, string cmdName, int tid = -1)
    ;MiscUtil.PrintConsole("Run: " + _actor + ", " + tid + ", " + cmdName)
    
    int idxSpell = getNextCSpell(_actor)
    
    if idxSpell < 0
        MiscUtil.PrintConsole("Too many effects on: " + _actor)
		return
    endIf
    
    ;MiscUtil.PrintConsole("Run: spell: " + idxSpell)
    
	
	PushAMEValues(_actor, SLTCFG.CommandsFolder + "/" + cmdName, tid)
	customSpells[idxSpell].RemoteCast(_actor, _actor, _actor)
    
	;wait for effect to start. but not for too long
	; should no longer be necessary as we are using a queue that is enqueued before
	; cast, and each AME dequeues from it as it comes alive
	; the queue is in a known location attached to the caster (i.e. the 'home')
	; of the AME
	
    ;MiscUtil.PrintConsole("Wait: ")
	;int iWaitCount = 0
	;While iWaitCount < 20 && StorageUtil.HasIntValue(_actor, "slu:tid")
		;Utility.Wait(0.2)
		;iWaitCount += 1
        ;MiscUtil.PrintConsole("Wait: " + iWaitCount)
	;EndWhile

EndFunction
