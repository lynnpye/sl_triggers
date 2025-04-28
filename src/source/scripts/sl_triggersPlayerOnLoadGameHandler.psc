scriptname sl_triggersPlayerOnLoadGameHandler extends ReferenceAlias

import sl_triggersStatics

sl_triggersMain			Property SLT Auto

Event OnPlayerLoadGame()
	SLT.DoOnPlayerLoadGame()
	UnregisterForMenu("Console")
	RegisterForMenu("Console")
EndEvent

Event OnInit()
	UnregisterForMenu("Console")
	RegisterForMenu("Console")
EndEvent
 
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
				string[] cmd = sl_triggers_internal.SafeTokenize(cmdLine)

				if cmd[0] == "slt" || cmd[0] == "sl_triggers"
					string subcommand = cmd[1]

					int consoleLinesToSkip = 0

					if subcommand
						Actor _theActor = Game.GetCurrentConsoleRef() as Actor
						if !_theActor
							_theActor = Game.GetCurrentCrosshairRef() as Actor
							if !_theActor
								_theActor = GetReference() as Actor
							endif
						endif

						if subcommand == "version"
							MiscUtil.PrintConsole("SLT version: " + GetModVersion())
							consoleLinesToSkip += 1
						elseif subcommand == "list"
							string[] commandsList = SLT.GetCommandsList()
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
						consoleLinesToSkip += 2
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