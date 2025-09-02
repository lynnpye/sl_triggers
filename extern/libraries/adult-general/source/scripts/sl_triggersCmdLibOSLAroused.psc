scriptname sl_triggersCmdLibOSLAroused

import sl_triggersStatics

; sltname osla_get_arousal
; sltgrup OSLAroused
; sltdesc Returns: float: the result of OSLAroused_ModInterface.GetArousal()
; sltargs Form: actor: target Actor
; sltsamp osla_get_arousal $system.self
; sltsamp msg_console "Arousal is: " $$
function osla_get_arousal(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterOSLA.GetArousal(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_get_arousal_multiplier
; sltgrup OSLAroused
; sltdesc Returns: float: the result of OSLAroused_ModInterface.GetArousal()
; sltargs Form: actor: target Actor
; sltsamp osla_get_arousal_multiplier $system.self
; sltsamp msg_console "Arousal multiplier is: " $$
function osla_get_arousal_multiplier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterOSLA.GetArousalMultiplier(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_get_exposure
; sltgrup OSLAroused
; sltdesc Returns: float: the result of OSLAroused_ModInterface.GetArousal()
; sltargs Form: actor: target Actor
; sltsamp osla_get_exposure $system.self
; sltsamp msg_console "Exposure is: " $$
function osla_get_exposure(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterOSLA.GetExposure(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_get_actor_days_since_last_orgasm
; sltgrup OSLAroused
; sltdesc Returns: float: the result of OSLAroused_ModInterface.GetArousal()
; sltargs Form: actor: target Actor
; sltsamp osla_get_actor_days_since_last_orgasm $self
; sltsamp msg_console "Arousal is: " $$
function osla_get_actor_days_since_last_orgasm(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterOSLA.GetActorDaysSinceLastOrgasm(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_modify_arousal
; sltgrup OSLAroused
; sltdesc Returns: float: the result of OSLAroused_ModInterface.ModifyArousal(Actor, float, string)
; sltargs Form: actor: target Actor
; sltargs float: value: value
; sltargs string: reason: optional (default "unknown")
; sltsamp osla_modify_arousal $system.self 20.0 "for reasons"
function osla_modify_arousal(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            float value = CmdPrimary.ResolveFloat(param[2])
            string reason
            if param.Length > 3
                reason = CmdPrimary.ResolveString(param[3])
            endif
            newResult = sl_triggersAdapterOSLA.ModifyArousal(_targetActor, value, reason)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_set_arousal
; sltgrup OSLAroused
; sltdesc Returns: float: the result of OSLAroused_ModInterface.SetArousal(Actor, float, string)
; sltargs Form: actor: target Actor
; sltargs float: value: value
; sltargs string: reason: optional (default "unknown")
; sltsamp osla_set_arousal $system.self 50.0 "for reasons"
function osla_set_arousal(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            float value = CmdPrimary.ResolveFloat(param[2])
            string reason
            if param.Length > 3
                reason = CmdPrimary.ResolveString(param[3])
            endif
            newResult = sl_triggersAdapterOSLA.SetArousal(_targetActor, value, reason)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_modify_arousal_multiplier
; sltgrup OSLAroused
; sltdesc Returns: float: the result of OSLAroused_ModInterface.ModifyArousalMultiplier(Actor, float, string)
; sltargs Form: actor: target Actor
; sltargs float: value: value
; sltargs string: reason: optional (default "unknown")
; sltsamp osla_modify_arousal_multiplier $system.self 0.5 "for reasons"
function osla_modify_arousal_multiplier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            float value = CmdPrimary.ResolveFloat(param[2])
            string reason
            if param.Length > 3
                reason = CmdPrimary.ResolveString(param[3])
            endif
            newResult = sl_triggersAdapterOSLA.ModifyArousalMultiplier(_targetActor, value, reason)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_set_arousal_multiplier
; sltgrup OSLAroused
; sltdesc Returns: float: the result of OSLAroused_ModInterface.SetArousalMultiplier(Actor, float, string)
; sltargs Form: actor: target Actor
; sltargs float: value: value
; sltargs string: reason: optional (default "unknown")
; sltsamp osla_set_arousal_multiplier $system.self 2.0 "for reasons"
function osla_set_arousal_multiplier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            float value = CmdPrimary.ResolveFloat(param[2])
            string reason
            if param.Length > 3
                reason = CmdPrimary.ResolveString(param[3])
            endif
            newResult = sl_triggersAdapterOSLA.SetArousalMultiplier(_targetActor, value, reason)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

