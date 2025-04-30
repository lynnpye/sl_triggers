scriptname sl_triggersCmdLibCore

import sl_triggersStatics

sl_triggersExtensionCore Function GetExtension() global
    return Game.GetFormFromFile(0xD62, "sl_triggers.esp") as sl_triggersExtensionCore
EndFunction

function toh_elapsed_time(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    CmdPrimary.MostRecentResult = GetExtension().TohElapsedTime as string
endFunction

function actual_hours_since_last_top(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    toh_elapsed_time(CmdTargetActor, CmdPrimary, param)
endFunction