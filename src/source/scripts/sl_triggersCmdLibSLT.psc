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

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        string[] darr = PapyrusUtil.StringArray(param.Length)
        darr[0] = "DebMsg> "
        int i = 1
        while i < darr.Length
            darr[i] = CmdPrimary.Resolve(param[i])
            i += 1
        endwhile
        string dmsg = PapyrusUtil.StringJoin(darr, "")
        DebMsg(dmsg)
    endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            _targetActor.RestoreActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)
        endif
    endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            _targetActor.DamageActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)
        endif
    endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            _targetActor.ModActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)
        endif
    endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            _targetActor.SetActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)
        endif
    endif
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

    string nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])

        if _targetActor
            nextResult = _targetActor.GetBaseActorValue(CmdPrimary.resolve(param[2])) as string
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult
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

    string nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])

        if _targetActor
            nextResult = _targetActor.GetActorValue(CmdPrimary.resolve(param[2])) as string
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult
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

    string nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])

        if _targetActor
            nextResult = _targetActor.GetActorValueMax(CmdPrimary.resolve(param[2])) as string
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult
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

    string nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            nextResult = (_targetActor.GetActorValuePercentage(CmdPrimary.resolve(param[2])) * 100.0) as string
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult
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

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
            if _targetActor
                thing.RemoteCast(_targetActor, _targetActor, _targetActor)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve SPEL with FormId (" + param[1] + ")")
        endIf
    endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
            if _targetActor
                _targetActor.DoCombatSpellApply(thing, _targetActor)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve SPEL with FormId (" + param[1] + ")")
        endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
            if _targetActor
                _targetActor.DispelSpell(thing)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve SPEL with FormId (" + param[1] + ")")
        endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
            if _targetActor
                _targetActor.AddSpell(thing)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve SPEL with FormId (" + param[1] + ")")
        endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
            if _targetActor
                _targetActor.RemoveSpell(thing)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve SPEL with FormId (" + param[1] + ")")
        endif
    endif
endFunction

; sltname item_add
; sltgrup Items
; sltdesc Adds the item to the actor's inventory.
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs count: number (optional: default 1)
; sltargs displaymessage: 0 - show message | 1 - silent (optional: default 0 - show message)
; sltsamp item_add $self "skyrim.esm:15" 10 0
; sltrslt Adds 10 gold to the actor, displaying the notification
function item_add(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 6)
        Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
    
            if _targetActor
                int count = 1
                if param.Length > 3
                    count = CmdPrimary.resolve(param[3]) as int
                endif
                bool isSilent = false
                if param.Length > 4
                    isSilent = CmdPrimary.resolve(param[4]) as int
                endif
                _targetActor.AddItem(thing, count, isSilent)
            else
                DebMsg("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            DebMsg("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif
endFunction

; sltname item_addex
; sltgrup Items
; sltdesc Adds the item to the actor's inventory, but check if some armor was re-equipped (if NPC)
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs count: number (optional: default 1)
; sltargs displaymessage: 0 - show message | 1 - silent (optional: default 0 - show message)
; sltsamp item_addex $self "skyrim.esm:15" 10 0
function item_addex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 6)
    
        Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
        if thing
            int count = 1
            if param.Length > 3
                count = CmdPrimary.resolve(param[3]) as int
            endif
            bool isSilent = false
            if param.Length > 4
                isSilent = CmdPrimary.resolve(param[4]) as int
            endif
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
            
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
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif
endFunction

; sltname item_remove
; sltgrup Items
; sltdesc Remove the item from the actor's inventory
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs count: number
; sltargs displaymessage: 0 - show message | 1 - silent (optional: default 0 - show message)
; sltsamp item_remove $self "skyrim.esm:15" 10 0
; sltrslt Removes up to 10 gold from the actor
function item_remove(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 6)
        Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])

            if _targetActor
                int count = CmdPrimary.resolve(param[3]) as int
                bool isSilent = false
                if param.Length > 4
                    isSilent = CmdPrimary.resolve(param[4]) as int
                endif
                _targetActor.RemoveItem(thing, count, isSilent)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif
endFunction

; sltname item_adduse
; sltgrup Items
; sltdesc Add item (like item_add) and then use the added item. Useful for potions, food, and other consumables.
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs count: number (optional: default 1)
; sltargs displaymessage: 0 - show message | 1 - silent (optional: default 0 - show message)
; sltsamp item_adduse $self "skyrim.esm:216158" 1 0
; sltrslt Add and drink some booze
function item_adduse(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 6)
        Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))    
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
            if _targetActor
                int count = 1
                if param.Length > 3
                    count = CmdPrimary.resolve(param[3]) as int
                endif
                bool isSilent = false
                if param.Length > 4
                    isSilent = CmdPrimary.resolve(param[4]) as int
                endif
                _targetActor.AddItem(thing, count, isSilent)
                _targetActor.EquipItem(thing, false, isSilent)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 6)
        Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))    
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
            if _targetActor
                int slotId = CmdPrimary.resolve(param[3]) as int
                bool isSilent = CmdPrimary.resolve(param[4]) as int
                bool isRemovalPrevented = CmdPrimary.Resolve(param[5]) as int
                _targetActor.EquipItemEx(thing, slotId, isRemovalPrevented, isSilent)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 5)
        Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
            if _targetActor
                int slotId = CmdPrimary.resolve(param[3]) as int
                bool isSilent = CmdPrimary.resolve(param[4]) as int
                _targetActor.EquipItem(thing, slotId, isSilent)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
            if _targetActor
                int slotId = CmdPrimary.resolve(param[3]) as int
                _targetActor.UnEquipItemEx(thing, slotId)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
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

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))    
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
            if _targetActor
                nextResult = _targetActor.GetItemCount(thing)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult
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

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        string[] darr = PapyrusUtil.StringArray(param.Length)
        int i = 1
        while i < darr.Length
            darr[i] = CmdPrimary.Resolve(param[i])
            i += 1
        endwhile
        string msg = PapyrusUtil.StringJoin(darr, "")
        Debug.Notification(msg)
    endif
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

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        string[] darr = PapyrusUtil.StringArray(param.Length)
        int i = 1
        while i < darr.Length
            darr[i] = CmdPrimary.Resolve(param[i])
            i += 1
        endwhile
        string msg = PapyrusUtil.StringJoin(darr, "")
        MiscUtil.PrintConsole(msg)
    endif
endFunction

