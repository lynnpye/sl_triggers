scriptname sl_triggersAdapterSLIF

import sl_triggersStatics

int Function GetVersion() global
    return SLIF_Main.GetScriptVersion()
EndFunction

string Function GetVersionString() global
    return SLIF_Main.GetScriptVersionString()
EndFunction

bool Function IsInstalled() global
    return SLIF_Main.IsInstalled()
EndFunction

bool Function IsUpdating() global
    return SLIF_Main.IsUpdating()
EndFunction

bool Function IsWorking() global
    return SLIF_Main.IsWorking()
EndFunction

bool Function IsInMaintenance() global
    return SLIF_Main.IsInMaintenance()
EndFunction

Function Inflate(Actor kActor, string modName, string node, float value, string oldModName = "") global
    SLIF_Main.inflate(kActor, modName, node, value, -1, -1, oldModName)
EndFunction

Function RegisterActor(Actor kActor, string modName, string node = "", string oldModName = "", float min = -1.0, float max = -1.0, float mult = -1.0, float incr = -1.0) global
    SLIF_Main.registerActor(kActor, modName, node, -1, oldModName, min, max, mult, incr)
EndFunction

Function UnregisterActor(Actor kActor, string modName) global
    SLIF_Main.UnregisterActor(kActor, modName)
EndFunction

Function UpdateActor(Actor kActor, string modName, string node = "", string oldModName = "", float min = -1.0, float max = -1.0, float mult = -1.0, float incr = -1.0) global
    SLIF_Main.UpdateActor(kActor, modName, node, -1, -1, -1, oldModName, min, max, mult, incr)
EndFunction

Function ResetActor(Actor kActor, string modName, string node = "", float value = 1.0, string oldModName = "", float min = -1.0, float max = -1.0, float mult = -1.0, float incr = -1.0) global
    SLIF_Main.resetactor(kActor, modName, node, value, -1, -1, -1, oldModName, min, max, mult, incr)
EndFunction

Function HideNode(Actor kActor, string modName, string node, float value = 0.0000001, string oldModName = "") global
    SLIF_Main.hidenode(kActor, modName, node, value, oldModName)
EndFunction

Function ShowNode(Actor kActor, string modName, string node) global
    SLIF_Main.shownode(kActor, modName, node)
EndFunction

bool Function IsNodeHidden(Actor kActor, string node) global
    return SLIF_Main.IsNodeHidden(kActor, node)
EndFunction

int Function GetGender(Actor kActor, int gender = -1) global
    return SLIF_Main.GetGender(kActor, gender)
EndFunction

Function SetDefaultValues(Actor kActor, String modName, String node, float min = 0.0, float max = 100.0, float mult = 1.0, float incr = 0.1) global
    SLIF_Main.SetMinMaxMultIncrValue(kActor, modName, node, min, max, mult, incr)
EndFunction

float Function GetValue(Actor kActor, string modName, string node, float default = 0.0) global
    return SLIF_Main.GetValue(kActor, modName, node, default)
EndFunction

float Function GetMinValue(Actor kActor, string modName, string node, float default = 0.0) global
    return SLIF_Main.GetMinValue(kActor, modName, node, default)
EndFunction

float Function GetMaxValue(Actor kActor, string modName, string node, float default = 100.0) global
    return SLIF_Main.GetMaxValue(kActor, modName, node, default)
EndFunction

float Function GetMultValue(Actor kActor, string modName, string node, float default = 1.0) global
    return SLIF_Main.GetMultValue(kActor, modName, node, default)
EndFunction

float Function GetIncrValue(Actor kActor, string modName, string node, float default = 0.1) global
    return SLIF_Main.GetIncrValue(kActor, modName, node, default)
EndFunction