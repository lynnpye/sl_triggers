scriptname sl_triggersCmdLibCore

import sl_triggersStatics

sl_triggersExtensionCore Function GetExtension() global
    return Game.GetFormFromFile(0x1111, "sl_triggers.esp") as sl_triggersExtensionCore
EndFunction

function hextun_test(Actor CmdTargetActor, string[] param, ActiveMagicEffect CmdPrimary) global
    DebMsg("hextun_test: core")
endFunction

function toh_elapsed_time(Actor CmdTargetActor, string[] param, ActiveMagicEffect _CmdPrimary) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    CmdPrimary.MostRecentResult = GetExtension().TohElapsedTime as string
endFunction

function actual_hours_since_last_top(Actor CmdTargetActor, string[] param, ActiveMagicEffect _CmdPrimary) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    toh_elapsed_time(CmdTargetActor, param, CmdPrimary)
endFunction