; sltname rnd_list
; sltgrup Utility
; sltdesc Sets $$ to one of the arguments at random
; sltargs arguments: <argument> <argument> [<argument> <argument> ...]
; sltsamp rnd_list "Hello" $2 "Yo"
; sltrslt $$ will be one of the values. $2 will be resolved to it's value before populating $$
function rnd_list(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        int idx = Utility.RandomInt(1, param.Length - 1)
        nextResult = CmdPrimary.Resolve(param[idx])
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname rnd_int
; sltgrup Utility
; sltdesc Sets $$ to a random integer between min and max inclusive
; sltargs min: number
; sltargs max: number
; sltsamp rnd_int 1 100
function rnd_int(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        nextResult = Utility.RandomInt(CmdPrimary.resolve(param[1]) as int, CmdPrimary.resolve(param[2]) as int) as string
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname util_wait
; sltgrup Utility
; sltdesc Wait specified number of seconds i.e. Utility.Wait()
; sltargs duration: float, seconds
; sltsamp util_wait 2.5
; sltrslt The script will pause processing for 2.5 seconds
function util_wait(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Utility.Wait(CmdPrimary.resolve(param[1]) as float)
    endif
endFunction

; sltname util_getrandomactor
; sltgrup Utility
; sltdesc Sets $iterActor to a random actor within specified range of self
; sltargs range: 0 - all | >0 skyrim units
; sltsamp util_getrandomactor 320
function util_getrandomactor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    Actor nextIterActor

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor[] inCell = MiscUtil.ScanCellNPCs(CmdPrimary.PlayerRef, CmdPrimary.resolve(param[1]) as float)
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

    CmdPrimary.iterActor = nextIterActor
endFunction

; sltname perk_addpoints
; sltgrup Perks
; sltdesc Add specified number of perk points to player
; sltargs perkpointcount: number of perk points to add
; sltsamp perk_addpoints 4
function perk_addpoints(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Game.AddPerkPoints(CmdPrimary.resolve(param[1]) as int)
    endif
endFunction

; sltname perk_add
; sltgrup Perks
; sltdesc Add specified perk to the targeted actor
; sltargs perk: PERK FormID
; sltargs actor: target Actor
; sltsamp perk_add "skyrim.esm:12384" $self
function perk_add(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Perk thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Perk    
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
            if _targetActor
                _targetActor.AddPerk(thing)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[1] + ")")
        endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Perk thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Perk    
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
            if _targetActor
                _targetActor.RemovePerk(thing)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[2] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve ITEM with FormId (" + param[1] + ")")
        endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            string skillName = CmdPrimary.resolve(param[2])
            if skillName
                Game.AdvanceSkill(skillName, CmdPrimary.resolve(param[3]) as int)
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve skill name (" + param[2] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
        endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            string skillName = CmdPrimary.resolve(param[2])
            if skillName
                if _targetActor == CmdPrimary.PlayerRef
                    Game.IncrementSkillBy(skillName, CmdPrimary.resolve(param[3]) as int)
                else
                    _targetActor.ModActorValue(skillName, CmdPrimary.resolve(param[3]) as int)
                endif
            else
                MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve skill name (" + param[2] + ")")
            endif
        else
            MiscUtil.PrintConsole("SLT: [" + CmdPrimary.cmdName + "][lineNum:" + CmdPrimary.lineNum + "] unable to resolve actor variable (" + param[1] + ")")
        endif
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

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Cell  cc = CmdPrimary.PlayerRef.getParentCell()
        
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor && _targetActor.isEnabled() && !_targetActor.isDead() && !_targetActor.isInCombat() && !_targetActor.IsUnconscious() && _targetActor.Is3DLoaded() && cc == _targetActor.getParentCell()
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
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

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _actorOne = CmdPrimary.resolveActor(param[1])
        Actor _actorTwo = CmdPrimary.resolveActor(param[2])
        
        if _actorOne && _actorTwo && _actorOne.hasLOS(_actorTwo)
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname actor_name
; sltgrup Actor
; sltdesc Set $$ to the actor name
; sltargs actor: target Actor
; sltsamp actor_name $actor
function actor_name(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            nextResult = CmdPrimary.ActorName(_targetActor)
        endif
    endif
    
    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname actor_modcrimegold
; sltgrup Actor
; sltdesc Specified actor reports player, increasing bounty by specified amount.
; sltargs actor: target Actor
; sltargs bounty: number
; sltsamp actor_modcrimegold $actor 100
function actor_modcrimegold(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            Faction crimeFact = _targetActor.GetCrimeFaction()
            if crimeFact
                crimeFact.ModCrimeGold(CmdPrimary.resolve(param[2]) as int, false)
            endIf
        endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            _targetActor.QueueNiNodeUpdate()
        endif
    endif
endFunction

; sltname actor_isguard
; sltgrup Actor
; sltdesc Sets $$ to 1 if actor is guard, 0 otherwise.
; sltargs actor: target Actor
; sltsamp actor_isguard $actor
function actor_isguard(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor && _targetActor.IsGuard()
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
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

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor && _targetActor == CmdPrimary.PlayerRef
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname actor_getgender
; sltgrup Actor
; sltdesc Sets $$ to the actor's gender, 0 - male, 1 - female, 2 - creature, "" otherwise
; sltargs actor: target Actor
; sltsamp actor_getgender $actor
function actor_getgender(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            nextResult = CmdPrimary.ActorGender(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname actor_say
; sltgrup Actor
; sltdesc Causes the actor to 'say' the topic indicated by FormId; not usable on the Player
; sltargs actor: target Actor
; sltargs topic: TOPIC FormID
; sltsamp actor_say $actor "Skyrim.esm:1234"
function actor_say(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        string thingFormId = CmdPrimary.resolve(param[2])
        Topic thing = CmdPrimary.GetFormId(thingFormId) as Topic
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
            if _targetActor
                _targetActor.Say(thing)
            endif
        endIf
    endif
endFunction

; sltname actor_haskeyword
; sltgrup Actor
; sltdesc Sets $$ to 1 if actor has the keyword, 0 otherwise.
; sltargs actor: target Actor
; sltargs keyword: string, keyword name
; sltsamp actor_haskeyword $actor Vampire
function actor_haskeyword(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Keyword keyw = Keyword.GetKeyword(CmdPrimary.resolve(param[2]))
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if keyw && _targetActor && _targetActor.HasKeyword(keyw)
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname actor_iswearing
; sltgrup Actor
; sltdesc Sets $$ to 1 if actor is wearing the armor indicated by the FormId, 0 otherwise.
; sltargs actor: target Actor
; sltargs armor: ARMO FormID
; sltsamp actor_iswearing $actor "petcollar.esp:31017"
function actor_iswearing(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Armor thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Armor
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if thing && _targetActor && _targetActor.IsEquipped(thing)
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname actor_getscale
; sltgrup Actor
; sltdesc Sets $$ to the 'scale' value of the specified Actor
; sltdesc Note: this is properly a function of ObjectReference, so may get pushed to a different group at some point
; sltargs actor: target Actor
; sltsamp actor_getscale $self
; sltsamp msg_console "Scale reported: " $$
function actor_getscale(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            nextResult = _targetActor.GetScale() as string
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname actor_setscale
; sltgrup Actor
; sltdesc Sets the actor's scale to the specified value
; sltdesc Note: this is properly a function of ObjectReference, so may get pushed to a different group at some point
; sltargs actor: target Actor
; sltargs scale: float, new scale value to replace the old
; sltsamp actor_setscale $self 1.01
function actor_setscale(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        float newScale = CmdPrimary.Resolve(param[2]) as float
        if _targetActor
            _targetActor.SetScale(newScale)
        endif
    endif
endFunction

; sltname actor_worninslot
; sltgrup Actor
; sltdesc Sets $$ to 1 if actor is wearing armor in the indicated slotId, 0 otherwise.
; sltargs actor: target Actor
; sltargs armorslot: number, e.g. 32 for body slot
; sltsamp actor_worninslot $actor 32
function actor_worninslot(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor && _targetActor.GetEquippedArmorInSlot(CmdPrimary.Resolve(param[2]) as int)
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname actor_wornhaskeyword
; sltgrup Actor
; sltdesc Sets $$ to 1 if actor is wearing any armor with indicated keyword, 0 otherwise.
; sltargs actor: target Actor
; sltargs keyword: string, keyword name
; sltsamp actor_wornhaskeyword $actor "VendorItemJewelry"
function actor_wornhaskeyword(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Keyword keyw = Keyword.GetKeyword(CmdPrimary.resolve(param[2]))
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        
        if keyw && _targetActor && _targetActor.WornHasKeyword(keyw)
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
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

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Keyword keyw = Keyword.GetKeyword(CmdPrimary.resolve(param[2]))
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        
        if keyw && _targetActor && _targetActor.GetCurrentLocation().HasKeyword(keyw)
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
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

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _actorOne = CmdPrimary.resolveActor(param[1])
        Actor _actorTwo = CmdPrimary.resolveActor(param[2])
        if _actorOne && _actorTwo
            nextResult = _actorOne.GetRelationshipRank(_actorTwo) as int
        endif
    endif
    
    CmdPrimary.MostRecentResult = nextResult
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

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _actorOne = CmdPrimary.resolveActor(param[1])
        Actor _actorTwo = CmdPrimary.resolveActor(param[2])
        if _actorOne && _actorTwo
            _actorOne.SetRelationshipRank(_actorTwo, CmdPrimary.resolve(param[3]) as int)
        endif
    endif
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

    int nextResult = 0

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        Faction thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Faction
        if _targetActor && thing && _targetActor.IsInFaction(thing)
            nextResult = 1
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname actor_getfactionrank
; sltgrup Actor
; sltdesc Sets $$ to the actor's rank in the faction indicated by the FormId
; sltargs actor: target Actor
; sltargs faction: FACTION FormID
; sltsamp actor_getfactionrank $actor "skyrim.esm:378958"
function actor_getfactionrank(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult = 0

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            Faction thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Faction
            
            if thing
                nextResult = _targetActor.GetFactionRank(thing)
            endif
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult
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

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            Faction thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Faction
            if thing
                _targetActor.SetFactionRank(thing, CmdPrimary.resolve(param[3]) as int)
            endif
        endif
    endif
endFunction

; sltname actor_isaffectedby
; sltgrup Actor
; sltdesc Sets $$ to 1 if the specified actor is currently affected by the MGEF or SPEL indicated by FormID (accepts either)
; sltargs actor: target Actor
; sltargs (optional) "ALL": if specified, all following MGEF or SPEL FormIDs must be found on the target Actor
; sltargs magic effect or spell: MGEF or SPEL FormID [<MGEF or SPEL FormID> <MGEF or SPEL FormID> ...]
; sltsamp actor_isaffectedby $actor "skyrim.esm:1030541"
; sltsamp actor_isaffectedby $actor "skyrim.esm:1030541" "skyrim.esm:1030542" "skyrim.esm:1030543"
; sltsamp actor_isaffectedby $actor ALL "skyrim.esm:1030541" "skyrim.esm:1030542" "skyrim.esm:1030543"
function actor_isaffectedby(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult = -1

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            int idx = 2
            bool needAll
            int spelidx
            int numeffs
            while idx < param.Length && nextResult < -1
                string pstr = CmdPrimary.Resolve(param[idx])
                if idx == 2 && "ALL" == pstr
                    needAll = true
                    idx += 1
                else
                    Form wizardStuff = CmdPrimary.GetFormId(pstr)
                    if !wizardStuff
                        wizardStuff = CmdPrimary.GetFormId(CmdPrimary.Resolve(pstr))
                    endif

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
	
	CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname actor_removefaction
; sltgrup Actor
; sltdesc Removes the actor from the specified faction
; sltargs actor: target Actor
; sltargs faction: FACTION FormID
; sltsamp actor_removefaction $actor "skyrim.esm:3505"
function actor_removefaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        Faction thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Faction
    
        if thing && _targetActor
            _targetActor.RemoveFromFaction(thing)
        endif
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

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Debug.SendAnimationEvent(CmdPrimary.resolveActor(param[1]), CmdPrimary.resolve(param[2]))
    endif
endFunction

; sltname actor_sendmodevent
; sltgrup Actor
; sltdesc Causes the actor to send the mod event with the provided arguments
; sltargs actor: target Actor
; sltargs event: name of the event
; sltargs string arg: string argument (meaning varies by event sent) (optional: default "")
; sltargs float arg: float argument (meaning varies by event sent) (optional: default 0.0)
; sltsamp actor_sendmodevent $self "IHaveNoIdeaButEventNamesShouldBeEasyToFind" "strarg" 20.0
function actor_sendmodevent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            string ss1 = CmdPrimary.resolve(param[2])
            string ss2
            if param.Length > 3
                ss2 = CmdPrimary.resolve(param[3])
            endif
            float  p3
            if param.Length > 4
                p3 = CmdPrimary.resolve(param[4]) as float
            endif
            
            _targetActor.SendModEvent(ss1, ss2, p3)
        endif
    endif
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

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        string ss1 = CmdPrimary.resolve(param[2])
        
        string nextResult
        if _targetActor 
            if ss1 == "GetCombatState"
                nextResult = _targetActor.GetCombatState() as string
            elseif ss1 == "GetLevel"
                nextResult = _targetActor.GetLevel() as string
            elseif ss1 == "GetSleepState"
                nextResult = _targetActor.GetSleepState() as string
            elseif ss1 == "IsAlerted"
                nextResult = _targetActor.IsAlerted() as string
            elseif ss1 == "IsAlarmed"
                nextResult = _targetActor.IsAlarmed() as string
            elseif ss1 == "IsPlayerTeammate"
                nextResult = _targetActor.IsPlayerTeammate() as string
            elseif ss1 == "SetPlayerTeammate"
                int p3 = 0
                if param.Length > 3
                    p3 = CmdPrimary.resolve(param[3]) as int
                endif
                _targetActor.SetPlayerTeammate(p3 as bool)
            elseif ss1 == "SendAssaultAlarm"
                _targetActor.SendAssaultAlarm()
            endIf
        endIf

        if StringUtil.GetLength(nextResult) > 0
            CmdPrimary.MostRecentResult = nextResult
        endif
    endif
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

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        string ss1 = CmdPrimary.resolve(param[2])
        
        if _targetActor 
            if ss1 == "ClearExtraArrows"
                _targetActor.ClearExtraArrows()
            elseif ss1 == "RegenerateHead"
                _targetActor.RegenerateHead()
            elseif ss1 == "GetWeight"
                CmdPrimary.MostRecentResult = _targetActor.GetActorBase().GetWeight() as string
            elseif ss1 == "SetWeight"
                float baseW = _targetActor.GetActorBase().GetWeight()
                float p3
                if param.Length > 3
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
                    _targetActor.GetActorBase().SetWeight(newW)
                    _targetActor.UpdateWeight(neckD)
                EndIf
            endIf
        endIf
    endif
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

    string nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        
        if _targetActor
            string ss1 = CmdPrimary.resolve(param[2])
            if !ss1
                nextResult = _targetActor.GetRace().GetName()
            endIf
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname actor_setalpha
; sltgrup Actor
; sltdesc Set the Actor's alpha value (inverse of transparency, 1.0 is fully visible) (has no effect if IsGhost() returns true)
; sltargs actor: target Actor
; sltargs alpha: 0.0 to 1.0 (higher is more visible)
; sltargs fade: 0 - instance | 1 - fade to the new alpha gradually (optional: default 1 - fade)
; sltsamp actor_setalpha $self 0.5 1 
; sltrslt $self will fade to new alpha of 0.5, not instantly
function actor_setalpha(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 5)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        
        if _targetActor && !_targetActor.IsGhost()
            float alpha = CmdPrimary.Resolve(param[2]) as float
            bool abFade = true
            if param.Length > 3
                abFade = (CmdPrimary.Resolve(param[3]) as int) != 0
            endif
            _targetActor.SetAlpha(alpha, abFade)
        endIf
    endif
endFunction

; sltname ism_applyfade
; sltgrup Imagespace Modifier
; sltdesc Apply imagespace modifier - per original author, check CreationKit, SpecialEffects\Imagespace Modifier
; sltargs item: ITEM FormID
; sltargs duration: fade duration in seconds
; sltsamp ism_applyfade $1 2
function ism_applyfade(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        ImageSpaceModifier thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as ImageSpaceModifier
    
        if thing
            thing.ApplyCrossFade(CmdPrimary.resolve(param[2]) as float)
        endIf
    endif
endFunction

; sltname ism_removefade
; sltgrup Imagespace Modifier
; sltdesc Remove imagespace modifier - per original author, check CreationKit, SpecialEffects\Imagespace Modifier
; sltargs item: ITEM FormID
; sltargs duration: fade duration in seconds
; sltsamp ism_removefade $1 2
function ism_removefade(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1]))
    
        if thing
            ImageSpaceModifier.RemoveCrossFade(CmdPrimary.resolve(param[2]) as float)
        endIf
    endif
endFunction

; sltname util_sendmodevent
; sltgrup Utility
; sltdesc Shorthand for actor_sendmodevent $player <event name> <string argument> <float argument>
; sltargs event: name of the event
; sltargs string arg: string argument (meaning varies by event sent) (optional: default "")
; sltargs float arg: float argument (meaning varies by event sent) (optional: default 0.0)
; sltsamp util_sendmodevent "IHaveNoIdeaButEventNamesShouldBeEasyToFind" "strarg" 0.0
function util_sendmodevent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        string ss1 = CmdPrimary.resolve(param[1])
        string ss2
        if param.Length > 2
            ss2 = CmdPrimary.resolve(param[2])
        endif
        float  p3
        if param.Length > 3
            p3 = CmdPrimary.resolve(param[3]) as float
        endif
        
        CmdTargetActor.SendModEvent(ss1, ss2, p3)
    endif
endFunction

; sltname util_sendevent
; sltgrup Utility
; sltdesc Send SKSE custom event, with each type/value pair being an argument to the custom event
; sltargs event: name of the event
; sltargs (type/value pairs are optional; this devolves to util_sendmodevent <eventname>, though with such a call the event signature would require having no arguments)
; sltargs param type: type of parameter e.g. "bool", "int", etc.
; sltargs param value: value of parameter
; sltargs [type/value, type/value ...]
; sltargsmore <type> can be any of [bool, int, float, string, form]
; sltsamp util_sendevent "slaUpdateExposure" form $self float 33
; sltrslt The "slaUpdateExposure" event will be sent with $self, and the float value of 33.0 as the two arguments
function util_sendevent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthGT(CmdPrimary, param.Length, 1)
        string eventName = CmdPrimary.resolve(param[1])
        if eventName
            int eid = ModEvent.Create(eventName)
            
            if eid
                string typeId
                string ss
                
                int idxArg = 2 
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
                    else
                        SquawkFunctionError(CmdPrimary, "util_sendevent: unexpected type provided: '" + typeId + "'")
                    endif
                    
                    idxArg += 2
                endWhile

                if idxArg >= param.Length
                    SquawkFunctionError(CmdPrimary, "util_sendevent: imbalanced type/value pairs provided")
                endif
                
                ModEvent.Send(eid)
            endIf
        endif
    endif
endFunction

; sltname util_getgametime
; sltgrup Utility
; sltdesc Sets $$ to the value of Utility.GetCurrentGameTime() (a float value representing the number of days in game time; mid-day day 2 is 1.5)
; sltsamp util_getgametime
function util_getgametime(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        float dayTime = Utility.GetCurrentGameTime()
        dayTime = Math.Floor(dayTime * 100.0) / 100.0
        
        CmdPrimary.MostRecentResult = dayTime
    else
        CmdPrimary.MostRecentResult = ""
    endif
endFunction

; sltname util_getrealtime
; sltgrup Utility
; sltdesc Sets $$ to the value of Utility.GetCurrentRealTime() (a float value representing the number of seconds since Skyrim.exe was launched this session)
; sltsamp util_getrealtime
function util_getrealtime(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        float realTime = Utility.GetCurrentRealTime()
        realTime = Math.Floor(realTime * 100.0) / 100.0

        CmdPrimary.MostRecentResult = realTime
    else
        CmdPrimary.MostRecentResult = ""
    endif
endFunction

; sltname util_getgametime
; sltgrup Utility
; sltdesc Sets $$ to the in-game hour (i.e. 2:30 AM returns 2)
; sltsamp util_getgametime
function util_gethour(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        float dayTime = Utility.GetCurrentGameTime()
    
        dayTime -= Math.Floor(dayTime)
        dayTime *= 24
        
        int theHour = dayTime as int
        
        CmdPrimary.MostRecentResult = theHour as string
    else
        CmdPrimary.MostRecentResult = ""
    endif
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
	
    if ParamLengthGT(CmdPrimary, param.Length, 2)
        string p1 = CmdPrimary.resolve(param[1])
        
        if "IncrementStat" == p1
            string p2 = CmdPrimary.resolve(param[2])
            int iModAmount
            if param.Length > 3
                iModAmount = CmdPrimary.resolve(param[3]) as Int
            endif
            Game.IncrementStat(p2, iModAmount)
        elseIf "QueryStat" == p1
            string p2 = CmdPrimary.resolve(param[2])
            CmdPrimary.MostRecentResult = Game.QueryStat(p2) as string
        endIf
    endif
endFunction

; sltname snd_play
; sltgrup Sound
; sltdesc Return the sound instance handle from playing the specified audio from the specified actor
; sltargs audio: AUDIO FormID
; sltargs actor: target Actor
; sltsamp snd_play "skyrim.esm:318128" $self
function snd_play(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult = 0
	
    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Sound   thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Sound
        Actor   _targetActor = CmdPrimary.resolveActor(param[2])
        int     retVal
        if thing && _targetActor
            nextResult = thing.Play(_targetActor)
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
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
	
    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        int    soundId = CmdPrimary.resolve(param[1]) as int
        float  vol     = CmdPrimary.resolve(param[2]) as float
        Sound.SetInstanceVolume(soundId, vol)
    endif
endFunction

; sltname snd_stop
; sltgrup Sound
; sltdesc Stops the audio specified by the sound instance handle (from snd_play)
; sltargs handle: sound instance handle from snd_play
; sltsamp snd_stop $1
function snd_stop(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        int    soundId = CmdPrimary.resolve(param[1]) as int
        Sound.StopInstance(soundId)
    endif
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
	
    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])

        if _targetActor
            int cnt = param.length
            int idx = 2
        
            string ss
            string ssx
            while idx < cnt
                ss = CmdPrimary.resolve(param[idx])
                ssx += ss
                idx += 1
            endWhile
            
            sl_TriggersConsole.exec_console(_targetActor, ssx)
        endif
    endif
endFunction

; sltname mfg_reset
; sltgrup MfgFix
; sltdesc Resets facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)
; sltargs actor: target Actor
; sltsamp mfg_reset $self
function mfg_reset(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            sl_TriggersMfg.mfg_reset(_targetActor)
        endif
    endif
endFunction

; sltname mfg_setphonememodifier
; sltgrup MfgFix
; sltdesc Set facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)
; sltargs actor: target Actor
; sltargs mode: number, 0 - set phoneme | 1 - set modifier
; sltargs id: an id  (I'm not familiar with MfgFix :/)
; sltargs value: int
; sltargs <actor variable> <mode> <id> <value>
; sltsamp mfg_setphonememodifier $self 0 $1 $2
function mfg_setphonememodifier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthEQ(CmdPrimary, param.Length, 5)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if !_targetActor
            int p1 = CmdPrimary.resolve(param[2]) as Int
            int p2 = CmdPrimary.resolve(param[3]) as Int
            int p3 = CmdPrimary.resolve(param[4]) as Int
            
            sl_TriggersMfg.mfg_SetPhonemeModifier(_targetActor, p1, p2, p3)
        endif
    endif
endFunction

; sltname mfg_getphonememodifier
; sltgrup MfgFix
; sltdesc Return facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)
; sltargs actor: target Actor
; sltargs mode: number, 0 - set phoneme | 1 - set modifier
; sltargs id: an id (I'm not familiar with MfgFix :/)
; sltsamp mfg_getphonememodifier $self 0 $1
function mfg_getphonememodifier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult
	
    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            int p1 = CmdPrimary.resolve(param[2]) as Int
            int p2 = CmdPrimary.resolve(param[3]) as Int
        
            nextResult = sl_TriggersMfg.mfg_GetPhonemeModifier(_targetActor, p1, p2)
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult as string
endFunction

; sltname util_waitforkbd
; sltgrup Utility
; sltdesc Sets $$ to the keycode pressed after waiting for user to press any of the specified keys
; sltargs dxscancode: <DXScanCode of key> [<DXScanCode of key> ...]
; sltsamp util_waitforkbd 74 78 181 55
function util_waitforkbd(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult = -1
	
    if ParamLengthGT(CmdPrimary, param.Length, 1) && CmdTargetActor == CmdPrimary.PlayerRef
        int cnt         = param.length
        string ss
        string ssx
        int idx
        int scancode
    
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

        if CmdPrimary.lastKey ; and at this point, it really ought to be
            nextResult = CmdPrimary.lastKey
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult as string
endFunction

; sltname json_getvalue
; sltgrup JSON
; sltdesc Sets $$ to value from JSON file (uses PapyrusUtil/JsonUtil)
; sltargs filename: name of file, rooted from 'Data/SKSE/Plugins/sl_triggers'
; sltargs datatype: int, float, string
; sltargs key: the key
; sltargs default: default value in case it isn't present (optional: default for type)
; sltsamp json_getvalue "../somefolder/afile" float "demofloatvalue" 2.3
; sltrslt JsonUtil automatically appends .json when not given a file extension
function json_getvalue(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult
	
    if ParamLengthGT(CmdPrimary, param.Length, 3)
        string pname = CmdPrimary.resolve(param[1])
        string ptype = CmdPrimary.resolve(param[2])
        string pkey  = CmdPrimary.resolve(param[3])
        string pdef
        if param.Length > 4
            pdef = CmdPrimary.resolve(param[4])
        endif
        
        if pname && ptype && pkey
            if ptype == "int"
                int iRet = JsonUtil.GetIntValue(pname, pkey, pdef as int)
                nextResult = iRet as string
            elseif ptype == "float"
                float fRet = JsonUtil.GetFloatValue(pname, pkey, pdef as float)
                nextResult = fRet as string
            else
                string sRet = JsonUtil.GetStringValue(pname, pkey, pdef)
                nextResult = sRet
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

    CmdPrimary.MostRecentResult = nextResult
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
	
    if ParamLengthEQ(CmdPrimary, param.Length, 5)
        string pname = CmdPrimary.resolve(param[1])
        string ptype = CmdPrimary.resolve(param[2])
        string pkey  = CmdPrimary.resolve(param[3])
        string pdef  = CmdPrimary.resolve(param[4])
    
        if pname && ptype && pkey
            if ptype == "int"
                JsonUtil.SetIntValue(pname, pkey, pdef as int)
            elseif ptype == "float"
                JsonUtil.SetFloatValue(pname, pkey, pdef as float)
            elseif ptype == "string"
                JsonUtil.SetStringValue(pname, pkey, pdef)
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
endFunction

; sltname json_save
; sltgrup JSON
; sltdesc Tells JsonUtil to immediately save the specified file from cache
; sltargs filename: name of file, rooted from 'Data/SKSE/Plugins/sl_triggers'
; sltsamp json_save "../somefolder/afile"
function json_save(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        string pname = CmdPrimary.resolve(param[1])
        if pname
            JsonUtil.Save(pname)
        endif
    endif
endFunction

string function getValidJSONType(sl_triggersCmd CmdPrimary, string jtype) global
    if "int" == jtype || "float" == jtype || "string" == jtype
        return jtype
    endif
    SquawkFunctionError(CmdPrimary, "jsonutil: unimplemented JSON type (" + jtype + ")")
    return ""
endfunction

; sltname jsonutil
; sltgrup PapyrusUtil
; sltdesc Wrapper around most JsonUtil functions
; sltargs <sub-function> - JsonUtil functionality to perform
; sltargs <filename> - JSON file to interact with
; sltargsmore Valid sub-functions are:
; sltargsmore load              : <filename>
; sltargsmore save              : <filename>
; sltargsmore ispendingsave     : <filename>
; sltargsmore isgood            : <filename>
; sltargsmore geterrors         : <filename>
; sltargsmore exists            : <filename>
; sltargsmore unload            : <filename> [saveChanges: 0 - false | 1 - true] [minify: 0 - false | 1 - true]
; sltargsmore set               : <filename> <key> <type: int | float | string> <value>
; sltargsmore get               : <filename> <key> <type: int | float | string> [<default value>]
; sltargsmore unset             : <filename> <key> <type: int | float | string>
; sltargsmore has               : <filename> <key> <type: int | float | string>
; sltargsmore adjust            : <filename> <key> <type: int | float>          <amount>
; sltargsmore listadd           : <filename> <key> <type: int | float | string> <value>
; sltargsmore listget           : <filename> <key> <type: int | float | string> <index>
; sltargsmore listset           : <filename> <key> <type: int | float | string> <index> <value>
; sltargsmore listremoveat      : <filename> <key> <type: int | float | string> <index>
; sltargsmore listinsertat      : <filename> <key> <type: int | float | string> <index> <value>
; sltargsmore listclear         : <filename> <key> <type: int | float | string>
; sltargsmore listcount         : <filename> <key> <type: int | float | string>
; sltargsmore listcountvalue    : <filename> <key> <type: int | float | string> <value> [<exclude: 0 - false | 1 - true>]
; sltargsmore listfind          : <filename> <key> <type: int | float | string> <value>
; sltargsmore listhas           : <filename> <key> <type: int | float | string> <value>
; sltargsmore listresize        : <filename> <key> <type: int | float | string> <toLength> [<filler value>]
function jsonutil(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthGT(CmdPrimary, param.Length, 2)
        string func = CmdPrimary.Resolve(param[1])
        string jfile = CmdPrimary.Resolve(param[2])

        if JsonUtil.JsonExists(jfile)

            ;; file functions
            if "load" == func
                JsonUtil.Load(jfile)
            elseif "save" == func
                JsonUtil.Save(jfile)
            elseif "ispendingsave" == func
                CmdPrimary.MostRecentResult = JsonUtil.IsPendingSave(jfile) as int
            elseif "isgood" == func
                CmdPrimary.MostRecentResult = JsonUtil.IsGood(jfile) as int
            elseif "geterrors" == func
                CmdPrimary.MostRecentResult = JsonUtil.GetErrors(jfile)
            elseif "exists" == func
                CmdPrimary.MostRecentResult = 1
            elseif "unload" == func
                bool saveChanges = true
                bool minify = false
                if param.Length > 3
                    saveChanges = CmdPrimary.Resolve(param[3]) as int
                endif
                if param.Length > 4
                    minify = CmdPrimary.Resolve(param[4]) as int
                endif
                JsonUtil.Unload(jfile, saveChanges, minify)
            elseif ParamLengthGT(CmdPrimary, param.Length, 4)
                string jkey = CmdPrimary.Resolve(param[3])
                string jtype = getValidJSONType(CmdPrimary, CmdPrimary.Resolve(param[4]))

                if jtype
                    if "unset" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.UnsetIntValue(jfile, jkey) as int
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.UnsetFloatValue(jfile, jkey) as int
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.UnsetStringValue(jfile, jkey) as int
                        endif
                    elseif "has" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.HasIntValue(jfile, jkey) as int
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.HasFloatValue(jfile, jkey) as int
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.HasStringValue(jfile, jkey) as int
                        endif
                    elseif "listclear" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.IntListClear(jfile, jkey)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.FloatListClear(jfile, jkey)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.StringListClear(jfile, jkey)
                        endif
                    elseif "listcount" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.IntListCount(jfile, jkey)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.FloatListCount(jfile, jkey)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.StringListCount(jfile, jkey)
                        endif
                    elseif "get" == func
                        string dval
                        if param.Length > 5
                            dval = CmdPrimary.Resolve(param[5])
                        endif
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.GetIntValue(jfile, jkey, dval as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.GetFloatValue(jfile, jkey, dval as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = JsonUtil.GetStringValue(jfile, jkey, dval)
                        endif

                    elseif ParamLengthGT(CmdPrimary, param.Length, 5)
                        string parm5 = CmdPrimary.Resolve(param[5])
                        string parm6
                        if param.Length > 6
                            parm6 = CmdPrimary.Resolve(param[6])
                        endif

                        if "set" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.SetIntValue(jfile, jkey, parm5 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.SetFloatValue(jfile, jkey, parm5 as float)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.SetStringValue(jfile, jkey, parm5)
                            endif
                        elseif "adjust" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.AdjustIntValue(jfile, jkey, parm5 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.AdjustFloatValue(jfile, jkey, parm5 as float)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentResult = ""
                                SquawkFunctionError(CmdPrimary, "jsonutil: 'string' is not a valid type for JsonUtil Adjust")
                            endif
                        elseif "listadd" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.IntListAdd(jfile, jkey, parm5 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.FloatListAdd(jfile, jkey, parm5 as float)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.StringListAdd(jfile, jkey, parm5)
                            endif
                        elseif "listget" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.IntListGet(jfile, jkey, parm5 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.FloatListGet(jfile, jkey, parm5 as int)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.StringListGet(jfile, jkey, parm5 as int)
                            endif
                        elseif "listset" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.IntListSet(jfile, jkey, parm5 as int, parm6 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.FloatListSet(jfile, jkey, parm5 as int, parm6 as float)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.StringListSet(jfile, jkey, parm5 as int, parm6 as string)
                            endif
                        elseif "listremoveat" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.IntListRemove(jfile, jkey, parm5 as int, parm6 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.FloatListRemove(jfile, jkey, parm5 as float, parm6 as int)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.StringListRemove(jfile, jkey, parm5, parm6 as int)
                            endif
                        elseif "listinsertat" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.IntListInsertAt(jfile, jkey, parm5 as int, parm6 as int) as int
                            elseif "float" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.FloatListInsertAt(jfile, jkey, parm5 as int, parm6 as float) as int
                            elseif "string" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.StringListInsertAt(jfile, jkey, parm5 as int, parm6) as int
                            endif
                        elseif "listremoveat" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.IntListRemoveAt(jfile, jkey, parm5 as int) as int
                            elseif "float" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.FloatListRemoveAt(jfile, jkey, parm5 as int) as int
                            elseif "string" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.StringListRemoveAt(jfile, jkey, parm5 as int) as int
                            endif
                        elseif "listcountvalue" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.IntListCountValue(jfile, jkey, parm5 as int, parm6 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.FloatListCountValue(jfile, jkey, parm5 as float, parm6 as int)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.StringListCountValue(jfile, jkey, parm5, parm6 as int)
                            endif
                        elseif "listfind" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.IntListFind(jfile, jkey, parm5 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.FloatListFind(jfile, jkey, parm5 as float)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.StringListFind(jfile, jkey, parm5)
                            endif
                        elseif "listhas" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.IntListHas(jfile, jkey, parm5 as int) as int
                            elseif "float" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.FloatListHas(jfile, jkey, parm5 as float) as int
                            elseif "string" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.StringListHas(jfile, jkey, parm5) as int
                            endif
                        elseif "listresize" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.IntListResize(jfile, jkey, parm5 as int, parm6 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.FloatListResize(jfile, jkey, parm5 as int, parm6 as float)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentResult = JsonUtil.StringListResize(jfile, jkey, parm5 as int, parm6)
                            endif



                        else
                            SquawkFunctionError(CmdPrimary, "jsonutil: unknown sub-function (" + func + ")")
                        endif
                    endif
                endif
            endif

        else
            if "exists" == func
                CmdPrimary.MostRecentResult = 0
            else
                SquawkFunctionError(CmdPrimary, "jsonutil: file (" + jfile + ") does not exist or cannot be opened")
            endif
        endif
    endif
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
; sltargsmore      $self, $player, $actor   ; these all resolve to Actor
; sltargsmore      "sl_triggers.esp:3426"   ; the FormID for the main Quest object for sl_triggers
; sltargsmore    Read more about StorageUtil for more details
; sltargsmore Valid sub-functions are:
; sltargsmore set               : <form identifier> <key> <type: int | float | string> <value>
; sltargsmore get               : <form identifier> <key> <type: int | float | string> [<default value>]
; sltargsmore pluck             : <form identifier> <key> <type: int | float | string> [<default value>]
; sltargsmore unset             : <form identifier> <key> <type: int | float | string>
; sltargsmore has               : <form identifier> <key> <type: int | float | string>
; sltargsmore adjust            : <form identifier> <key> <type: int | float>          <amount>
; sltargsmore listadd           : <form identifier> <key> <type: int | float | string> <value>
; sltargsmore listget           : <form identifier> <key> <type: int | float | string> <index>
; sltargsmore listpluck         : <form identifier> <key> <type: int | float | string> <index> <default value>
; sltargsmore listset           : <form identifier> <key> <type: int | float | string> <index> <value>
; sltargsmore listremoveat      : <form identifier> <key> <type: int | float | string> <index>
; sltargsmore listinsertat      : <form identifier> <key> <type: int | float | string> <index> <value>
; sltargsmore listadjust        : <form identifier> <key> <type: int | float | string> <index> <amount>
; sltargsmore listclear         : <form identifier> <key> <type: int | float | string>
; sltargsmore listpop           : <form identifier> <key> <type: int | float | string>
; sltargsmore listshift         : <form identifier> <key> <type: int | float | string>
; sltargsmore listsort          : <form identifier> <key> <type: int | float | string>
; sltargsmore listcount         : <form identifier> <key> <type: int | float | string>
; sltargsmore listcountvalue    : <form identifier> <key> <type: int | float | string> <value> [<exclude: 0 - false | 1 - true>]
; sltargsmore listfind          : <form identifier> <key> <type: int | float | string> <value>
; sltargsmore listhas           : <form identifier> <key> <type: int | float | string> <value>
; sltargsmore listresize        : <form identifier> <key> <type: int | float | string> <toLength> [<filler value>]
function storageutil(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthGT(CmdPrimary, param.Length, 2)
        string func = CmdPrimary.Resolve(param[1])

        Form suform
        if param[2]
            suform = CmdPrimary.ResolveActor(param[2])
            if !suform
                suform = CmdPrimary.GetFormId(CmdPrimary.Resolve(param[2]))
            endif
        endif

        if ParamLengthGT(CmdPrimary, param.Length, 4)
            string jkey = CmdPrimary.Resolve(param[3])
            string jtype = getValidJSONType(CmdPrimary, CmdPrimary.Resolve(param[4]))

            if jtype
                if "unset" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.UnsetIntValue(suform, jkey) as int
                    elseif "float" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.UnsetFloatValue(suform, jkey) as int
                    elseif "string" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.UnsetStringValue(suform, jkey) as int
                    endif
                elseif "has" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.HasIntValue(suform, jkey) as int
                    elseif "float" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.HasFloatValue(suform, jkey) as int
                    elseif "string" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.HasStringValue(suform, jkey) as int
                    endif
                elseif "listclear" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.IntListClear(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.FloatListClear(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.StringListClear(suform, jkey)
                    endif
                elseif "listpop" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.IntListPop(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.FloatListPop(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.StringListPop(suform, jkey)
                    endif
                elseif "listshift" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.IntListShift(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.FloatListShift(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.StringListShift(suform, jkey)
                    endif
                elseif "listsort" == func
                    if "int" == jtype
                        StorageUtil.IntListSort(suform, jkey)
                    elseif "float" == jtype
                        StorageUtil.FloatListSort(suform, jkey)
                    elseif "string" == jtype
                        StorageUtil.StringListSort(suform, jkey)
                    endif
                elseif "listcount" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.IntListCount(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.FloatListCount(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.StringListCount(suform, jkey)
                    endif
                elseif "get" == func
                    string dval
                    if param.Length > 5
                        dval = CmdPrimary.Resolve(param[5])
                    endif
                    if "int" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.GetIntValue(suform, jkey, dval as int)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.GetFloatValue(suform, jkey, dval as float)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.GetStringValue(suform, jkey, dval)
                    endif
                elseif "pluck" == func
                    string dval
                    if param.Length > 5
                        dval = CmdPrimary.Resolve(param[5])
                    endif
                    if "int" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.GetIntValue(suform, jkey, dval as int)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.GetFloatValue(suform, jkey, dval as float)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentResult = StorageUtil.GetStringValue(suform, jkey, dval)
                    endif

                elseif ParamLengthGT(CmdPrimary, param.Length, 5)
                    string parm5 = CmdPrimary.Resolve(param[5])
                    string parm6
                    if param.Length > 6
                        parm6 = CmdPrimary.Resolve(param[6])
                    endif

                    if "set" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.SetIntValue(suform, jkey, parm5 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.SetFloatValue(suform, jkey, parm5 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.SetStringValue(suform, jkey, parm5)
                        endif
                    elseif "adjust" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.AdjustIntValue(suform, jkey, parm5 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.AdjustFloatValue(suform, jkey, parm5 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = ""
                            SquawkFunctionError(CmdPrimary, "jsonutil: 'string' is not a valid type for StorageUtil Adjust")
                        endif
                    elseif "listadd" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.IntListAdd(suform, jkey, parm5 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.FloatListAdd(suform, jkey, parm5 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.StringListAdd(suform, jkey, parm5)
                        endif
                    elseif "listget" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.IntListGet(suform, jkey, parm5 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.FloatListGet(suform, jkey, parm5 as int)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.StringListGet(suform, jkey, parm5 as int)
                        endif
                    elseif "listpluck" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.IntListPluck(suform, jkey, parm5 as int, parm6 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.FloatListPluck(suform, jkey, parm5 as int, parm6 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.StringListPluck(suform, jkey, parm5 as int, parm6 as string)
                        endif
                    elseif "listset" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.IntListSet(suform, jkey, parm5 as int, parm6 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.FloatListSet(suform, jkey, parm5 as int, parm6 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.StringListSet(suform, jkey, parm5 as int, parm6 as string)
                        endif
                    elseif "listremoveat" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.IntListRemove(suform, jkey, parm5 as int, parm6 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.FloatListRemove(suform, jkey, parm5 as float, parm6 as int)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.StringListRemove(suform, jkey, parm5, parm6 as int)
                        endif
                    elseif "listinsertat" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.IntListInsert(suform, jkey, parm5 as int, parm6 as int) as int
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.FloatListInsert(suform, jkey, parm5 as int, parm6 as float) as int
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.StringListInsert(suform, jkey, parm5 as int, parm6) as int
                        endif
                    elseif "listadjust" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.IntListAdjust(suform, jkey, parm5 as int, parm6 as int) as int
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.FloatListAdjust(suform, jkey, parm5 as int, parm6 as float) as int
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = ""
                            SquawkFunctionError(CmdPrimary, "jsonutil: 'string' is not a valid type for StorageUtil List Adjust")
                        endif
                    elseif "listremoveat" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.IntListRemoveAt(suform, jkey, parm5 as int) as int
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.FloatListRemoveAt(suform, jkey, parm5 as int) as int
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.StringListRemoveAt(suform, jkey, parm5 as int) as int
                        endif
                    elseif "listcountvalue" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.IntListCountValue(suform, jkey, parm5 as int, parm6 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.FloatListCountValue(suform, jkey, parm5 as float, parm6 as int)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.StringListCountValue(suform, jkey, parm5, parm6 as int)
                        endif
                    elseif "listfind" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.IntListFind(suform, jkey, parm5 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.FloatListFind(suform, jkey, parm5 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.StringListFind(suform, jkey, parm5)
                        endif
                    elseif "listhas" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.IntListHas(suform, jkey, parm5 as int) as int
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.FloatListHas(suform, jkey, parm5 as float) as int
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.StringListHas(suform, jkey, parm5) as int
                        endif
                    elseif "listresize" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.IntListResize(suform, jkey, parm5 as int, parm6 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.FloatListResize(suform, jkey, parm5 as int, parm6 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentResult = StorageUtil.StringListResize(suform, jkey, parm5 as int, parm6)
                        endif



                    else
                        SquawkFunctionError(CmdPrimary, "jsonutil: unknown sub-function (" + func + ")")
                    endif
                endif
            endif
        endif
    endif
endFunction


; sltname weather_state
; sltgrup Utility
; sltdesc Weather related functions based on sub-function
; sltargs <sub-function> ; currently only GetClassification
; sltsamp weather_state GetClassification
function weather_state(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult = ""
	
    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        string ss1 = CmdPrimary.resolve(param[1])
        
        if ss1 == "GetClassification"
            Weather curr = Weather.GetCurrentWeather()
            if curr
                nextResult = curr.GetClassification() as string
            endIf
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
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
function Math(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult = ""
	
    if ParamLengthGT(CmdPrimary, param.Length, 2)
        string ss1 = CmdPrimary.resolve(param[1])
        string ss2
        int    ii1
        float  ff1
        
        if ss1 == "asint"
            ss2 = CmdPrimary.resolve(param[2])
            if ss2 
                ii1 = ss2 as int
            else
                ii1 = 0
            endIf
            nextResult = ii1 as string
        elseIf ss1 == "floor"
            ss1 = CmdPrimary.resolve(param[2])
            ii1 = Math.floor(ss1 as float)
            nextResult = ii1 as string
        elseIf ss1 == "ceiling"
            ss1 = CmdPrimary.resolve(param[2])
            ii1 = Math.Ceiling(ss1 as float)
            nextResult = ii1 as string
        elseIf ss1 == "abs"
            ss1 = CmdPrimary.resolve(param[2])
            ff1 = Math.abs(ss1 as float)
            nextResult = ff1 as string
        elseIf ss1 == "toint"
            ss2 = CmdPrimary.resolve(param[2])
            if ss2 && (StringUtil.GetNthChar(ss2, 0) == "0")
                ii1 = CmdPrimary.hextoint(ss2)
            elseIf ss2
                ii1 = ss2 as int
            else 
                ii1 = 0
            endIf
            nextResult = ii1 as string
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction
 