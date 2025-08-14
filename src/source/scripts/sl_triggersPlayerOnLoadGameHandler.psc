scriptname sl_triggersPlayerOnLoadGameHandler extends ReferenceAlias

import sl_triggersStatics

sl_triggersMain			Property SLT Auto
sl_triggersExtensionCore Property SLTCore Auto Hidden

Keyword kwdVampire
Race raceVampireLord
Race raceWerewolf
Race PriorRace
bool wasVampire
bool wasVampireLord
bool wasWerewolf

Event OnPlayerLoadGame()
	SLT.SLTPLYREF = self

	if !kwdVampire
		kwdVampire = Keyword.GetKeyword("Vampire")
		raceVampireLord = sl_triggers.GetForm("DLC1VampireBeastRace") as Race
		raceWerewolf = sl_triggers.GetForm("WerewolfBeastRace") as Race
		UpdatePriorRace(GetActorReference().GetRace())
	endif

	SLT.DoPlayerLoadGame()
	InitiateConsoleHook()
EndEvent

Event OnInit()
	SLT.SLTPLYREF = self

	kwdVampire = Keyword.GetKeyword("Vampire")
	raceVampireLord = sl_triggers.GetForm("DLC1VampireBeastRace") as Race
	raceWerewolf = sl_triggers.GetForm("WerewolfBeastRace") as Race
	UpdatePriorRace(GetActorReference().GetRace())
	
	InitiateConsoleHook()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	SLTCore.HandleLocationChanged(akOldLoc, akNewLoc)
EndEvent

Event OnPlayerFastTravelEnd(float afTravelGameTimeHours)
	SLTCore.HandleFastTravel()
EndEvent

Event OnLycanthropyStateChanged(bool abIsWerewolf)
	if abIsWerewolf
		SLTCore.HandleLycanthropy(true, false, false, false)
	else
		SLTCore.HandleLycanthropy(false, true, false, false)
	endif
EndEvent

;/
Event OnVampirismStateChanged(bool abIsVampire)
	SLTDebugMsg("OnVampirismStateChanged (" + abIsVampire + ")")
EndEvent
/;

Event OnRaceSwitchComplete()
	Race newRace = GetActorReference().GetRace()
	bool isVampire = newRace.HasKeyword(kwdVampire)
	bool isVampireLord = newRace == raceVampireLord
	bool isWerewolf = newRace == raceWerewolf

	If (wasVampire != isVampire)
		if isVampire
			SLTCore.HandleVampirism(true, false, false, false)
		else
			SLTCore.HandleVampirism(false, true, false, false)
		endif
	EndIf

	If (wasVampireLord != isVampireLord)
		if isVampireLord
			SLTCore.HandleVampirism(false, false, true, false)
		else
			SLTCore.HandleVampirism(false, false, false, true)
		endif
	EndIf

	If (wasWerewolf != isWerewolf)
		if isWerewolf
			SLTCore.HandleLycanthropy(false, false, true, false)
		else
			SLTCore.HandleLycanthropy(false, false, false, true)
		endif
	EndIf

	UpdatePriorRace(newRace)
EndEvent

Event OnVampireFeed(Actor akTarget)
	SLTCore.HandleVampireFeeding(akTarget)
EndEvent

Function UpdatePriorRace(Race newRace)
	PriorRace = newRace
	wasVampire = PriorRace.HasKeyword(kwdVampire)
	wasVampireLord = PriorRace == raceVampireLord
	wasWerewolf = PriorRace == raceWerewolf
EndFunction

Function InitiateConsoleHook()
    if SKSE.GetPluginVersion("ConsoleUtilSSE") != -1
		; Per ConsoleUtil Extended documentation:
		; The scripts API version (will return 777 or greater for ConsoleUtil Extended)
        if ConsoleUtil.GetVersion() < 777
			; So only do our pseudo hook if the far superior option of CUE is not available
			UnregisterForMenu("Console")
			RegisterForMenu("Console")
		else
			UnregisterForMenu("Console")
        endIf
    endIf
