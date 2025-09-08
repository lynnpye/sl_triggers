scriptname sl_triggersCmdLibSexLabDependent

import sl_triggersStatics


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;; Devious Follower
;;
;;

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
; sltargs int: newdebt: new debt value
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;; Devious Devices
;;
;;

; sltname dd_unlockslot
; sltgrup Devious Devices
; sltdesc Attempts to unlock any device in the specified slot
; sltargs Form: actor: target Actor
; sltargs int: armorslot: int value armor slot e.g. 32 is body armor
; sltargs string: force: "force" to force an unlock, anything else otherwise
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
; sltargs Form: actor: target Actor
; sltargs string: force: "force" to force an unlock, anything else otherwise
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;; SexLab Aroused/OSLAroused
;;
;;

; sltname sla_get_version
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Returns: int: the version of SexLabAroused or OSLAroused
; sltsamp sla_get_version
; sltsamp msg_console "Version is: " $$
function sla_get_version(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentIntResult = sl_triggersAdapterSLA.GetVersion()

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_get_arousal
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Returns: int: the current arousal of the actor as an int
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
; sltdesc Returns: int: the current exposure level of the actor as an int
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
; sltargs Form: actor: target Actor
; sltargs int: exposureAmount: amount of exposure update to set
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
; sltargs Form: actor: target Actor
; sltargs int: exposureAmount: amount of exposure update to apply
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
; sltargs Form: actor: target Actor
; sltargs float: exposureAmount: amount of exposure update to send
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
; sltdesc Returns: float: the days since the actor last had an orgasm as a float
; sltargs Form: actor: target Actor
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;; SexLab Survival
;;
;;

; sltname sls_block_license_purchase
; sltgrup SexLab Survival
; sltdesc Blocks or unblocks license purchasing
; sltargs Form: blocker: the Form to use as the "blocker"; use $system.forms.sltr_main if you don't have a Form you prefer
; sltargs bool: abBlock: true to block license purchases; false to unblock
; sltsamp sls_block_license_purchase $system.forms.sltr_main true ; the player will no longer be able to purchases licenses
function sls_block_license_purchase(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form blocker = CmdPrimary.ResolveForm(param[1])
        if blocker
            sl_triggersAdapterSLS.block_license_purchase(blocker, CmdPrimary.ResolveBool(param[2]))
        else
            CmdPrimary.SFE("unable to resolve (" + param[1] + ") to Form")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_revoke_license
; sltgrup SexLab Survival
; sltdesc Revokes SexLab Survival licenses
; sltargs string: license: the license to revoke; valid values:
; sltargsmore All - revokes all licenses
; sltargsmore Random - revokes a random license
; sltargsmore Magic
; sltargsmore Weapon
; sltargsmore Armor
; sltargsmore Bikini
; sltargsmore Clothes
; sltargsmore Curfew
; sltargsmore Whore
; sltargsmore Freedom
; sltargsmore Property
; sltsamp sls_revoke_license "All" ; revokes all licenses
; sltsamp sls_revoke_license "Random" ; revokes a license at random
; sltsamp sls_revoke_license "Clothes" ; revokes a Clothes license if it exists
function sls_revoke_license(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        sl_triggersAdapterSLS.revoke_license(CmdPrimary.ResolveString(param[1]))
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_send_to_kennel
; sltgrup SexLab Survival
; sltdesc Send the player to the kennel associated with either the crime_faction_member or the hold specified by parameter; only one needs to provided
; sltargs Form: crime_faction_member: an Actor member of the crime faction (i.e. Hold) where you want the player sent; specify none if you are using the "hold" argument
; sltargs string: hold: the hold you want the player sent to; specify "" if you are using the "crime_faction_member"
; sltargsmore Whiterun
; sltargsmore Solitude
; sltargsmore Markarth
; sltargsmore Windhelm
; sltargsmore Riften
; sltsamp sls_send_to_kennel none "Riften" ; send the player to the Riften kennel
; sltsamp set $windhelm_guard ...fromsomewhere...
; sltsamp sls_send_to_kennel $windhelm_guard "" ; send the player to the Windhelm kennel by specifying a Windhelm guard
function sls_send_to_kennel(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        Form crime_faction_member = CmdPrimary.ResolveForm(param[1])
        string hold
        if param.Length > 2
            hold = CmdPrimary.ResolveString(param[2])
        endif
        sl_triggersAdapterSLS.send_to_kennel(crime_faction_member, hold)
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_evict_from_home
; sltgrup SexLab Survival
; sltdesc Evicts the player from the specified player home
; sltargs int: home: an ID to indicate which home to evict from
; sltargsmore 0 - Whiterun
; sltargsmore 1 - Solitude
; sltargsmore 2 - Markarth
; sltargsmore 3 - Windhelm
; sltargsmore 4 - Riften
; sltargs Form: evict_form: the Form to use as the "evicter"; use $system.forms.sltr_main if you don't have a Form you prefer
; sltargs string: reason: the reason to present to the player for the eviction
; sltsamp ; to evict the player from Solitude
; sltsamp sls_evict_from_home 1 $system.forms.sltr_main "Naughty pets don't get pet houses."
function sls_evict_from_home(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        sl_triggersAdapterSLS.evict_from_home(CmdPrimary.ResolveInt(param[1]), CmdPrimary.ResolveForm(param[2]), CmdPrimary.ResolveString(param[3]))
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_unevict_from_home
; sltgrup SexLab Survival
; sltdesc Unevicts the player from the specified player home, allowing them use of the home once more
; sltargs int: home: an ID to indicate which home to evict from
; sltargsmore 0 - Whiterun
; sltargsmore 1 - Solitude
; sltargsmore 2 - Markarth
; sltargsmore 3 - Windhelm
; sltargsmore 4 - Riften
; sltargs Form: evict_form: the Form to use as the "evicter"; use $system.forms.sltr_main if you don't have a Form you prefer; must be the same as used to evict
; sltsamp ; to unevict the player from Solitude, allowing them use of the home there again
; sltsamp sls_unevict_from_home 1 $system.forms.sltr_main
function sls_unevict_from_home(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        sl_triggersAdapterSLS.unevict_from_home(CmdPrimary.ResolveInt(param[1]), CmdPrimary.ResolveForm(param[2]))
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_increase_ground_time
; sltgrup SexLab Survival
; sltdesc Increases the amount of time the player is "grounded" in a given hold
; sltargs Form: crime_faction_member: an Actor member of the crime faction (i.e. Hold) where the player is to be grounded; specify none if you are using the "hold" argument
; sltargs int: hold: an ID to indicate which hold the player is to be grounded; specify -1 if you are using crime_faction_member (optional; default: -1)
; sltargsmore -1 - Ignore
; sltargsmore 0 - Whiterun
; sltargsmore 1 - Solitude
; sltargsmore 2 - Markarth
; sltargsmore 3 - Windhelm
; sltargsmore 4 - Riften
; sltargs int: days: how many days to ground for (optional: default: 1)
; sltsamp ; to ground the player in Markarth
; sltsamp sls_increase_ground_time none 2 5 ; ground the player in Markarth for 5 days
; sltsamp ; to ground the player in Riften
; sltsamp set $riften_guard ..somehow
; sltsamp sls_increase_ground_time $riften_guard ; ground the player in Riften for 1 day
function sls_increase_ground_time(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        sl_triggersAdapterSLS.unevict_from_home(CmdPrimary.ResolveInt(param[1]), CmdPrimary.ResolveForm(param[2]))
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_remove_magic_curse
; sltgrup SexLab Survival
; sltdesc Removes the SLS magic curse from the target
; sltargs Form: akTarget: the target to remove the magic curse from
; sltsamp sls_remove_magic_curse $system.self
function sls_remove_magic_curse(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        sl_triggersAdapterSLS.remove_magic_curse(CmdPrimary.ResolveForm(param[1]))
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_add_magic_curse
; sltgrup SexLab Survival
; sltdesc Adds the SLS magic curse to the target
; sltargs Form: akTarget: the target to add the magic curse to
; sltsamp sls_add_magic_curse $system.self
function sls_add_magic_curse(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        sl_triggersAdapterSLS.remove_magic_curse(CmdPrimary.ResolveForm(param[1]))
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_swallow_cum
; sltgrup SexLab Survival
; sltdesc Triggers the SLS cum swallow effect
; sltargs Form: cum_source: the source of the cum
; sltargs float: amount: an amount of cum to swallow
; sltargs bool: did_swallow: true if the player tries to swallow everything; false otherwise
; sltargs int add_to_face: how much cum to add to the player's face
; sltargsmore 0 - No cum
; sltargsmore 1 - 1 layer of cum
; sltargsmore 2 - 2 layers of cum
; sltsamp sls_swallow_cum $system.partner 0.5 true 1
function sls_swallow_cum(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        sl_triggersAdapterSLS.remove_magic_curse(CmdPrimary.ResolveForm(param[1]))
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_get_creature_corruption
; sltgrup SexLab Survival
; sltdesc Returns: float: the current amount of creature corruption
; sltsamp set $corruption resultfrom sls_get_creature_corruption
function sls_get_creature_corruption(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        CmdPrimary.MostRecentFloatResult = sl_triggersAdapterSLS.get_creature_corruption()
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_is_enjoying_cum
; sltgrup SexLab Survival
; sltdesc Returns: bool: is the player currently in the state of enjoying cum; varies based on factors like cum addiction, cum hunger
; sltsamp set $enjoying_cum resultfrom sls_is_enjoying_cum
function sls_is_enjoying_cum(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        CmdPrimary.MostRecentBoolResult = sl_triggersAdapterSLS.is_enjoying_cum()
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_get_load_tier
; sltgrup SexLab Survival
; sltdesc Returns: int: the cum load tier of the specified cum_source
; sltargs Form: cum_source: Actor who is the source of the cum load
; sltrslt 0 - tiny - Skeever/Hare
; sltrslt 1 - small - Dog/Wolf
; sltrslt 2 - average - Most playable races
; sltrslt 3 - above average - Orcs/Nords
; sltrslt 4 - big - Troll/Horse/Bear/Sabrecat
; sltrslt 5 - huge - Mammoth
; sltrslt 6 - massive - Dragon
; sltsamp set $load_tier resultfrom sls_get_load_tier $some_npc_or_creature
function sls_get_load_tier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor cum_source = CmdPrimary.ResolveActor(param[1])
        if (cum_source)
            CmdPrimary.MostRecentIntResult = sl_triggersAdapterSLS.get_load_tier(cum_source)
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_get_load_size
; sltgrup SexLab Survival
; sltdesc Returns: float: the cum load size from the cum_source at the specified tier
; sltargs Form: cum_source: Actor who is the source of the cum load
; sltargs int: cum_load_tier: the load_tier from sls_get_load_tier (optional: default: -1)
; sltsamp set $load_size resultfrom sls_get_load_size $some_npc_or_creature $load_tier
function sls_get_load_size(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        Actor cum_source = CmdPrimary.ResolveActor(param[1])
        if (cum_source)
            int cum_load_tier = -1
            if param.Length > 2
                cum_load_tier = CmdPrimary.ResolveInt(param[2])
            endif
            CmdPrimary.MostRecentFloatResult = sl_triggersAdapterSLS.get_load_size(cum_source, cum_load_tier)
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_get_load_size_actual
; sltgrup SexLab Survival
; sltdesc Returns: float: the actual cum load size from the cum_source at the specified tier
; sltargs Form: cum_source: Actor who is the source of the cum load
; sltargs int: base_load_size: the base load size from sls_get_load_size
; sltsamp set $load_size_actual resultfrom sls_get_load_size_actual $some_npc_or_creature $base_load_size
function sls_get_load_size_actual(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor cum_source = CmdPrimary.ResolveActor(param[1])
        if (cum_source)
            CmdPrimary.MostRecentFloatResult = sl_triggersAdapterSLS.get_load_size_actual(cum_source, CmdPrimary.ResolveFloat(param[2]))
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_get_load_fullness
; sltgrup SexLab Survival
; sltdesc Returns: float: the value, 0.0-1.0 inclusive, representing how full of cum the cum_source's balls are
; sltargs Form: cum_source: Actor who is the source of the cum load
; sltsamp set $load_fullness resultfrom sls_get_load_fullness $some_npc_or_creature
function sls_get_load_fullness(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor cum_source = CmdPrimary.ResolveActor(param[1])
        if (cum_source)
            CmdPrimary.MostRecentFloatResult = sl_triggersAdapterSLS.get_load_fullness(cum_source)
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_get_cum_stuffed_factor
; sltgrup SexLab Survival
; sltdesc Returns: float: the value, 0.0-1.0 inclusive, representing how full of cum the target is from taking in cum; includes vaginal and oral amount
; sltargs Form: target: Actor who is stuffed full of cum
; sltsamp set $cum_stuffed_amount resultfrom sls_get_cum_stuffed_factor $system.player
function sls_get_cum_stuffed_factor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor akTarget = CmdPrimary.ResolveActor(param[1])
        if (akTarget)
            CmdPrimary.MostRecentFloatResult = sl_triggersAdapterSLS.get_cum_stuffed_factor(akTarget)
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_is_drugged
; sltgrup SexLab Survival
; sltdesc Returns: bool: is the target drugged, checking skooma, Skooma Whore, and lactacid as indicated
; sltargs Form: target: target Actor
; sltargs bool: check_skooma: true to check skooma; false otherwise (optional: default: true)
; sltargs bool: check_sw: true to check Skooma Whore; false otherwise (optional: default: true)
; sltargs bool: check_lactacid: true to check MME Lactacid; false otherwise (optional: default: true)
; sltsamp sls_is_drugged $system.self false false true
function sls_is_drugged(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        Actor akTarget = CmdPrimary.ResolveActor(param[1])
        bool check_skooma = true
        bool check_sw = true
        bool check_lactacid = true
        if param.Length > 2
            check_skooma = CmdPrimary.ResolveBool(param[2])
            if param.Length > 3
                check_sw = CmdPrimary.ResolveBool(param[3])
                if param.Length > 4
                    check_lactacid = CmdPrimary.ResolveBool(param[4])
                endif
            endif
        endif
        if (akTarget)
            CmdPrimary.MostRecentBoolResult = sl_triggersAdapterSLS.is_drugged(akTarget, check_skooma, check_sw, check_lactacid)
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_is_high_on_skooma
; sltgrup SexLab Survival
; sltdesc Returns: bool: is the target high on skooma (not specifically Skooma Whore)
; sltargs Form: target: target Actor
; sltsamp sls_is_high_on_skooma $system.self
function sls_is_high_on_skooma(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor akTarget = CmdPrimary.ResolveActor(param[1])
        if (akTarget)
            CmdPrimary.MostRecentBoolResult = sl_triggersAdapterSLS.is_high_on_skooma(akTarget)
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_is_high_on_skooma_whore_drugs
; sltgrup SexLab Survival
; sltdesc Returns: bool: is the target high on Skooma Whore drugs (not just skooma generally)
; sltargs Form: target: target Actor
; sltsamp sls_is_high_on_skooma_whore_drugs $system.self
function sls_is_high_on_skooma_whore_drugs(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor akTarget = CmdPrimary.ResolveActor(param[1])
        if (akTarget)
            CmdPrimary.MostRecentBoolResult = sl_triggersAdapterSLS.is_high_on_skooma_whore_drugs(akTarget)
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_is_high_on_lactacid
; sltgrup SexLab Survival
; sltdesc Returns: bool: is the target high on MME Lactacid
; sltargs Form: target: target Actor
; sltsamp sls_is_high_on_lactacid $system.self
function sls_is_high_on_lactacid(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor akTarget = CmdPrimary.ResolveActor(param[1])
        if (akTarget)
            CmdPrimary.MostRecentBoolResult = sl_triggersAdapterSLS.is_high_on_lactacid(akTarget)
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_get_skooma_junkie_level
; sltgrup SexLab Survival
; sltdesc Returns: float: the skooma junkie level of the target
; sltrslt 0 - Not addicted
; sltrslt 1 - Experimentation
; sltrslt 2 - Regular use
; sltrslt 3 - Risky use
; sltrslt 4 - Dependence
; sltrslt 5 - Addiction
; sltargs Form: target: Actor to check level for
; sltargs bool is_withdrawing: true if withdrawal effects must be active; false if we don't care
; sltsamp set $junkie_level resultfrom sls_get_skooma_junkie_level $system.self false
function sls_get_skooma_junkie_level(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor akTarget = CmdPrimary.ResolveActor(param[1])
        if (akTarget)
            CmdPrimary.MostRecentIntResult = sl_triggersAdapterSLS.get_skooma_junkie_level(akTarget, CmdPrimary.ResolveBool(param[2]))
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_do_female_pain_sound
; sltgrup SexLab Survival
; sltdesc Causes SLS to trigger the female pain sound
; sltargs Form: target: target Actor
; sltargs float: volume: volume level to emit the sound at
; sltsamp sls_do_female_pain_sound $system.self 0.5
function sls_do_female_pain_sound(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor akTarget = CmdPrimary.ResolveActor(param[1])
        if (akTarget)
            sl_triggersAdapterSLS.do_hit_sound(akTarget, CmdPrimary.ResolveFloat(param[2]))
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_do_hit_sound
; sltgrup SexLab Survival
; sltdesc Causes SLS to trigger the hit sound
; sltargs Form: target: target Actor
; sltargs float: volume: volume level to emit the sound at
; sltsamp sls_do_hit_sound $system.self 0.5
function sls_do_hit_sound(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor akTarget = CmdPrimary.ResolveActor(param[1])
        if (akTarget)
            sl_triggersAdapterSLS.do_hit_sound(akTarget, CmdPrimary.ResolveFloat(param[2]))
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sls_do_trauma_hit_sound
; sltgrup SexLab Survival
; sltdesc Causes SLS to trigger the trauma hit sound (of an actor being hit; as in the Trauma module)
; sltargs Form: target: target Actor
; sltargs bool: playerSqueaks: true if the player should squeak; false otherwise
; sltsamp sls_do_trauma_hit_sound $system.self true
function sls_do_trauma_hit_sound(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor akTarget = CmdPrimary.ResolveActor(param[1])
        if (akTarget)
            sl_triggersAdapterSLS.do_trauma_hit_sound(akTarget, CmdPrimary.ResolveFloat(param[2]))
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

