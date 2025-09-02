scriptname sl_triggersCmdLibSLIF

import sl_triggersStatics

; sltname slif_get_version
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Returns: int: a numeric version value, reported by SLIF
Function slif_get_version(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        CmdPrimary.MostRecentIntResult = sl_triggersAdapterSLIF.GetVersion()
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_get_versionstring
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Returns: string: the version as a string, reported by SLIF
Function slif_get_versionstring(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        CmdPrimary.MostRecentStringResult = sl_triggersAdapterSLIF.GetVersionString()
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_is_installed
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Returns: bool: true if SLIF is installed, false otherwise
Function slif_is_installed(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        CmdPrimary.MostRecentBoolResult = sl_triggersAdapterSLIF.IsInstalled()
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_is_updating
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Returns: bool: true if SLIF is updating, false otherwise
Function slif_is_updating(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        CmdPrimary.MostRecentBoolResult = sl_triggersAdapterSLIF.IsUpdating()
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_is_working
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Returns: bool: true if SLIF is working, false otherwise
Function slif_is_working(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        CmdPrimary.MostRecentBoolResult = sl_triggersAdapterSLIF.IsWorking()
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_is_inmaintenance
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Returns: bool: true if SLIF is in maintenance mode, false otherwise
Function slif_is_inmaintenance(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        CmdPrimary.MostRecentBoolResult = sl_triggersAdapterSLIF.IsInMaintenance()
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_inflate
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Tells SLIF to inflate the actor, on the given node, for the given amount.
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: modName: your modname for SLIF purposes (you could use your script name)
; sltargs string: node: the SLIF node to work with
; sltargs float: value: the value to apply
; sltargs string: oldModName: (optional: default: "") see SLIF documentation; probably should use ""
Function slif_inflate(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 4)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string modName = CmdPrimary.ResolveString(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        float value = CmdPrimary.ResolveFloat(param[4])
        string oldModName = ""
        if param.Length > 5
            oldModName = CmdPrimary.ResolveString(param[5])
        endif
        sl_triggersAdapterSLIF.Inflate(kActor, modName, node, value, oldModName)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_register_actor
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Tells SLIF to register the actor. SLIF automatically registers on first inflate call, so this is not always required.
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: modName: your modname for SLIF purposes (you could use your script name)
; sltargs string: node: (optional: default: "") the SLIF node to work with
; sltargs string: oldModName: (optional: default: "") see SLIF documentation; probably should use ""
; sltargs float: min: (optional: default: -1.0) min value
; sltargs float: max: (optional: default: -1.0) max value
; sltargs float: multiplier: (optional: default: -1.0) multiplier value
; sltargs float: increment: (optional: default: -1.0) increment value
Function slif_register_actor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string modName = CmdPrimary.ResolveString(param[2])
        string node = ""
        string oldModName = ""
        float min = -1.0
        float max = -1.0
        float mult = -1.0
        float incr = -1.0
        if param.Length > 3
            node = CmdPrimary.ResolveString(param[3])
            if param.Length > 4
                oldModName = CmdPrimary.ResolveString(param[4])
                if param.Length > 5
                    min = CmdPrimary.ResolveFloat(param[5])
                    if param.Length > 6
                        max = CmdPrimary.ResolveFloat(param[6])
                        if param.Length > 7
                            mult = CmdPrimary.ResolveFloat(param[7])
                            if param.Length > 8
                                incr = CmdPrimary.ResolveFloat(param[8])
                            endif
                        endif
                    endif
                endif
            endif
        endif
        sl_triggersAdapterSLIF.RegisterActor(kActor, modName, node, oldModName, min, max, mult, incr)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_unregister_actor
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Tells SLIF to unregister the actor
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: modName: your modname for SLIF purposes (you could use your script name)
Function slif_unregister_actor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string modName = CmdPrimary.ResolveString(param[2])
        sl_triggersAdapterSLIF.UnregisterActor(kActor, modName)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_update_actor
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Tells SLIF to update the actor
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: modName: your modname for SLIF purposes (you could use your script name)
; sltargs string: node: (optional: default: "") the SLIF node to update
; sltargs string: oldModName: (optional: default: "") see SLIF documentation; probably should use ""
; sltargs float: min: (optional: default: -1.0) min value
; sltargs float: max: (optional: default: -1.0) max value
; sltargs float: multiplier: (optional: default: -1.0) multiplier value
; sltargs float: increment: (optional: default: -1.0) increment value
Function slif_update_actor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string modName = CmdPrimary.ResolveString(param[2])
        string node = ""
        string oldModName = ""
        float min = -1.0
        float max = -1.0
        float mult = -1.0
        float incr = -1.0
        if param.Length > 3
            node = CmdPrimary.ResolveString(param[3])
            if param.Length > 4
                oldModName = CmdPrimary.ResolveString(param[4])
                if param.Length > 5
                    min = CmdPrimary.ResolveFloat(param[5])
                    if param.Length > 6
                        max = CmdPrimary.ResolveFloat(param[6])
                        if param.Length > 7
                            mult = CmdPrimary.ResolveFloat(param[7])
                            if param.Length > 8
                                incr = CmdPrimary.ResolveFloat(param[8])
                            endif
                        endif
                    endif
                endif
            endif
        endif
        sl_triggersAdapterSLIF.UpdateActor(kActor, modName, node, oldModName, min, max, mult, incr)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_reset_actor
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Resets the SLIF actor, with optional overrides for various settings
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: modName: your modname for SLIF purposes (you could use your script name)
; sltargs string: node: (optional: default: "") the SLIF node to reset
; sltargs float: value: (optional: default: 1.0) the value to apply to reset to
; sltargs string: oldModName: (optional: default: "") see SLIF documentation; probably should use ""
; sltargs float: min: (optional: default: -1.0) min value
; sltargs float: max: (optional: default: -1.0) max value
; sltargs float: multiplier: (optional: default: -1.0) multiplier value
; sltargs float: increment: (optional: default: -1.0) increment value
Function slif_reset_actor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string modName = CmdPrimary.ResolveString(param[2])
        string node = ""
        float value = 1.0
        string oldModName = ""
        float min = -1.0
        float max = -1.0
        float mult = -1.0
        float incr = -1.0
        if param.Length > 3
            node = CmdPrimary.ResolveString(param[3])
            if param.Length > 4
                value = CmdPrimary.ResolveFloat(param[4])
                if param.Length > 5
                    oldModName = CmdPrimary.ResolveString(param[5])
                    if param.Length > 6
                        min = CmdPrimary.ResolveFloat(param[6])
                        if param.Length > 7
                            max = CmdPrimary.ResolveFloat(param[7])
                            if param.Length > 8
                                mult = CmdPrimary.ResolveFloat(param[8])
                                if param.Length > 9
                                    incr = CmdPrimary.ResolveFloat(param[9])
                                endif
                            endif
                        endif
                    endif
                endif
            endif
        endif
        sl_triggersAdapterSLIF.ResetActor(kActor, modName, node, value, oldModName, min, max, mult, incr)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_hide_node
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Tells SLIF to hide the node, with an optional hide value to set the scale to
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: modName: your modname for SLIF purposes (you could use your script name)
; sltargs string: node: the SLIF node to work with
; sltargs float: value: (optional: default: 0.0000001) the value to apply for hiding
; sltargs string: oldModName: (optional: default: "") see SLIF documentation; probably should use ""
Function slif_hide_node(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string modName = CmdPrimary.ResolveString(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        float value = 0.0000001
        string oldModName = ""
        if param.Length > 4
            value = CmdPrimary.ResolveFloat(param[4])
            if param.Length > 5
                oldModName = CmdPrimary.ResolveString(param[5])
            endif
        endif
        sl_triggersAdapterSLIF.HideNode(kActor, modName, node, value, oldModName)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_show_node
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Tells SLIF to show the node if it was previously hidden
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: modName: your modname for SLIF purposes (you could use your script name)
; sltargs string: node: the SLIF node to work with
Function slif_show_node(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string modName = CmdPrimary.ResolveString(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        sl_triggersAdapterSLIF.ShowNode(kActor, modName, node)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_is_node_hidden
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Returns: bool: true if the SLIF node is hidden on the actor, false otherwise
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: node: the SLIF node to work with
Function slif_is_node_hidden(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string node = CmdPrimary.ResolveString(param[2])
        CmdPrimary.MostRecentBoolResult = sl_triggersAdapterSLIF.IsNodeHidden(kActor, node)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_get_gender
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Returns: int: the integer value representing gender as SLIF knows it.
; sltrslt Per SLIF documentation:
; sltrslt male            = 0
; sltrslt female          = 1
; sltrslt shemale         = 2
; sltrslt futanari        = 3
; sltrslt genderless      = 4
; sltrslt male_creature   = 5
; sltrslt female_creature = 6
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs int: gender: (optional: default: -1) default gender if not already set; use -1 to let SLIF determine the default
Function slif_get_gender(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        int gender = -1
        if param.Length > 2
            gender = CmdPrimary.ResolveInt(param[2])
        endif
        CmdPrimary.MostRecentIntResult = sl_triggersAdapterSLIF.GetGender(kActor, gender)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_set_default_values
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Sets the default values for SLIF for the node on the actor
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: modName: your modname for SLIF purposes (you could use your script name)
; sltargs string: node: the SLIF node to work with
; sltargs float: min: (optional: default: 0.0) default min value if one is not specified
; sltargs float: max: (optional: default: 100.0) default max value if one is not specified
; sltargs float: multiplier: (optional: default: 1.0) default multiplier value if one is not specified
; sltargs float: increment: (optional: default: 0.1) default increment value if one is not specified
Function slif_set_default_values(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string modName = CmdPrimary.ResolveString(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        float min = 0.0
        float max = 100.0
        float mult = 1.0
        float incr = 0.1
        if param.Length > 4
            min = CmdPrimary.ResolveFloat(param[4])
            if param.Length > 5
                max = CmdPrimary.ResolveFloat(param[5])
                if param.Length > 6
                    mult = CmdPrimary.ResolveFloat(param[6])
                    if param.Length > 7
                        incr = CmdPrimary.ResolveFloat(param[7])
                    endif
                endif
            endif
        endif
        sl_triggersAdapterSLIF.SetDefaultValues(kActor, modName, node, min, max, mult, incr)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_get_value
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Returns: float: the current value from SLIF for the node on the actor
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: modName: your modname for SLIF purposes (you could use your script name)
; sltargs string: node: the SLIF node to work with
; sltargs float: default: (optional: default: 0.0) default value to assume if one is not already set
Function slif_get_value(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string modName = CmdPrimary.ResolveString(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        float default = 0.0
        if param.Length > 4
            default = CmdPrimary.ResolveFloat(param[4])
        endif
        CmdPrimary.MostRecentFloatResult = sl_triggersAdapterSLIF.GetValue(kActor, modName, node, default)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_get_minvalue
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Returns: float: the min value from SLIF for the node on the actor
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: modName: your modname for SLIF purposes (you could use your script name)
; sltargs string: node: the SLIF node to work with
; sltargs float: default: (optional: default: 0.0) default value to assume if one is not already set
Function slif_get_minvalue(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string modName = CmdPrimary.ResolveString(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        float default = 0.0
        if param.Length > 4
            default = CmdPrimary.ResolveFloat(param[4])
        endif
        CmdPrimary.MostRecentFloatResult = sl_triggersAdapterSLIF.GetMinValue(kActor, modName, node, default)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_get_maxvalue
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Returns: float: the max value from SLIF for the node on the actor
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: modName: your modname for SLIF purposes (you could use your script name)
; sltargs string: node: the SLIF node to work with
; sltargs float: default: (optional: default: 100.0) default value to assume if one is not already set
Function slif_get_maxvalue(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string modName = CmdPrimary.ResolveString(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        float default = 0.0
        if param.Length > 4
            default = CmdPrimary.ResolveFloat(param[4])
        endif
        CmdPrimary.MostRecentFloatResult = sl_triggersAdapterSLIF.GetMaxValue(kActor, modName, node, default)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_get_multvalue
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Returns: float: the multiplier value from SLIF for the node on the actor
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: modName: your modname for SLIF purposes (you could use your script name)
; sltargs string: node: the SLIF node to work with
; sltargs float: default: (optional: default: 1.0) default value to assume if one is not already set
Function slif_get_multvalue(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string modName = CmdPrimary.ResolveString(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        float default = 0.0
        if param.Length > 4
            default = CmdPrimary.ResolveFloat(param[4])
        endif
        CmdPrimary.MostRecentFloatResult = sl_triggersAdapterSLIF.GetMultValue(kActor, modName, node, default)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slif_get_incrvalue
; sltgrup SLIF (SexLab Inflation Framework)
; sltdesc Returns: float: the increment value from SLIF for the node on the actor
; sltargs Form: actor: the Actor target for the SLIF call
; sltargs string: modName: your modname for SLIF purposes (you could use your script name)
; sltargs string: node: the SLIF node to work with
; sltargs float: default: (optional: default: 0.1) default value to assume if one is not already set
Function slif_get_incrvalue(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Actor kActor = CmdPrimary.ResolveActor(param[1])
        string modName = CmdPrimary.ResolveString(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        float default = 0.0
        if param.Length > 4
            default = CmdPrimary.ResolveFloat(param[4])
        endif
        CmdPrimary.MostRecentFloatResult = sl_triggersAdapterSLIF.GetIncrValue(kActor, modName, node, default)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction