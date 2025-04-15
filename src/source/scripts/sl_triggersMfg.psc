Scriptname sl_TriggersMfg Hidden

Function mfg_reset(Actor _a) global
    if SKSE.GetPluginVersion("MfgFix") != -1
        MfgConsoleFunc.SetPhonemeModifier(_a, -1, 0, 0)
        return
    endIf
    MiscUtil.PrintConsole("MfgFix not found")    
EndFunction

Function mfg_SetPhonemeModifier(Actor _a, int mode, int id, int value) global
    if SKSE.GetPluginVersion("MfgFix") != -1
        MfgConsoleFunc.SetPhonemeModifier(_a, mode, id, value)
        return
    endIf  
    MiscUtil.PrintConsole("MfgFix not found")
EndFunction

int Function mfg_GetPhonemeModifier(Actor _a, int mode, int id) global
    if SKSE.GetPluginVersion("MfgFix") != -1
        return MfgConsoleFunc.GetPhonemeModifier(_a, mode, id)
    endIf  
    MiscUtil.PrintConsole("MfgFix not found")
    return -1
EndFunction
