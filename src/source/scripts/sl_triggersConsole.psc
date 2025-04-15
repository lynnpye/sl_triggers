Scriptname sl_TriggersConsole Hidden

int Function exec_console(Actor _a, string _cmd) global

    if SKSE.GetPluginVersion("ConsoleUtilSSE") != -1
        if ConsoleUtil.GetVersion() > 0
            ConsoleUtil.SetSelectedReference(_a)
            ConsoleUtil.ExecuteCommand(_cmd)
            return 1
        endIf
    endIf
    
    MiscUtil.PrintConsole("ConsoleUtilSSE not found")
    return 0
    
EndFunction
