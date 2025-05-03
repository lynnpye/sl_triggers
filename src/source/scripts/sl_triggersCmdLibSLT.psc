scriptname sl_triggersCmdLibSLT

import sl_triggersStatics
 
;;;;;;;;;;
;; 

; sltname hextun_test
; sltdesc hextun's test function
; sltsamp hextun_test ???
function hextun_test(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    deb_msg(CmdTargetActor, _CmdPrimary, param)
    string res1 = CmdPrimary.Resolve(param[1])
    Actor res2 = CmdPrimary.ResolveActor(param[2])
    string[] msg = new string[2];
    msg[1] = "res1(" + res1 + ") res2(" + res2.GetDisplayName() + ")"
    deb_msg(CmdTargetActor, _CmdPrimary, msg)
endFunction

; sltname hextun_test2
; sltdesc hextun's other test function
; sltsamp hextun_test2 ???
function hextun_test2(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    msg_console(CmdTargetActor, _CmdPrimary, param)
endFunction

; sltname deb_msg
; sltdesc Joins all <msg> arguments together and adds the text to SKSE\Plugins\sl_triggers\debugmsg.log
; sltargs <msg> [<msg> <msg> ...]
; sltsamp deb_msg "Hello" "world!" OR deb_msg "Hello world!"
Function deb_msg(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    if param.Length < 2
        return
    endif
    string[] darr = PapyrusUtil.StringArray(param.Length)
    darr[0] = "DebMsg> "
    int i = 1
    while i < darr.Length
        darr[i] = CmdPrimary.Resolve(param[i])
        i += 1
    endwhile
    string dmsg = PapyrusUtil.StringJoin(darr, "")
    DebMsg(dmsg)
endFunction

; sltname set
; sltdesc Set the indicated local or global variable to the indicated value
; sltargs <$var|$gvar> <resolvable value> OR <$var|$gvar> <resolvable value> <operator> <resolvable value>
; sltsamp set $1 32 OR set $1 $2 OR set $1 $2 + $3
function set(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    ;DebMsg("set>>>>")
    if ParamLengthNEQ2(CmdPrimary, param.Length, 3, 5)
        return
    endif
    
	int varindex = CmdPrimary.IsVarString(param[1])
    int g_varindex = CmdPrimary.IsVarStringG(param[1])

    if (varindex < 0) && (g_varindex < 0)
        ;DebMsg("returning early")
        return
    endif
    if g_varindex > -1
        varindex = g_varindex
    endif

    string strparm2 = CmdPrimary.resolve(param[2])

    if param.length == 3
        if g_varindex > -1
			CmdPrimary.globalvars_set(varindex, strparm2)
        else
            CmdPrimary.vars_set(varindex, strparm2)
        endif
    elseif param.length == 5
        string strparm4 = CmdPrimary.Resolve(param[4])
        float op1 = strparm2 as float
        float op2 = strparm4 as float
        string operat = param[3]

        string strresult

        if operat == "+"
            strresult = (op1 + op2) as string
        elseIf operat == "-"
            strresult = (op1 - op2) as string
        elseIf operat == "*"
            strresult = (op1 * op2) as string
        elseIf operat == "/"
            strresult = (op1 / op2) as string
        elseIf operat == "&"
            strresult = strparm2 + strparm4
        else
            DebMsg("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unexpected operator for 'set' (" + operat + ")")
        endif
        if g_varindex > -1
            CmdPrimary.globalvars_set(varindex, strresult)
        else
            CmdPrimary.vars_set(varindex, strresult)
        endif
    else
        DebMsg("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unexpected number of arguments for 'set' got " + param.length + " expected 3 or 5")
    endif

    ;DebMsg("leaving set")
endFunction

; sltname inc
; sltdesc Increments the indicated variable
; sltargs <$var|$gvar> <numeric value>
; sltsamp inc $3 12.3 OR inc $5 4
function inc(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 3)
        return
    endif

    string varstr = param[1]
    float incrAmount = CmdPrimary.resolve(param[2]) as float

    ;DebMsg("inc (" + varstr + ") (" + incrAmount + ") (" + param.length + ") (" + param[2] + ")")

    int varindex = CmdPrimary.IsVarStringG(varstr)
    if varindex >= 0
        CmdPrimary.globalvars_set(varindex, ((CmdPrimary.globalvars_get(varindex) as float) + incrAmount) as string)
    else
        varindex = CmdPrimary.IsVarString(varstr)
        if varindex >= 0
            CmdPrimary.vars_set(varindex, ((CmdPrimary.vars_get(varindex) as float) + incrAmount) as string)
        else
            DebMsg("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] no resolve found for variable parameter (" + param[1] + ")")
        endif
    endif
endFunction
 
; sltname cat
; sltdesc Concatenates one or more strings onto the end of the indicated variable
; sltargs <$var|$gvar> <string> [<string> <string> ...]
; sltsamp cat $4 "onestring" "twostring" "redstring" "bluestring"
function cat(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 3)
        return
    endif

    string varstr = param[1]
    float incrAmount = CmdPrimary.resolve(param[2]) as float

    int varindex = CmdPrimary.IsVarStringG(varstr)
    if varindex >= 0
        CmdPrimary.globalvars_set(varindex, (CmdPrimary.globalvars_get(varindex) + CmdPrimary.resolve(param[2])) as string)
    else
        varindex = CmdPrimary.IsVarString(varstr)
        if varindex >= 0
            CmdPrimary.vars_set(varindex, (CmdPrimary.vars_get(varindex) + CmdPrimary.resolve(param[2])) as string)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] no resolve found for variable parameter (" + param[1] + ")")
        endif
    endif
endFunction
 
; sltname av_restore
; sltdesc Restore actor value
; sltargs <actor variable> <av name> <amount>
; sltsamp av_restore $self Health 100 OR av_restore $self $3 100 (where $3 might be "Health")
function av_restore(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    
    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    mate.RestoreActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)
endFunction

; sltname av_damage
; sltdesc Damage actor value
; sltargs <actor variable> <av name> <amount>
; sltsamp av_damage $self Health 100 OR av_damage $self $3 100 (where $3 might be "Health")
function av_damage(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    mate.DamageActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)
endFunction

; sltname av_mod
; sltdesc Modify actor value
; sltargs <actor variable> <av name> <amount>
; sltsamp av_mod $self Health 100 OR av_mod $self $3 100 (where $3 might be "Health")
function av_mod(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    mate.ModActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)
endFunction

; sltname av_set
; sltdesc Set actor value
; sltargs <actor variable> <av name> <amount>
; sltsamp av_set $self Health 100 OR av_set $self $3 100 (where $3 might be "Health")
function av_set(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    mate.SetActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)
endFunction

; sltname av_getbase
; sltdesc Get base actor value
; sltargs <actor variable> <av name>
; sltsamp av_getbase $self Health  OR av_getbase $self $3  (where $3 might be "Health")
function av_getbase(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Actor mate
    
    mate = CmdPrimary.resolveActor(param[1])
    CmdPrimary.MostRecentResult = mate.GetBaseActorValue(CmdPrimary.resolve(param[2])) as string
endFunction

; sltname av_get
; sltdesc Get actor value
; sltargs <actor variable> <av name>
; sltsamp av_get $self Health  OR av_get $self $3  (where $3 might be "Health")
function av_get(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Actor mate
    
    mate = CmdPrimary.resolveActor(param[1])
    CmdPrimary.MostRecentResult = mate.GetActorValue(CmdPrimary.resolve(param[2])) as string
endFunction

; sltname av_getmax
; sltdesc Get max actor value
; sltargs <actor variable> <av name> 
; sltsamp av_getmax $self Health  OR av_getmax $self $3  (where $3 might be "Health")
function av_getmax(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    CmdPrimary.MostRecentResult = mate.GetActorValueMax(CmdPrimary.resolve(param[2])) as string
endFunction

; sltname av_getpercent
; sltdesc Get current percentage of max actor value
; sltargs <actor variable> <av name> 
; sltsamp av_getpercent $self Health  OR av_getpercent $self $3  (where $3 might be "Health")
function av_getpercent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    CmdPrimary.MostRecentResult = (mate.GetActorValuePercentage(CmdPrimary.resolve(param[2])) * 100.0) as string
endFunction

; sltname spell_cast
; sltdesc Cast spell at target
; sltargs <SPEL FormId> <actor variable>
; sltsamp spell_cast "skyrim.esm:275236" $self
function spell_cast(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Spell thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
    if thing
        Actor mate = CmdPrimary.resolveActor(param[2])
        if mate
            thing.RemoteCast(mate, mate, mate)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve SPEL with FormId (" + param[1] + ")")
    endIf
endFunction

; sltname spell_dcsa
; sltdesc Casts spell with DoCombatSpellApply Papyrus function. It is usually used for spells that are part of a melee attack (like animals that also carry poison or disease).
; sltargs <SPEL FormId> <actor variable>
; sltsamp spell_dcsa "skyrim.esm:275236" $self
function spell_dcsa(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Spell thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
    if thing
        Actor mate = CmdPrimary.resolveActor(param[2])
        if mate
            mate.DoCombatSpellApply(thing, mate)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve SPEL with FormId (" + param[1] + ")")
    endif
endFunction

; sltname spell_dispel
; sltdesc Dispels specified SPEL by FormId from targeted Actor
; sltargs <SPEL FormId> <actor variable>
; sltsamp spell_dispel "skyrim.esm:275236" $self
function spell_dispel(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Spell thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
    if thing
        Actor mate = CmdPrimary.resolveActor(param[2])
        if mate
            mate.DispelSpell(thing)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve SPEL with FormId (" + param[1] + ")")
    endif
endFunction

; sltname spell_add
; sltdesc Adds the specified SPEL by FormId to the targeted Actor, usually to add as an available power or spell in the spellbook.
; sltargs <SPEL FormId> <actor variable>
; sltsamp spell_add "skyrim.esm:275236" $self
function spell_add(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Spell thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
    if thing
        Actor mate = CmdPrimary.resolveActor(param[2])
        if mate
            mate.AddSpell(thing)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve SPEL with FormId (" + param[1] + ")")
    endif
endFunction

; sltname spell_remove
; sltdesc Removes the specified SPEL by FormId from the targeted Actor, usually to remove as an available power or spell in the spellbook.
; sltargs <SPEL FormId> <actor variable>
; sltsamp spell_remove "skyrim.esm:275236" $self
function spell_remove(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Spell thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
    if thing
        Actor mate = CmdPrimary.resolveActor(param[2])
        if mate
            mate.RemoveSpell(thing)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve SPEL with FormId (" + param[1] + ")")
    endif
endFunction

; sltname item_add
; sltdesc Adds the item to the actor's inventory.
; sltargs <actor variable> <ITEM FormId> <number> <0 - show message | 1 - silent>
; sltsamp item_add $self "skyrim.esm:15" 10 0
function item_add(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 5)
        return
    endif

    Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
    if thing
        Actor mate = CmdPrimary.resolveActor(param[1])
        int count = CmdPrimary.resolve(param[3]) as int
        bool isSilent = CmdPrimary.resolve(param[4]) as int

        if mate
            mate.AddItem(thing, count, isSilent)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_addex
; sltdesc Adds the item to the actor's inventory, but check if some armor was re-equipped (if NPC)
; sltargs <actor variable> <ITEM FormId> <number> <0 - show message | 1 - silent>
; sltsamp item_addex $self "skyrim.esm:15" 10 0
function item_addex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 5)
        return
    endif
    
    Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
    if thing
        Actor mate = CmdPrimary.resolveActor(param[1])
        int count = CmdPrimary.resolve(param[3]) as int
        bool isSilent = CmdPrimary.resolve(param[4]) as int
        
        Form[] itemSlots = new Form[34]
        int index
        int slotsChecked
        int thisSlot
        
        If mate != CmdPrimary.PlayerRef
            index = 0
            slotsChecked += 0x00100000
            slotsChecked += 0x00200000
            slotsChecked += 0x80000000
            thisSlot = 0x01
            While (thisSlot < 0x80000000)
                if (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot) 
                    Form thisArmor = mate.GetWornForm(thisSlot)
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
        
        mate.AddItem(thing, count, isSilent)

        If mate != CmdPrimary.PlayerRef
            index = 0
            slotsChecked = 0
            slotsChecked += 0x00100000
            slotsChecked += 0x00200000
            slotsChecked += 0x80000000
            thisSlot = 0x01
            While (thisSlot < 0x80000000)
                if (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot)
                    Form thisArmor = mate.GetWornForm(thisSlot)
                    if (thisArmor)
                        If itemSlots.Find(thisArmor) < 0
                            CmdTargetActor.UnequipItemEx(thisArmor, 0)
                        EndIf
                        slotsChecked += (thisArmor as Armor).GetSlotMask()
                    else
                        slotsChecked += thisSlot
                    endif
                endif
                thisSlot *= 2 
            endWhile
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_remove
; sltdesc Remove the item from the actor's inventory
; sltargs <actor variable> <ITEM FormId> <number> <0 - show message | 1 - silent>
; sltsamp item_remove $self "skyrim.esm:15" 10 0
function item_remove(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 5)
        return
    endif
    
    Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
    thing
    if thing
        Actor mate = CmdPrimary.resolveActor(param[1])
        int count = CmdPrimary.resolve(param[3]) as int
        bool isSilent = CmdPrimary.resolve(param[4]) as int
        if mate
            mate.RemoveItem(thing, count, isSilent)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_adduse
; sltdesc Add item (like item_add) and then use the added item. Useful for potions, food, and other consumables.
; sltargs <actor variable> <ITEM FormId> <number> <0 - show message | 1 - silent>
; sltsamp item_adduse $self "skyrim.esm:15" 10 0
function item_adduse(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 5)
        return
    endif

    Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))    
    if thing
        Actor mate = CmdPrimary.resolveActor(param[1])
        int count = CmdPrimary.resolve(param[3]) as int
        bool isSilent = CmdPrimary.resolve(param[4]) as int
        if mate
            mate.AddItem(thing, count, isSilent)
            mate.EquipItem(thing, false, isSilent)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_equipex
; sltdesc Equip item (SKSE version)
; sltargs <actor variable> <ITEM FormId> <armor slot Id> <0 - no sound | 1 - with sound> <0 - removal allowed | 1 - removal not allowed>
; sltsamp item_equipex "ZaZAnimationPack.esm:159072" 0 1
function item_equipex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif

    Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))    
    if thing
        Actor mate = CmdPrimary.resolveActor(param[1])
        if mate
            int slotId = CmdPrimary.resolve(param[3]) as int
            bool isSilent = CmdPrimary.resolve(param[4]) as int
            bool isRemovalPrevented = CmdPrimary.Resolve(param[5]) as int
            mate.EquipItemEx(thing, slotId, isRemovalPrevented, isSilent)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_equip
; sltdesc Equip item ("vanilla" version)
; sltargs <actor variable> <ITEM FormId> <0 - removal allowed | 1 - removal not allowed> <0 - no sound | 1 - with sound>
; sltsamp item_equip "ZaZAnimationPack.esm:159072" 0 1
function item_equip(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif
    
    Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
    if thing
        Actor mate = CmdPrimary.resolveActor(param[1])
        if mate
            int slotId = CmdPrimary.resolve(param[3]) as int
            bool isSilent = CmdPrimary.resolve(param[4]) as int
            mate.EquipItem(thing, slotId, isSilent)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_unequipex
; sltdesc Unequip item
; sltargs <actor variable> <ITEM FormId> <armor slot id>
; sltsamp item_unequipex "ZaZAnimationPack.esm:159072" 0
function item_unequipex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
    if thing
        Actor mate = CmdPrimary.resolveActor(param[1])
        if mate
            int slotId = CmdPrimary.resolve(param[3]) as int
            mate.UnEquipItemEx(thing, slotId)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_getcount
; sltdesc Return how many of a specified item an actor has
; sltargs <actor variable> <ITEM FormId>
; sltsamp item_getcount $self "skyrim.esm:15"
function item_getcount(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))    
    if thing
        Actor mate = CmdPrimary.resolveActor(param[1])
        if mate
            int retVal = mate.GetItemCount(thing)
            CmdPrimary.MostRecentResult = retVal as string
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname msg_notify
; sltdesc Display the message in the standard notification area (top left of your screen by default)
; sltargs <msg> [<msg> <msg> ...]
; sltsamp msg_notify "Hello" "world!" OR msg_notify "Hello world!"
function msg_notify(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 2)
        return
    endif

    string[] darr = PapyrusUtil.StringArray(param.Length)
    int i = 1
    while i < darr.Length
        darr[i] = CmdPrimary.Resolve(param[i])
        i += 1
    endwhile
    string msg = PapyrusUtil.StringJoin(darr, "")
    Debug.Notification(msg)
endFunction

; sltname msg_console
; sltdesc Display the message in the console
; sltargs <msg> [<msg> <msg> ...]
; sltsamp msg_console "Hello" "world!" OR msg_console "Hello world!"
function msg_console(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 2)
        return
    endif

    string[] darr = PapyrusUtil.StringArray(param.Length)
    int i = 1
    while i < darr.Length
        darr[i] = CmdPrimary.Resolve(param[i])
        i += 1
    endwhile
    string msg = PapyrusUtil.StringJoin(darr, "")
    MiscUtil.PrintConsole(msg)
endFunction

; sltname rnd_list
; sltdesc Pick one of the arguments at random and place it into the $$ result variable
; sltargs <argument> <argument> [<argument> <argument> ...]
; sltsamp rnd_list "Hello" $2 "Yo"
function rnd_list(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 2)
        return
    endif
    
    int idx = Utility.RandomInt(1, param.Length - 1)
    CmdPrimary.MostRecentResult = CmdPrimary.Resolve(param[idx])
endFunction

; sltname rnd_int
; sltdesc Return a random integer between min and max inclusive
; sltargs <min integer> <max integer>
; sltsamp rnd_int 1 100
function rnd_int(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    CmdPrimary.MostRecentResult = Utility.RandomInt(CmdPrimary.resolve(param[1]) as int, CmdPrimary.resolve(param[2]) as int) as string
endFunction

; sltname util_wait
; sltdesc Wait specified number of seconds
; sltargs <float>
; sltsamp util_wait 2.5
function util_wait(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    Utility.Wait(CmdPrimary.resolve(param[1]) as float)
endFunction

; sltname util_getrndactor
; sltdesc Return a random actor within specified range of self
; sltargs <range: 0 - all | >0 skyrim units>
; sltsamp util_getrndactor
function util_getrndactor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 1)
        return
    endif
    
    Actor[] inCell = MiscUtil.ScanCellNPCs(CmdPrimary.PlayerRef, CmdPrimary.resolve(param[1]) as float)
    if !(inCell.Length)
        return 
    endif

    Keyword ActorTypeNPC = Game.GetFormFromFile(0x13794, "Skyrim.esm") as Keyword
    Cell    cc = CmdPrimary.PlayerRef.getParentCell()

    int i = 0
    int nuns = 0
    while i < inCell.Length
        Actor mate = inCell[i]
        if !mate || mate == CmdPrimary.PlayerRef || !mate.isEnabled() || mate.isDead() || mate.isInCombat() || mate.IsUnconscious() || !mate.HasKeyWord(ActorTypeNPC) || !mate.Is3DLoaded() || cc != mate.getParentCell()
            inCell[i] = none
            nuns += 1
        endif
        i += 1
    endwhile

    CmdPrimary.iterActor = none

    if inCell.Length == nuns
        return
    endif

    Form[] noblanks = PapyrusUtil.FormArray(inCell.Length - nuns)

    i = 0
    int j = 0
    while i < inCell.Length
        if inCell[i]
            noblanks[j] = inCell[i]
            j += 1
        endif
        i += 1
    endwhile

    i = Utility.RandomInt(0, noblanks.Length)
    CmdPrimary.iterActor = noblanks[i] as Actor
endFunction

; sltname perk_addpoints
; sltdesc Add specified number of perk points to player
; sltargs <number of perk points to add>
; sltsamp perk_addpoints 4
function perk_addpoints(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    Game.AddPerkPoints(CmdPrimary.resolve(param[1]) as int)
endFunction

; sltname perk_add
; sltdesc Add specified perk to the targeted actor
; sltargs <Form ID of PERK> <actor variable>
; sltsamp perk_add "skyrim.esm:12384" $self
function perk_add(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Perk thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Perk    
    if thing
        Actor mate = CmdPrimary.resolveActor(param[2])
        if mate
            mate.AddPerk(thing)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve ITEM with FormId (" + param[1] + ")")
    endif
endFunction

; sltname perk_remove
; sltdesc Remove specified perk from the targeted actor
; sltargs <Form ID of PERK> <actor variable>
; sltsamp perk_remove "skyrim.esm:12384" $self
function perk_remove(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Perk thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Perk    
    if thing
        Actor mate = CmdPrimary.resolveActor(param[2])
        if mate
            mate.RemovePerk(thing)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve ITEM with FormId (" + param[1] + ")")
    endif
endFunction

; sltname actor_advskill
; sltdesc Advance targeted actor's skill by specified amount. Only works on Player.
; sltargs <actor variable> <skill name> <amount>
; sltsamp actor_advskill $self Alteration 1
function actor_advskill(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    if mate
        string skillName = CmdPrimary.resolve(param[2])
        if skillName
            Game.AdvanceSkill(skillName, CmdPrimary.resolve(param[3]) as int)
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve skill name (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[1] + ")")
    endif
endFunction

; sltname actor_incskill
; sltdesc Increase targeted actor's skill by specified amount
; sltargs <actor variable> <skill name> <amount>
; sltsamp actor_incskill $self Alteration 1
function actor_incskill(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    if mate
        string skillName = CmdPrimary.resolve(param[2])
        if skillName
            if mate == CmdPrimary.PlayerRef
                Game.IncrementSkillBy(skillName, CmdPrimary.resolve(param[3]) as int)
            else
                mate.ModActorValue(skillName, CmdPrimary.resolve(param[3]) as int)
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve skill name (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][cmdidx:" + CmdPrimary.cmdIdx + "] unable to resolve actor variable (" + param[1] + ")")
    endif
endFunction

; sltname actor_isvalid
; sltdesc Return 1 if actor is valid, 0 if not.
; sltargs <actor variable>
; sltsamp actor_isvalid $actor
function actor_isvalid(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif

    Cell  cc = CmdPrimary.PlayerRef.getParentCell()
    
    Actor mate = CmdPrimary.resolveActor(param[1])
    if mate && mate.isEnabled() && !mate.isDead() && !mate.isInCombat() && !mate.IsUnconscious() && mate.Is3DLoaded() && cc == mate.getParentCell()
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
endFunction

; sltname actor_haslos
; sltdesc Return 1 if first actor can see second actor, 0 if not.
; sltargs <actor variable> <actor variable>
; sltsamp actor_haslos $actor $self
function actor_haslos(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    Actor mate2 = CmdPrimary.resolveActor(param[2])
    
    if mate.hasLOS(mate2)
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
endFunction

; sltname actor_name
; sltdesc Return actor name
; sltargs <actor variable>
; sltsamp actor_name $actor
function actor_name(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    CmdPrimary.MostRecentResult = CmdPrimary.ActorName(CmdPrimary.resolveActor(param[1]))
endFunction

; sltname actor_modcrimegold
; sltdesc Specified actor reports player, increasing bounty by specified amount.
; sltargs <actor variable> <bounty increase>
; sltsamp actor_haslos $actor 100
function actor_modcrimegold(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    if mate
        Faction crimeFact = mate.GetCrimeFaction()
        if crimeFact
            crimeFact.ModCrimeGold(CmdPrimary.resolve(param[2]) as int, false)
        endIf
    endif
endFunction

; sltname actor_qnnu
; sltdesc Repaints actor (calls QueueNiNodeUpdate)
; sltargs <actor variable>
; sltsamp actor_qnnu $actor
function actor_qnnu(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    CmdPrimary.resolveActor(param[1]).QueueNiNodeUpdate()
endFunction

; sltname actor_isguard
; sltdesc Returns 1 if actor is guard, 0 otherwise.
; sltargs <actor variable>
; sltsamp actor_isguard $actor
function actor_isguard(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    if CmdPrimary.resolveActor(param[1]).IsGuard()
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
endFunction
function actor_isquard(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	actor_isguard(CmdTargetActor, CmdPrimary, param)
endFunction

; sltname actor_isplayer
; sltdesc Returns 1 if actor is the player, 0 otherwise.
; sltargs <actor variable>
; sltsamp actor_isplayer $actor
function actor_isplayer(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    if CmdPrimary.resolveActor(param[1]) == CmdPrimary.PlayerRef
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
endFunction

; sltname actor_getgender
; sltdesc Return actor's gender, 0 - male, 1 - female, 2 - creature
; sltargs <actor variable>
; sltsamp actor_getgender $actor
function actor_getgender(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    CmdPrimary.MostRecentResult = CmdPrimary.ActorGender(CmdPrimary.resolveActor(param[1]))
endFunction

; sltname actor_say
; sltdesc Causes the actor to 'say' the topic indicated by FormId
; sltargs <actor variable> <Topic FormID>
; sltsamp actor_say $actor "Skyrim.esm:1234"
function actor_say(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    Topic thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Topic
    if thing
        CmdPrimary.resolveActor(param[1]).Say(thing)
    endIf
endFunction

; sltname actor_haskeyword
; sltdesc Returns 1 if actor has the keyword, 0 otherwise.
; sltargs <actor variable> <keyword name>
; sltsamp actor_isplayer $actor Vampire
function actor_haskeyword(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    Keyword keyw = Keyword.GetKeyword(CmdPrimary.resolve(param[2]))
    
    if keyw && CmdPrimary.resolveActor(param[1]).HasKeyword(keyw)
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
endFunction

; sltname actor_iswearing
; sltdesc Returns 1 if actor is wearing the armor indicated by the FormId, 0 otherwise.
; sltargs <actor variable> <armor FormId>
; sltsamp actor_iswearing $actor "petcollar.esp:31017"
function actor_iswearing(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
	
	Armor thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Armor
	
	if thing && CmdPrimary.resolveActor(param[1]).IsEquipped(thing)
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
endFunction

; sltname actor_worninslot
; sltdesc Returns 1 if actor is wearing armor in the indicated slotId, 0 otherwise.
; sltargs <actor variable> <armor slot id>
; sltsamp actor_worninslot $actor 32
function actor_worninslot(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

	Actor mate = CmdPrimary.resolveActor(param[1])
	if mate && mate.GetEquippedArmorInSlot(param[2] as int)
		CmdPrimary.MostRecentResult = "1"
	else
		CmdPrimary.MostRecentResult = "0"
	endIf
endFunction

; sltname actor_wornhaskeyword
; sltdesc Returns 1 if actor is wearing any armor with indicated keyword, 0 otherwise.
; sltargs <actor variable> <keyword name>
; sltsamp actor_wornhaskeyword $actor "VendorItemJewelry"
function actor_wornhaskeyword(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Keyword keyw = Keyword.GetKeyword(CmdPrimary.resolve(param[2]))
    
    if keyw && CmdPrimary.resolveActor(param[1]).WornHasKeyword(keyw)
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
endFunction

; sltname actor_lochaskeyword
; sltdesc Returns 1 if actor's current location has the indicated keyword, 0 otherwise.
; sltargs <actor variable> <keyword name>
; sltsamp actor_lochaskeyword $actor "LocTypeInn"
function actor_lochaskeyword(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    Keyword keyw = Keyword.GetKeyword(CmdPrimary.resolve(param[2]))
    
    if keyw && CmdPrimary.resolveActor(param[1]).GetCurrentLocation().HasKeyword(keyw)
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
endFunction

; sltname actor_getrelation
; sltdesc Return relationship rank between the two actors
; sltargs <actor variable> <actor variable>
; sltsamp actor_getrelation $actor $player
function actor_getrelation(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    CmdPrimary.MostRecentResult = CmdPrimary.resolveActor(param[1]).GetRelationshipRank(CmdPrimary.resolveActor(param[2])) as int
endFunction

; sltname actor_setrelation
; sltdesc Set relationship rank between the two actors to the indicated value
; sltargs <actor variable> <actor variable> <rank>
; sltsamp actor_setrelation $actor $player 0
function actor_setrelation(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif

    CmdPrimary.resolveActor(param[1]).SetRelationshipRank(CmdPrimary.resolveActor(param[2]), CmdPrimary.resolve(param[3]) as int)
endFunction

; sltname actor_infaction
; sltdesc Returns 1 if actor is in the faction indicated by the FormId, 0 otherwise
; sltargs <actor variable> <faction FormId>
; sltsamp actor_infaction $actor "skyrim.esm:378958"
function actor_infaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Faction thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Faction
    
    if thing
        if CmdPrimary.resolveActor(param[1]).IsInFaction(thing)
            CmdPrimary.MostRecentResult = "1"
            return
        endif
    endif
    CmdPrimary.MostRecentResult = "0"
endFunction

; sltname actor_getfactionrank
; sltdesc Returns the actor's rank in the faction indicated by the FormId
; sltargs <actor variable> <faction FormId>
; sltsamp actor_getfactionrank $actor "skyrim.esm:378958"
function actor_getfactionrank(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Faction thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Faction
    
    if thing
        CmdPrimary.MostRecentResult = CmdPrimary.resolveActor(param[1]).GetFactionRank(thing)
    else
        CmdPrimary.MostRecentResult = "0"
    endif
endFunction

; sltname actor_setfactionrank
; sltdesc Sets the actor's rank in the faction indicated by the FormId to the indicated rank
; sltargs <actor variable> <faction FormId> <rank>
; sltsamp actor_setfactionrank $actor "skyrim.esm:378958" 0
function actor_setfactionrank(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif
    
    Faction thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Faction
    if thing
        CmdPrimary.resolveActor(param[1]).SetFactionRank(thing, CmdPrimary.resolve(param[3]) as int)
    endif
endFunction

; sltname actor_isaffectedby
; sltdesc Returns 1 if the specified actor is currently affected by the MGEF or SPEL indicated by FormID (accepts either)
; sltargs <actor variable> <MGEF/SPEL FormId>
; sltsamp actor_isaffectedby $actor "skyrim.esm:1030541"
function actor_isaffectedby(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
	
	Actor mate = CmdPrimary.resolveActor(param[1])
	if !mate
		CmdPrimary.MostRecentResult = "0"
		return
	endif
	
	Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
	
	MagicEffect mgef = thing as MagicEffect
	if mgef
		if mate.HasMagicEffect(mgef)
			CmdPrimary.MostRecentResult = "1"
		else
			CmdPrimary.MostRecentResult = "0"
		endif
		return
	endif
	
	Spell spel = thing as Spell
	if spel
		int i = 0
		int numeffs = spel.GetNumEffects()
		while i < numeffs
			mgef = spel.GetNthEffectMagicEffect(i)
			if mate.HasMagicEffect(mgef)
				CmdPrimary.MostRecentResult = "1"
				return
			endif
			
			i += 1
		endwhile
	endif
	
	CmdPrimary.MostRecentResult = "0"
endFunction

; sltname actor_removefaction
; sltdesc Removes the actor from the specified faction
; sltargs <actor variable> <Faction FormId>
; sltsamp actor_removefaction $actor "skyrim.esm:3505"
function actor_removefaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    Faction thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Faction

    if thing
        CmdPrimary.resolveActor(param[1]).RemoveFromFaction(thing)
    endif
endFunction

; sltname actor_playanim
; sltdesc Causes the actor to play the specified animation
; sltargs <actor variable> <animation name>
; sltsamp actor_playanim $self "IdleChildCryingStart"
function actor_playanim(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    Debug.SendAnimationEvent(CmdPrimary.resolveActor(param[1]), CmdPrimary.resolve(param[2]))
endFunction

; sltname actor_sendmodevent
; sltdesc Causes the actor to send the mod event with the provided arguments
; sltargs <actor variable> <event name> <string argument> <float argument>
; sltsamp actor_sendmodevent $self "IHaveNoIdeaButEventNamesShouldBeEasyToFind" "strarg" 0.0
function actor_sendmodevent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 5)
        return
    endif
    
    Actor mate = CmdPrimary.resolveActor(param[1])
    
    if mate
        string ss1 = CmdPrimary.resolve(param[2])
        string ss2 = CmdPrimary.resolve(param[3])
        float p3 = CmdPrimary.resolve(param[4]) as float
        mate.SendModEvent(ss1, ss2, p3)
    endIf
endFunction

; sltname actor_state
; sltdesc Returns the state of the actor for a given sub-function
; sltargs <actor variable> <sub-function> <varies by subfunction>
; sltargsmore if parameter 2 is "GetCombatState": return actors combatstate. 0-no combat, 1-combat, 2-searching
; sltargsmore if parameter 2 is "GetLevel": return actors level
; sltargsmore if parameter 2 is "GetSleepState": return actors sleep mode. 0-not, 1-not, but wants to, 2-sleeping, 3-sleeping, but wants to wake up
; sltargsmore if parameter 2 is "IsAlerted": is actor alerted
; sltargsmore if parameter 2 is "IsAlarmed": is actor alerted
; sltargsmore if parameter 2 is "IsPlayerTeammate": is actor PC team member
; sltargsmore if parameter 2 is "SetPlayerTeammate" (parameter 3: <bool true to set, false to unset>): set actor as PC team member
; sltargsmore if parameter 2 is "SendAssaultAlarm": actor will send out alarm 
; sltsamp actor_state $self "GetCombatState"
function actor_state(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 2)
        return
    endif
    
    Actor mate = CmdPrimary.resolveActor(param[1])
    string ss1 = CmdPrimary.resolve(param[2])
    
    CmdPrimary.MostRecentResult = ""
    if mate 
        if ss1 == "GetCombatState"
            CmdPrimary.MostRecentResult = mate.GetCombatState() as string
        elseif ss1 == "GetLevel"
            CmdPrimary.MostRecentResult = mate.GetLevel() as string
        elseif ss1 == "GetSleepState"
            CmdPrimary.MostRecentResult = mate.GetSleepState() as string
        elseif ss1 == "IsAlerted"
            CmdPrimary.MostRecentResult = mate.IsAlerted() as string
        elseif ss1 == "IsAlarmed"
            CmdPrimary.MostRecentResult = mate.IsAlarmed() as string
        elseif ss1 == "IsPlayerTeammate"
            CmdPrimary.MostRecentResult = mate.IsPlayerTeammate() as string
        elseif ss1 == "SetPlayerTeammate"
            int p3 = 0
			if param.Length > 2
				p3 = CmdPrimary.resolve(param[3]) as int
			endif
            mate.SetPlayerTeammate(p3 as bool)
        elseif ss1 == "SendAssaultAlarm"
            mate.SendAssaultAlarm()
        endIf
    endIf
endFunction

; sltname actor_body
; sltdesc Alters or queries information about the actor's body, based on sub-function
; sltargs <actor variable> <sub-function>
; sltargsmore if parameter 2 is "ClearExtraArrows": clear extra arrows 
; sltargsmore if parameter 2 is "RegenerateHead": regenerate head
; sltargsmore if parameter 2 is "GetWeight": get actors weight (0-100)
; sltargsmore if parameter 2 is "SetWeight" (parameter 3: <float, weight>): set actors weight
; sltargsmore ; sltsamp actor_body $self "SetWeight" 110
function actor_body(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 2)
        return
    endif
    
    Actor mate = CmdPrimary.resolveActor(param[1])
    string ss1 = CmdPrimary.resolve(param[2])
    
    CmdPrimary.MostRecentResult = ""
    if mate 
        if ss1 == "ClearExtraArrows"
            mate.ClearExtraArrows()
        elseif ss1 == "RegenerateHead"
            mate.RegenerateHead()
        elseif ss1 == "GetWeight"
            CmdPrimary.MostRecentResult = mate.GetActorBase().GetWeight() as string
        elseif ss1 == "SetWeight"
            float baseW = mate.GetActorBase().GetWeight()
			float p3
			if param.Length > 2
				p3 = CmdPrimary.resolve(param[3]) as float
			endif
				
            float newW  = p3
            If newW < 0
                newW = 0
            ElseIf newW > 100
                newW = 100
            EndIf
            float neckD = (baseW - newW) / 100
	
            If neckD
                mate.GetActorBase().SetWeight(newW)
                mate.UpdateWeight(neckD)
            EndIf
        endIf
    endIf
endFunction

; sltname actor_race
; sltdesc Returns the race name based on sub-function. Blank, empty sub-function returns Vanilla racenames. e.g. "SL" can return SexLab race keynames.
; sltargs <actor variable> <sub-function>
; sltargsmore if parameter 2 is "": return actors race name. Skyrims, original name. Like: "Nord", "Breton"
; sltargsmore if parameter 2 is "SL": return actors Sexlab frameworks race key name. Like: "dogs", "bears", etc. Note: will return "" if actor is humanoid
; sltsamp actor_race $self ""
function actor_race(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    Actor mate = CmdPrimary.resolveActor(param[1])
    
    CmdPrimary.MostRecentResult = ""
    if mate
        string ss1 = CmdPrimary.resolve(param[2])
        if ss1 == ""
            CmdPrimary.MostRecentResult = mate.GetRace().GetName()
        endIf
    endIf
endFunction

; sltname ism_applyfade
; sltdesc Apply imagespace modifier - per original author, check CreationKit, SpecialEffects\Imagespace Modifier
; sltargs <item Id> <fade duration>
; sltsamp ism_applyfade $1 2
function ism_applyfade(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    ImageSpaceModifier thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as ImageSpaceModifier

    if thing
        thing.ApplyCrossFade(CmdPrimary.resolve(param[2]) as float)
    endIf
endFunction

; sltname ism_removefade
; sltdesc Remove imagespace modifier - per original author, check CreationKit, SpecialEffects\Imagespace Modifier
; sltargs <item Id> <fade duration>
; sltsamp ism_removefade $1 2
function ism_removefade(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1]))

    if thing
        ImageSpaceModifier.RemoveCrossFade(CmdPrimary.resolve(param[2]) as float)
    endIf
endFunction

; sltname util_sendmodevent
; sltdesc Shorthand for actor_sendmodevent $player <event name> <string argument> <float argument>
; sltargs <event name> <string argument> <float argument>
; sltsamp util_sendmodevent $self "IHaveNoIdeaButEventNamesShouldBeEasyToFind" "strarg" 0.0
function util_sendmodevent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 5)
        return
    endif
	
    string ss1
    string ss2
    string ss3
    float  p3
    
    ss1 = CmdPrimary.resolve(param[1])
    ss2 = CmdPrimary.resolve(param[2])
    ss3 = CmdPrimary.resolve(param[3])
    p3 = ss3 as float
    
    CmdTargetActor.SendModEvent(ss1, ss2, p3)
endFunction

; sltname util_sendmodevent
; sltdesc Send SKSE custom event, with each type/value pair being an argument to the custom event
; sltargs <event name> <param 1 type> <param 1 value> [<param 2 type> <param 2 value> ...]
; sltargsmore <type> can be any of [bool, int, float, string, form]
; sltsamp util_sendmodevent "slaUpdateExposure" form $self float 33
function util_sendevent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthLT(CmdPrimary, param.Length, 4)
        return
    endif
	
    string eventName
    string typeId
    string ss
    int idxArg
    
    eventName = CmdPrimary.resolve(param[1])
    int eid = ModEvent.Create(eventName)
    
    if eid
        idxArg = 2 
        while idxArg + 1 < param.Length
            typeId = CmdPrimary.resolve(param[idxArg])
            if typeId == "bool"
                ss = CmdPrimary.resolve(param[idxArg + 1])
                if (ss as int)
                    ModEvent.PushBool(eid, true)
                else
                    ModEvent.PushBool(eid, false)
                endIf
            elseif typeId == "int"
                ss = CmdPrimary.resolve(param[idxArg + 1])
                ModEvent.PushInt(eid, ss as int)
            elseif typeId == "float"
                ss = CmdPrimary.resolve(param[idxArg + 1])
                ModEvent.PushFloat(eid, ss as float)
            elseif typeId == "string"
                ss = CmdPrimary.resolve(param[idxArg + 1])
                ModEvent.PushString(eid, ss)
            elseif typeId == "form"
                actor mate1 = CmdPrimary.resolveActor(param[idxArg + 1])
                ModEvent.PushForm(eid, mate1)
            endif
            
            idxArg += 2
        endWhile
        
        ModEvent.Send(eid)
    endIf
endFunction

; sltname util_getgametime
; sltdesc Returns the value of Utility.GetCurrentGameTime() (a float value representing the number of days in game time; mid-day day 2 is 1.5)
; sltsamp util_getgametime
function util_getgametime(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    float dayTime = Utility.GetCurrentGameTime()
    
    CmdPrimary.MostRecentResult = dayTime as string
endFunction

; sltname util_getrealtime
; sltdesc Returns the value of Utility.GetCurrentRealTime() (a float value representing the number of seconds since Skyrim.exe was launched this session)
; sltsamp util_getrealtime
function util_getrealtime(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentResult = Utility.GetCurrentRealTime() as string
endFunction

; sltname util_getgametime
; sltdesc Returns the in-game hour (i.e. 2:30 AM returns 2)
; sltsamp util_getgametime
function util_gethour(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	float dayTime = Utility.GetCurrentGameTime()
 
	dayTime -= Math.Floor(dayTime)
	dayTime *= 24
    
    int theHour = dayTime as int
    
    CmdPrimary.MostRecentResult = theHour as string
endFunction

; sltname util_game
; sltdesc Perform game related functions based on sub-function
; sltargs <sub-function> <varies by sub-function>
; sltargsmore if sub-function is "IncrementStat", (parameter 3, <stat name>, parameter 4, <amount>), see https://ck.uesp.net/wiki/IncrementStat_-_Game
; sltargsmore if sub-function is "QueryStat", (parameter 3, <stat name>), returns the value
; sltsamp util_game "IncrementStat" "Bribes" 1
function util_game(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
	
    string p1
    string p2
    
    p1 = CmdPrimary.resolve(param[1])
    if p1 == "IncrementStat"
        p2 = CmdPrimary.resolve(param[2])
        int iModAmount = CmdPrimary.resolve(param[3]) as Int
        Game.IncrementStat(p2, iModAmount)
    elseIf p1 == "QueryStat"
        p2 = CmdPrimary.resolve(param[2])
        CmdPrimary.MostRecentResult = Game.QueryStat(p2) as string
    endIf
endFunction

; sltname snd_play
; sltdesc Return the sound instance handle from playing the specified audio from the specified actor
; sltargs <audio FormID> <actor variable>
; sltsamp snd_play "skyrim.esm:318128" $self
function snd_play(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
	
    Sound   thing
    Actor   mate
    int     retVal
    
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Sound
    mate = CmdPrimary.resolveActor(param[2])
    
    if thing
        retVal = thing.Play(mate)
        CmdPrimary.MostRecentResult = retVal as string
    endIf
endFunction

; sltname snd_setvolume
; sltdesc Set the sound volume using the specified sound instance handle (from snd_play)
; sltargs <sound instance handle> <volume 0..1.0>
; sltsamp snd_setvolume $1 0.5
function snd_setvolume(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
	
    string ss
    int    soundId
    float  vol
    
    ss = CmdPrimary.resolve(param[1])
    soundId = ss as int
    
    ss = CmdPrimary.resolve(param[2])
    vol = ss as float

    
    Sound.SetInstanceVolume(soundId, vol)
endFunction

; sltname snd_stop
; sltdesc Stops the audio specified by the sound instance handle (from snd_play)
; sltargs <sound instance handle>
; sltsamp snd_stop $1
function snd_stop(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
	
    string ss
    int    soundId

    ss = CmdPrimary.resolve(param[1])
    soundId = ss as int
    
    
    Sound.StopInstance(soundId)
endFunction

; sltname console
; sltdesc Executes the console command (requires a ConsoleUtil variant installed; recommend ConsoleUtil-Extended https://www.nexusmods.com/skyrimspecialedition/mods/133569)
; sltargs <actor as selected console reference> <command fragment> [<command fragment> ...] ; all <command fragments> will be concatenated
; sltsamp console $self "sgtm" "" "0.5" ; as an example... you could replace the third parameter with a variable reference
function console(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthLT(CmdPrimary, param.Length, 3)
        return
    endif
	
    string ss
    string ssx
    int cnt
    int idx
    Actor mate
    
    mate = CmdPrimary.resolveActor(param[1])
    
    cnt = param.length
    idx = 2
    while idx < cnt
        ss = CmdPrimary.resolve(param[idx])
        ssx += ss
        idx += 1
    endWhile
    
    sl_TriggersConsole.exec_console(mate, ssx)
endFunction

; sltname mfg_reset
; sltdesc Resets facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)
; sltargs <actor variable>
; sltsamp mfg_reset $self
function mfg_reset(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
	
    Actor mate
    
    mate = CmdPrimary.resolveActor(param[1])

    sl_TriggersMfg.mfg_reset(mate)
endFunction

; sltname mfg_setphonememodifier
; sltdesc Set facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)
; sltargs <actor variable> <mode> <id> <value> ; <mode> can be 0 - set phoneme or 1 - set modifier
; sltsamp mfg_setphonememodifier $self 0 $1 $2
function mfg_setphonememodifier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 5)
        return
    endif
	
    Actor mate
    int   p1
    int   p2
    int   p3
    
    mate = CmdPrimary.resolveActor(param[1])
    p1 = CmdPrimary.resolve(param[2]) as Int
    p2 = CmdPrimary.resolve(param[3]) as Int
    p3 = CmdPrimary.resolve(param[4]) as Int
    
    sl_TriggersMfg.mfg_SetPhonemeModifier(mate, p1, p2, p3)
endFunction

; sltname mfg_getphonememodifier
; sltdesc Return facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)
; sltargs <actor variable> <mode> <id> ; <mode> can be 0 - set phoneme or 1 - set modifier
; sltsamp mfg_getphonememodifier $self 0 $1
function mfg_getphonememodifier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif
	
    Actor mate
    int   p1
    int   p2
    int   retVal
    
    mate = CmdPrimary.resolveActor(param[1])
    p1 = CmdPrimary.resolve(param[2]) as Int
    p2 = CmdPrimary.resolve(param[3]) as Int
    
    retVal = sl_TriggersMfg.mfg_GetPhonemeModifier(mate, p1, p2)
    CmdPrimary.MostRecentResult = retVal as string
endFunction

; sltname util_waitforkbd
; sltdesc Returns the keycode pressed after waiting for user to press any of the specified keys
; sltargs <DXScanCode of key> [<DXScanCode of key> ...]
; sltsamp util_waitforkbd 74 78 181 55
function util_waitforkbd(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthLT(CmdPrimary, param.Length, 2)
        return
    endif
	
    string ss
    string ssx
    int cnt
    int idx
    int scancode

    cnt = param.length

    if (CmdTargetActor != CmdPrimary.PlayerRef) || (cnt <= 1)
        CmdPrimary.MostRecentResult = "-1"
        return
    endIf

    CmdPrimary.UnregisterForAllKeys()

    idx = 1
    while idx < cnt
        ss = CmdPrimary.resolve(param[idx])
        scancode = ss as int
        if scancode > 0
            CmdPrimary.RegisterForKey(scanCode)
            
        endIf
        idx += 1
    endWhile
    
    CmdPrimary.lastKey = 0
	int timeoutcheck = 0
    
    while CmdPrimary && CmdPrimary.lastKey == 0 && timeoutcheck < 20
        Utility.Wait(0.5)
		timeoutcheck += 1
    endWhile

    CmdPrimary.UnregisterForAllKeys()
    
    CmdPrimary.MostRecentResult = CmdPrimary.lastKey as string
endFunction

; sltname json_getvalue
; sltdesc Returns value from JSON file (uses PapyrusUtil/JsonUtil)
; sltargs <file name> <data type [int, float, string]> <key> <default value if not found>
; sltsamp json_getvalue "../somefolder/afile" float "demofloatvalue" 2.3 ; JsonUtil automatically appends .json when not given a file extension
function json_getvalue(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 5)
        return
    endif
	
    string pname
    string ptype
    string pkey
    string pdef
    
    pname = CmdPrimary.resolve(param[1])
    ptype = CmdPrimary.resolve(param[2])
    pkey  = CmdPrimary.resolve(param[3])
    pdef  = CmdPrimary.resolve(param[4])
    
    if ptype == "int"
        int iRet
        iRet = JsonUtil.GetIntValue(pname, pkey, pdef as int)
        CmdPrimary.MostRecentResult = iRet as string
    elseif ptype == "float"
        float fRet
        fRet = JsonUtil.GetFloatValue(pname, pkey, pdef as float)
        CmdPrimary.MostRecentResult = fRet as string
    else
        string sRet
        sRet = JsonUtil.GetStringValue(pname, pkey, pdef)
        CmdPrimary.MostRecentResult = sRet
    endIf
endFunction

; sltname json_setvalue
; sltdesc Sets a value in a JSON file (uses PapyrusUtil/JsonUtil)
; sltargs <file name> <data type [int, float, string]> <key> <new value>
; sltsamp json_setvalue "../somefolder/afile" float "demofloatvalue" 2.3 ; JsonUtil automatically appends .json when not given a file extension
function json_setvalue(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 5)
        return
    endif
	
    string pname
    string ptype
    string pkey
    string pdef
    
    pname = CmdPrimary.resolve(param[1])
    ptype = CmdPrimary.resolve(param[2])
    pkey  = CmdPrimary.resolve(param[3])
    pdef  = CmdPrimary.resolve(param[4])

    if ptype == "int"
        JsonUtil.SetIntValue(pname, pkey, pdef as int)
    elseif ptype == "float"
        JsonUtil.SetFloatValue(pname, pkey, pdef as float)
    else
        JsonUtil.SetStringValue(pname, pkey, pdef)
    endIf
endFunction

; sltname json_save
; sltdesc Tells JsonUtil to immediately save the specified file from cache
; sltargs <file name>
; sltsamp json_save "../somefolder/afile"
function json_save(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
	
    string pname
    
    pname = CmdPrimary.resolve(param[1])
    
    JsonUtil.Save(pname)
endFunction

; sltname weather_state
; sltdesc Weather related functions based on sub-function
; sltargs <sub-function> ; currently only GetClassification
; sltsamp weather_state GetClassification
function weather_state(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
	
    string ss1
    string ss2
    
    ss1 = CmdPrimary.resolve(param[1])
    
    CmdPrimary.MostRecentResult = ""
    if ss1 == "GetClassification"
        Weather curr = Weather.GetCurrentWeather()
        if curr
            CmdPrimary.MostRecentResult = curr.GetClassification() as string
        endIf
    endIf
endFunction

; sltname math
; sltdesc Return values from math operations based on sub-function
; sltargs <sub-function> <variable 3 varies by sub-function>
; sltargsmore if parameter 2 1s "asint": return parameter 3 as integer
; sltargsmore if parameter 2 1s "floor": return parameter 3 the largest integer less than or equal to the value
; sltargsmore if parameter 2 1s "ceiling": return parameter 3 the smallest integer greater than or equal to the value
; sltargsmore if parameter 2 1s "abs": return parameter 3 as absolute value of the passed in value - N for N, and N for (-N)
; sltargsmore if parameter 2 1s "toint": return parameter 3 as integer. Parameter 3 can be in dec or hex. If it starts with 0, its converted as hex value
; sltsamp math floor 1.2
function math(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthLT(CmdPrimary, param.Length, 3)
        return
    endif
	
    string ss1
    string ss2
    int    ii1
    float  ff1
    
    ss1 = CmdPrimary.resolve(param[1])
    
    CmdPrimary.MostRecentResult = ""
    if ss1 == "asint"
        ss2 = CmdPrimary.resolve(param[2])
        if ss2 
            ii1 = ss2 as int
        else
            ii1 = 0
        endIf
        CmdPrimary.MostRecentResult = ii1 as string
    elseIf ss1 == "floor"
        ss1 = CmdPrimary.resolve(param[2])
        ii1 = Math.floor(ss1 as float)
        CmdPrimary.MostRecentResult = ii1 as string
    elseIf ss1 == "ceiling"
        ss1 = CmdPrimary.resolve(param[2])
        ii1 = Math.Ceiling(ss1 as float)
        CmdPrimary.MostRecentResult = ii1 as string
    elseIf ss1 == "abs"
        ss1 = CmdPrimary.resolve(param[2])
        ff1 = Math.abs(ss1 as float)
        CmdPrimary.MostRecentResult = ff1 as string
    elseIf ss1 == "toint"
        ss2 = CmdPrimary.resolve(param[2])
        if ss2 && (StringUtil.GetNthChar(ss2, 0) == "0")
            ii1 = CmdPrimary.hextoint(ss2)
        elseIf ss2
            ii1 = ss2 as int
        else 
            ii1 = 0
        endIf
        CmdPrimary.MostRecentResult = ii1 as string
    endIf
endFunction
 