EndFunction
 
Event OnMenuOpen(string menuName)
	if menuName=="Console"
		RegisterForKey(28)
		RegisterForKey(156)
	endif
endEvent
 
Event OnMenuClose(string menuName)
	if menuName=="Console"
		UnregisterForKey(28)
		UnregisterForKey(156)
	endif
endEvent
 
Event OnKeyDown(int keyCode)
	if keyCode==28 || keyCode==156
		int cmdCount = UI.GetInt("Console", "_global.Console.ConsoleInstance.Commands.length")
		if cmdCount>0
			cmdCount-=1
			string cmdLine = UI.GetString("Console","_global.Console.ConsoleInstance.Commands." + cmdCount)
			if cmdLine != ""
				string[] cmd = sl_triggers.Tokenize(cmdLine)

				if cmd[0] == "slt" || cmd[0] == "sl_triggers"
					string subcommand = cmd[1]

					int consoleLinesToSkip = 0

					if subcommand
						Actor _theActor = Game.GetCurrentConsoleRef() as Actor
						if !_theActor
							_theActor = Game.GetCurrentCrosshairRef() as Actor
							if !_theActor
								_theActor = Game.GetPlayer()
							endif
						endif

						if subcommand == "version"
							MiscUtil.PrintConsole("SLT version: " + GetModVersion())
							consoleLinesToSkip += 1
						elseif subcommand == "list"
							string[] commandsList = sl_triggers.GetScriptsList()
							int i = 0
							MiscUtil.PrintConsole("SLT Scripts List Start:")
							consoleLinesToSkip += 1
							while i < commandsList.Length
								MiscUtil.PrintConsole(commandsList[i])
								consoleLinesToSkip += 1
								i += 1
							endwhile
							MiscUtil.PrintConsole("SLT Scripts List End:")
							consoleLinesToSkip += 1
						elseif subcommand == "run"
							string _thescriptname = cmd[2]
							if !_thescriptname
								MiscUtil.PrintConsole("slt run requires a valid scriptname to run")
								consoleLinesToSkip += 1
							else
								MiscUtil.PrintConsole("Sending request to run \"" + _thescriptname + "\" on Actor (" + _theActor.GetDisplayName() + ")")
								consoleLinesToSkip += 1
								_theActor.SendModEvent(EVENT_SLT_REQUEST_COMMAND(), _thescriptname)
							endif
						else
							subcommand = ""
						endif
					endif

					if !subcommand
						MiscUtil.PrintConsole("Usage: slt version          ; displays sl_triggers mod version")
						MiscUtil.PrintConsole("Usage: slt list             ; lists the scripts available to run from SLT")
						MiscUtil.PrintConsole("Usage: slt run <scriptname> ; where <scriptname> is a valid script for SLT")
						consoleLinesToSkip += 3
					endif
					
					; Remove last line (error line)
					Utility.WaitMenuMode(0.1)
					string history = UI.GetString("Console","_global.Console.ConsoleInstance.CommandHistory.text")
					int iHistory = StringUtil.GetLength(history) - 1
					bool bRunning = true
					int pickup = -1
					while iHistory > 0 && bRunning == true
						if StringUtil.AsOrd(StringUtil.GetNthChar(history,iHistory - 1)) == 13
							if consoleLinesToSkip > 0
								consoleLinesToSkip -= 1
								if consoleLinesToSkip < 1
									pickup = iHistory
								endif
								iHistory -= 1
							else
								bRunning = false
							endif
						else
							iHistory -= 1
						endif
					endWhile
					string newconsoletext = StringUtil.Substring(history,0,iHistory)
					if pickup > 0
						newconsoletext += StringUtil.Substring(history, pickup)
					endif
					UI.SetString("Console", "_global.Console.ConsoleInstance.CommandHistory.text", newconsoletext)
				endif
			endif
		endif
	endif
endEvent