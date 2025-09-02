scriptname sl_triggersCmdLibCore

import sl_triggersStatics

sl_triggersExtensionCore Function GetExtension() global
    return GetForm_SLT_ExtensionCore() as sl_triggersExtensionCore
EndFunction

; sltname toh_elapsed_time
; sltgrup Core
; sltdesc Returns: float: the actual game time passed at the time of the last "Top of the Hour"
; sltdesc For example, if you slept from 1:30 to 4:00, you would get a Top of the Hour event at 4 with a value of 2.5
; sltsamp ; to get the actual elapsed game time from the previous "Top of the Hour" event
; sltsamp set $timeSinceLastTOHEvent resultfrom toh_elapsed_time
; sltsamp ; this can happen, for example, due to fast travel and sleep events, where multiple hours may pass
function toh_elapsed_time(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentFloatResult = GetExtension().TohElapsedTime

    CmdPrimary.CompleteOperationOnActor()
endFunction