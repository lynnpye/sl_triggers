scriptname sl_triggersCmdLibAdult

import sl_triggersStatics

; sltname df_resetall
; sltgrup Devious Followers
; sltdesc Resets all Devious Followers values (i.e. quest states, deal states, boredom, debt)
; sltdesc back to values as if having just started out.
; sltsamp df_resetall
; sltrslt Should be free of all debts, deals, and rules
function df_resetall(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        Form dfMCM_form = GetForm_DeviousFollowers_MCM()

        if dfMCM_form
            _DFlowMCM dfMCM = dfMCM_form as _DFlowMCM
            dfMCM.ResetQuests(true)
        else
            CmdPrimary.SFE("df_resetall: Unable to retrieve the DeviousFollowers MCM Form using (" + GetModFilename_DeviousFollowers_MCM() + ":" + GetRelativeFormID_DeviousFollowers_MCM() + ")")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname df_setdebt
; sltgrup Devious Followers
; sltdesc Sets current debt to the specified amount
; sltargs newdebt: new debt value
; sltsamp df_setdebt 0
; sltrslt We all know what you are going to use it for
function df_setdebt(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Form dfQuest_form = GetForm_DeviousFollowers_dfQuest()

        if dfQuest_form
            QF__Gift_09000D62 dfQuest = dfQuest_form as QF__Gift_09000D62
            if dfQuest
                int debt = CmdPrimary.ResolveInt(param[1])
                dfQuest.SetDebt(debt)
            endif
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname dd_unlockslot
; sltgrup Devious Devices
; sltdesc Attempts to unlock any device in the specified slot
; sltargs actor: target Actor
; sltargs armorslot: int value armor slot e.g. 32 is body armor
; sltargs force: "force" to force an unlock, anything else otherwise
; sltsamp dd_unlockslot $self 32 force
; sltrslt Should remove anything in body slot e.g. corset, harness, etc., and forced, so including quest items (be careful!)
function dd_unlockslot(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 5)
        zadLibs ddlib = GetForm_DeviousDevices_zadLibs() as zadLibs
        
        if ddlib
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            if _targetActor
                bool force = (param.Length > 3 && CmdPrimary.ResolveString(param[3]) == "force")
                int i = CmdPrimary.ResolveInt(param[2])

                Armor device = _targetActor.GetEquippedArmorInSlot(i)
                if device
                    Keyword ddkeyword = ddlib.GetDeviceKeyword(device)
                    if ddkeyword
                        Armor renderedDevice = ddlib.GetRenderedDevice(device)
                        if renderedDevice && (force || (!renderedDevice.HasKeyWord(ddlib.zad_QuestItem) && !device.HasKeyword(ddlib.zad_QuestItem)))
                            ddlib.UnlockDevice(_targetActor, device, renderedDevice)
                        endif
                    endif
                endif
            endif
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname dd_unlockall
; sltgrup Devious Devices
; sltdesc Attempts to unlock all devices locked on the actor
; sltargs actor: target Actor
; sltargs force: "force" to force an unlock, anything else otherwise
; sltsamp dd_unlockall $self force
; sltrslt Will attempt to (forcibly if necessary, e.g. quest locked items) unlock all lockable items on targeted actor.
function dd_unlockall(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 4)
        zadLibs ddlib = GetForm_DeviousDevices_zadLibs() as zadLibs

        if ddlib
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            if _targetActor
                bool force = (param.Length > 2 && CmdPrimary.ResolveString(param[2]) == "force")
                bool lockable
                int i = 0
                Armor device
                Armor renderedDevice
                while i < 61
                    device = _targetActor.GetEquippedArmorInSlot(i)
                    if device
                        renderedDevice = ddlib.GetRenderedDevice(device)
                        lockable = device.HasKeyword(ddlib.zad_lockable) || renderedDevice.HasKeyword(ddlib.zad_lockable)

                        if lockable && (force || (!(renderedDevice && renderedDevice.HasKeyWord(ddlib.zad_QuestItem)) && !device.HasKeyword(ddlib.zad_QuestItem)))
                            ddlib.UnlockDevice(_targetActor, device, renderedDevice)
                        endif
                    endif
            
                    i += 1
                endwhile
            endif
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_get_version
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Returns the version of SexLabAroused or OSLAroused
; sltsamp sla_get_version
; sltsamp msg_console "Version is: " $$
function sla_get_version(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentIntResult = sl_triggersAdapterSLA.GetVersion()

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_get_arousal
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Returns the current arousal of the actor as an int
; sltargs actor: target Actor
; sltsamp sla_get_arousal
function sla_get_arousal(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterSLA.GetArousal(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentIntResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_get_exposure
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Returns the current exposure level of the actor as an int
; sltargs actor: target Actor
; sltsamp sla_get_exposure $system.self
function sla_get_exposure(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterSLA.GetExposure(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentIntResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_set_exposure
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Sets the exposure for the target actor and returns the new amount as an int
; sltargs actor: target Actor
; sltargs exposureAmount: int; amount of exposure update to set
; sltsamp sla_set_exposure $system.self 25
function sla_set_exposure(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        int value = CmdPrimary.ResolveInt(param[2])
        if _targetActor
            newResult = sl_triggersAdapterSLA.SetExposure(_targetActor, value)
        endif
    endif

    CmdPrimary.MostRecentIntResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_update_exposure
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Updates the exposure for the target actor and returns the updated amount as an int.
; sltdesc This uses the API, not a modevent directly (though the API may still be sending a modevent behind the scenes)
; sltargs actor: target Actor
; sltargs exposureAmount: int; amount of exposure update to apply
; sltsamp sla_update_exposure $system.self 5
function sla_update_exposure(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        int value = CmdPrimary.ResolveInt(param[2])
        if _targetActor
            newResult = sl_triggersAdapterSLA.UpdateExposure(_targetActor, value)
        endif
    endif

    CmdPrimary.MostRecentIntResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_send_exposure_event
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Sends the "slaUpdateExposure" modevent. No return value.
; sltargs actor: target Actor
; sltargs exposureAmount: float; amount of exposure update to send
; sltsamp sla_send_exposure_event $system.self 5.0
function sla_send_exposure_event(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        float value = CmdPrimary.ResolveFloat(param[2])
        if _targetActor
            sl_triggersAdapterSLA.SendUpdateExposureEvent(_targetActor, value)
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_get_actor_days_since_last_orgasm
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Returns the days since the actor last had an orgasm as a float
; sltargs actor: target Actor
; sltsamp sla_get_actor_days_since_last_orgasm $system.self
function sla_get_actor_days_since_last_orgasm(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterSLA.GetActorDaysSinceLastOrgasm(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_get_actor_hours_since_last_sex
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Returns the in-game hours since the actor last had sex as an int
; sltargs actor: target Actor
; sltsamp sla_get_actor_hours_since_last_sex $system.self
function sla_get_actor_hours_since_last_sex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterSLA.GetActorHoursSinceLastSex(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentIntResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_get_arousal
; sltgrup OSLAroused
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.GetArousal()
; sltargs actor: target Actor
; sltsamp osla_get_arousal $self
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
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.GetArousal()
; sltargs actor: target Actor
; sltsamp osla_get_arousal_multiplier $self
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
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.GetArousal()
; sltargs actor: target Actor
; sltsamp osla_get_exposure $self
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
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.GetArousal()
; sltargs actor: target Actor
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
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.ModifyArousal(Actor, float, string)
; sltargs actor: target Actor
; sltargs value: float value
; sltargs reason: string, optional (default "unknown")
; sltsamp osla_modify_arousal $self 20.0 "for reasons"
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
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.SetArousal(Actor, float, string)
; sltargs actor: target Actor
; sltargs value: float value
; sltargs reason: string, optional (default "unknown")
; sltsamp osla_set_arousal $self 50.0 "for reasons"
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
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.ModifyArousalMultiplier(Actor, float, string)
; sltargs actor: target Actor
; sltargs value: float value
; sltargs reason: string, optional (default "unknown")
; sltsamp osla_modify_arousal_multiplier $self 0.5 "for reasons"
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
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.SetArousalMultiplier(Actor, float, string)
; sltargs actor: target Actor
; sltargs value: float value
; sltargs reason: string, optional (default "unknown")
; sltsamp osla_set_arousal_multiplier $self 2.0 "for reasons"
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

