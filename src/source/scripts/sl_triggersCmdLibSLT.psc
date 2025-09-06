scriptname sl_triggersCmdLibSLT

import sl_triggersStatics
 
;;;;;;;;;;
;; 

; sltname deb_msg
; sltgrup Utility
; sltdesc Joins all arguments together into a single string and logs to "<Documents>\My Games\Skyrim Special Edition\SKSE\sl-triggers.log"
; sltdesc This file is truncated on game start.
; sltdesc Usage 1: deb_msg <msg> [<msg> ...]
; sltargs string: message: any string or interpolated string
; sltdesc Usage 2: deb_msg $msglist ; where $msglist is a string[]
; sltargs string[]: msglist: a list of strings to concatenate for a message
; sltrslt ; These all print the same thing
; sltsamp deb_msg "Hello " "world!"
; sltsamp deb_msg "Hello world!"
; sltsamp set $whom "world"
; sltsamp deb_msg "Hello {$whom}!"
; sltsamp set $msg[0] "Hello "
; sltsamp set $msg[1] "world!"
; sltsamp deb_msg $msg
Function deb_msg(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        string[] resolvedStringList = CmdPrimary.ResolveListString(param[1])
        string dmsg
        if (resolvedStringList)
            dmsg = "DebMsg> " + PapyrusUtil.StringJoin(resolvedStringList, "")
        else
            string[] darr = PapyrusUtil.StringArray(param.Length)
            darr[0] = "DebMsg> "
            int i = 1
            while i < darr.Length
                darr[i] = CmdPrimary.ResolveString(param[i])
                i += 1
            endwhile
            dmsg = PapyrusUtil.StringJoin(darr, "")
        endif
        SLTDebugMsg(dmsg)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname msg_notify
; sltgrup Utility
; sltdesc Joins all arguments together into a single string and displays the message in the standard notification area (top left of your screen by default)
; sltdesc Usage 1: msg_notify <msg> [<msg> ...]
; sltargs string: message: any string or interpolated string
; sltdesc Usage 2: msg_notify $msglist ; where $msglist is a string[]
; sltargs string[]: msglist: a list of strings to concatenate for a message
; sltrslt ; These all print the same thing
; sltsamp msg_notify "Hello " "world!"
; sltsamp msg_notify "Hello world!"
; sltsamp set $whom "world"
; sltsamp msg_notify "Hello {$whom}!"
; sltsamp set $msg[0] "Hello "
; sltsamp set $msg[1] "world!"
; sltsamp msg_notify $msg
function msg_notify(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        string[] resolvedStringList = CmdPrimary.ResolveListString(param[1])
        string msg
        if (resolvedStringList)
            msg = PapyrusUtil.StringJoin(resolvedStringList, "")
        else
            string[] darr = PapyrusUtil.StringArray(param.Length)
            int i = 1
            while i < darr.Length
                darr[i] = CmdPrimary.ResolveString(param[i])
                i += 1
            endwhile
            msg = PapyrusUtil.StringJoin(darr, "")
        endif
        Debug.Notification(msg)
        CmdPrimary.SFI(msg)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname msg_console
; sltgrup Utility
; sltdesc Joins all arguments together into a single string and displays the message in the console
; sltdesc Usage 1: msg_console <msg> [<msg> ...]
; sltargs string: message: any string or interpolated string
; sltdesc Usage 2: msg_console $msglist ; where $msglist is a string[]
; sltargs string[]: msglist: a list of strings to concatenate for a message
; sltrslt ; These all print the same thing
; sltsamp msg_console "Hello " "world!"
; sltsamp msg_console "Hello world!"
; sltsamp set $whom "world"
; sltsamp msg_console "Hello {$whom}!"
; sltsamp set $msg[0] "Hello "
; sltsamp set $msg[1] "world!"
; sltsamp msg_console $msg
function msg_console(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        string[] resolvedStringList = CmdPrimary.ResolveListString(param[1])
        string msg
        if (resolvedStringList)
            msg = PapyrusUtil.StringJoin(resolvedStringList, "")
        else
            string[] darr = PapyrusUtil.StringArray(param.Length)
            int i = 1
            while i < darr.Length
                darr[i] = CmdPrimary.ResolveString(param[i])
                i += 1
            endwhile
            msg = PapyrusUtil.StringJoin(darr, "")
        endif
        MiscUtil.PrintConsole(msg)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname form_getbyid
; sltgrup Form
; sltdesc Returns: Form: Performs a lookup for a Form and returns it if found; returns none otherwise
; sltdesc Note that if multiple mods introduce an object with the same editorId, the lookup would only return whichever one won
; sltdesc Anywhere a Form is called for in other functions, one of these formIDs can be substituted.
; sltargs string: formID: FormID as: "modfile.esp:<relative int or hex formID>" (mod-colon-id), "<relative int or hex formID>|modfile.esp" (id-pipe-mod), "<absolute int or hex formID>" (id), "anEditorId" (will attempt an editorId lookup)
; sltsamp set $aleForm resultfrom form_getbyid "Ale"
; sltsamp set $aleName resultfrom form_dogetter $aleForm GetName
; sltsamp msg_notify $"{$aleName}!! Yay!!"
; sltsamp ; Ale!! Yay!!
; sltsamp ; anything that derives from Form can be retrieved with this, including Armor, Weapon, Quest, Spell, MagicEffect, Actor, and other types of objects
Function form_getbyid(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    Form outcome

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        outcome = CmdPrimary.ResolveForm(param[1])
    endif

    CmdPrimary.MostRecentFormResult = outcome

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname global_getvalue
; sltgrup GlobalVariable
; sltdesc Returns: float: Finds the indicated GlobalVariable and returns its current value as a float.
; sltargs Form: globalVariable: the GLOB record targeted
; sltsamp ; retrieve the GLOB via the editorID 'GameDaysPassed', and get it's current value
; sltsamp set $gameDaysPassed resultfrom global_getvalue "GameDaysPassed"
Function global_getvalue(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    GlobalVariable gvar

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        gvar = CmdPrimary.ResolveForm(param[1]) as GlobalVariable
    endif

    if gvar
        CmdPrimary.MostRecentFloatResult = gvar.GetValue()
    else
        CmdPrimary.SFE("Unable to resolve GlobalVariable from (" + param[1] + ")")
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname global_setvalue
; sltgrup GlobalVariable
; sltdesc Finds the indicated GlobalVariable and sets its current value.
; sltargs Form: globalVariable: the GLOB record targeted
; sltargs newValue: float
; sltsamp ; retrieve the GLOB via the editorID 'GameDaysPassed', and set it's current value
; sltsamp ; Sets the Devious Followers willpower global to 20.0
; sltsamp global_setvalue "_Dwill" 20.0
Function global_setvalue(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    GlobalVariable gvar
    float newvalue

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        gvar = CmdPrimary.ResolveForm(param[1]) as GlobalVariable
        newvalue = CmdPrimary.ResolveFloat(param[2])

        if gvar
            gvar.SetValue(newvalue)
        else
            CmdPrimary.SFE("Unable to resolve GlobalVariable from (" + param[1] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction
 
; sltname av_restore
; sltgrup Actor Value
; sltdesc Restore actor value
; sltargs Form: actor: target Actor
; sltargs string: av name: Actor Value name e.g. Health
; sltargs float: amount: amount to restore
; sltrslt ; both of these restore Health by 100 e.g. healing
; sltsamp av_restore $system.self Health 100
; sltsamp av_restore $system.self   $3   100 ;where $3 might be "Health"
function av_restore(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            _targetActor.RestoreActorValue(CmdPrimary.ResolveString(param[2]), CmdPrimary.ResolveFloat(param[3]))
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname av_damage
; sltgrup Actor Value
; sltdesc Damage actor value
; sltargs Form: actor: target Actor
; sltargs string: av name: Actor Value name e.g. Health
; sltargs float: amount: amount to damage
; sltrslt ; both of these damage Health by 100. This can result in death.
; sltsamp av_damage $system.self Health 100
; sltsamp av_damage $system.self   $3   100 ;where $3 might be "Health"
function av_damage(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            _targetActor.DamageActorValue(CmdPrimary.ResolveString(param[2]), CmdPrimary.ResolveFloat(param[3]))
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname av_mod
; sltgrup Actor Value
; sltdesc Modify actor value
; sltargs Form: actor: target Actor
; sltargs string: av name: Actor Value name e.g. Health
; sltargs float: amount: amount to modify by
; sltrslt ; Changes the max value of the actor value. Not the same as restore/damage.
; sltsamp av_mod $system.self Health 100
; sltsamp av_mod $system.self   $3   100 ;where $3 might be "Health"
function av_mod(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            _targetActor.ModActorValue(CmdPrimary.ResolveString(param[2]), CmdPrimary.ResolveFloat(param[3]))
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname av_set
; sltgrup Actor Value
; sltdesc Set actor value
; sltargs Form: actor: target Actor
; sltargs string: av name: Actor Value name e.g. Health
; sltargs float: amount: amount to modify by
; sltsamp av_set $system.self Health 100
; sltsamp av_set $system.self   $3   100 ;where $3 might be "Health"
; sltrslt Sets the value of the actor value.
function av_set(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            _targetActor.SetActorValue(CmdPrimary.ResolveString(param[2]), CmdPrimary.ResolveFloat(param[3]))
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname av_getbase
; sltgrup Actor Value
; sltdesc Returns: float: the actor's base value for the specified Actor Value
; sltargs Form: actor: target Actor
; sltargs string: av name: Actor Value name e.g. Health
; sltsamp float: av_getbase $system.self Health
; sltrslt Sets the actor's base Health into $$
function av_getbase(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])

        if _targetActor
            nextResult = _targetActor.GetBaseActorValue(CmdPrimary.ResolveString(param[2]))
        endif
    endif

    CmdPrimary.MostRecentFloatResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname av_get
; sltgrup Actor Value
; sltdesc Returns: float: the actor's current value for the specified Actor Value
; sltargs Form: actor: target Actor
; sltargs string: av name: Actor Value name e.g. Health
; sltsamp av_get $system.self Health
; sltrslt Sets the actor's current Health into $$
function av_get(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        string avname = CmdPrimary.ResolveString(param[2])

        If (CmdPrimary.SLT.Debug_Cmd_Functions)
            if _targetActor
                nextResult = _targetActor.GetActorValue(avname)
                SLTDebugMsg("av_get: actor(" + _targetActor + ") avname(" + avname + ") value(" + nextResult + ")")
            else
                SLTDebugMsg("av_get: unable to resolve _targetActor from (" + param[1] + ")")
            endif
        else
            if _targetActor
                nextResult = _targetActor.GetActorValue(avname)
            endif
        EndIf
    endif

    CmdPrimary.MostRecentFloatResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname av_getmax
; sltgrup Actor Value
; sltdesc Returns: float: the actor's max value for the specified Actor Value
; sltargs Form: actor: target Actor
; sltargs string: av name: Actor Value name e.g. Health
; sltsamp av_get $system.self Health
; sltrslt Sets the actor's max Health into $$
function av_getmax(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])

        if _targetActor
            nextResult = _targetActor.GetActorValueMax(CmdPrimary.ResolveString(param[2]))
        endif
    endif

    CmdPrimary.MostRecentFloatResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname av_getpercentage
; sltgrup Actor Value
; sltdesc Returns: float: the actor's value as a percentage of max for the specified Actor Value
; sltargs Form: actor: target Actor
; sltargs string: av name: Actor Value name e.g. Health
; sltsamp av_getpercentage $system.self Health
; sltrslt Sets the actor's percentage of Health remaining into $$
function av_getpercent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            nextResult = (_targetActor.GetActorValuePercentage(CmdPrimary.ResolveString(param[2])) * 100.0)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname spell_cast
; sltgrup Spells
; sltdesc Cast spell at target
; sltargs Form: spell: the Spell to cast
; sltargs Form: actor: target Actor
; sltsamp spell_cast "skyrim.esm:275236" $system.self
; sltrslt Casts light spell on self
function spell_cast(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.ResolveForm(param[1]) as Spell
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[2])
            if _targetActor
                thing.RemoteCast(_targetActor, _targetActor, _targetActor)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve SPEL with FormId (" + param[1] + ")")
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname spell_dcsa
; sltgrup Spells
; sltdesc Casts spell with DoCombatSpellApply Papyrus function. It is usually used for spells that 
; sltdesc are part of a melee attack (like animals that also carry poison or disease).
; sltargs Form: spell: the Spell
; sltargs Form: actor: target Actor
; sltsamp spell_dcsa "skyrim.esm:275236" $system.self
function spell_dcsa(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.ResolveForm(param[1]) as Spell
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[2])
            if _targetActor
                _targetActor.DoCombatSpellApply(thing, _targetActor)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve SPEL with FormId (" + param[1] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname spell_dispel
; sltgrup Spells
; sltdesc Dispels specified SPEL by FormId from targeted Actor
; sltargs Form: spell: the Spell to dispel
; sltargs Form: actor: target Actor
; sltsamp spell_dispel "skyrim.esm:275236" $system.self
; sltrslt If light was currently on $system.self, it would now be dispelled
function spell_dispel(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.ResolveForm(param[1]) as Spell
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[2])
            if _targetActor
                _targetActor.DispelSpell(thing)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve SPEL with FormId (" + param[1] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname spell_add
; sltgrup Spells
; sltdesc Adds the specified SPEL by FormId to the targeted Actor, usually to add as an available power or spell in the spellbook.
; sltargs Form: spell: the Spell to add
; sltargs Form: actor: target Actor
; sltsamp spell_add "skyrim.esm:275236" $system.self
; sltrslt The light spell is now in the actor's spellbook
function spell_add(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.ResolveForm(param[1]) as Spell
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[2])
            if _targetActor
                _targetActor.AddSpell(thing)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve SPEL with FormId (" + param[1] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname spell_remove
; sltgrup Spells
; sltdesc Removes the specified SPEL by FormId from the targeted Actor, usually to remove as an available power or spell in the spellbook.
; sltargs Form: spell: the Spell to remove
; sltargs Form: actor: target Actor
; sltsamp spell_remove "skyrim.esm:275236" $system.self
; sltrslt The light spell should no longer be in the actor's spellbook
function spell_remove(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.ResolveForm(param[1]) as Spell
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[2])
            if _targetActor
                _targetActor.RemoveSpell(thing)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve SPEL with FormId (" + param[1] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname item_add
; sltgrup Items
; sltdesc Adds the item to the actor's inventory. If you are struggling with NPC's, try item_addex.
; sltargs Form: actor: target Actor
; sltargs Form: item: the item to add (e.g. Weapon, Armor, Misc. Item)
; sltargs int: count: number (optional: default 1)
; sltargs bool: isSilent: false - show message | true - silent (optional: default: false - show message)
; sltsamp item_add $system.self "skyrim.esm:15" 10 false
; sltrslt Adds 10 gold to the actor, displaying the notification
function item_add(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 6)
        Form thing = CmdPrimary.ResolveForm(param[2])
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
    
            if _targetActor
                int count = 1
                if param.Length > 3
                    count = CmdPrimary.ResolveInt(param[3])
                endif
                bool isSilent = false
                if param.Length > 4
                    isSilent = CmdPrimary.ResolveBool(param[4])
                endif
                _targetActor.AddItem(thing, count, isSilent)
            else
                SLTErrMsg("SLT: [" + CmdPrimary.currentScriptName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            SLTErrMsg("SLT: [" + CmdPrimary.currentScriptName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname item_addex
; sltgrup Items
; sltdesc Adds the item to the actor's inventory, but check if some armor was re-equipped (if NPC)
; sltargs Form: actor: target Actor
; sltargs Form: item: ITEM FormId
; sltargs int: count: number (optional: default 1)
; sltargs bool: isSilent: false - show message | true - silent (optional: default false - show message)
; sltsamp item_addex $system.self "skyrim.esm:15" 10 false
function item_addex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 6)
    
        Form thing = CmdPrimary.ResolveForm(param[2])
        if thing
            int count = 1
            if param.Length > 3
                count = CmdPrimary.ResolveInt(param[3])
            endif
            bool isSilent = false
            if param.Length > 4
                isSilent = CmdPrimary.ResolveBool(param[4])
            endif
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            
            Form[] itemSlots = new Form[34]
            int index
            int slotsChecked
            int thisSlot
            
            If _targetActor != CmdPrimary.PlayerRef
                index = 0
                slotsChecked += 0x00100000
                slotsChecked += 0x00200000
                slotsChecked += 0x80000000
                thisSlot = 0x01
                While (thisSlot < 0x80000000)
                    if (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot) 
                        Form thisArmor = _targetActor.GetWornForm(thisSlot)
                        if (thisArmor)
                            itemSlots[index] = thisArmor
                            index += 1
                            slotsChecked += (thisArmor as Armor).GetSlotMask() 
                        else 
                            slotsChecked += thisSlot
                        endif
                    endif
                    thisSlot *= 2 
                endWhile
            EndIf
            
            _targetActor.AddItem(thing, count, isSilent)
    
            If _targetActor != CmdPrimary.PlayerRef
                index = 0
                slotsChecked = 0
                slotsChecked += 0x00100000
                slotsChecked += 0x00200000
                slotsChecked += 0x80000000
                thisSlot = 0x01
                While (thisSlot < 0x80000000)
                    if (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot)
                        Form thisArmor = _targetActor.GetWornForm(thisSlot)
                        if (thisArmor)
                            If itemSlots.Find(thisArmor) < 0
                                _targetActor.UnequipItemEx(thisArmor, 0)
                            EndIf
                            slotsChecked += (thisArmor as Armor).GetSlotMask()
                        else
                            slotsChecked += thisSlot
                        endif
                    endif
                    thisSlot *= 2 
                endWhile
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname item_remove
; sltgrup Items
; sltdesc Remove the item from the source's inventory
; sltargs Form: container: the ObjectReference container (e.g. an Actor, Chest, Barrel, corpse) to remove an item from
; sltargs Form: item: the Form of the item to remove
; sltargs count: number
; sltargs bool: silent: false - show message | true - silent (optional: default false - show message)
; sltargs Form: targetContainer: other container (ObjectReference) to move the item to (optional: default none)
; sltsamp item_remove $system.self "skyrim.esm:15" 10 false $system.player
; sltrslt Removes up to 10 gold from the source, looting it to the player (target)
function item_remove(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Form thing = CmdPrimary.ResolveForm(param[2])
        if thing
            ObjectReference _targetRef = CmdPrimary.ResolveForm(param[1]) as ObjectReference

            if _targetRef
                int count = CmdPrimary.ResolveInt(param[3])
                bool isSilent = false
                ObjectReference akOtherContainer = none
                if param.Length > 4
                    isSilent = CmdPrimary.ResolveBool(param[4])
                    if param.Length > 5
                        akOtherContainer = CmdPrimary.ResolveObjRef(param[5])
                        if !akOtherContainer
                            CmdPrimary.SFW("item_remove: unable to resolve target container (ObjectReference) from (param 5)(" + param[5] + "); continuing with 'none', check the ground?")
                        endif
                    endif
                endif
                _targetRef.RemoveItem(thing, count, isSilent, akOtherContainer)
            else
                CmdPrimary.SFE("unable to resolve ObjectReference container (" + param[1] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname item_adduse
; sltgrup Items
; sltdesc Add item (like item_add) and then use the added item (like item_equip). Useful for potions, food, and other consumables.
; sltargs Form: actor: target Actor
; sltargs Form: item: the item to add and equip
; sltargs int: count: number (optional: default 1)
; sltargs bool: isSilent: false - show message | true - silent (optional: default false - show message)
; sltsamp item_adduse $system.self "skyrim.esm:216158" 1 false
; sltrslt Add and drink some booze
function item_adduse(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 6)
        Form thing = CmdPrimary.ResolveForm(param[2])
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            if _targetActor
                int count = 1
                if param.Length > 3
                    count = CmdPrimary.ResolveInt(param[3])
                endif
                bool isSilent = false
                if param.Length > 4
                    isSilent = CmdPrimary.ResolveBool(param[4])
                endif
                _targetActor.AddItem(thing, count, isSilent)
                _targetActor.EquipItem(thing, false, isSilent)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname item_equipex
; sltgrup Items
; sltdesc Equip item (SKSE version)
; sltargs Form: actor: target Actor
; sltargs Form: item: the item to equip
; sltargs int: armorslot: number e.g. 32 for body slot
; sltargs bool: sound: false - no sound | true - with sound
; sltargs bool: removalPrevented: false - removal allowed | true - removal not allowed
; sltsamp item_equipex $system.self "ZaZAnimationPack.esm:159072" 32 0 1
; sltrslt Equip the ZaZ armor on $system.self, at body slot 32, silently, with no removal allowed
; sltrslt Equips item directly, Workaround for "NPCs re-equip all armor, if they get an item that looks like armor"
function item_equipex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 6)
        Form thing = CmdPrimary.ResolveForm(param[2])
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            if _targetActor
                int slotId = CmdPrimary.ResolveInt(param[3])
                bool isSilent = CmdPrimary.ResolveBool(param[4])
                bool isRemovalPrevented = CmdPrimary.ResolveBool(param[5])
                _targetActor.EquipItemEx(thing, slotId, isRemovalPrevented, isSilent)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname item_equip
; sltgrup Items
; sltdesc Equip item ("vanilla" version). Note that the documentation suggests adding the item first in most cases if it does not exist.
; sltargs Form: actor: target Actor
; sltargs Form: item: the item to equip
; sltargs bool: preventRemoval: false - removal allowed | true - removal not allowed
; sltargs bool: sound: false - no sound | true - with sound
; sltsamp item_equip $system.self "ZaZAnimationPack.esm:159072" true false
; sltrslt Equip the ZaZ armor on $system.self, silently, with no removal allowed (uses whatever slot the armor uses)
function item_equip(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 5)
        Form thing = CmdPrimary.ResolveForm(param[2])
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            if _targetActor
                bool preventRemoval = CmdPrimary.ResolveBool(param[3])
                bool isSilent = CmdPrimary.ResolveBool(param[4])
                _targetActor.EquipItem(thing, preventRemoval, isSilent)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname item_unequipex
; sltgrup Items
; sltdesc Unequip item
; sltargs Form: actor: target Actor
; sltargs Form: item: the item to unequip
; sltargs int: armorslot: number e.g. 32 for body slot
; sltsamp item_unequipex $system.self "ZaZAnimationPack.esm:159072" 32
; sltrslt Unequips the ZaZ armor from slot 32 on $system.self
function item_unequipex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form thing = CmdPrimary.ResolveForm(param[2])
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            if _targetActor
                int slotId = CmdPrimary.ResolveInt(param[3])
                _targetActor.UnEquipItemEx(thing, slotId)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname item_getcount
; sltgrup Items
; sltdesc Returns: int: how many of a specified item an ObjectReference (typically an actor) has
; sltargs Form: actor: target ObjectReference
; sltargs Form: item: item to count
; sltsamp item_getcount $system.self "skyrim.esm:15"
function item_getcount(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form thing = CmdPrimary.ResolveForm(param[2])
        if thing
            ObjectReference _targetObjRef = CmdPrimary.ResolveObjRef(param[1])
            if _targetObjRef
                nextResult = _targetObjRef.GetItemCount(thing)
            else
                CmdPrimary.SFE("unable to resolve ObjectReference variable (" + param[1] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif

    CmdPrimary.MostRecentIntResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname rnd_list
; sltgrup Utility
; sltdesc Returns: string: one of the arguments at random
; sltdesc Usage 1: rnd_list <argument> [<argument> ...]
; sltargs string: argument: any string or interpolated string
; sltdesc Usage 2: rnd_list $arglist ; where $arglist is a string[]
; sltargs string[]: arglist: a list of strings to pick from
; sltrslt ; These do the same thing
; sltsamp rnd_list "One" "Two" "Three"
; sltsamp listadd $picklist "One" "Two" "Three"
; sltsamp rnd_list $picklist
function rnd_list(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        string[] resolvedStringList = CmdPrimary.ResolveListString(param[1])
        if (resolvedStringList)
            int idx = Utility.RandomInt(0, resolvedStringList.Length - 1)
            nextResult = resolvedStringList[idx]
        else
            int idx = Utility.RandomInt(1, param.Length - 1)
            nextResult = CmdPrimary.ResolveString(param[idx])
        endif
    endif

    CmdPrimary.MostRecentStringResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname rnd_int
; sltgrup Utility
; sltdesc Returns: int: a random integer between min and max inclusive
; sltargs int: min: number
; sltargs int: max: number
; sltsamp rnd_int 1 100
function rnd_int(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        nextResult = Utility.RandomInt(CmdPrimary.ResolveInt(param[1]), CmdPrimary.ResolveInt(param[2]))
    endif

    CmdPrimary.MostRecentIntResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname rnd_float
; sltgrup Utility
; sltdesc Returns: float: a random integer between min and max inclusive
; sltargs float: min: number
; sltargs float: max: number
; sltsamp rnd_float 1 100
function rnd_float(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        nextResult = Utility.RandomFloat(CmdPrimary.ResolveFloat(param[1]), CmdPrimary.ResolveFloat(param[2]))
    endif

    CmdPrimary.MostRecentFloatResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname util_wait
; sltgrup Utility
; sltdesc Wait specified number of seconds i.e. Utility.Wait()
; sltargs float: duration: time to wait, in seconds
; sltsamp util_wait 2.5
; sltrslt The script will pause processing for 2.5 seconds
function util_wait(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Utility.Wait(CmdPrimary.ResolveFloat(param[1]))
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname util_getrandomactor
; sltgrup Utility
; sltdesc Returns: Form: a random actor within specified range of self
; sltargs float: range: 0 - all | >0 skyrim units
; sltsamp util_getrandomactor 320
function util_getrandomactor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    Actor nextIterActor

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor[] inCell = MiscUtil.ScanCellNPCs(CmdPrimary.CmdTargetActor, CmdPrimary.ResolveFloat(param[1]))
        if inCell.Length
            Keyword ActorTypeNPC = GetForm_Skyrim_ActorTypeNPC() as Keyword
            Cell    cc = CmdPrimary.PlayerRef.getParentCell()
        
            int i = 0
            int nuns = 0
            while i < inCell.Length
                Actor _targetActor = inCell[i]
                if !_targetActor || _targetActor == CmdPrimary.PlayerRef || !_targetActor.isEnabled() || _targetActor.isDead() || _targetActor.isInCombat() || _targetActor.IsUnconscious() || !_targetActor.HasKeyWord(ActorTypeNPC) || !_targetActor.Is3DLoaded() || cc != _targetActor.getParentCell()
                    inCell[i] = none
                    nuns += 1
                endif
                i += 1
            endwhile
        
            int remainder = inCell.Length - nuns
            if remainder > 0
                int _targetMetaIndex = Utility.RandomInt(0, remainder - 1)
                int _metaIndex = -1

                i = 0
                while i < inCell.Length && _metaIndex < _targetMetaIndex
                    if inCell[i]
                        _metaIndex += 1
                    endif
                    if _metaIndex < _targetMetaIndex
                        i += 1
                    endif
                endwhile

                if _metaIndex == _targetMetaIndex
                    nextIterActor = inCell[i]
                endif
            endif
        endif
    endif

    CmdPrimary.IterActor = nextIterActor

    CmdPrimary.CustomResolveFormResult = nextIterActor

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname perk_addpoints
; sltgrup Perks
; sltdesc Add specified number of perk points to player
; sltargs int: perkpointcount: number of perk points to add
; sltsamp perk_addpoints 4
function perk_addpoints(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Game.AddPerkPoints(CmdPrimary.ResolveInt(param[1]))
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname perk_add
; sltgrup Perks
; sltdesc Add specified perk to the targeted actor
; sltargs Form: perk: the Perk to add
; sltargs Form: actor: target Actor
; sltsamp perk_add "skyrim.esm:12384" $system.self
function perk_add(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Perk thing = CmdPrimary.ResolveForm(param[1]) as Perk    
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[2])
            if _targetActor
                _targetActor.AddPerk(thing)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve ITEM with FormId (" + param[1] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname perk_remove
; sltgrup Perks
; sltdesc Remove specified perk from the targeted actor
; sltargs Form: perk: the Perk to remove
; sltargs Form: actor: target Actor
; sltsamp perk_remove "skyrim.esm:12384" $system.self
function perk_remove(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Perk thing = CmdPrimary.ResolveForm(param[1]) as Perk    
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[2])
            if _targetActor
                _targetActor.RemovePerk(thing)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve ITEM with FormId (" + param[1] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_advskill
; sltgrup Actor
; sltdesc Advance targeted actor's skill by specified amount. Only works on Player.
; sltargs Form: actor: target Actor
; sltargs string: skill: skillname e.g. Alteration, Destruction
; sltargs float: value: number
; sltsamp actor_advskill $system.self Alteration 1
; sltrslt Boost Alteration by 1 point
; sltrslt Note: Currently only works on PC/Player
function actor_advskill(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            string skillName = CmdPrimary.ResolveString(param[2])
            if skillName
                Game.AdvanceSkill(skillName, CmdPrimary.ResolveFloat(param[3]))
            else
                CmdPrimary.SFE("unable to resolve skill name (" + param[2] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve actor variable (" + param[1] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_incskill
; sltgrup Actor
; sltdesc Increase targeted actor's skill by specified amount.
; sltdesc For the Player, this uses Game.IncrementSkillBy()
; sltdesc For all other Actors, this uses Actor.ModActorValue()
; sltargs Form: actor: target Actor
; sltargs string: skill: skillname e.g. Alteration, Destruction
; sltargs float: value: number
; sltsamp actor_incskill $system.self Alteration 1
; sltrslt Boost Alteration by 1 point
function actor_incskill(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            string skillName = CmdPrimary.ResolveString(param[2])
            if skillName
                if _targetActor == CmdPrimary.PlayerRef
                    Game.IncrementSkillBy(skillName, CmdPrimary.ResolveInt(param[3]))
                else
                    _targetActor.ModActorValue(skillName, CmdPrimary.ResolveFloat(param[3]))
                endif
            else
                CmdPrimary.SFE("unable to resolve skill name (" + param[2] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve actor variable (" + param[1] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_isvalid
; sltgrup Actor
; sltdesc Returns: bool: true if actor is valid, false if not.
; sltargs Form: actor: target Actor
; sltsamp actor_isvalid $actor
; sltsamp if $$ = false end
; sltsamp ...
; sltsamp [end]
; sltrslt Jump to the end if actor is not valid
function actor_isvalid(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Cell  cc = CmdPrimary.PlayerRef.getParentCell()
        
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor && _targetActor.isEnabled() && !_targetActor.isDead() && !_targetActor.isInCombat() && !_targetActor.IsUnconscious() && _targetActor.Is3DLoaded() && cc == _targetActor.getParentCell()
            nextResult = 1
        else
            If (CmdPrimary.SLT.Debug_Cmd_Functions)
                string actor_isvalid_problems = ""

                if !_targetActor
                    actor_isvalid_problems = "actor_isvalid: problems for _targetActor /_targetActor is null"
                else
                        
                    if !_targetActor.IsEnabled()
                        actor_isvalid_problems = actor_isvalid_problems + "/_targetActor is not enabled"
                    endif

                    if _targetActor.IsDead()
                        actor_isvalid_problems = actor_isvalid_problems + "/_targetActor is dead"
                    endif

                    if _targetActor.isInCombat()
                        actor_isvalid_problems = actor_isvalid_problems + "/_targetActor is in combat"
                    endif

                    if _targetActor.IsUnconscious()
                        actor_isvalid_problems = actor_isvalid_problems + "/_targetActor is unconscious"
                    endif

                    if !_targetActor.Is3DLoaded()
                        actor_isvalid_problems = actor_isvalid_problems + "/_targetActor is not 3D loaded"
                    endif

                    if cc != _targetActor.getParentCell()
                        actor_isvalid_problems = actor_isvalid_problems + "/player's cell (" + cc + ") is not same as _targetActor's parentCell(" + _targetActor.GetParentCell() + ")"
                    endif
                    
                    if actor_isvalid_problems
                        actor_isvalid_problems = "actor_isvalid: problems for _targetActor(" + _targetActor + ") " + actor_isvalid_problems
                    endif
                    
                endif

                if actor_isvalid_problems
                    SLTDebugMsg(actor_isvalid_problems)
                else
                    SLTDebugMsg("_targetActor fulfilled allrequirements; nextResult is (" + nextResult + ") and should be (1), but then you shouldn't have hit this branch of logic")
                endif

            EndIf
        endIf
    endif

    CmdPrimary.MostRecentIntResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_haslos
; sltgrup Actor
; sltdesc Returns: bool: true if first actor can see second actor, false if not.
; sltargs Form: first actor: target Actor
; sltargs Form: second actor: target Actor
; sltsamp actor_haslos $actor $system.self
; sltsamp if $$ = false cannotseeme
function actor_haslos(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _actorOne = CmdPrimary.ResolveActor(param[1])
        Actor _actorTwo = CmdPrimary.ResolveActor(param[2])
        
        if _actorOne && _actorTwo && _actorOne.hasLOS(_actorTwo)
            nextResult = true
        endIf
    endif

    CmdPrimary.MostRecentBoolResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_name
; sltgrup Actor
; sltdesc Returns: string: the actor name
; sltargs Form: actor: target Actor
; sltsamp actor_name $actor
function actor_name(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            nextResult = CmdPrimary.ActorName(_targetActor)
        endif
    endif
    
    CmdPrimary.MostRecentStringResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_display_name
; sltgrup Actor
; sltdesc Returns: string: the actor displayName
; sltargs Form: actor: target Actor
; sltsamp actor_display_name $actor
function actor_display_name(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            nextResult = CmdPrimary.ActorDisplayName(_targetActor)
        endif
    endif
    
    CmdPrimary.MostRecentStringResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_modcrimegold
; sltgrup Actor
; sltdesc Specified actor reports player, increasing bounty by specified amount.
; sltargs Form: actor: target Actor
; sltargs int: bountyMod: amount to modify bounty by
; sltsamp actor_modcrimegold $actor 100
function actor_modcrimegold(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            Faction crimeFact = _targetActor.GetCrimeFaction()
            if crimeFact
                crimeFact.ModCrimeGold(CmdPrimary.ResolveInt(param[2]), false)
            endIf
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_qnnu
; sltgrup Actor
; sltdesc Repaints actor (calls QueueNiNodeUpdate)
; sltargs Form: actor: target Actor
; sltsamp actor_qnnu $actor
; sltrslt Note: Do not call this too frequently as the rapid refreshes can causes crashes to desktop
function actor_qnnu(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            _targetActor.QueueNiNodeUpdate()
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_isguard
; sltgrup Actor
; sltdesc Returns: bool: true if actor is guard, 1 otherwise.
; sltargs actor: target Actor
; sltsamp actor_isguard $actor
function actor_isguard(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor && _targetActor.IsGuard()
            nextResult = true
        endIf
    endif

    CmdPrimary.MostRecentBoolResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_isplayer
; sltgrup Actor
; sltdesc Returns: bool: true if actor is the player, false otherwise.
; sltargs Form: actor: target Actor
; sltsamp actor_isplayer $actor
function actor_isplayer(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor && _targetActor == CmdPrimary.PlayerRef
            nextResult = true
        endIf
    endif

    CmdPrimary.MostRecentBoolResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_getgender
; sltgrup Actor
; sltdesc Returns: int: the actor's gender, 0 - male, 1 - female, -1 - None
; sltargs Form: actor: target Actor
; sltsamp actor_getgender $actor
function actor_getgender(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult = -1

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            nextResult = CmdPrimary.ActorGender(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentIntResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_say
; sltgrup Actor
; sltdesc Causes the actor to 'say' the topic indicated by FormId; not usable on the Player
; sltargs Form: actor: target Actor
; sltargs Form topic: the TopicInfo to say
; sltsamp actor_say $actor "Skyrim.esm:1234"
function actor_say(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Topic thing = CmdPrimary.ResolveForm(param[2]) as Topic
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            if _targetActor
                _targetActor.Say(thing)
            endif
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_haskeyword
; sltgrup Actor
; sltdesc Returns: bool: true if actor has the keyword, false otherwise.
; sltargs Form: actor: target Actor
; sltargs string: keyword: keyword name
; sltsamp actor_haskeyword $actor Vampire
function actor_haskeyword(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Keyword keyw = Keyword.GetKeyword(CmdPrimary.ResolveString(param[2]))
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if keyw && _targetActor && _targetActor.HasKeyword(keyw)
            nextResult = true
        endIf
    endif

    CmdPrimary.MostRecentBoolResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_iswearing
; sltgrup Actor
; sltdesc Returns: bool: true if actor is wearing the armor indicated by the FormId, false otherwise.
; sltargs actor: target Actor
; sltargs armor: ARMO FormID
; sltsamp actor_iswearing $actor "petcollar.esp:31017"
function actor_iswearing(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Armor thing = CmdPrimary.ResolveForm(param[2]) as Armor
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if thing && _targetActor && _targetActor.IsEquipped(thing)
            nextResult = true
        endIf
    endif

    CmdPrimary.MostRecentBoolResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_getscale
; sltgrup Actor
; sltdesc Returns: float: the 'scale' value of the specified Actor
; sltdesc Note: this is properly a function of ObjectReference, so may get pushed to a different group at some point
; sltargs Form: actor: target Actor
; sltsamp actor_getscale $system.self
; sltsamp msg_console "Scale reported: " $$
function actor_getscale(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            nextResult = _targetActor.GetScale()
        endif
    endif

    CmdPrimary.MostRecentFloatResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_setscale
; sltgrup Actor
; sltdesc Sets the actor's scale to the specified value
; sltdesc Note: this is properly a function of ObjectReference, so may get pushed to a different group at some point
; sltargs Form: actor: target Actor
; sltargs scale: float, new scale value to replace the old
; sltsamp actor_setscale $system.self 1.01
function actor_setscale(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        float newScale = CmdPrimary.ResolveFloat(param[2])
        if _targetActor
            _targetActor.SetScale(newScale)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_worninslot
; sltgrup Actor
; sltdesc Returns: bool: true if actor is wearing armor in the indicated slotId, false otherwise.
; sltargs Form: actor: target Actor
; sltargs int: armorslot: number, e.g. 32 for body slot
; sltsamp actor_worninslot $actor 32
function actor_worninslot(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor && _targetActor.GetEquippedArmorInSlot(CmdPrimary.ResolveInt(param[2]))
            nextResult = true
        endIf
    endif

    CmdPrimary.MostRecentBoolResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_wornhaskeyword
; sltgrup Actor
; sltdesc Returns: bool: true if actor is wearing any armor with indicated keyword, false otherwise.
; sltargs Form: actor: target Actor
; sltargs string: keyword: keyword name
; sltsamp actor_wornhaskeyword $actor "VendorItemJewelry"
function actor_wornhaskeyword(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Keyword keyw = Keyword.GetKeyword(CmdPrimary.ResolveString(param[2]))
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        
        if keyw && _targetActor && _targetActor.WornHasKeyword(keyw)
            nextResult = true
        endIf
    endif

    CmdPrimary.MostRecentBoolResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_lochaskeyword
; sltgrup Actor
; sltdesc Returns: bool: true if actor's current location has the indicated keyword, false otherwise.
; sltargs Form: actor: target Actor
; sltargs string: keyword: keyword name
; sltsamp actor_lochaskeyword $actor "LocTypeInn"
; sltrslt In a bar, inn, or tavern
function actor_lochaskeyword(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Keyword keyw = Keyword.GetKeyword(CmdPrimary.ResolveString(param[2]))
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        
        if keyw && _targetActor && _targetActor.GetCurrentLocation().HasKeyword(keyw)
            nextResult = true
        endIf
    endif

    CmdPrimary.MostRecentBoolResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_getrelation
; sltgrup Actor
; sltdesc Returns: int: the relationship rank between the two actors
; sltargs Form: first actor: target Actor
; sltargs Form: second actor: target Actor
; sltsamp actor_getrelation $actor $system.player
; sltrslt  4  - Lover
; sltrslt  3  - Ally
; sltrslt  2  - Confidant
; sltrslt  1  - Friend
; sltrslt  0  - Acquaintance
; sltrslt  -1 - Rival
; sltrslt  -2 - Foe
; sltrslt  -3 - Enemy
; sltrslt  -4 - Archnemesis
function actor_getrelation(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _actorOne = CmdPrimary.ResolveActor(param[1])
        Actor _actorTwo = CmdPrimary.ResolveActor(param[2])
        if _actorOne && _actorTwo
            nextResult = _actorOne.GetRelationshipRank(_actorTwo)
        endif
    endif
    
    CmdPrimary.MostRecentIntResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_setrelation
; sltgrup Actor
; sltdesc Set relationship rank between the two actors to the indicated value
; sltargs Form: first actor: target Actor
; sltargs Form: second actor: target Actor
; sltargs int: rank: new rank
; sltsamp actor_setrelation $actor $system.player 0
; sltrslt See actor_getrelation for ranks
function actor_setrelation(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _actorOne = CmdPrimary.ResolveActor(param[1])
        Actor _actorTwo = CmdPrimary.ResolveActor(param[2])
        if _actorOne && _actorTwo
            _actorOne.SetRelationshipRank(_actorTwo, CmdPrimary.ResolveInt(param[3]))
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_infaction
; sltgrup Actor
; sltdesc Returns: bool: true if actor is in the faction indicated by the FormId, false otherwise
; sltargs Form: actor: target Actor
; sltargs Form: faction: the Faction
; sltsamp actor_infaction $actor "skyrim.esm:378958"
; sltrslt $$ will be true if $actor is a follower (CurrentFollowerFaction)
function actor_infaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        Faction thing = CmdPrimary.ResolveForm(param[2]) as Faction
        if _targetActor && thing && _targetActor.IsInFaction(thing)
            nextResult = true
        endif
    endif

    CmdPrimary.MostRecentBoolResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_getfactionrank
; sltgrup Actor
; sltdesc Returns: int: the actor's rank in the faction indicated by the FormId
; sltargs Form: actor: target Actor
; sltargs Form: faction: the Faction
; sltsamp actor_getfactionrank $actor "skyrim.esm:378958"
function actor_getfactionrank(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult = 0

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            Faction thing = CmdPrimary.ResolveForm(param[2]) as Faction
            
            if thing
                nextResult = _targetActor.GetFactionRank(thing)
            endif
        endif
    endif

    CmdPrimary.MostRecentIntResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_setfactionrank
; sltgrup Actor
; sltdesc Sets the actor's rank in the faction indicated by the FormId to the indicated rank
; sltargs Form: actor: target Actor
; sltargs Form: faction: target Faction
; sltargs int: rank: new faction rank
; sltsamp actor_setfactionrank $actor "skyrim.esm:378958" -1
function actor_setfactionrank(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            Faction thing = CmdPrimary.ResolveForm(param[2]) as Faction
            if thing
                _targetActor.SetFactionRank(thing, CmdPrimary.ResolveInt(param[3]))
            endif
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_isaffectedby
; sltgrup Actor
; sltdesc Returns: bool: true if the specified actor is currently affected by the MGEF or SPEL indicated by FormID (accepts either); false otherwise
; sltargs Form: actor: target Actor
; sltargs (optional) "ALL": if specified, all following MGEF or SPEL FormIDs must be found on the target Actor
; sltargs Form: mgef: MGEF (Magic Effect) or SPEL (Spell) to check for
; sltargs ; are they affected by all of the effectts (AND)
; sltargs Usage 1: actor_isaffectedby $system.self ALL "skyrim.esm:1030541" "skyrim.esm:1030542" "skyrim.esm:1030543"
; sltargs ; are they affected by any of the effectts (OR)
; sltargs Usage 2: actor_isaffectedby $system.self "skyrim.esm:1030541" "skyrim.esm:1030542" "skyrim.esm:1030543"
function actor_isaffectedby(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    bool actualResult
    int nextResult = -1

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            int idx = 2
            bool needAll
            int spelidx
            int numeffs
            while idx < param.Length && nextResult < -1
                string pstr = CmdPrimary.ResolveString(param[idx])
                if idx == 2 && "ALL" == pstr
                    needAll = true
                    idx += 1
                else
                    Form wizardStuff = CmdPrimary.ResolveForm(param[idx])

                    if wizardStuff
                        if !needAll
                            MagicEffect mgef = wizardStuff as MagicEffect
                            if mgef
                                if _targetActor.HasMagicEffect(mgef)
                                    nextResult = 1
                                endif
                            endif
                            
                            Spell spel = wizardStuff as Spell
                            if spel
                                spelidx = 0
                                numeffs = spel.GetNumEffects()
                                while spelidx < numeffs && nextResult < 0
                                    mgef = spel.GetNthEffectMagicEffect(spelidx)
                                    if _targetActor.HasMagicEffect(mgef)
                                        nextResult = 1
                                    endif
                                    
                                    spelidx += 1
                                endwhile
                            endif
                        endif
                    elseif needAll
                        nextResult = 0
                    endif
                endif
            endwhile
        endif
    endif

    if nextResult < 0
        nextResult = 0
    endif

    actualResult = (nextResult == 1)
	
	CmdPrimary.MostRecentBoolResult = actualResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_removefaction
; sltgrup Actor
; sltdesc Removes the actor from the specified faction
; sltargs Form: actor: target Actor
; sltargs Form: faction: target Faction
; sltsamp actor_removefaction $actor "skyrim.esm:3505"
function actor_removefaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        Faction thing = CmdPrimary.ResolveForm(param[2]) as Faction
    
        if thing && _targetActor
            _targetActor.RemoveFromFaction(thing)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_playanim
; sltgrup Actor
; sltdesc Causes the actor to play the specified animation
; sltargs Form: actor: target Actor
; sltargs string: animation: animation name
; sltsamp actor_playanim $system.self "IdleChildCryingStart"
function actor_playanim(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Debug.SendAnimationEvent(CmdPrimary.ResolveActor(param[1]), CmdPrimary.ResolveString(param[2]))
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_sendmodevent
; sltgrup Actor
; sltdesc Causes the actor to send the mod event with the provided arguments
; sltargs Form: actor: target Actor
; sltargs string: event: name of the event
; sltargs string: args: string argument (meaning varies by event sent) (optional: default "")
; sltargs float: argf: float argument (meaning varies by event sent) (optional: default 0.0)
; sltsamp actor_sendmodevent $system.self "IHaveNoIdeaButEventNamesShouldBeEasyToFind" "strarg" 20.0
function actor_sendmodevent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            string ss1 = CmdPrimary.ResolveString(param[2])
            string ss2
            if param.Length > 3
                ss2 = CmdPrimary.ResolveString(param[3])
            endif
            float  p3
            if param.Length > 4
                p3 = CmdPrimary.ResolveFloat(param[4])
            endif
            
            _targetActor.SendModEvent(ss1, ss2, p3)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_state
; sltgrup Actor
; sltdesc Returns: (varies): the state of the actor for a given sub-function
; sltargs actor: target Actor
; sltargs sub-function: sub-function
; sltargs third argument: varies by sub-function
; sltargsmore if parameter 2 is "GetCombatState": return actors combatstate. 0-no combat, 1-combat, 2-searching
; sltargsmore if parameter 2 is "GetLevel": return actors level
; sltargsmore if parameter 2 is "GetSleepState": return actors sleep mode. 0-not, 1-not, but wants to, 2-sleeping, 3-sleeping, but wants to wake up
; sltargsmore if parameter 2 is "IsAlerted": is actor alerted
; sltargsmore if parameter 2 is "IsAlarmed": is actor alerted
; sltargsmore if parameter 2 is "IsPlayerTeammate": is actor PC team member
; sltargsmore if parameter 2 is "SetPlayerTeammate" (parameter 3: <bool true to set, false to unset>): set actor as PC team member
; sltargsmore if parameter 2 is "SendAssaultAlarm": actor will send out alarm 
; sltsamp actor_state $system.self "GetCombatState"
function actor_state(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        string ss1 = CmdPrimary.ResolveString(param[2])
        
        if _targetActor 
            if ss1 == "GetCombatState"
                CmdPrimary.MostRecentIntResult = _targetActor.GetCombatState()
            elseif ss1 == "GetLevel"
                CmdPrimary.MostRecentIntResult = _targetActor.GetLevel()
            elseif ss1 == "GetSleepState"
                CmdPrimary.MostRecentIntResult = _targetActor.GetSleepState()
            elseif ss1 == "IsAlerted"
                CmdPrimary.MostRecentBoolResult = _targetActor.IsAlerted()
            elseif ss1 == "IsAlarmed"
                CmdPrimary.MostRecentBoolResult = _targetActor.IsAlarmed()
            elseif ss1 == "IsPlayerTeammate"
                CmdPrimary.MostRecentBoolResult = _targetActor.IsPlayerTeammate()
            elseif ss1 == "SetPlayerTeammate"
                bool p3 = false
                if param.Length > 3
                    p3 = CmdPrimary.ResolveBool(param[3])
                endif
                _targetActor.SetPlayerTeammate(p3)
            elseif ss1 == "SendAssaultAlarm"
                _targetActor.SendAssaultAlarm()
            endIf
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_body
; sltgrup Actor
; sltdesc Returns: (varies): Alters or queries information about the actor's body, based on sub-function
; sltargs actor: target Actor
; sltargs sub-function: sub-function
; sltargs third argument: varies by sub-function
; sltargsmore if parameter 2 is "ClearExtraArrows": clear extra arrows 
; sltargsmore if parameter 2 is "RegenerateHead": regenerate head
; sltargsmore if parameter 2 is "GetWeight": get actors weight (0-100)
; sltargsmore if parameter 2 is "SetWeight" (parameter 3: <float, weight>): set actors weight
; sltsamp actor_body $system.self "SetWeight" 110
function actor_body(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        string ss1 = CmdPrimary.ResolveString(param[2])
        
        if _targetActor 
            if ss1 == "ClearExtraArrows"
                _targetActor.ClearExtraArrows()
            elseif ss1 == "RegenerateHead"
                _targetActor.RegenerateHead()
            elseif ss1 == "GetWeight"
                CmdPrimary.MostRecentFloatResult = _targetActor.GetActorBase().GetWeight()
            elseif ss1 == "SetWeight"
                float baseW = _targetActor.GetActorBase().GetWeight()
                float p3
                if param.Length > 3
                    p3 = CmdPrimary.ResolveFloat(param[3])
                endif
                    
                float newW  = p3
                If newW < 0
                    newW = 0
                ElseIf newW > 100
                    newW = 100
                EndIf
                float neckD = (baseW - newW) / 100
        
                If neckD
                    _targetActor.GetActorBase().SetWeight(newW)
                    _targetActor.UpdateWeight(neckD)
                EndIf
            endIf
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_race_type
; sltgrup Actor
; sltdesc Returns: int: the "race type". This is what the "Race" filter uses for filtering.
; sltargs Form: actor: target Actor
; sltsamp actor_race_type $system.self
; sltrslt 0 - error occurred
; sltrslt 1 - Player
; sltrslt 2 - Humanoid - Actor.HasKeyword(ActorTypeNPC)
; sltrslt 3 - Undead - Actor.HasKeyword(ActorTypeUndead)
; sltrslt 4 - Creature - presumed, default if nothing else matches
function actor_race_type(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        
        if _targetActor
            nextResult = CmdPrimary.ActorRaceType(_targetActor)
        else
            CmdPrimary.SFW("_targetActor not able to be loaded")
        endIf
    endif

    CmdPrimary.MostRecentIntResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_race
; sltgrup Actor
; sltdesc Returns: string: the race name based on sub-function. Blank, empty sub-function returns Vanilla racenames. e.g. "SL" can return SexLab race keynames.
; sltargs Form: actor: target Actor
; sltargs string: sub-function: sub-function
; sltargsmore if parameter 2 is "": return actors race name. Skyrims, original name. Like: "Nord", "Breton"
; sltsamp actor_race $system.self ""
function actor_race(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if CmdPrimary.SLT.Debug_Cmd_Functions
        CmdPrimary.SFD("Base.actor_race params/" + PapyrusUtil.StringJoin(param, "/") + "/")
    endif

    string nextResult

    if param.Length == 2
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        
        if _targetActor
            if CmdPrimary.SLT.Debug_Cmd_Functions
                Race tr = _targetActor.GetRace()
                string nm = tr.GetName()
                CmdPrimary.SFD("Base.actor_race: _targetActor(" + _targetActor + ") race(" + tr + ") name(" + nm + ")")
            endif
            nextResult = _targetActor.GetRace().GetName()
        else
            CmdPrimary.SFW("actor_race: Unable to resolve actor token(" + param[1] + ")")
        endIf
    elseif param.Length == 3
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        
        if _targetActor
            string ss1 = CmdPrimary.ResolveString(param[2])
            if CmdPrimary.SLT.Debug_Cmd_Functions
                Race tr = _targetActor.GetRace()
                string nm = tr.GetName()
                CmdPrimary.SFD("Base.actor_race: ss1(" + ss1 + ") _targetActor(" + _targetActor + ") race(" + tr + ") name(" + nm + ")")
            endif
            if !ss1
                nextResult = _targetActor.GetRace().GetName()
            endIf
        else
            CmdPrimary.SFW("actor_race: Unable to resolve actor token(" + param[1] + ")")
        endIf
    else
        CmdPrimary.SFE("actor_race: invalid parameter count")
    endif

    if CmdPrimary.SLT.Debug_Cmd_Functions
        CmdPrimary.SFD("Base.actor_race supposed to return(" + nextResult + ")")
    endif
    CmdPrimary.MostRecentStringResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_setalpha
; sltgrup Actor
; sltdesc Set the Actor's alpha value (inverse of transparency, 1.0 is fully visible) (has no effect if IsGhost() returns true)
; sltargs Form: actor: target Actor
; sltargs float: alpha: 0.0 to 1.0 (higher is more visible)
; sltargs bool: fade: false - instant | true - fade to the new alpha gradually (optional: default true - fade)
; sltsamp actor_setalpha $system.self 0.5 true
; sltrslt $system.self will fade to new alpha of 0.5, not instantly
function actor_setalpha(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 5)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        
        if _targetActor && !_targetActor.IsGhost()
            float alpha = CmdPrimary.ResolveFloat(param[2])
            bool abFade = true
            if param.Length > 3
                abFade = CmdPrimary.ResolveBool(param[3])
            endif
            _targetActor.SetAlpha(alpha, abFade)
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_submerged_level
; sltgrup Actor
; sltdesc Returns: float: Get the Actor's level of water submersion (from 0.0 to 1.0; 0.0 meaning not touching water, and 1.0 being fully submerged)
; sltargs Form: actor: target Actor
; sltsamp set $submersion resultfrom actor_submerged_level $system.self
; sltsamp ; at about $submersion 0.65 or so, you are chest high and likely to start having to swim
function actor_submerged_level(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
    sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])

        if _targetActor
            CmdPrimary.MostRecentFloatResult = sl_triggers.GetSubmergedLevel(_targetActor)
        else
            CmdPrimary.SFW("actor_submerged_level: unable to resolve actor from (" + param[1] + ")")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ism_applyfade
; sltgrup Imagespace Modifier
; sltdesc Apply imagespace modifier - per original author, check CreationKit, SpecialEffects\Imagespace Modifier
; sltargs Form: item: ImageSpaceModifier to apply
; sltargs float: duration: cross-fade duration in seconds
; sltsamp ism_applyfade $1 2
function ism_applyfade(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        ImageSpaceModifier thing = CmdPrimary.ResolveForm(param[1]) as ImageSpaceModifier
    
        if thing
            thing.ApplyCrossFade(CmdPrimary.ResolveFloat(param[2]))
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ism_removefade
; sltgrup Imagespace Modifier
; sltdesc Remove imagespace modifier - per original author, check CreationKit, SpecialEffects\Imagespace Modifier
; sltargs float: duration: cross-fade removal duration in seconds
; sltsamp ism_removefade 2
function ism_removefade(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        ImageSpaceModifier.RemoveCrossFade(CmdPrimary.ResolveFloat(param[1]))
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname util_sendmodevent
; sltgrup Utility
; sltdesc Shorthand for actor_sendmodevent $system.player <event name> <string argument> <float argument>
; sltargs string: event: name of the event
; sltargs string: arg: string argument (meaning varies by event sent) (optional: default "")
; sltargs float: arg: float argument (meaning varies by event sent) (optional: default 0.0)
; sltsamp util_sendmodevent "IHaveNoIdeaButEventNamesShouldBeEasyToFind" "strarg" 0.0
function util_sendmodevent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        string ss1 = CmdPrimary.ResolveString(param[1])
        string ss2
        if param.Length > 2
            ss2 = CmdPrimary.ResolveString(param[2])
        endif
        float  p3
        if param.Length > 3
            p3 = CmdPrimary.ResolveFloat(param[3])
        endif
        
        if CmdPrimary.SLT.Debug_Cmd_Functions
            CmdPrimary.SFD("\tutil_sendmodevent: eventName(" + ss1 + ") strArg(" + ss2 + ") numArg(" + p3 + ")")
        endif
        CmdTargetActor.SendModEvent(ss1, ss2, p3)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname util_sendevent
; sltgrup Utility
; sltdesc Send SKSE custom event, with each type/value pair being an argument to the custom event
; sltargs string: event: name of the event
; sltargs (type/value pairs are optional; this devolves to util_sendmodevent <eventname>, though with such a call the event signature would require having no arguments)
; sltargs string: param type: type of parameter e.g. "bool", "int", etc.
; sltargs string: param value: value of parameter
; sltargs [type/value, type/value ...]
; sltargsmore <type> can be any of [bool, int, float, string, form]
; sltsamp util_sendevent "slaUpdateExposure" form $system.self float 33
; sltrslt The "slaUpdateExposure" event will be sent with $system.self, and the float value of 33.0 as the two arguments
function util_sendevent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthGT(CmdPrimary, param.Length, 1)
        string eventName = CmdPrimary.ResolveString(param[1])
        if eventName
            int eid = ModEvent.Create(eventName)
            
            if eid
                string typeId
                
                int idxArg = 2 
                while idxArg + 1 < param.Length
                    typeId = CmdPrimary.ResolveString(param[idxArg])

                    if typeId == "bool"
                        ModEvent.PushBool(eid, CmdPrimary.ResolveBool(param[idxArg + 1]))
                    elseif typeId == "int"
                        ModEvent.PushInt(eid, CmdPrimary.ResolveInt(param[idxArg + 1]))
                    elseif typeId == "float"
                        ModEvent.PushFloat(eid, CmdPrimary.ResolveFloat(param[idxArg + 1]))
                    elseif typeId == "string"
                        ModEvent.PushString(eid, CmdPrimary.ResolveString(param[idxArg + 1]))
                    elseif typeId == "form"
                        ModEvent.PushForm(eid, CmdPrimary.ResolveActor(param[idxArg + 1]))
                    else
                        SquawkFunctionError(CmdPrimary, "util_sendevent: unexpected type provided: '" + typeId + "'")
                    endif
                    
                    idxArg += 2
                endWhile

                if idxArg > param.Length
                    SquawkFunctionError(CmdPrimary, "util_sendevent: imbalanced type/value pairs provided")
                endif
                
                ModEvent.Send(eid)
            endIf
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname util_getgametime
; sltgrup Utility
; sltdesc Returns: float: the value of Utility.GetCurrentGameTime() (a float value representing the number of days in game time; mid-day day 2 is 1.5)
; sltsamp util_getgametime
function util_getgametime(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        float dayTime = CmdPrimary.SLT.GetTheGameTime()
        dayTime = Math.Floor(dayTime * 100.0) / 100.0
        CmdPrimary.MostRecentFloatResult = dayTime
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname util_getrealtime
; sltgrup Utility
; sltdesc Returns: float: the value of Utility.GetCurrentRealTime() (a float value representing the number of seconds since Skyrim.exe was launched this session)
; sltsamp util_getrealtime
function util_getrealtime(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if CmdPrimary.SLT.Debug_Cmd_Functions
        SLTDebugMsg("util_getrealtime: starting")
    endif

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        float realTime = Utility.GetCurrentRealTime()
        realTime = Math.Floor(realTime * 100.0) / 100.0

        if CmdPrimary.SLT.Debug_Cmd_Functions
            SLTDebugMsg("util_getrealtime: realtime(" + realtime + ")")
        endif
        CmdPrimary.MostRecentFloatResult = realTime
    endif

    if CmdPrimary.SLT.Debug_Cmd_Functions
        SLTDebugMsg("util_getrealtime: returning")
    endif
	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname util_getgametime
; sltgrup Utility
; sltdesc Returns: int: the in-game hour (i.e. 2:30 AM returns 2)
; sltsamp util_getgametime
function util_gethour(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        float dayTime = CmdPrimary.SLT.GetTheGameTime()
    
        dayTime -= Math.Floor(dayTime)
        dayTime *= 24
        
        int theHour = dayTime as int
        
        CmdPrimary.MostRecentIntResult = theHour
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname util_game
; sltgrup Utility
; sltdesc Returns: (varies): Perform game related functions based on sub-function
; sltargs sub-function: sub-function
; sltargs parameter: varies by sub-function
; sltargsmore if sub-function is "IncrementStat", (parameter 3, <stat name>, parameter 4, <amount>), see https://ck.uesp.net/wiki/IncrementStat_-_Game
; sltargsmore if sub-function is "QueryStat", (parameter 3, <stat name>), returns the value
; sltsamp util_game "IncrementStat" "Bribes" 1
function util_game(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthGT(CmdPrimary, param.Length, 2)
        string p1 = CmdPrimary.ResolveString(param[1])
        
        if "IncrementStat" == p1
            int iModAmount
            if param.Length > 3
                iModAmount = CmdPrimary.ResolveInt(param[3])
            endif
            Game.IncrementStat(CmdPrimary.ResolveString(param[2]), iModAmount)
        elseIf "QueryStat" == p1
            CmdPrimary.MostRecentIntResult = Game.QueryStat(CmdPrimary.ResolveString(param[2]))
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname snd_play
; sltgrup Sound
; sltdesc Returns: int: the sound instance handle from playing the specified audio from the specified actor
; sltargs Form: audio: the Audio Form to play
; sltargs Form: actor: target Actor
; sltsamp snd_play "skyrim.esm:318128" $system.self
function snd_play(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult = 0
	
    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Sound   thing = CmdPrimary.ResolveForm(param[1]) as Sound
        Actor   _targetActor = CmdPrimary.ResolveActor(param[2])
        int     retVal
        if thing && _targetActor
            nextResult = thing.Play(_targetActor)
        endIf
    endif

    CmdPrimary.MostRecentIntResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname snd_setvolume
; sltgrup Sound
; sltdesc Set the sound volume using the specified sound instance handle (from snd_play)
; sltargs int: handle: sound instance handle from snd_play
; sltargs Form: actor: target Actor
; sltargs float; volume: 0.0 - 1.0
; sltsamp snd_setvolume $1 0.5
; sltrslt Set the volume of the audio sound playing with handle stored in $1 to 50%
function snd_setvolume(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        int    soundId = CmdPrimary.ResolveInt(param[1])
        float  vol     = CmdPrimary.ResolveFloat(param[2])
        Sound.SetInstanceVolume(soundId, vol)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname snd_stop
; sltgrup Sound
; sltdesc Stops the audio specified by the sound instance handle (from snd_play)
; sltargs int: handle: sound instance handle from snd_play
; sltsamp snd_stop $1
function snd_stop(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        int    soundId = CmdPrimary.ResolveInt(param[1])
        Sound.StopInstance(soundId)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname console
; sltgrup Utility
; sltdesc Executes the console command (requires a ConsoleUtil variant installed
; sltdesc Recommend ConsoleUtil-Extended https://www.nexusmods.com/skyrimspecialedition/mods/133569)
; sltargs Form: actor: target Actor
; sltargs string: command: <command fragment> [<command fragment> ...] ; all <command fragments> will be concatenated
; sltsamp console $system.self "sgtm" "" "0.5"
; sltsamp console $system.self "sgtm 0.5"
; sltrslt Both are the same
function console(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])

        if _targetActor
            int cnt = param.length
            int idx = 2
        
            string ss
            string ssx
            while idx < cnt
                ss = CmdPrimary.ResolveString(param[idx])
                ssx += ss
                idx += 1
            endWhile
            
            sl_TriggersConsole.exec_console(_targetActor, ssx)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname mfg_reset
; sltgrup MfgFix
; sltdesc Resets facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)
; sltargs Form: actor: target Actor
; sltsamp mfg_reset $system.self
function mfg_reset(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            sl_TriggersMfg.mfg_reset(_targetActor)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname mfg_setphonememodifier
; sltgrup MfgFix
; sltdesc Set facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)
; sltargs Form: actor: target Actor
; sltargs int: mode: number, 0 - set phoneme | 1 - set modifier
; sltargs int: id: an id  (I'm not familiar with MfgFix :/)
; sltargs int: value: new value
; sltargs <actor variable> <mode> <id> <value>
; sltsamp mfg_setphonememodifier $system.self 0 $1 $2
function mfg_setphonememodifier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthEQ(CmdPrimary, param.Length, 5)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if !_targetActor
            sl_TriggersMfg.mfg_SetPhonemeModifier(_targetActor, CmdPrimary.ResolveInt(param[2]), CmdPrimary.ResolveInt(param[3]), CmdPrimary.ResolveInt(param[4]))
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname mfg_getphonememodifier
; sltgrup MfgFix
; sltdesc Returns: int: facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)
; sltargs Form: actor: target Actor
; sltargs int: mode: number, 0 - set phoneme | 1 - set modifier
; sltargs int: id: an id (I'm not familiar with MfgFix :/)
; sltsamp mfg_getphonememodifier $system.self 0 $1
function mfg_getphonememodifier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult
	
    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            nextResult = sl_TriggersMfg.mfg_GetPhonemeModifier(_targetActor, CmdPrimary.ResolveInt(param[2]), CmdPrimary.ResolveInt(param[3]))
        endif
    endif

    CmdPrimary.MostRecentIntResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname util_waitforkbd
; sltgrup Utility
; sltdesc Returns: int: the keycode pressed after waiting for user to press any of the specified keys.
; sltdesc (See https://ck.uesp.net/wiki/Input_Script for the DXScanCodes)
; sltdesc Usage 1: util_waitforkbd <dxscancode> [<dxscancode> ...]
; sltargs int: dxscancode: <DXScanCode of key>
; sltdesc Usage 2: util_waitforkbd $keylist ; where $keylist is a int[]
; sltargs int[]: keylist: a list of dxscancode
; sltrslt ; These do the same thing
; sltsamp util_waitforkbd 74 78 181 55
; sltsamp listadd $keystowaitfor 74 78 181 55
; sltsamp util_waitforkbd $keystowaitfor
function util_waitforkbd(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult = -1
	
    if ParamLengthGT(CmdPrimary, param.Length, 1) && CmdTargetActor == CmdPrimary.PlayerRef
        int cnt         = param.length
        int idx
        int scancode
    
        CmdPrimary.UnregisterForAllKeys()

        int[] resolvedListInt = CmdPrimary.ResolveListInt(param[1])
        if (resolvedListInt)
            idx = resolvedListInt.Length
            while idx
                idx -= 1
                if resolvedListInt[idx] > 0
                    CmdPrimary.RegisterForKey(resolvedListInt[idx])
                endIf
            endWhile
        else
            idx = 1
            while idx < cnt
                scancode = CmdPrimary.ResolveInt(param[idx])
                if scancode > 0
                    CmdPrimary.RegisterForKey(scanCode)
                endIf
                idx += 1
            endWhile
        endif
        
        CmdPrimary.lastKey = 0
        
        while CmdPrimary && CmdPrimary.lastKey == 0
            Utility.Wait(0.5)
        endWhile
    
        CmdPrimary.UnregisterForAllKeys()

        if CmdPrimary.lastKey ; and at this point, it really ought to be
            nextResult = CmdPrimary.lastKey
        endif
    endif

    CmdPrimary.MostRecentIntResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname json_getvalue
; sltgrup JSON
; sltdesc Returns: (varies): value from JSON file (uses PapyrusUtil/JsonUtil)
; sltargs string: filename: name of file, rooted from 'Data/SKSE/Plugins/StorageUtilData'
; sltargs string: datatype: int, float, string
; sltargs string: key: the key
; sltargs (varies): default: default value in case it isn't present (optional: default for type)
; sltsamp json_getvalue "../somefolder/afile" float "demofloatvalue" 2.3
; sltrslt JsonUtil automatically appends .json when not given a file extension
function json_getvalue(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult
	
    if ParamLengthGT(CmdPrimary, param.Length, 3)
        string pname = CmdPrimary.ResolveString(param[1])
        string ptype = CmdPrimary.ResolveString(param[2])
        string pkey  = CmdPrimary.ResolveString(param[3])
        
        if pname && ptype && pkey
            if ptype == "int"
                CmdPrimary.MostRecentIntResult = JsonUtil.GetIntValue(pname, pkey, CmdPrimary.ResolveInt(param[4]))
            elseif ptype == "float"
                CmdPrimary.MostRecentFloatResult = JsonUtil.GetFloatValue(pname, pkey, CmdPrimary.ResolveFloat(param[4]))
            elseif ptype == "form"
                CmdPrimary.MostRecentFormResult = JsonUtil.GetFormValue(pname, pkey, CmdPrimary.ResolveForm(param[4]))
            else
                CmdPrimary.MostRecentStringResult = JsonUtil.GetStringValue(pname, pkey, CmdPrimary.ResolveString(param[4]))
            endIf
        else
            if !pname
                SquawkFunctionError(CmdPrimary, "could not resolve JSON filename")
            endif
            if !ptype
                SquawkFunctionError(CmdPrimary, "could not resolve JSON type")
            endif
            if !pkey
                SquawkFunctionError(CmdPrimary, "could not resolve JSON key")
            endif
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname json_setvalue
; sltgrup JSON
; sltdesc Sets a value in a JSON file (uses PapyrusUtil/JsonUtil)
; sltargs string: filename: name of file, rooted from 'Data/SKSE/Plugins/StorageUtilData'
; sltargs string: datatype: int, float, string
; sltargs string: key: the key
; sltargs (varies): new value: value to set
; sltsamp json_setvalue "../somefolder/afile" float "demofloatvalue" 2.3
; sltrslt JsonUtil automatically appends .json when not given a file extension
function json_setvalue(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthEQ(CmdPrimary, param.Length, 5)
        string pname = CmdPrimary.ResolveString(param[1])
        string ptype = CmdPrimary.ResolveString(param[2])
        string pkey  = CmdPrimary.ResolveString(param[3])
    
        if pname && ptype && pkey
            if ptype == "int"
                JsonUtil.SetIntValue(pname, pkey, CmdPrimary.ResolveInt(param[4]))
            elseif ptype == "float"
                JsonUtil.SetFloatValue(pname, pkey, CmdPrimary.ResolveFloat(param[4]))
            elseif ptype == "string"
                JsonUtil.SetStringValue(pname, pkey, CmdPrimary.ResolveString(param[4]))
            else
                SquawkFunctionError(CmdPrimary, "json_setvalue: unexpected type '" + ptype +  "'")
            endIf
        else
            if !pname
                SquawkFunctionError(CmdPrimary, "json_setvalue: could not resolve JSON filename")
            endif
            if !ptype
                SquawkFunctionError(CmdPrimary, "json_setvalue: could not resolve JSON type")
            endif
            if !pkey
                SquawkFunctionError(CmdPrimary, "json_setvalue: could not resolve JSON key")
            endif
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname json_save
; sltgrup JSON
; sltdesc Tells JsonUtil to immediately save the specified file from cache
; sltargs string: filename: name of file, rooted from 'Data/SKSE/Plugins/StorageUtilData'
; sltsamp json_save "../somefolder/afile"
function json_save(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        string pname = CmdPrimary.ResolveString(param[1])
        if pname
            JsonUtil.Save(pname)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

string function getValidJSONType(sl_triggersCmd CmdPrimary, string jtype) global
    if "int" == jtype || "float" == jtype || "string" == jtype || "form" == jtype
        return jtype
    endif
    SquawkFunctionError(CmdPrimary, "jsonutil: unimplemented JSON type (" + jtype + ")")
    return ""
endfunction

; sltname jsonutil
; sltgrup PapyrusUtil
; sltdesc Wrapper around most JsonUtil functions
; sltargs <sub-function> - JsonUtil functionality to perform
; sltargs <filename> - JSON file to interact with, rooted from 'Data/SKSE/Plugins/StorageUtilData'
; sltargsmore Valid sub-functions are:
; sltargsmore load              : <filename>
; sltargsmore save              : <filename>
; sltargsmore ispendingsave     : <filename>
; sltargsmore isgood            : <filename>
; sltargsmore geterrors         : <filename>
; sltargsmore exists            : <filename>
; sltargsmore unload            : <filename> [saveChanges: 0 - false | 1 - true] [minify: 0 - false | 1 - true]
; sltargsmore set               : <filename> <key> <type: int | float | string | form> <value>
; sltargsmore get               : <filename> <key> <type: int | float | string | form> [<default value>]
; sltargsmore unset             : <filename> <key> <type: int | float | string | form>
; sltargsmore has               : <filename> <key> <type: int | float | string | form>
; sltargsmore adjust            : <filename> <key> <type: int | float>          <amount>
; sltargsmore listadd           : <filename> <key> <type: int | float | string | form> <value>
; sltargsmore listget           : <filename> <key> <type: int | float | string | form> <index>
; sltargsmore listset           : <filename> <key> <type: int | float | string | form> <index> <value>
; sltargsmore listremoveat      : <filename> <key> <type: int | float | string | form> <index>
; sltargsmore listinsertat      : <filename> <key> <type: int | float | string | form> <index> <value>
; sltargsmore listclear         : <filename> <key> <type: int | float | string | form>
; sltargsmore listcount         : <filename> <key> <type: int | float | string | form>
; sltargsmore listcountvalue    : <filename> <key> <type: int | float | string | form> <value> [<exclude: 0 - false | 1 - true>]
; sltargsmore listfind          : <filename> <key> <type: int | float | string | form> <value>
; sltargsmore listhas           : <filename> <key> <type: int | float | string | form> <value>
; sltargsmore listresize        : <filename> <key> <type: int | float | string | form> <toLength> [<filler value>]
; sltargsmore listslice         : <filename> <key> <type: int | float | string | form> <slice length> [<startIndex = 0>] ; returns a typed list e.g. int[]
; sltargsmore listcopy          : <filename> <key> <type: int | float | string | form> <list variable | value [value ... ] >
; sltargsmore listtoarray       : <filename> <key> <type: int | float | string | form> ; returns a typed list e.g. int[]
; sltsamp Example from the regression test script:
; sltsamp set $testfile "../sl_triggers/commandstore/jsonutil_function_test"
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp set $flag resultfrom jsonutil exists $testfile
; sltsamp if $flag
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: jsonutil exists ({flag})"
; sltsamp else
; sltsamp     deb_msg $"FAIL: jsonutil exists ({flag})"
; sltsamp endif
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp set $avalue resultfrom jsonutil set $testfile "key1" "string" "avalue"
; sltsamp if $avalue == "avalue"
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: jsonutil set ({avalue})"
; sltsamp else
; sltsamp     deb_msg $"FAIL: jsonutil set ({avalue})"
; sltsamp endif
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp set $hasworks resultfrom jsonutil has $testfile "key1" "string"
; sltsamp if $hasworks
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: jsonutil has ({hasworks})"
; sltsamp else
; sltsamp     deb_msg $"FAIL: jsonutil has ({hasworks})"
; sltsamp endif
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp set $unsetworks resultfrom jsonutil unset $testfile "key1" "string"
; sltsamp if $unsetworks
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: jsonutil unset ({unsetworks})"
; sltsamp else
; sltsamp     deb_msg $"FAIL: jsonutil unset ({unsetworks})"
; sltsamp endif
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp set $hasalsoworks resultfrom jsonutil has $testfile "key1" "string"
; sltsamp if $hasalsoworks
; sltsamp     deb_msg $"FAIL: jsonutil unset or has is failing ({hasalsoworks})"
; sltsamp else
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: jsonutil unset/has ({hasalsoworks})"
; sltsamp endif
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp set $setfloatworks resultfrom jsonutil set $testfile "key1" "float" "87"
; sltsamp if $setfloatworks == 87
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: jsonutil set with float ({setfloatworks})"
; sltsamp else
; sltsamp     deb_msg $"FAIL: jsonutil set with float ({setfloatworks})"
; sltsamp endif
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp set $checktypes resultfrom jsonutil has $testfile "key1" "string"
; sltsamp if $checktypes
; sltsamp     deb_msg $"FAIL: has failed, crossed the streams float and string? ({setfloatworks})"
; sltsamp else
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: has success ({setfloatworks})"
; sltsamp endif
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp jsonutil listclear $testfile  "somelist" "int"
; sltsamp 
; sltsamp jsonutil listadd $testfile  "somelist"  "int"  1
; sltsamp jsonutil listadd $testfile  "somelist"  "int"  2
; sltsamp jsonutil listadd $testfile  "somelist"  "int"  3
; sltsamp jsonutil listadd $testfile  "somelist"  "int"  1
; sltsamp 
; sltsamp set $listcount resultfrom jsonutil listcount $testfile "somelist" "int"
; sltsamp if $listcount == 4
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: listclear/listadd/listcount ({setfloatworks})"
; sltsamp else
; sltsamp     deb_msg $"FAIL: listclear/listadd/listcount; one has failed ({setfloatworks})"
; sltsamp endif
; sltsamp 
; sltsamp jsonutil save $testfile
function jsonutil(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthGT(CmdPrimary, param.Length, 2)
        string func = CmdPrimary.ResolveString(param[1])
        string jfile = CmdPrimary.ResolveString(param[2])

        if JsonUtil.JsonExists(jfile)

            ;; file functions
            if "load" == func
                CmdPrimary.MostRecentBoolResult = JsonUtil.Load(jfile)
            elseif "save" == func
                CmdPrimary.MostRecentBoolResult = JsonUtil.Save(jfile)
            elseif "ispendingsave" == func
                CmdPrimary.MostRecentBoolResult = JsonUtil.IsPendingSave(jfile)
            elseif "isgood" == func
                CmdPrimary.MostRecentBoolResult = JsonUtil.IsGood(jfile)
            elseif "geterrors" == func
                CmdPrimary.MostRecentStringResult = JsonUtil.GetErrors(jfile)
            elseif "exists" == func
                CmdPrimary.MostRecentBoolResult = true
            elseif "unload" == func
                bool saveChanges = true
                bool minify = false
                if param.Length > 3
                    saveChanges = CmdPrimary.ResolveBool(param[3])
                endif
                if param.Length > 4
                    minify = CmdPrimary.ResolveBool(param[4])
                endif
                CmdPrimary.MostRecentBoolResult = JsonUtil.Unload(jfile, saveChanges, minify)
            elseif ParamLengthGT(CmdPrimary, param.Length, 4)
                string jkey = CmdPrimary.ResolveString(param[3])
                string jtype = getValidJSONType(CmdPrimary, CmdPrimary.ResolveString(param[4]))

                if jtype
                    if "unset" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentBoolResult = JsonUtil.UnsetIntValue(jfile, jkey)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentBoolResult = JsonUtil.UnsetFloatValue(jfile, jkey)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentBoolResult = JsonUtil.UnsetStringValue(jfile, jkey)
                        elseif "form" == jtype
                            CmdPrimary.MostRecentBoolResult = JsonUtil.UnsetFormValue(jfile, jkey)
                        endif
                    elseif "has" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentBoolResult = JsonUtil.HasIntValue(jfile, jkey)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentBoolResult = JsonUtil.HasFloatValue(jfile, jkey)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentBoolResult = JsonUtil.HasStringValue(jfile, jkey)
                        elseif "form" == jtype
                            CmdPrimary.MostRecentBoolResult = JsonUtil.HasFormValue(jfile, jkey)
                        endif
                    elseif "listclear" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = JsonUtil.IntListClear(jfile, jkey)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentIntResult = JsonUtil.FloatListClear(jfile, jkey)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentIntResult = JsonUtil.StringListClear(jfile, jkey)
                        elseif "form" == jtype
                            CmdPrimary.MostRecentIntResult = JsonUtil.FormListClear(jfile, jkey)
                        endif
                    elseif "listcount" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = JsonUtil.IntListCount(jfile, jkey)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentIntResult = JsonUtil.FloatListCount(jfile, jkey)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentIntResult = JsonUtil.StringListCount(jfile, jkey)
                        elseif "form" == jtype
                            CmdPrimary.MostRecentIntResult = JsonUtil.FormListCount(jfile, jkey)
                        endif
                    elseif "get" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = JsonUtil.GetIntValue(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentFloatResult = JsonUtil.GetFloatValue(jfile, jkey, CmdPrimary.ResolveFloat(param[5]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentStringResult = JsonUtil.GetStringValue(jfile, jkey, CmdPrimary.ResolveString(param[5]))
                        elseif "form" == jtype
                            CmdPrimary.MostRecentFormResult = JsonUtil.GetFormValue(jfile, jkey, CmdPrimary.ResolveForm(param[5]))
                        endif

                    elseif ParamLengthGT(CmdPrimary, param.Length, 5)
                        if "set" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.SetIntValue(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                            elseif "float" == jtype
                                CmdPrimary.MostRecentFloatResult = JsonUtil.SetFloatValue(jfile, jkey, CmdPrimary.ResolveFloat(param[5]))
                            elseif "string" == jtype
                                CmdPrimary.MostRecentStringResult = JsonUtil.SetStringValue(jfile, jkey, CmdPrimary.ResolveString(param[5]))
                            elseif "form" == jtype
                                CmdPrimary.MostRecentFormResult = JsonUtil.SetFormValue(jfile, jkey, CmdPrimary.ResolveForm(param[5]))
                            endif
                        elseif "adjust" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.AdjustIntValue(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                            elseif "float" == jtype
                                CmdPrimary.MostRecentFloatResult = JsonUtil.AdjustFloatValue(jfile, jkey, CmdPrimary.ResolveFloat(param[5]))
                            elseif "string" == jtype
                                CmdPrimary.MostRecentStringResult = ""
                                SquawkFunctionError(CmdPrimary, "jsonutil: 'string' is not a valid type for JsonUtil Adjust")
                            endif
                        elseif "listadd" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListAdd(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                            elseif "float" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FloatListAdd(jfile, jkey, CmdPrimary.ResolveFloat(param[5]))
                            elseif "string" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.StringListAdd(jfile, jkey, CmdPrimary.ResolveString(param[5]))
                            elseif "form" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FormListAdd(jfile, jkey, CmdPrimary.ResolveForm(param[5]))
                            endif
                        elseif "listget" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListGet(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                            elseif "float" == jtype
                                CmdPrimary.MostRecentFloatResult = JsonUtil.FloatListGet(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                            elseif "string" == jtype
                                CmdPrimary.MostRecentStringResult = JsonUtil.StringListGet(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                            elseif "form" == jtype
                                CmdPrimary.MostRecentFormResult = JsonUtil.FormListGet(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                            endif
                        elseif "listset" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListSet(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveInt(param[6]))
                            elseif "float" == jtype
                                CmdPrimary.MostRecentFloatResult = JsonUtil.FloatListSet(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveFloat(param[6]))
                            elseif "string" == jtype
                                CmdPrimary.MostRecentStringResult = JsonUtil.StringListSet(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveString(param[6]))
                            elseif "form" == jtype
                                CmdPrimary.MostRecentFormResult = JsonUtil.FormListSet(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveForm(param[6]))
                            endif
                        elseif "listremoveat" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListRemove(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveBool(param[6]))
                            elseif "float" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FloatListRemove(jfile, jkey, CmdPrimary.ResolveFloat(param[5]), CmdPrimary.ResolveBool(param[6]))
                            elseif "string" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.StringListRemove(jfile, jkey, CmdPrimary.ResolveString(param[5]), CmdPrimary.ResolveBool(param[6]))
                            elseif "form" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FormListRemove(jfile, jkey, CmdPrimary.ResolveForm(param[5]), CmdPrimary.ResolveBool(param[6]))
                            endif
                        elseif "listinsertat" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.IntListInsertAt(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveInt(param[6]))
                            elseif "float" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.FloatListInsertAt(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveFloat(param[6]))
                            elseif "string" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.StringListInsertAt(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveString(param[6]))
                            elseif "form" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.FormListInsertAt(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveForm(param[6]))
                            endif
                        elseif "listremoveat" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.IntListRemoveAt(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                            elseif "float" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.FloatListRemoveAt(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                            elseif "string" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.StringListRemoveAt(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                            elseif "form" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.FormListRemoveAt(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                            endif
                        elseif "listcountvalue" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListCountValue(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveBool(param[6]))
                            elseif "float" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FloatListCountValue(jfile, jkey, CmdPrimary.ResolveFloat(param[5]), CmdPrimary.ResolveBool(param[6]))
                            elseif "string" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.StringListCountValue(jfile, jkey, CmdPrimary.ResolveString(param[5]), CmdPrimary.ResolveBool(param[6]))
                            elseif "form" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FormListCountValue(jfile, jkey, CmdPrimary.ResolveForm(param[5]), CmdPrimary.ResolveBool(param[6]))
                            endif
                        elseif "listfind" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListFind(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                            elseif "float" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FloatListFind(jfile, jkey, CmdPrimary.ResolveFloat(param[5]))
                            elseif "string" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.StringListFind(jfile, jkey, CmdPrimary.ResolveString(param[5]))
                            elseif "form" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FormListFind(jfile, jkey, CmdPrimary.ResolveForm(param[5]))
                            endif
                        elseif "listhas" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.IntListHas(jfile, jkey, CmdPrimary.ResolveInt(param[5]))
                            elseif "float" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.FloatListHas(jfile, jkey, CmdPrimary.ResolveFloat(param[5]))
                            elseif "string" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.StringListHas(jfile, jkey, CmdPrimary.ResolveString(param[5]))
                            elseif "form" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.FormListHas(jfile, jkey, CmdPrimary.ResolveForm(param[5]))
                            endif
                        elseif "listresize" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListResize(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveInt(param[6]))
                            elseif "float" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FloatListResize(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveFloat(param[6]))
                            elseif "string" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.StringListResize(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveString(param[6]))
                            elseif "form" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FormListResize(jfile, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveForm(param[6]))
                            endif
                        elseif "listslice" == func ; typed[]
                            if "int" == jtype
                                int[] slice = PapyrusUtil.IntArray(CmdPrimary.ResolveInt(param[5]))
                                JsonUtil.IntListSlice(jfile, jkey, slice, CmdPrimary.ResolveInt(param[6]))
                                CmdPrimary.MostRecentListIntResult = slice
                            elseif "float" == jtype
                                float[] slice = PapyrusUtil.FloatArray(CmdPrimary.ResolveInt(param[5]))
                                JsonUtil.FloatListSlice(jfile, jkey, slice, CmdPrimary.ResolveInt(param[6]))
                                CmdPrimary.MostRecentListFloatResult = slice
                            elseif "string" == jtype
                                string[] slice = PapyrusUtil.StringArray(CmdPrimary.ResolveInt(param[5]))
                                JsonUtil.StringListSlice(jfile, jkey, slice, CmdPrimary.ResolveInt(param[6]))
                                CmdPrimary.MostRecentListStringResult = slice
                            elseif "form" == jtype
                                Form[] slice = PapyrusUtil.FormArray(CmdPrimary.ResolveInt(param[5]))
                                JsonUtil.FormListSlice(jfile, jkey, slice, CmdPrimary.ResolveInt(param[6]))
                                CmdPrimary.MostRecentListFormResult = slice
                            endif
                        elseif "listcopy" == func ; bool
                            if "int" == jtype
                                int[] data = CmdPrimary.ResolveListInt(param[5])
                                if !data
                                    data = PapyrusUtil.IntArray(param.Length - 5)
                                    int ip = 5
                                    while ip < param.length
                                        data[ip - 5] = CmdPrimary.ResolveInt(param[ip])
                                        ip += 1
                                    endwhile
                                endif
                                CmdPrimary.MostRecentBoolResult = JsonUtil.IntListCopy(jfile, jkey, data)
                            elseif "float" == jtype
                                float[] data = CmdPrimary.ResolveListFloat(param[5])
                                if !data
                                    data = PapyrusUtil.FloatArray(param.Length - 5)
                                    int ip = 5
                                    while ip < param.length
                                        data[ip - 5] = CmdPrimary.ResolveFloat(param[ip])
                                        ip += 1
                                    endwhile
                                endif
                                CmdPrimary.MostRecentBoolResult = JsonUtil.FloatListCopy(jfile, jkey, data)
                            elseif "string" == jtype
                                string[] data = CmdPrimary.ResolveListString(param[5])
                                if !data
                                    data = PapyrusUtil.StringArray(param.Length - 5)
                                    int ip = 5
                                    while ip < param.length
                                        data[ip - 5] = CmdPrimary.ResolveString(param[ip])
                                        ip += 1
                                    endwhile
                                endif
                                CmdPrimary.MostRecentBoolResult = JsonUtil.StringListCopy(jfile, jkey, data)
                            elseif "form" == jtype
                                Form[] data = CmdPrimary.ResolveListForm(param[5])
                                if !data
                                    data = PapyrusUtil.FormArray(param.Length - 5)
                                    int ip = 5
                                    while ip < param.length
                                        data[ip - 5] = CmdPrimary.ResolveForm(param[ip])
                                        ip += 1
                                    endwhile
                                endif
                                CmdPrimary.MostRecentBoolResult = JsonUtil.FormListCopy(jfile, jkey, data)
                            endif
                        elseif "listtoarray" == func ; typed[]
                            if "int" == jtype
                                CmdPrimary.MostRecentListIntResult = JsonUtil.IntListToArray(jfile, jkey)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentListFloatResult = JsonUtil.FloatListToArray(jfile, jkey)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentListStringResult = JsonUtil.StringListToArray(jfile, jkey)
                            elseif "form" == jtype
                                CmdPrimary.MostRecentListFormResult = JsonUtil.FormListToArray(jfile, jkey)
                            endif
                        else
                            SquawkFunctionError(CmdPrimary, "jsonutil: unknown sub-function (" + func + ")")
                        endif
                    endif
                endif
            endif

        else
            if "exists" == func
                CmdPrimary.MostRecentBoolResult = false
            else
                SquawkFunctionError(CmdPrimary, "jsonutil: file (" + jfile + ") does not exist or cannot be opened")
            endif
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname storageutil
; sltgrup PapyrusUtil
; sltdesc Wrapper around most StorageUtil functions
; sltargs <sub-function> - StorageUtil functionality to perform
; sltargs <form identifier> - object to interact with; see below for details
; sltargsmore <form identifier> - represents the object you want StorageUtil activity keyed to
; sltargsmore    StorageUtil accepts 'none' (null) to represent "global" StorageUtil space
; sltargsmore    For SLTScript purposes, any identifier that will resolve to a Form object can be used
; sltargsmore    Or you may specify the empty string ("") for the global space
; sltargsmore    For example, any of the following might be valid:
; sltargsmore      $system.self, $system.player, $actor   ; these all resolve to Actor
; sltargsmore      "sl_triggers.esp:3426"   ; the FormID for the main Quest object for sl_triggers
; sltargsmore    Read more about StorageUtil for more details
; sltargsmore Valid sub-functions are:
; sltargsmore set               : <form identifier> <key> <type: int | float | string | form> <value>
; sltargsmore get               : <form identifier> <key> <type: int | float | string | form> [<default value>]
; sltargsmore pluck             : <form identifier> <key> <type: int | float | string | form> [<default value>]
; sltargsmore unset             : <form identifier> <key> <type: int | float | string | form>
; sltargsmore has               : <form identifier> <key> <type: int | float | string | form>
; sltargsmore adjust            : <form identifier> <key> <type: int | float>          <amount>
; sltargsmore listadd           : <form identifier> <key> <type: int | float | string | form> <value>
; sltargsmore listget           : <form identifier> <key> <type: int | float | string | form> <index>
; sltargsmore listpluck         : <form identifier> <key> <type: int | float | string | form> <index> <default value>
; sltargsmore listset           : <form identifier> <key> <type: int | float | string | form> <index> <value>
; sltargsmore listremoveat      : <form identifier> <key> <type: int | float | string | form> <index>
; sltargsmore listinsertat      : <form identifier> <key> <type: int | float | string | form> <index> <value>
; sltargsmore listadjust        : <form identifier> <key> <type: int | float | string | form> <index> <amount>
; sltargsmore listclear         : <form identifier> <key> <type: int | float | string | form>
; sltargsmore listpop           : <form identifier> <key> <type: int | float | string | form>
; sltargsmore listshift         : <form identifier> <key> <type: int | float | string | form>
; sltargsmore listsort          : <form identifier> <key> <type: int | float | string | form>
; sltargsmore listcount         : <form identifier> <key> <type: int | float | string | form>
; sltargsmore listcountvalue    : <form identifier> <key> <type: int | float | string | form> <value> [<exclude: 0 - false | 1 - true>]
; sltargsmore listfind          : <form identifier> <key> <type: int | float | string | form> <value>
; sltargsmore listhas           : <form identifier> <key> <type: int | float | string | form> <value>
; sltargsmore listresize        : <form identifier> <key> <type: int | float | string | form> <toLength> [<filler value>]
; sltargsmore listslice         : <form identifier> <key> <type: int | float | string | form> <slice length> [<startIndex = 0>] ; returns a typed list e.g. int[]
; sltargsmore listcopy          : <form identifier> <key> <type: int | float | string | form> <list variable | value [value ... ] >
; sltargsmore listtoarray       : <form identifier> <key> <type: int | float | string | form> ; returns a typed list e.g. int[]
; sltsamp Example usage from the regression tests
; sltsamp set $suhost $system.player
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp set $result resultfrom storageutil set $suhost "key1" "string" "avalue"
; sltsamp if $result == "avalue"
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: storageutil set ({result})"
; sltsamp else
; sltsamp     deb_msg $"FAIL: storageutil set ({result})"
; sltsamp endif
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp set $result resultfrom storageutil has $suhost "key1" "string"
; sltsamp if $result
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: storageutil has ({result})"
; sltsamp else
; sltsamp     deb_msg $"FAIL: storageutil has ({result})"
; sltsamp endif
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp set $result resultfrom storageutil unset $suhost "key1" "string"
; sltsamp if $result
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: storageutil unset ({result})"
; sltsamp else
; sltsamp     deb_msg $"FAIL: storageutil unset ({result})"
; sltsamp endif
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp set $result resultfrom storageutil has $suhost "key1" "string"
; sltsamp if $result
; sltsamp     deb_msg $"FAIL: storageutil unset ({result})"
; sltsamp else
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: storageutil unset ({result})"
; sltsamp endif
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp set $result resultfrom storageutil set $suhost "key1" "float" "87"
; sltsamp if $result == 87
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: storageutil set float ({result})"
; sltsamp else
; sltsamp     deb_msg $"FAIL: storageutil set float ({result})"
; sltsamp endif
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp set $result resultfrom storageutil has $suhost "key1" "string"
; sltsamp if $result
; sltsamp     deb_msg $"FAIL: storageutil unset/has ({result})"
; sltsamp else
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: storageutil unset/has ({result})"
; sltsamp endif
; sltsamp 
; sltsamp inc $thread.testCount
; sltsamp storageutil listclear $suhost  "somelist" "int"
; sltsamp 
; sltsamp storageutil listadd $suhost  "somelist"  "int"  1
; sltsamp storageutil listadd $suhost  "somelist"  "int"  2
; sltsamp storageutil listadd $suhost  "somelist"  "int"  3
; sltsamp storageutil listadd $suhost  "somelist"  "int"  1
; sltsamp 
; sltsamp set $result resultfrom storageutil listcount $suhost "somelist" "int"
; sltsamp if $result == 4
; sltsamp     inc $thread.passCount
; sltsamp     deb_msg $"PASS: storageutil listclear/listadd/listcount ({result})"
; sltsamp else
; sltsamp     deb_msg $"FAIL: storageutil listclear/listadd/listcount ({result})"
; sltsamp endif
function storageutil(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthGT(CmdPrimary, param.Length, 2)
        string func = CmdPrimary.ResolveString(param[1])

        Form suform
        if param[2]
            suform = CmdPrimary.ResolveForm(param[2])
        endif

        if ParamLengthGT(CmdPrimary, param.Length, 4)
            string jkey = CmdPrimary.ResolveString(param[3])
            string jtype = getValidJSONType(CmdPrimary, CmdPrimary.ResolveString(param[4]))

            if jtype
                if "unset" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentBoolResult = StorageUtil.UnsetIntValue(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentBoolResult = StorageUtil.UnsetFloatValue(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentBoolResult = StorageUtil.UnsetStringValue(suform, jkey)
                    elseif "form" == jtype
                        CmdPrimary.MostRecentBoolResult = StorageUtil.UnsetFormValue(suform, jkey)
                    endif
                elseif "has" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentBoolResult = StorageUtil.HasIntValue(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentBoolResult = StorageUtil.HasFloatValue(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentBoolResult = StorageUtil.HasStringValue(suform, jkey)
                    elseif "form" == jtype
                        CmdPrimary.MostRecentBoolResult = StorageUtil.HasFormValue(suform, jkey)
                    endif
                elseif "listclear" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.IntListClear(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.FloatListClear(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.StringListClear(suform, jkey)
                    elseif "form" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.FormListClear(suform, jkey)
                    endif
                elseif "listpop" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.IntListPop(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentFloatResult = StorageUtil.FloatListPop(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentStringResult = StorageUtil.StringListPop(suform, jkey)
                    elseif "form" == jtype
                        CmdPrimary.MostRecentFormResult = StorageUtil.FormListPop(suform, jkey)
                    endif
                elseif "listshift" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.IntListShift(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentFloatResult = StorageUtil.FloatListShift(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentStringResult = StorageUtil.StringListShift(suform, jkey)
                    elseif "form" == jtype
                        CmdPrimary.MostRecentFormResult = StorageUtil.FormListShift(suform, jkey)
                    endif
                elseif "listsort" == func
                    if "int" == jtype
                        StorageUtil.IntListSort(suform, jkey)
                    elseif "float" == jtype
                        StorageUtil.FloatListSort(suform, jkey)
                    elseif "string" == jtype
                        StorageUtil.StringListSort(suform, jkey)
                    elseif "form" == jtype
                        StorageUtil.FormListSort(suform, jkey)
                    endif
                elseif "listcount" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.IntListCount(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.FloatListCount(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.StringListCount(suform, jkey)
                    elseif "form" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.FormListCount(suform, jkey)
                    endif
                elseif "get" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.GetIntValue(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                    elseif "float" == jtype
                        CmdPrimary.MostRecentFloatResult = StorageUtil.GetFloatValue(suform, jkey, CmdPrimary.ResolveFloat(param[5]))
                    elseif "string" == jtype
                        CmdPrimary.MostRecentStringResult = StorageUtil.GetStringValue(suform, jkey, CmdPrimary.ResolveString(param[5]))
                    elseif "form" == jtype
                        CmdPrimary.MostRecentFormResult = StorageUtil.GetFormValue(suform, jkey, CmdPrimary.ResolveForm(param[5]))
                    endif
                elseif "pluck" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.PluckIntValue(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                    elseif "float" == jtype
                        CmdPrimary.MostRecentFloatResult = StorageUtil.PluckFloatValue(suform, jkey, CmdPrimary.ResolveFloat(param[5]))
                    elseif "string" == jtype
                        CmdPrimary.MostRecentStringResult = StorageUtil.PluckStringValue(suform, jkey, CmdPrimary.ResolveString(param[5]))
                    elseif "form" == jtype
                        CmdPrimary.MostRecentFormResult = StorageUtil.PluckFormValue(suform, jkey, CmdPrimary.ResolveForm(param[5]))
                    endif

                elseif ParamLengthGT(CmdPrimary, param.Length, 5)
                    if "set" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.SetIntValue(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentFloatResult = StorageUtil.SetFloatValue(suform, jkey, CmdPrimary.ResolveFloat(param[5]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentStringResult = StorageUtil.SetStringValue(suform, jkey, CmdPrimary.ResolveString(param[5]))
                        elseif "form" == jtype
                            CmdPrimary.MostRecentFormResult = StorageUtil.SetFormValue(suform, jkey, CmdPrimary.ResolveForm(param[5]))
                        endif
                    elseif "adjust" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.AdjustIntValue(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentFloatResult = StorageUtil.AdjustFloatValue(suform, jkey, CmdPrimary.ResolveFloat(param[5]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentStringResult = ""
                            CmdPrimary.SFE("storageutil: 'string' is not a valid type for StorageUtil Adjust")
                        elseif "form" == jtype
                            CmdPrimary.MostRecentFormResult = none
                            CmdPrimary.SFE("storageutil: 'form' is not a valid type for StorageUtil Adjust")
                        endif
                    elseif "listadd" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListAdd(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FloatListAdd(suform, jkey, CmdPrimary.ResolveFloat(param[5]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.StringListAdd(suform, jkey, CmdPrimary.ResolveString(param[5]))
                        elseif "form" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FormListAdd(suform, jkey, CmdPrimary.ResolveForm(param[5]))
                        endif
                    elseif "listget" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListGet(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentFloatResult = StorageUtil.FloatListGet(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentStringResult = StorageUtil.StringListGet(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                        elseif "form" == jtype
                            CmdPrimary.MostRecentFormResult = StorageUtil.FormListGet(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                        endif
                    elseif "listpluck" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListPluck(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveInt(param[6]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentFloatResult = StorageUtil.FloatListPluck(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveFloat(param[6]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentStringResult = StorageUtil.StringListPluck(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveString(param[6]))
                        elseif "form" == jtype
                            CmdPrimary.MostRecentFormResult = StorageUtil.FormListPluck(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveForm(param[6]))
                        endif
                    elseif "listset" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListSet(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveInt(param[6]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentFloatResult = StorageUtil.FloatListSet(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveFloat(param[6]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentStringResult = StorageUtil.StringListSet(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveString(param[6]))
                        elseif "form" == jtype
                            CmdPrimary.MostRecentFormResult = StorageUtil.FormListSet(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveForm(param[6]))
                        endif
                    elseif "listremoveat" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListRemove(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveBool(param[6]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FloatListRemove(suform, jkey, CmdPrimary.ResolveFloat(param[5]), CmdPrimary.ResolveBool(param[6]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.StringListRemove(suform, jkey, CmdPrimary.ResolveString(param[5]), CmdPrimary.ResolveBool(param[6]))
                        elseif "form" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FormListRemove(suform, jkey, CmdPrimary.ResolveForm(param[5]), CmdPrimary.ResolveBool(param[6]))
                        endif
                    elseif "listinsertat" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.IntListInsert(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveInt(param[6]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.FloatListInsert(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveFloat(param[6]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.StringListInsert(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveString(param[6]))
                        elseif "form" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.FormListInsert(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveForm(param[6]))
                        endif
                    elseif "listadjust" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListAdjust(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveInt(param[6]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentFloatResult = StorageUtil.FloatListAdjust(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveFloat(param[6]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentStringResult = ""
                            CmdPrimary.SFE("storageutil: 'string' is not a valid type for StorageUtil List Adjust")
                        elseif "form" == jtype
                            CmdPrimary.MostRecentFormResult = none
                            CmdPrimary.SFE("storageutil: 'form' is not a valid type for StorageUtil List Adjust")
                        endif
                    elseif "listremoveat" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.IntListRemoveAt(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.FloatListRemoveAt(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.StringListRemoveAt(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                        elseif "form" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.FormListRemoveAt(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                        endif
                    elseif "listcountvalue" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListCountValue(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveBool(param[6]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FloatListCountValue(suform, jkey, CmdPrimary.ResolveFloat(param[5]), CmdPrimary.ResolveBool(param[6]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.StringListCountValue(suform, jkey, CmdPrimary.ResolveString(param[5]), CmdPrimary.ResolveBool(param[6]))
                        elseif "form" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FormListCountValue(suform, jkey, CmdPrimary.ResolveForm(param[5]), CmdPrimary.ResolveBool(param[6]))
                        endif
                    elseif "listfind" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListFind(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FloatListFind(suform, jkey, CmdPrimary.ResolveFloat(param[5]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.StringListFind(suform, jkey, CmdPrimary.ResolveString(param[5]))
                        elseif "form" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FormListFind(suform, jkey, CmdPrimary.ResolveForm(param[5]))
                        endif
                    elseif "listhas" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.IntListHas(suform, jkey, CmdPrimary.ResolveInt(param[5]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.FloatListHas(suform, jkey, CmdPrimary.ResolveFloat(param[5]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.StringListHas(suform, jkey, CmdPrimary.ResolveString(param[5]))
                        elseif "form" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.FormListHas(suform, jkey, CmdPrimary.ResolveForm(param[5]))
                        endif
                    elseif "listresize" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListResize(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveInt(param[6]))
                        elseif "float" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FloatListResize(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveFloat(param[6]))
                        elseif "string" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.StringListResize(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveString(param[6]))
                        elseif "form" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FormListResize(suform, jkey, CmdPrimary.ResolveInt(param[5]), CmdPrimary.ResolveForm(param[6]))
                        endif
                    elseif "listslice" == func ; typed[]
                        if "int" == jtype
                            int[] slice = PapyrusUtil.IntArray(CmdPrimary.ResolveInt(param[5]))
                            StorageUtil.IntListSlice(suform, jkey, slice, CmdPrimary.ResolveInt(param[6]))
                            CmdPrimary.MostRecentListIntResult = slice
                        elseif "float" == jtype
                            float[] slice = PapyrusUtil.FloatArray(CmdPrimary.ResolveInt(param[5]))
                            StorageUtil.FloatListSlice(suform, jkey, slice, CmdPrimary.ResolveInt(param[6]))
                            CmdPrimary.MostRecentListFloatResult = slice
                        elseif "string" == jtype
                            string[] slice = PapyrusUtil.StringArray(CmdPrimary.ResolveInt(param[5]))
                            StorageUtil.StringListSlice(suform, jkey, slice, CmdPrimary.ResolveInt(param[6]))
                            CmdPrimary.MostRecentListStringResult = slice
                        elseif "form" == jtype
                            Form[] slice = PapyrusUtil.FormArray(CmdPrimary.ResolveInt(param[5]))
                            StorageUtil.FormListSlice(suform, jkey, slice, CmdPrimary.ResolveInt(param[6]))
                            CmdPrimary.MostRecentListFormResult = slice
                        endif
                    elseif "listcopy" == func ; bool
                        if "int" == jtype
                            int[] data = CmdPrimary.ResolveListInt(param[5])
                            if !data
                                data = PapyrusUtil.IntArray(param.Length - 5)
                                int ip = 5
                                while ip < param.length
                                    data[ip - 5] = CmdPrimary.ResolveInt(param[ip])
                                    ip += 1
                                endwhile
                            endif
                            CmdPrimary.MostRecentBoolResult = StorageUtil.IntListCopy(suform, jkey, data)
                        elseif "float" == jtype
                            float[] data = CmdPrimary.ResolveListFloat(param[5])
                            if !data
                                data = PapyrusUtil.FloatArray(param.Length - 5)
                                int ip = 5
                                while ip < param.length
                                    data[ip - 5] = CmdPrimary.ResolveFloat(param[ip])
                                    ip += 1
                                endwhile
                            endif
                            CmdPrimary.MostRecentBoolResult = StorageUtil.FloatListCopy(suform, jkey, data)
                        elseif "string" == jtype
                            string[] data = CmdPrimary.ResolveListString(param[5])
                            if !data
                                data = PapyrusUtil.StringArray(param.Length - 5)
                                int ip = 5
                                while ip < param.length
                                    data[ip - 5] = CmdPrimary.ResolveString(param[ip])
                                    ip += 1
                                endwhile
                            endif
                            CmdPrimary.MostRecentBoolResult = StorageUtil.StringListCopy(suform, jkey, data)
                        elseif "form" == jtype
                            Form[] data = CmdPrimary.ResolveListForm(param[5])
                            if !data
                                data = PapyrusUtil.FormArray(param.Length - 5)
                                int ip = 5
                                while ip < param.length
                                    data[ip - 5] = CmdPrimary.ResolveForm(param[ip])
                                    ip += 1
                                endwhile
                            endif
                            CmdPrimary.MostRecentBoolResult = StorageUtil.FormListCopy(suform, jkey, data)
                        endif
                    elseif "listtoarray" == func ; typed[]
                        if "int" == jtype
                            CmdPrimary.MostRecentListIntResult = StorageUtil.IntListToArray(suform, jkey)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentListFloatResult = StorageUtil.FloatListToArray(suform, jkey)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentListStringResult = StorageUtil.StringListToArray(suform, jkey)
                        elseif "form" == jtype
                            CmdPrimary.MostRecentListFormResult = StorageUtil.FormListToArray(suform, jkey)
                        endif
                    else
                        SquawkFunctionError(CmdPrimary, "storageutil: unknown sub-function (" + func + ")")
                    endif
                endif
            endif
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname util_getrndactor
; sltgrup Utility
; sltdesc Returns: Form: a random actor within specified range of self
; sltargs float: range: (0 - all | >0 - range in Skyrim units)
; sltsamp util_getrndactor 500
; sltsamp set $isvalid resultfrom actor_isvalid $actor
; sltsamp if $isvalid == false [end]
; sltsamp msg_notify "Someone is nearby!"
; sltsamp [end]
function util_getrndactor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    Actor nextIterActor

    if ParamLengthLT(CmdPrimary, param.Length, 4)
        Actor[] inCell = MiscUtil.ScanCellNPCs(CmdPrimary.PlayerRef, CmdPrimary.ResolveFloat(param[1]))
        if inCell.Length
            Keyword ActorTypeNPC = GetForm_Skyrim_ActorTypeNPC() as Keyword
            Cell    cc = CmdPrimary.PlayerRef.getParentCell()
        
            int i = 0
            int nuns = 0
            while i < inCell.Length
                Actor _targetActor = inCell[i]
                if !_targetActor || _targetActor == CmdPrimary.PlayerRef || !_targetActor.isEnabled() || _targetActor.isDead() || _targetActor.isInCombat() || _targetActor.IsUnconscious() || (ActorTypeNPC && !_targetActor.HasKeyWord(ActorTypeNPC)) || !_targetActor.Is3DLoaded() || (cc && cc != _targetActor.getParentCell())
                    inCell[i] = none
                    nuns += 1
                endif
                i += 1
            endwhile
        
            int remainder = inCell.Length - nuns
            if remainder > 0
                int _targetMetaIndex = Utility.RandomInt(0, remainder - 1)
                int _metaIndex = -1

                i = 0
                while i < inCell.Length && _metaIndex < _targetMetaIndex
                    if inCell[i]
                        _metaIndex += 1
                    endif
                    if _metaIndex < _targetMetaIndex
                        i += 1
                    endif
                endwhile

                if _metaIndex == _targetMetaIndex
                    nextIterActor = inCell[i]
                endif
            endif
        endif
    endif

    CmdPrimary.MostRecentFormResult = nextIterActor
    CmdPrimary.iterActor = nextIterActor

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname weather_state
; sltgrup Utility
; sltdesc Returns: (varies): Weather related functions based on sub-function
; sltargs <sub-function> ; currently only GetClassification
; sltsamp weather_state GetClassification
function weather_state(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        string ss1 = CmdPrimary.ResolveString(param[1])
        
        if ss1 == "GetClassification"
            Weather curr = Weather.GetCurrentWeather()
            if curr
                CmdPrimary.MostRecentIntResult = curr.GetClassification()
            endIf
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname math
; sltgrup Utility
; sltdesc Returns: (varies): values from math operations based on sub-function
; sltargs sub-function: sub-function
; sltargs variable: variable 3 varies by sub-function
; sltargsmore if parameter 2 1s "asint": return parameter 3 as integer
; sltargsmore if parameter 2 1s "floor": return parameter 3 the largest integer less than or equal to the value
; sltargsmore if parameter 2 1s "ceiling": return parameter 3 the smallest integer greater than or equal to the value
; sltargsmore if parameter 2 1s "abs": return parameter 3 as absolute value of the passed in value - N for N, and N for (-N)
; sltargsmore if parameter 2 1s "toint": return parameter 3 as integer. Parameter 3 can be in dec or hex. If it starts with 0, its converted as hex value
; sltsamp math floor 1.2
function Math(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthGT(CmdPrimary, param.Length, 2)
        string subcode = CmdPrimary.ResolveString(param[1])
        
        if      subcode == "asint"
            CmdPrimary.MostRecentIntResult = CmdPrimary.ResolveInt(param[2])
        elseIf  subcode == "floor"
            CmdPrimary.MostRecentFloatResult = Math.floor(CmdPrimary.ResolveFloat(param[2]))
        elseIf  subcode == "ceiling"
            CmdPrimary.MostRecentFloatResult = Math.ceiling(CmdPrimary.ResolveFloat(param[2]))
        elseIf  subcode == "abs"
            CmdPrimary.MostRecentFloatResult = Math.abs(CmdPrimary.ResolveFloat(param[2]))
        elseIf  subcode == "toint"
            CmdPrimary.MostRecentIntResult = CmdPrimary.ResolveInt(param[2])
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname topicinfo_getresponsetext
; sltgrup TopicInfo
; sltdesc Returns: string: Attempts to return a single response text associated with the provided TopicInfo (by editorID or FormID)
; sltdesc Note: This is more beta than normal; it isn't obvious whether in some cases multiple strings should actually be returned.
; sltargs Form: topicinfo: <formID> or <editorID> for the desired TopicInfo (not Topic)
; sltsamp topicinfo_getresponsetext "Skyrim.esm:0x00020954"
; sltsamp msg_notify $$
; sltsamp ; $$ would contain "I used to be an adventurer like you. Then I took an arrow in the knee..."
Function topicinfo_getresponsetext(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string responsetext = ""

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Form tiform = CmdPrimary.ResolveForm(param[1])
        if !tiform
            CmdPrimary.SFE("Unable to resolve (" + param[1] + ")")
        else
            TopicInfo ti = tiform as TopicInfo
            if !ti
                CmdPrimary.SFE("Resolved (" + param[1] + ") but instead of TopicInfo received(" + tiform + ")")
            else
                responsetext = sl_triggers.GetTopicInfoResponse(ti)
            endif
        endif
    endif

    CmdPrimary.MostRecentStringResult = responsetext

	CmdPrimary.CompleteOperationOnActor()
endFunction

