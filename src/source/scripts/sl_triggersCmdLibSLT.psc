scriptname sl_triggersCmdLibSLT

import sl_triggersStatics
 
;;;;;;;;;;
;; 

; HAVE TO FIX THE STRING PARAM TO STRING[] PARAM BEFORE YOU CAN USE THIS
function hextun_test(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
endFunction

; HAVE TO FIX THE STRING PARAM TO STRING[] PARAM BEFORE YOU CAN USE THIS
function hextun_test2(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
endFunction

; sltname deb_msg
; sltgrup Utility
; sltdesc Joins all <msg> arguments together and adds the text to SKSE\Plugins\sl_triggers\debugmsg.log
; sltdesc Text is always appended to the log, so if you use this, it will only grow in size until you truncate it.
; sltargs message: <msg> [<msg> <msg> ...]
; sltsamp deb_msg "Hello" "world!"
; sltsamp deb_msg "Hello world!"
; sltrslt Both do the same thing
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
 
; sltname av_restore
; sltgrup Actor Value
; sltdesc Restore actor value
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltargs amount: amount to restore
; sltsamp av_restore $self Health 100
; sltsamp av_restore $self   $3   100 ;where $3 might be "Health"
; sltrslt Restores Health by 100 e.g. healing
function av_restore(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    
    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    mate.RestoreActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)
endFunction

; sltname av_damage
; sltgrup Actor Value
; sltdesc Damage actor value
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltargs amount: amount to damage
; sltsamp av_damage $self Health 100
; sltsamp av_damage $self   $3   100 ;where $3 might be "Health"
; sltrslt Damages Health by 100. This can result in death.
function av_damage(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    mate.DamageActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)
endFunction

; sltname av_mod
; sltgrup Actor Value
; sltdesc Modify actor value
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltargs amount: amount to modify by
; sltsamp av_mod $self Health 100
; sltsamp av_mod $self   $3   100 ;where $3 might be "Health"
; sltrslt Changes the max value of the actor value. Not the same as restore/damage.
function av_mod(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    mate.ModActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)
endFunction

; sltname av_set
; sltgrup Actor Value
; sltdesc Set actor value
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltargs amount: amount to modify by
; sltsamp av_set $self Health 100
; sltsamp av_set $self   $3   100 ;where $3 might be "Health"
; sltrslt Sets the value of the actor value.
function av_set(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    mate.SetActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)
endFunction

; sltname av_getbase
; sltgrup Actor Value
; sltdesc Sets $$ to the actor's base value for the specified Actor Value
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltsamp av_getbase $self Health
; sltrslt Sets the actor's base Health into $$
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
; sltgrup Actor Value
; sltdesc Set $$ to the actor's current value for the specified Actor Value
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltsamp av_get $self Health
; sltrslt Sets the actor's current Health into $$
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
; sltgrup Actor Value
; sltdesc Set $$ to the actor's max value for the specified Actor Value
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltsamp av_get $self Health
; sltrslt Sets the actor's max Health into $$
function av_getmax(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    CmdPrimary.MostRecentResult = mate.GetActorValueMax(CmdPrimary.resolve(param[2])) as string
endFunction

; sltname av_getpercentage
; sltgrup Actor Value
; sltdesc Set $$ to the actor's value as a percentage of max for the specified Actor Value
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltsamp av_getpercentage $self Health
; sltrslt Sets the actor's percentage of Health remaining into $$
function av_getpercent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif

    Actor mate = CmdPrimary.resolveActor(param[1])
    CmdPrimary.MostRecentResult = (mate.GetActorValuePercentage(CmdPrimary.resolve(param[2])) * 100.0) as string
endFunction

; sltname spell_cast
; sltgrup Spells
; sltdesc Cast spell at target
; sltargs spell: SPEL FormID
; sltargs actor: target Actor
; sltsamp spell_cast "skyrim.esm:275236" $self
; sltrslt Casts light spell on self
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve SPEL with FormId (" + param[1] + ")")
    endIf
endFunction

; sltname spell_dcsa
; sltgrup Spells
; sltdesc Casts spell with DoCombatSpellApply Papyrus function. It is usually used for spells that 
; sltdesc are part of a melee attack (like animals that also carry poison or disease).
; sltargs spell: SPEL FormId
; sltargs actor: target Actor
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve SPEL with FormId (" + param[1] + ")")
    endif
endFunction

; sltname spell_dispel
; sltgrup Spells
; sltdesc Dispels specified SPEL by FormId from targeted Actor
; sltargs spell: SPEL FormId
; sltargs actor: target Actor
; sltsamp spell_dispel "skyrim.esm:275236" $self
; sltrslt If light was currently on $self, it would now be dispelled
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve SPEL with FormId (" + param[1] + ")")
    endif
endFunction

; sltname spell_add
; sltgrup Spells
; sltdesc Adds the specified SPEL by FormId to the targeted Actor, usually to add as an available power or spell in the spellbook.
; sltargs spell: SPEL FormId
; sltargs actor: target Actor
; sltsamp spell_add "skyrim.esm:275236" $self
; sltrslt The light spell is now in the actor's spellbook
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve SPEL with FormId (" + param[1] + ")")
    endif
endFunction

; sltname spell_remove
; sltgrup Spells
; sltdesc Removes the specified SPEL by FormId from the targeted Actor, usually to remove as an available power or spell in the spellbook.
; sltargs spell: SPEL FormId
; sltargs actor: target Actor
; sltsamp spell_remove "skyrim.esm:275236" $self
; sltrslt The light spell should no longer be in the actor's spellbook
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve SPEL with FormId (" + param[1] + ")")
    endif
endFunction

; sltname item_add
; sltgrup Items
; sltdesc Adds the item to the actor's inventory.
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs count: number
; sltargs displaymessage: 0 - show message | 1 - silent
; sltsamp item_add $self "skyrim.esm:15" 10 0
; sltrslt Adds 10 gold to the actor, displaying the notification
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_addex
; sltgrup Items
; sltdesc Adds the item to the actor's inventory, but check if some armor was re-equipped (if NPC)
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs count: number
; sltargs displaymessage: 0 - show message | 1 - silent
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_remove
; sltgrup Items
; sltdesc Remove the item from the actor's inventory
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs count: number
; sltargs displaymessage: 0 - show message | 1 - silent
; sltsamp item_remove $self "skyrim.esm:15" 10 0
; sltrslt Removes up to 10 gold from the actor
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_adduse
; sltgrup Items
; sltdesc Add item (like item_add) and then use the added item. Useful for potions, food, and other consumables.
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs count: number
; sltargs displaymessage: 0 - show message | 1 - silent
; sltsamp item_adduse $self "skyrim.esm:216158" 1 0
; sltrslt Add and drink some booze
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_equipex
; sltgrup Items
; sltdesc Equip item (SKSE version)
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs armorslot: number e.g. 32 for body slot
; sltargs sound: 0 - no sound | 1 - with sound
; sltargs removalallowed: 0 - removal allowed | 1 - removal not allowed
; sltsamp item_equipex $self "ZaZAnimationPack.esm:159072" 32 0 1
; sltrslt Equip the ZaZ armor on $self, at body slot 32, silently, with no removal allowed
; sltrslt Equips item directly, Workaround for "NPCs re-equip all armor, if they get an item that looks like armor"
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_equip
; sltgrup Items
; sltdesc Equip item ("vanilla" version)
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs removalallowed: 0 - removal allowed | 1 - removal not allowed
; sltargs sound: 0 - no sound | 1 - with sound
; sltargs <actor variable> <ITEM FormId> <0 - removal allowed | 1 - removal not allowed> <0 - no sound | 1 - with sound>
; sltsamp item_equip $self "ZaZAnimationPack.esm:159072" 1 0
; sltrslt Equip the ZaZ armor on $self, silently, with no removal allowed (uses whatever slot the armor uses)
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_unequipex
; sltgrup Items
; sltdesc Unequip item
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs armorslot: number e.g. 32 for body slot
; sltsamp item_unequipex $self "ZaZAnimationPack.esm:159072" 32
; sltrslt Unequips the ZaZ armor from slot 32 on $self
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname item_getcount
; sltgrup Items
; sltdesc Set $$ to how many of a specified item an actor has
; sltargs actor: target Actor
; sltargs item: ITEM FormId
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
    endif
endFunction

; sltname msg_notify
; sltgrup Utility
; sltdesc Display the message in the standard notification area (top left of your screen by default)
; sltargs message: <msg> [<msg> <msg> ...]
; sltsamp msg_notify "Hello" "world!"
; sltsamp msg_notify "Hello world!"
; sltrslt Both are the same
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
; sltgrup Utility
; sltdesc Display the message in the console
; sltargs message: <msg> [<msg> <msg> ...]
; sltsamp msg_console "Hello" "world!"
; sltsamp msg_console "Hello world!"
; sltrslt Both are the same
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
; sltgrup Utility
; sltdesc Sets $$ to one of the arguments at random
; sltargs arguments: <argument> <argument> [<argument> <argument> ...]
; sltsamp rnd_list "Hello" $2 "Yo"
; sltrslt $$ will be one of the values. $2 will be resolved to it's value before populating $$
function rnd_list(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 2)
        return
    endif
    
    int idx = Utility.RandomInt(1, param.Length - 1)
    CmdPrimary.MostRecentResult = CmdPrimary.Resolve(param[idx])
endFunction

; sltname rnd_int
; sltgrup Utility
; sltdesc Sets $$ to a random integer between min and max inclusive
; sltargs min: number
; sltargs max: number
; sltsamp rnd_int 1 100
function rnd_int(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    CmdPrimary.MostRecentResult = Utility.RandomInt(CmdPrimary.resolve(param[1]) as int, CmdPrimary.resolve(param[2]) as int) as string
endFunction

; sltname util_wait
; sltgrup Utility
; sltdesc Wait specified number of seconds i.e. Utility.Wait()
; sltargs duration: float, seconds
; sltsamp util_wait 2.5
; sltrslt The script will pause processing for 2.5 seconds
function util_wait(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    Utility.Wait(CmdPrimary.resolve(param[1]) as float)
endFunction

; sltname util_getrndactor
; sltgrup Utility
; sltdesc Sets $iterActor to a random actor within specified range of self
; sltargs range: 0 - all | >0 skyrim units
; sltsamp util_getrndactor 320
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
; sltgrup Perks
; sltdesc Add specified number of perk points to player
; sltargs perkpointcount: number of perk points to add
; sltsamp perk_addpoints 4
function perk_addpoints(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    Game.AddPerkPoints(CmdPrimary.resolve(param[1]) as int)
endFunction

; sltname perk_add
; sltgrup Perks
; sltdesc Add specified perk to the targeted actor
; sltargs perk: PERK FormID
; sltargs actor: target Actor
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[1] + ")")
    endif
endFunction

; sltname perk_remove
; sltgrup Perks
; sltdesc Remove specified perk from the targeted actor
; sltargs perk: PERK FormID
; sltargs actor: target Actor
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[1] + ")")
    endif
endFunction

; sltname actor_advskill
; sltgrup Actor
; sltdesc Advance targeted actor's skill by specified amount. Only works on Player.
; sltargs actor: target Actor
; sltargs skill: skillname e.g. Alteration, Destruction
; sltargs value: number
; sltsamp actor_advskill $self Alteration 1
; sltrslt Boost Alteration by 1 point
; sltrslt Note: Currently only works on PC/Player
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve skill name (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
    endif
endFunction

; sltname actor_incskill
; sltgrup Actor
; sltdesc Increase targeted actor's skill by specified amount
; sltargs actor: target Actor
; sltargs skill: skillname e.g. Alteration, Destruction
; sltargs value: number
; sltsamp actor_incskill $self Alteration 1
; sltrslt Boost Alteration by 1 point
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
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve skill name (" + param[2] + ")")
        endif
    else
        MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
    endif
endFunction

; sltname actor_isvalid
; sltgrup Actor
; sltdesc Set $$ to 1 if actor is valid, 0 if not.
; sltargs actor: target Actor
; sltsamp actor_isvalid $actor
; sltsamp if $$ = 0 end
; sltsamp ...
; sltsamp [end]
; sltrslt Jump to the end if actor is not valid
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
; sltgrup Actor
; sltdesc Set $$ to 1 if first actor can see second actor, 0 if not.
; sltargs first actor: target Actor
; sltargs second actor: target Actor
; sltsamp actor_haslos $actor $self
; sltsamp if $$ = 0 cannotseeme
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
; sltgrup Actor
; sltdesc Set $$ to the actor name
; sltargs actor: target Actor
; sltsamp actor_name $actor
function actor_name(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    CmdPrimary.MostRecentResult = CmdPrimary.ActorName(CmdPrimary.resolveActor(param[1]))
endFunction

; sltname actor_modcrimegold
; sltgrup Actor
; sltdesc Specified actor reports player, increasing bounty by specified amount.
; sltargs actor: target Actor
; sltargs bounty: number
; sltsamp actor_modcrimegold $actor 100
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
; sltgrup Actor
; sltdesc Repaints actor (calls QueueNiNodeUpdate)
; sltargs actor: target Actor
; sltsamp actor_qnnu $actor
; sltrslt Note: Do not call this too frequently as the rapid refreshes can causes crashes to desktop
function actor_qnnu(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    CmdPrimary.resolveActor(param[1]).QueueNiNodeUpdate()
endFunction

; sltname actor_isguard
; sltgrup Actor
; sltdesc Sets $$ to 1 if actor is guard, 0 otherwise.
; sltargs actor: target Actor
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
; sltgrup Actor
; sltdesc Sets $$ to 1 if actor is the player, 0 otherwise.
; sltargs actor: target Actor
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
; sltgrup Actor
; sltdesc Sets $$ to the actor's gender, 0 - male, 1 - female, 2 - creature
; sltargs actor: target Actor
; sltsamp actor_getgender $actor
function actor_getgender(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    CmdPrimary.MostRecentResult = CmdPrimary.ActorGender(CmdPrimary.resolveActor(param[1]))
endFunction

; sltname actor_say
; sltgrup Actor
; sltdesc Causes the actor to 'say' the topic indicated by FormId
; sltargs actor: target Actor
; sltargs topic: TOPIC FormID
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
; sltgrup Actor
; sltdesc Sets $$ to 1 if actor has the keyword, 0 otherwise.
; sltargs actor: target Actor
; sltargs keyword: string, keyword name
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
; sltgrup Actor
; sltdesc Sets $$ to 1 if actor is wearing the armor indicated by the FormId, 0 otherwise.
; sltargs actor: target Actor
; sltargs armor: ARMO FormID
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
; sltgrup Actor
; sltdesc Sets $$ to 1 if actor is wearing armor in the indicated slotId, 0 otherwise.
; sltargs actor: target Actor
; sltargs armorslot: number, e.g. 32 for body slot
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
; sltgrup Actor
; sltdesc Sets $$ to 1 if actor is wearing any armor with indicated keyword, 0 otherwise.
; sltargs actor: target Actor
; sltargs keyword: string, keyword name
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
; sltgrup Actor
; sltdesc Sets $$ to 1 if actor's current location has the indicated keyword, 0 otherwise.
; sltargs actor: target Actor
; sltargs keyword: string, keyword name
; sltsamp actor_lochaskeyword $actor "LocTypeInn"
; sltrslt In a bar, inn, or tavern
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
; sltgrup Actor
; sltdesc Set $$ to the relationship rank between the two actors
; sltargs first actor: target Actor
; sltargs second actor: target Actor
; sltsamp actor_getrelation $actor $player
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

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    CmdPrimary.MostRecentResult = CmdPrimary.resolveActor(param[1]).GetRelationshipRank(CmdPrimary.resolveActor(param[2])) as int
endFunction

; sltname actor_setrelation
; sltgrup Actor
; sltdesc Set relationship rank between the two actors to the indicated value
; sltargs first actor: target Actor
; sltargs second actor: target Actor
; sltargs rank: number
; sltsamp actor_setrelation $actor $player 0
; sltrslt See actor_getrelation for ranks
function actor_setrelation(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
        return
    endif

    CmdPrimary.resolveActor(param[1]).SetRelationshipRank(CmdPrimary.resolveActor(param[2]), CmdPrimary.resolve(param[3]) as int)
endFunction

; sltname actor_infaction
; sltgrup Actor
; sltdesc Sets $$ to 1 if actor is in the faction indicated by the FormId, 0 otherwise
; sltargs actor: target Actor
; sltargs faction: FACTION FormID
; sltsamp actor_infaction $actor "skyrim.esm:378958"
; sltrslt $$ will be 1 if $actor is a follower (CurrentFollowerFaction)
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
; sltgrup Actor
; sltdesc Sets $$ to the actor's rank in the faction indicated by the FormId
; sltargs actor: target Actor
; sltargs faction: FACTION FormID
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
; sltgrup Actor
; sltdesc Sets the actor's rank in the faction indicated by the FormId to the indicated rank
; sltargs actor: target Actor
; sltargs faction: FACTION FormID
; sltargs rank: number
; sltsamp actor_setfactionrank $actor "skyrim.esm:378958" -1
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
; sltgrup Actor
; sltdesc Sets $$ to 1 if the specified actor is currently affected by the MGEF or SPEL indicated by FormID (accepts either)
; sltargs actor: target Actor
; sltargs magic effect or spell: MGEF or SPEL FormID
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
; sltgrup Actor
; sltdesc Removes the actor from the specified faction
; sltargs actor: target Actor
; sltargs faction: FACTION FormID
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
; sltgrup Actor
; sltdesc Causes the actor to play the specified animation
; sltargs actor: target Actor
; sltargs animation: animation name
; sltsamp actor_playanim $self "IdleChildCryingStart"
function actor_playanim(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    Debug.SendAnimationEvent(CmdPrimary.resolveActor(param[1]), CmdPrimary.resolve(param[2]))
endFunction

; sltname actor_sendmodevent
; sltgrup Actor
; sltdesc Causes the actor to send the mod event with the provided arguments
; sltargs actor: target Actor
; sltargs event: name of the event
; sltargs string arg: string argument (meaning varies by event sent)
; sltargs float arg: float argument (meaning varies by event sent)
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
; sltgrup Actor
; sltdesc Returns the state of the actor for a given sub-function
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
; sltgrup Actor
; sltdesc Alters or queries information about the actor's body, based on sub-function
; sltargs actor: target Actor
; sltargs sub-function: sub-function
; sltargs third argument: varies by sub-function
; sltargsmore if parameter 2 is "ClearExtraArrows": clear extra arrows 
; sltargsmore if parameter 2 is "RegenerateHead": regenerate head
; sltargsmore if parameter 2 is "GetWeight": get actors weight (0-100)
; sltargsmore if parameter 2 is "SetWeight" (parameter 3: <float, weight>): set actors weight
; sltsamp actor_body $self "SetWeight" 110
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
; sltgrup Actor
; sltdesc Sets $$ to the race name based on sub-function. Blank, empty sub-function returns Vanilla racenames. e.g. "SL" can return SexLab race keynames.
; sltargs actor: target Actor
; sltargs sub-function: sub-function
; sltargsmore if parameter 2 is "": return actors race name. Skyrims, original name. Like: "Nord", "Breton"
; sltsamp actor_race $self ""
function actor_race(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    Actor mate = CmdPrimary.resolveActor(param[1])
    
    string result = ""
    if mate
        string ss1 = CmdPrimary.resolve(param[2])
        if ss1 == ""
            result = mate.GetRace().GetName()
        endIf
    endIf
    CmdPrimary.MostRecentResult = result
endFunction

; sltname actor_setalpha
; sltgrup Actor
; sltdesc Set the Actor's alpha value (inverse of transparency, 1.0 is fully visible) (has no effect if IsGhost() returns true)
; sltargs actor: target Actor
; sltargs alpha: 0.0 to 1.0 (higher is more visible)
; sltargs fade: 0 - instance | 1 - fade to the new alpha gradually
; sltsamp actor_setalpha $self 0.5 1 
; sltrslt $self will fade to new alpha of 0.5, not instantly
function actor_setalpha(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    Actor mate = CmdPrimary.resolveActor(param[1])
    
    if mate && !mate.IsGhost()
        float newalpha = param[2] as float
        mate.SetAlpha(newalpha)
    endIf
endFunction

; sltname ism_applyfade
; sltgrup Imagespace Modifier
; sltdesc Apply imagespace modifier - per original author, check CreationKit, SpecialEffects\Imagespace Modifier
; sltargs item: ITEM FormID
; sltargs duration: fade duration in seconds
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
; sltgrup Imagespace Modifier
; sltdesc Remove imagespace modifier - per original author, check CreationKit, SpecialEffects\Imagespace Modifier
; sltargs item: ITEM FormID
; sltargs duration: fade duration in seconds
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
; sltgrup Utility
; sltdesc Shorthand for actor_sendmodevent $player <event name> <string argument> <float argument>
; sltargs event: name of the event
; sltargs string arg: string argument (meaning varies by event sent)
; sltargs float arg: float argument (meaning varies by event sent)
; sltsamp util_sendmodevent "IHaveNoIdeaButEventNamesShouldBeEasyToFind" "strarg" 0.0
function util_sendmodevent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 4)
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

; sltname util_sendevent
; sltgrup Utility
; sltdesc Send SKSE custom event, with each type/value pair being an argument to the custom event
; sltargs event: name of the event
; sltargs param type: type of parameter e.g. "bool", "int", etc.
; sltargs param value: value of parameter
; sltargs [type/value, type/value ...]
; sltargsmore <type> can be any of [bool, int, float, string, form]
; sltsamp util_sendevent "slaUpdateExposure" form $self float 33
; sltrslt The "slaUpdateExposure" event will be sent with $self, and the float value of 33.0 as the two arguments
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
; sltgrup Utility
; sltdesc Sets $$ to the value of Utility.GetCurrentGameTime() (a float value representing the number of days in game time; mid-day day 2 is 1.5)
; sltsamp util_getgametime
function util_getgametime(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    float dayTime = Utility.GetCurrentGameTime()
    
    CmdPrimary.MostRecentResult = dayTime as string
endFunction

; sltname util_getrealtime
; sltgrup Utility
; sltdesc Sets $$ to the value of Utility.GetCurrentRealTime() (a float value representing the number of seconds since Skyrim.exe was launched this session)
; sltsamp util_getrealtime
function util_getrealtime(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentResult = Utility.GetCurrentRealTime() as string
endFunction

; sltname util_getgametime
; sltgrup Utility
; sltdesc Sets $$ to the in-game hour (i.e. 2:30 AM returns 2)
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
; sltgrup Utility
; sltdesc Perform game related functions based on sub-function
; sltargs sub-function: sub-function
; sltargs parameter: varies by sub-function
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
; sltgrup Sound
; sltdesc Return the sound instance handle from playing the specified audio from the specified actor
; sltargs audio: AUDIO FormID
; sltargs actor: target Actor
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
; sltgrup Sound
; sltdesc Set the sound volume using the specified sound instance handle (from snd_play)
; sltargs handle: sound instance handle from snd_play
; sltargs actor: target Actor
; sltargs volume: 0.0 - 1.0
; sltsamp snd_setvolume $1 0.5
; sltrslt Set the volume of the audio sound playing with handle stored in $1 to 50%
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
; sltgrup Sound
; sltdesc Stops the audio specified by the sound instance handle (from snd_play)
; sltargs handle: sound instance handle from snd_play
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
; sltgrup Utility
; sltdesc Executes the console command (requires a ConsoleUtil variant installed
; sltdesc Recommend ConsoleUtil-Extended https://www.nexusmods.com/skyrimspecialedition/mods/133569)
; sltargs actor: target Actor
; sltargs command: <command fragment> [<command fragment> ...] ; all <command fragments> will be concatenated
; sltsamp console $self "sgtm" "" "0.5"
; sltsamp console $self "sgtm 0.5"
; sltrslt Both are the same
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
; sltgrup MfgFix
; sltdesc Resets facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)
; sltargs actor: target Actor
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
; sltgrup MfgFix
; sltdesc Set facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)
; sltargs actor: target Actor
; sltargs mode: number, 0 - set phoneme | 1 - set modifier
; sltargs id
; sltargs value
; sltargs <actor variable> <mode> <id> <value>
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
; sltgrup MfgFix
; sltdesc Return facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)
; sltargs actor: target Actor
; sltargs mode: number, 0 - set phoneme | 1 - set modifier
; sltargs id
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
; sltgrup Utility
; sltdesc Sets $$ to the keycode pressed after waiting for user to press any of the specified keys
; sltargs dxscancode: <DXScanCode of key> [<DXScanCode of key> ...]
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
    
    while CmdPrimary && CmdPrimary.lastKey == 0
        Utility.Wait(0.5)
    endWhile

    CmdPrimary.UnregisterForAllKeys()
    
    CmdPrimary.MostRecentResult = CmdPrimary.lastKey as string
endFunction

; sltname json_getvalue
; sltgrup JSON
; sltdesc Sets $$ to value from JSON file (uses PapyrusUtil/JsonUtil)
; sltargs filename: name of file, rooted from 'Data/SKSE/Plugins/sl_triggers'
; sltargs datatype: int, float, string
; sltargs key: the key
; sltargs default: default value in case it isn't present
; sltsamp json_getvalue "../somefolder/afile" float "demofloatvalue" 2.3
; sltrslt JsonUtil automatically appends .json when not given a file extension
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
; sltgrup JSON
; sltdesc Sets a value in a JSON file (uses PapyrusUtil/JsonUtil)
; sltargs filename: name of file, rooted from 'Data/SKSE/Plugins/sl_triggers'
; sltargs datatype: int, float, string
; sltargs key: the key
; sltargs new value: value to set
; sltsamp json_setvalue "../somefolder/afile" float "demofloatvalue" 2.3
; sltrslt JsonUtil automatically appends .json when not given a file extension
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
; sltgrup JSON
; sltdesc Tells JsonUtil to immediately save the specified file from cache
; sltargs filename: name of file, rooted from 'Data/SKSE/Plugins/sl_triggers'
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
; sltgrup Utility
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
; sltgrup Utility
; sltdesc Return values from math operations based on sub-function
; sltargs sub-function: sub-function
; sltargs variable: variable 3 varies by sub-function
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
 