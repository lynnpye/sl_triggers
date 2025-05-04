scriptname sl_triggersCmdLibCore

import sl_triggersStatics

sl_triggersExtensionCore Function GetExtension() global
    return Game.GetFormFromFile(0xD62, "sl_triggers.esp") as sl_triggersExtensionCore
EndFunction

; sltname toh_elapsed_time
; sltgrup Core
; sltdesc Returns the actual game time passed at the time of the last "Top of the Hour"
; sltdesc For example, if you slept from 1:30 to 4:00, you would get a Top of the Hour event at 4 with a value of 2.5
; sltsamp toh_elapsed_time
; sltrslt $$ would contain the actual elapsed game time from the previous "Top of the Hour" event
function toh_elapsed_time(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    CmdPrimary.MostRecentResult = GetExtension().TohElapsedTime as string
endFunction