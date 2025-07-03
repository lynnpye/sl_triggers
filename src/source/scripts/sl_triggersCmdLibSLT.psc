scriptname sl_triggersCmdLibSLT

import sl_triggersStatics
 
;;;;;;;;;;
;; 

; HAVE TO FIX THE STRING PARAM TO STRING[] PARAM BEFORE YOU CAN USE THIS
function hextun_test(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

	CmdPrimary.CompleteOperationOnActor()
endFunction

; HAVE TO FIX THE STRING PARAM TO STRING[] PARAM BEFORE YOU CAN USE THIS
function hextun_test2(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname deb_msg
; sltgrup Utility
; sltdesc Joins all <msg> arguments together and logs to "<Documents>\My Games\Skyrim Special Edition\SKSE\sl-triggers.log"
; sltdesc This file is truncated on game start.
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
        SLTDebugMsg(dmsg)
    endif

	CmdPrimary.CompleteOperationOnActor()
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
        ;SLTInfoMsg(msg)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname form_getbyid
; sltgrup Form
; sltdesc Performs a lookup for a Form and returns it if found; returns none otherwise
; sltdesc Accepts FormID as: "modfile.esp:012345", "012345" (absolute ID), "anEditorId" (will attempt an editorId lookup)
; sltdesc Note that if multiple mods introduce an object with the same editorId, the lookup would only return whichever one won
; sltargs formID: FormID as: "modfile.esp:012345", "012345" (absolute ID), "anEditorId" (will attempt an editorId lookup)
; sltsamp form_getbyid "Ale"
; sltsamp form_dogetter $$ GetName
; sltsamp msg_notify $$ "!! Yay!!"
; sltsamp ; Ale!! Yay!!
Function form_getbyid(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string _outcome

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Form _result = CmdPrimary.ResolveForm(param[1])
        if _result
            _outcome = _result.GetFormID()
        endif
    endif

    CmdPrimary.MostRecentResult = _outcome

	CmdPrimary.CompleteOperationOnActor()
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
            _targetActor.RestoreActorValue(CmdPrimary.Resolve(param[2]), CmdPrimary.Resolve(param[3]) as float)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
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
            _targetActor.DamageActorValue(CmdPrimary.Resolve(param[2]), CmdPrimary.Resolve(param[3]) as float)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
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
            _targetActor.ModActorValue(CmdPrimary.Resolve(param[2]), CmdPrimary.Resolve(param[3]) as float)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
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
            _targetActor.SetActorValue(CmdPrimary.Resolve(param[2]), CmdPrimary.Resolve(param[3]) as float)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
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
            nextResult = _targetActor.GetBaseActorValue(CmdPrimary.Resolve(param[2])) as string
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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
            nextResult = _targetActor.GetActorValue(CmdPrimary.Resolve(param[2])) as string
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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
            nextResult = _targetActor.GetActorValueMax(CmdPrimary.Resolve(param[2])) as string
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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
            nextResult = (_targetActor.GetActorValuePercentage(CmdPrimary.Resolve(param[2])) * 100.0) as string
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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
        Spell thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[1])) as Spell
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
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
; sltargs spell: SPEL FormId
; sltargs actor: target Actor
; sltsamp spell_dcsa "skyrim.esm:275236" $self
function spell_dcsa(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[1])) as Spell
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
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
; sltargs spell: SPEL FormId
; sltargs actor: target Actor
; sltsamp spell_dispel "skyrim.esm:275236" $self
; sltrslt If light was currently on $self, it would now be dispelled
function spell_dispel(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[1])) as Spell
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
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
; sltargs spell: SPEL FormId
; sltargs actor: target Actor
; sltsamp spell_add "skyrim.esm:275236" $self
; sltrslt The light spell is now in the actor's spellbook
function spell_add(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[1])) as Spell
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
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
; sltargs spell: SPEL FormId
; sltargs actor: target Actor
; sltsamp spell_remove "skyrim.esm:275236" $self
; sltrslt The light spell should no longer be in the actor's spellbook
function spell_remove(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Spell thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[1])) as Spell
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
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
        Form thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2]))
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
    
            if _targetActor
                int count = 1
                if param.Length > 3
                    count = CmdPrimary.Resolve(param[3]) as int
                endif
                bool isSilent = false
                if param.Length > 4
                    isSilent = CmdPrimary.Resolve(param[4]) as int
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
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs count: number (optional: default 1)
; sltargs displaymessage: 0 - show message | 1 - silent (optional: default 0 - show message)
; sltsamp item_addex $self "skyrim.esm:15" 10 0
function item_addex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthLT(CmdPrimary, param.Length, 6)
    
        Form thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2]))
        if thing
            int count = 1
            if param.Length > 3
                count = CmdPrimary.Resolve(param[3]) as int
            endif
            bool isSilent = false
            if param.Length > 4
                isSilent = CmdPrimary.Resolve(param[4]) as int
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
        Form thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2]))
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])

            if _targetActor
                int count = CmdPrimary.Resolve(param[3]) as int
                bool isSilent = false
                if param.Length > 4
                    isSilent = CmdPrimary.Resolve(param[4]) as int
                endif
                _targetActor.RemoveItem(thing, count, isSilent)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
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
        Form thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2]))    
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
            if _targetActor
                int count = 1
                if param.Length > 3
                    count = CmdPrimary.Resolve(param[3]) as int
                endif
                bool isSilent = false
                if param.Length > 4
                    isSilent = CmdPrimary.Resolve(param[4]) as int
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
        Form thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2]))    
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
            if _targetActor
                int slotId = CmdPrimary.Resolve(param[3]) as int
                bool isSilent = CmdPrimary.Resolve(param[4]) as int
                bool isRemovalPrevented = CmdPrimary.Resolve(param[5]) as int
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
        Form thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2]))
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
            if _targetActor
                int slotId = CmdPrimary.Resolve(param[3]) as int
                bool isSilent = CmdPrimary.Resolve(param[4]) as int
                _targetActor.EquipItem(thing, slotId, isSilent)
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
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs armorslot: number e.g. 32 for body slot
; sltsamp item_unequipex $self "ZaZAnimationPack.esm:159072" 32
; sltrslt Unequips the ZaZ armor from slot 32 on $self
function item_unequipex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2]))
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
            if _targetActor
                int slotId = CmdPrimary.Resolve(param[3]) as int
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
; sltdesc Set $$ to how many of a specified item an actor has
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltsamp item_getcount $self "skyrim.esm:15"
function item_getcount(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2]))    
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
            if _targetActor
                nextResult = _targetActor.GetItemCount(thing)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
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
        nextResult = Utility.RandomInt(CmdPrimary.Resolve(param[1]) as int, CmdPrimary.Resolve(param[2]) as int) as string
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname rnd_float
; sltgrup Utility
; sltdesc Sets $$ to a random integer between min and max inclusive
; sltargs min: number
; sltargs max: number
; sltsamp rnd_float 1 100
function rnd_float(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        nextResult = Utility.RandomFloat(CmdPrimary.ResolveFloat(param[1]), CmdPrimary.ResolveFloat(param[2])) as string
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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
        Utility.Wait(CmdPrimary.Resolve(param[1]) as float)
    endif

	CmdPrimary.CompleteOperationOnActor()
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
        Actor[] inCell = MiscUtil.ScanCellNPCs(CmdPrimary.CmdTargetActor, CmdPrimary.Resolve(param[1]) as float)
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

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname perk_addpoints
; sltgrup Perks
; sltdesc Add specified number of perk points to player
; sltargs perkpointcount: number of perk points to add
; sltsamp perk_addpoints 4
function perk_addpoints(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Game.AddPerkPoints(CmdPrimary.Resolve(param[1]) as int)
    endif

	CmdPrimary.CompleteOperationOnActor()
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
        Perk thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[1])) as Perk    
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
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
; sltargs perk: PERK FormID
; sltargs actor: target Actor
; sltsamp perk_remove "skyrim.esm:12384" $self
function perk_remove(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Perk thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[1])) as Perk    
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[2])
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
            string skillName = CmdPrimary.Resolve(param[2])
            if skillName
                Game.AdvanceSkill(skillName, CmdPrimary.Resolve(param[3]) as int)
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
            string skillName = CmdPrimary.Resolve(param[2])
            if skillName
                if _targetActor == CmdPrimary.PlayerRef
                    Game.IncrementSkillBy(skillName, CmdPrimary.Resolve(param[3]) as int)
                else
                    _targetActor.ModActorValue(skillName, CmdPrimary.Resolve(param[3]) as int)
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

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_name
; sltgrup Actor
; sltdesc Set $$ to the actor displayName
; sltargs actor: target Actor
; sltsamp actor_display_name $actor
function actor_display_name(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            nextResult = CmdPrimary.ActorDisplayName(_targetActor)
        endif
    endif
    
    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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
                crimeFact.ModCrimeGold(CmdPrimary.Resolve(param[2]) as int, false)
            endIf
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
endFunction
function actor_isquard(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	actor_isguard(CmdTargetActor, CmdPrimary, param)

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
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
        string thingFormId = CmdPrimary.Resolve(param[2])
        Topic thing = CmdPrimary.GetFormById(thingFormId) as Topic
        if thing
            Actor _targetActor = CmdPrimary.resolveActor(param[1])
            if _targetActor
                _targetActor.Say(thing)
            endif
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
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
        Keyword keyw = Keyword.GetKeyword(CmdPrimary.Resolve(param[2]))
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if keyw && _targetActor && _targetActor.HasKeyword(keyw)
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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
        Armor thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2])) as Armor
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if thing && _targetActor && _targetActor.IsEquipped(thing)
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
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
        Keyword keyw = Keyword.GetKeyword(CmdPrimary.Resolve(param[2]))
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        
        if keyw && _targetActor && _targetActor.WornHasKeyword(keyw)
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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
        Keyword keyw = Keyword.GetKeyword(CmdPrimary.Resolve(param[2]))
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        
        if keyw && _targetActor && _targetActor.GetCurrentLocation().HasKeyword(keyw)
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
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
            _actorOne.SetRelationshipRank(_actorTwo, CmdPrimary.Resolve(param[3]) as int)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
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
        Faction thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2])) as Faction
        if _targetActor && thing && _targetActor.IsInFaction(thing)
            nextResult = 1
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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
            Faction thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2])) as Faction
            
            if thing
                nextResult = _targetActor.GetFactionRank(thing)
            endif
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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
            Faction thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2])) as Faction
            if thing
                _targetActor.SetFactionRank(thing, CmdPrimary.Resolve(param[3]) as int)
            endif
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
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
                    Form wizardStuff = CmdPrimary.GetFormById(pstr)
                    if !wizardStuff
                        wizardStuff = CmdPrimary.GetFormById(CmdPrimary.Resolve(pstr))
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

	CmdPrimary.CompleteOperationOnActor()
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
        Faction thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2])) as Faction
    
        if thing && _targetActor
            _targetActor.RemoveFromFaction(thing)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
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
        Debug.SendAnimationEvent(CmdPrimary.resolveActor(param[1]), CmdPrimary.Resolve(param[2]))
    endif

	CmdPrimary.CompleteOperationOnActor()
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
            string ss1 = CmdPrimary.Resolve(param[2])
            string ss2
            if param.Length > 3
                ss2 = CmdPrimary.Resolve(param[3])
            endif
            float  p3
            if param.Length > 4
                p3 = CmdPrimary.Resolve(param[4]) as float
            endif
            
            _targetActor.SendModEvent(ss1, ss2, p3)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
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
        string ss1 = CmdPrimary.Resolve(param[2])
        
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
                    p3 = CmdPrimary.Resolve(param[3]) as int
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

	CmdPrimary.CompleteOperationOnActor()
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
        string ss1 = CmdPrimary.Resolve(param[2])
        
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
                    p3 = CmdPrimary.Resolve(param[3]) as float
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
            string ss1 = CmdPrimary.Resolve(param[2])
            if !ss1
                nextResult = _targetActor.GetRace().GetName()
            endIf
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
endFunction

bool function _slt_form_doaction(sl_triggersCmd CmdPrimary, Form _target, string _theAction) global
    if _target && _theAction
        if _theAction == "RegisterForSleep"
            _target.RegisterForSleep()
        elseif _theAction == "RegisterForTrackedStatsEvent"
            _target.RegisterForTrackedStatsEvent()
        elseif _theAction == "StartObjectProfiling"
            _target.StartObjectProfiling()
        elseif _theAction == "StopObjectProfiling"
            _target.StopObjectProfiling()
        elseif _theAction == "UnregisterForSleep"
            _target.UnregisterForSleep()
        elseif _theAction == "UnregisterForTrackedStatsEvent"
            _target.UnregisterForTrackedStatsEvent()
        elseif _theAction == "UnregisterForUpdate"
            _target.UnregisterForUpdate()
        elseif _theAction == "UnregisterForUpdateGameTime"
            _target.UnregisterForUpdateGameTime()
        elseif _theAction == "UnregisterForAllKeys"
            _target.UnregisterForAllKeys()
        elseif _theAction == "UnregisterForAllControls"
            _target.UnregisterForAllControls()
        elseif _theAction == "UnregisterForAllMenus"
            _target.UnregisterForAllMenus()
        elseif _theAction == "RegisterForCameraState"
            _target.RegisterForCameraState()
        elseif _theAction == "UnregisterForCameraState"
            _target.UnregisterForCameraState()
        elseif _theAction == "RegisterForCrosshairRef"
            _target.RegisterForCrosshairRef()
        elseif _theAction == "UnregisterForCrosshairRef"
            _target.UnregisterForCrosshairRef()
        elseif _theAction == "RegisterForNiNodeUpdate"
            _target.RegisterForNiNodeUpdate()
        elseif _theAction == "UnregisterForNiNodeUpdate"
            _target.UnregisterForNiNodeUpdate()
        else
            return false
        endif
        return true
    endif
    return false
endFunction

bool function _slt_objectreference_doaction(sl_triggersCmd CmdPrimary, ObjectReference _target, string _theAction) global
    if _target && _theAction
        if _theAction == "ClearDestruction"
            _target.ClearDestruction()
        elseif _theAction == "Delete"
            _target.Delete()
        elseif _theAction == "DeleteWhenAble"
            _target.DeleteWhenAble()
        elseif _theAction == "ForceAddRagdollToWorld"
            _target.ForceAddRagdollToWorld()
        elseif _theAction == "ForceRemoveRagdollFromWorld"
            _target.ForceRemoveRagdollFromWorld()
        elseif _theAction == "InterruptCast"
            _target.InterruptCast()
        elseif _theAction == "MoveToMyEditorLocation"
            _target.MoveToMyEditorLocation()
        elseif _theAction == "RemoveAllInventoryEventFilters"
            _target.RemoveAllInventoryEventFilters()
        elseif _theAction == "StopTranslation"
            _target.StopTranslation()
        elseif _theAction == "ResetInventory"
            _target.ResetInventory()
        else
            return _slt_form_doaction(CmdPrimary, _target, _theAction)
        endif
        return true
    endif
    return false
endFunction

bool function _slt_actor_doaction(sl_triggersCmd CmdPrimary, Actor _target, string _theAction) global
    if _target && _theAction
        if _theAction == "ClearArrested"
            _target.ClearArrested()
        elseif _theAction == "ClearExpressionOverride"
            _target.ClearExpressionOverride()
        elseif _theAction == "ClearExtraArrows"
            _target.ClearExtraArrows()
        elseif _theAction == "ClearForcedLandingMarker"
            _target.ClearForcedLandingMarker()
        elseif _theAction == "ClearKeepOffsetFromActor"
            _target.ClearKeepOffsetFromActor()
        elseif _theAction == "ClearLookAt"
            _target.ClearLookAt()
        elseif _theAction == "DispelAllSpells"
            _target.DispelAllSpells()
        elseif _theAction == "DrawWeapon"
            _target.DrawWeapon()
        elseif _theAction == "EndDeferredKill"
            _target.EndDeferredKill()
        elseif _theAction == "EvaluatePackage"
            _target.EvaluatePackage()
        elseif _theAction == "MakePlayerFriend"
            _target.MakePlayerFriend()
        elseif _theAction == "MoveToPackageLocation"
            _target.MoveToPackageLocation()
        elseif _theAction == "RemoveFromAllFactions"
            _target.RemoveFromAllFactions()
        elseif _theAction == "ResetHealthAndLimbs"
            _target.ResetHealthAndLimbs()
        elseif _theAction == "Resurrect"
            _target.Resurrect()
        elseif _theAction == "SendAssaultAlarm"
            _target.SendAssaultAlarm()
        elseif _theAction == "SetPlayerResistingArrest"
            _target.SetPlayerResistingArrest()
        elseif _theAction == "ShowBarterMenu"
            _target.ShowBarterMenu()
        elseif _theAction == "StartDeferredKill"
            _target.StartDeferredKill()
        elseif _theAction == "StartSneaking"
            _target.StartSneaking()
        elseif _theAction == "StopCombat"
            _target.StopCombat()
        elseif _theAction == "StopCombatAlarm"
            _target.StopCombatAlarm()
        elseif _theAction == "UnequipAll"
            _target.UnequipAll()
        elseif _theAction == "UnlockOwnedDoorsInCell"
            _target.UnlockOwnedDoorsInCell()
        elseif _theAction == "QueueNiNodeUpdate"
            _target.QueueNiNodeUpdate()
        elseif _theAction == "RegenerateHead"
            _target.RegenerateHead()
        elseif _theAction == "SheatheWeapon"
            _target.SheatheWeapon()
        else
            return _slt_objectreference_doaction(CmdPrimary, _target, _theAction)
        endif
        return true
    endIf
    return false
endFunction

; sltname form_doaction
; sltgrup Form
; sltdesc For the targeted Form, perform the associated function based on the specified action
; sltdesc 'Action' in this case specifically refers to functions that take no parameters and return no values
; sltdesc https://ck.uesp.net/wiki/Form_Script
; sltargs form: target Form (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)
; sltargs action: action name
; sltargsmore ;;;; These are from Form
; sltargsmore RegisterForSleep
; sltargsmore RegisterForTrackedStatsEvent
; sltargsmore StartObjectProfiling
; sltargsmore StopObjectProfiling
; sltargsmore UnregisterForSleep
; sltargsmore UnregisterForTrackedStatsEvent
; sltargsmore UnregisterForUpdate
; sltargsmore UnregisterForUpdateGameTime
; sltargsmore ;;;; These are from SKSE
; sltargsmore UnregisterForAllKeys
; sltargsmore UnregisterForAllControls
; sltargsmore UnregisterForAllMenus
; sltargsmore RegisterForCameraState
; sltargsmore UnregisterForCameraState
; sltargsmore RegisterForCrosshairRef
; sltargsmore UnregisterForCrosshairRef
; sltargsmore RegisterForNiNodeUpdate
; sltargsmore UnregisterForNiNodeUpdate
; sltsamp form_doaction $self StopCombat
function form_doaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form _target = CmdPrimary.ResolveForm(param[1])
        if _target
            string _theAction = CmdPrimary.Resolve(param[2])

            if _theAction
                if !_slt_form_doaction(CmdPrimary, _target, _theAction)
                    SquawkFunctionError(CmdPrimary, "form_doaction: unrecognized action(" + _theAction + ")")
                endif
            endif
        endif
    endif
EndFunction

; sltname objectreference_doaction
; sltgrup ObjectReference
; sltdesc For the targeted ObjectReference, perform the associated function based on the specified action
; sltdesc 'Action' in this case specifically refers to functions that take no parameters and return no values
; sltdesc https://ck.uesp.net/wiki/ObjectReference_Script
; sltargs objectreference: target ObjectReference  (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)
; sltargs action: action name
; sltargsmore ;;;; These are from ObjectReference
; sltargsmore ClearDestruction
; sltargsmore Delete
; sltargsmore DeleteWhenAble
; sltargsmore ForceAddRagdollToWorld
; sltargsmore ForceRemoveRagdollFromWorld
; sltargsmore InterruptCast
; sltargsmore MoveToMyEditorLocation
; sltargsmore RemoveAllInventoryEventFilters
; sltargsmore StopTranslation
; sltargsmore ;;;; These are from SKSE
; sltargsmore ResetInventory
; sltargsmore ;;;; will call form_doaction if no matches are found
; sltsamp objectreference_doaction $self StopCombat
function objectreference_doaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        ObjectReference _target = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        if _target
            string _theAction = CmdPrimary.Resolve(param[2])

            if _theAction
                if !_slt_objectreference_doaction(CmdPrimary, _target, _theAction)
                    SquawkFunctionError(CmdPrimary, "objectreference_doaction: unrecognized action(" + _theAction + ")")
                endif
            endif
        endif
    endif
EndFunction

; sltname actor_doaction
; sltgrup Actor
; sltdesc For the targeted Actor, perform the associated function based on the specified action
; sltdesc 'Action' in this case specifically refers to functions that take no parameters and return no values
; sltdesc https://ck.uesp.net/wiki/Actor_Script
; sltargs actor: target Actor  (accepts special variable names ($self, $player) and both relative "Skyrim.esm:0f" and absolute "0f" values)
; sltargs action: action name
; sltargsmore ;;;; These are from Actor
; sltargsmore ClearArrested
; sltargsmore ClearExpressionOverride
; sltargsmore ClearExtraArrows
; sltargsmore ClearForcedLandingMarker
; sltargsmore ClearKeepOffsetFromActor
; sltargsmore ClearLookAt
; sltargsmore DispelAllSpells
; sltargsmore DrawWeapon
; sltargsmore EndDeferredKill
; sltargsmore EvaluatePackage
; sltargsmore MakePlayerFriend
; sltargsmore MoveToPackageLocation
; sltargsmore RemoveFromAllFactions
; sltargsmore ResetHealthAndLimbs
; sltargsmore Resurrect
; sltargsmore SendAssaultAlarm
; sltargsmore SetPlayerResistingArrest
; sltargsmore ShowBarterMenu
; sltargsmore StartDeferredKill
; sltargsmore StartSneaking
; sltargsmore StopCombat
; sltargsmore StopCombatAlarm
; sltargsmore UnequipAll
; sltargsmore UnlockOwnedDoorsInCell
; sltargsmore ;;;; will call objectreference_doaction if no matches are found
; sltsamp actor_doaction $self StopCombat
function actor_doaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _target = CmdPrimary.ResolveForm(param[1]) as Actor
        if _target
            string _theAction = CmdPrimary.Resolve(param[2])

            if _theAction
                if !_slt_actor_doaction(CmdPrimary, _target, _theAction)
                    SquawkFunctionError(CmdPrimary, "actor_doaction: unrecognized action(" + _theAction + ")")
                endif
            endif
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction


string function _slt_form_dogetter(sl_triggersCmd CmdPrimary, Form _target, string _theAction) global
    string result
        
    if _target && _theAction
        if _theAction == "GetFormID"
            result = _target.GetFormID()
        elseif _theAction == "GetGoldValue"
            result = _target.GetGoldValue()
        elseif _theAction == "PlayerKnows"
            result = _target.PlayerKnows() as int
        elseif _theAction == "GetType"
            result = _target.GetType()
        elseif _theAction == "GetName"
            result = _target.GetName()
        elseif _theAction == "GetWeight"
            result = _target.GetWeight()
        elseif _theAction == "GetNumKeywords"
            result = _target.GetNumKeywords()
        elseif _theAction == "IsPlayable"
            result = _target.IsPlayable() as int
        elseif _theAction == "HasWorldModel"
            result = _target.HasWorldModel() as int
        elseif _theAction == "GetWorldModelPath"
            result = _target.GetWorldModelPath()
        elseif _theAction == "GetWorldModelNumTextureSets"
            result = _target.GetWorldModelNumTextureSets()
        elseif _theAction == "TempClone"
            Form _cloneForm = _target.TempClone()
            result = _cloneForm.GetFormID()
        endif
    endIf

    return result
endFunction

string function _slt_objectreference_dogetter(sl_triggersCmd CmdPrimary, ObjectReference _target, string _theAction) global
    string result
        
    if _target && _theAction
        if _theAction == "CanFastTravelToMarker"
            result = _target.CanFastTravelToMarker() as int
        elseif _theAction == "GetActorOwner"
            ActorBase _actorOwner = _target.GetActorOwner()
            if _actorOwner
                result = _actorOwner.GetFormID()
            endif
        elseif _theAction == "GetAngleX"
            result = _target.GetAngleX()
        elseif _theAction == "GetAngleY"
            result = _target.GetAngleY()
        elseif _theAction == "GetAngleZ"
            result = _target.GetAngleZ()
        elseif _theAction == "GetBaseObject"
            Form _baseobj = _target.GetBaseObject()
            if _baseobj
                result = _baseobj.GetFormID()
            endif
        elseif _theAction == "GetCurrentDestructionStage"
            result = _target.GetCurrentDestructionStage()
        elseif _theAction == "GetCurrentLocation"
            Location _loc = _target.GetCurrentLocation()
            if _loc
                result = _loc.GetFormID()
            endif
        elseif _theAction == "GetCurrentScene"
            Scene _scene = _target.GetCurrentScene()
            if _scene
                result = _scene.GetFormID()
            endif
        elseif _theAction == "GetEditorLocation"
            Location _loc = _target.GetEditorLocation()
            if _loc
                result = _loc.GetFormID()
            endif
        elseif _theAction == "GetFactionOwner"
            Faction _faction = _target.GetFactionOwner()
            if _faction
                result = _faction.GetFormID()
            endif
        elseif _theAction == "GetHeight"
            result = _target.GetHeight()
        elseif _theAction == "GetItemHealthPercent"
            result = _target.GetItemHealthPercent()
        elseif _theAction == "GetKey"
            Key _thekey = _target.GetKey()
            if _thekey
                result = _thekey.GetFormId()
            endif
        elseif _theAction == "GetLength"
            result = _target.GetLength()
        elseif _theAction == "GetLockLevel"
            result = _target.GetLockLevel()
        elseif _theAction == "GetMass"
            result = _target.GetMass()
        elseif _theAction == "GetOpenState"
            result = _target.GetOpenState()
        elseif _theAction == "GetParentCell"
            Cell _cell = _target.GetParentCell()
            if _cell
                result = _cell.GetFormID()
            endif
        elseif _theAction == "GetPositionX"
            result = _target.GetPositionX()
        elseif _theAction == "GetPositionY"
            result = _target.GetPositionY()
        elseif _theAction == "GetPositionZ"
            result = _target.GetPositionZ()
        elseif _theAction == "GetScale"
            result = _target.GetScale()
        elseif _theAction == "GetTriggerObjectCount"
            result = _target.GetTriggerObjectCount()
        elseif _theAction == "GetVoiceType"
            VoiceType _voiceType = _target.GetVoiceType()
            if _voiceType
                result = _voiceType.GetFormID()
            endif
        elseif _theAction == "GetWidth"
            result = _target.GetWidth()
        elseif _theAction == "GetWorldSpace"
            WorldSpace _worldspace = _target.GetWorldSpace()
            if _worldspace
                result = _worldspace.GetFormID()
            endif
        elseif _theAction == "IsActivationBlocked"
            result = _target.IsActivationBlocked() as int
        elseif _theAction == "Is3DLoaded"
            result = _target.Is3DLoaded() as int
        elseif _theAction == "IsDeleted"
            result = _target.IsDeleted() as int
        elseif _theAction == "IsDisabled"
            result = _target.IsDisabled() as int
        elseif _theAction == "IsEnabled"
            result = _target.IsEnabled() as int
        elseif _theAction == "IsIgnoringFriendlyHits"
            result = _target.IsIgnoringFriendlyHits() as int
        elseif _theAction == "IsInDialogueWithPlayer"
            result = _target.IsInDialogueWithPlayer() as int
        elseif _theAction == "IsInInterior"
            result = _target.IsInInterior() as int
        elseif _theAction == "IsLocked"
            result = _target.IsLocked() as int
        elseif _theAction == "IsMapMarkerVisible"
            result = _target.IsMapMarkerVisible() as int
        elseif _theAction == "IsNearPlayer"
            result = _target.IsNearPlayer() as int
        elseif _theAction == "GetNumItems"
            result = _target.GetNumItems()
        elseif _theAction == "GetTotalItemWeight"
            result = _target.GetTotalItemWeight()
        elseif _theAction == "GetTotalArmorWeight"
            result = _target.GetTotalArmorWeight()
        elseif _theAction == "IsHarvested"
            result = _target.IsHarvested() as int
        elseif _theAction == "GetItemMaxCharge"
            result = _target.GetItemMaxCharge()
        elseif _theAction == "GetItemCharge"
            result = _target.GetItemCharge()
        elseif _theAction == "IsOffLimits"
            result = _target.IsOffLimits() as int
        elseif _theAction == "GetDisplayName"
            result = _target.GetDisplayName()
        elseif _theAction == "GetEnableParent"
            ObjectReference _parent = _target.GetEnableParent()
            if _parent
                result = _parent.GetFormID()
            endif
        elseif _theAction == "GetEnchantment"
            Enchantment _ench = _target.GetEnchantment()
            if _ench
                result = _ench.GetFormID()
            endif
        elseif _theAction == "GetNumReferenceAliases"
            result = _target.GetNumReferenceAliases()
        else
            return _slt_form_dogetter(CmdPrimary, _target, _theAction)
        endif
    endIf

    return result
endFunction

string function _slt_actor_dogetter(sl_triggersCmd CmdPrimary, Actor _target, string _theAction) global
    string result
        
    if _target && _theAction
        if _theAction == "CanFlyHere"
            result = _target.CanFlyHere() as int
        elseif _theAction == "Dismount"
            result = _target.Dismount() as int
        elseif _theAction == "GetActorBase"
            ActorBase _obj = _target.GetActorBase()
            if _obj
                result = _obj.GetFormID()
            endif
        elseif _theAction == "GetBribeAmount"
            result = _target.GetBribeAmount()
        elseif _theAction == "GetCrimeFaction"
            Faction _obj = _target.GetCrimeFaction()
            if _obj
                result = _obj.GetFormID()
            endif
        elseif _theAction == "GetCombatState"
            result = _target.GetCombatState()
        elseif _theAction == "GetCombatTarget"
            Actor _obj = _target.GetCombatTarget()
            if _obj
                result = _obj.GetFormID()
            endif
        elseif _theAction == "GetCurrentPackage"
            Package _obj = _target.GetCurrentPackage()
            if _obj
                result = _obj.GetFormID()
            endif
        elseif _theAction == "GetDialogueTarget"
            Actor _obj = _target.GetDialogueTarget()
            if _obj
                result = _obj.GetFormID()
            endif
        elseif _theAction == "GetEquippedShield"
            Armor _shield = _target.GetEquippedShield()
            if _shield
                result = _shield.GetFormID()
            endif
        elseif _theAction == "GetEquippedShout"
            Shout _shout = _target.GetEquippedShout()
            if _shout
                result = _shout.GetFormID()
            endif
        elseif _theAction == "GetFlyingState"
            result = _target.GetFlyingState()
        elseif _theAction == "GetForcedLandingMarker"
            ObjectReference _marker = _target.GetForcedLandingMarker()
            if _marker
                result = _marker.GetFormID()
            endif
        elseif _theAction == "GetGoldAmount"
            result = _target.GetGoldAmount()
        elseif _theAction == "GetHighestRelationshipRank"
            result = _target.GetHighestRelationshipRank()
        elseif _theAction == "GetKiller"
            Actor _killer = _target.GetKiller()
            if _killer
                result = _killer.GetFormID()
            endif
        elseif _theAction == "GetLevel"
            result = _target.GetLevel()
        elseif _theAction == "GetLeveledActorBase"
            ActorBase _levab = _target.GetLeveledActorBase()
            if _levab
                result = _levab.GetFormID()
            endif
        elseif _theAction == "GetLightLevel"
            result = _target.GetLightLevel()
        elseif _theAction == "GetLowestRelationshipRank"
            result = _target.GetLowestRelationshipRank()
        elseif _theAction == "GetNoBleedoutRecovery"
            result = _target.GetNoBleedoutRecovery() as int
        elseif _theAction == "GetPlayerControls"
            result = _target.GetPlayerControls() as int
        elseif _theAction == "GetRace"
            Race _race = _target.GetRace()
            if _race
                result = _race.GetFormID()
            endif
        elseif _theAction == "GetSitState"
            result = _target.GetSitState()
        elseif _theAction == "GetSleepState"
            result = _target.GetSleepState()
        elseif _theAction == "GetVoiceRecoveryTime"
            result = _target.GetVoiceRecoveryTime()
        elseif _theAction == "IsAlarmed"
            result = _target.IsAlarmed() as int
        elseif _theAction == "IsAlerted"
            result = _target.IsAlerted() as int
        elseif _theAction == "IsAllowedToFly"
            result = _target.IsAllowedToFly() as int
        elseif _theAction == "IsArrested"
            result = _target.IsArrested() as int
        elseif _theAction == "IsArrestingTarget"
            result = _target.IsArrestingTarget() as int
        elseif _theAction == "IsBeingRidden"
            result = _target.IsBeingRidden() as int
        elseif _theAction == "IsBleedingOut"
            result = _target.IsBleedingOut() as int
        elseif _theAction == "IsBribed"
            result = _target.IsBribed() as int
        elseif _theAction == "IsChild"
            result = _target.IsChild() as int
        elseif _theAction == "IsCommandedActor"
            result = _target.IsCommandedActor() as int
        elseif _theAction == "IsDead"
            result = _target.IsDead() as int
        elseif _theAction == "IsDoingFavor"
            result = _target.IsDoingFavor() as int
        elseif _theAction == "IsEssential"
            result = _target.IsEssential() as int
        elseif _theAction == "IsFlying"
            result = _target.IsFlying() as int
        elseif _theAction == "IsGhost"
            result = _target.IsGhost() as int
        elseif _theAction == "IsGuard"
            result = _target.IsGuard() as int
        elseif _theAction == "IsInCombat"
            result = _target.IsInCombat() as int
        elseif _theAction == "IsInKillMove"
            result = _target.IsInKillMove() as int
        elseif _theAction == "IsIntimidated"
            result = _target.IsIntimidated() as int
        elseif _theAction == "IsOnMount"
            result = _target.IsOnMount() as int
        elseif _theAction == "IsPlayersLastRiddenHorse"
            result = _target.IsPlayersLastRiddenHorse() as int
        elseif _theAction == "IsPlayerTeammate"
            result = _target.IsPlayerTeammate() as int
        elseif _theAction == "IsRunning"
            result = _target.IsRunning() as int
        elseif _theAction == "IsSneaking"
            result = _target.IsSneaking() as int
        elseif _theAction == "IsSprinting"
            result = _target.IsSprinting() as int
        elseif _theAction == "IsTrespassing"
            result = _target.IsTrespassing() as int
        elseif _theAction == "IsUnconscious"
            result = _target.IsUnconscious() as int
        elseif _theAction == "IsWeaponDrawn"
            result = _target.IsWeaponDrawn() as int
        elseif _theAction == "GetSpellCount"
            result = _target.GetSpellCount()
        elseif _theAction == "IsAIEnabled"
            result = _target.IsAIEnabled() as int
        elseif _theAction == "IsSwimming"
            result = _target.IsSwimming() as int
        elseif _theAction == "WillIntimidateSucceed"
            result = _target.WillIntimidateSucceed() as int
        elseif _theAction == "IsOverEncumbered"
            result = _target.IsOverEncumbered() as int
        elseif _theAction == "GetWarmthRating"
            result = _target.GetWarmthRating()
        else
            return _slt_objectreference_dogetter(CmdPrimary, _target, _theAction)
        endif
    endIf

    return result
endFunction

; sltname form_dogetter
; sltgrup Form
; sltdesc For the targeted Actor, set $$ to the result of the specified getter
; sltdesc 'Getter' in this case specifically refers to functions that take no parameters but return a value
; sltdesc https://ck.uesp.net/wiki/Form_Script
; sltargs form: target Form (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)
; sltargs getter: getter name
; sltargsmore ;;;; T79686hese are from Form
; sltargsmore GetFormID
; sltargsmore GetGoldValue
; sltargsmore PlayerKnows
; sltargsmore ;;;; These are from SKSE
; sltargsmore GetType
; sltargsmore GetName
; sltargsmore GetWeight
; sltargsmore GetNumKeywords
; sltargsmore IsPlayable
; sltargsmore HasWorldModel
; sltargsmore GetWorldModelPath
; sltargsmore GetWorldModelNumTextureSets
; sltargsmore TempClone
; sltsamp form_dogetter $formId IsPlayable
; sltsamp if $$ = 1 itwasplayable
function form_dogetter(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string result

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form _target = CmdPrimary.ResolveForm(param[1])
        
        if _target
            string _theAction = CmdPrimary.Resolve(param[2])

            if _theAction
                result = _slt_form_dogetter(CmdPrimary, _target, _theAction)
                if !result
                    SquawkFunctionError(CmdPrimary, "form_dogetter: action returned empty string result, likely a problem(" + _theAction + ")")
                endif
            endif
        endIf
    endif

    CmdPrimary.MostRecentResult = result

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname objectreference_dogetter
; sltgrup ObjectReference
; sltdesc For the targeted ObjectReference, set $$ to the result of the specified getter
; sltdesc 'Getter' in this case specifically refers to functions that take no parameters but return a value
; sltdesc https://ck.uesp.net/wiki/ObjectReference_Script
; sltargs objectreference: target ObjectReference  (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)
; sltargs getter: getter name
; sltargsmore ;;;; These are from ObjectReference
; sltargsmore CanFastTravelToMarker
; sltargsmore GetActorOwner
; sltargsmore GetAngleX
; sltargsmore GetAngleY
; sltargsmore GetAngleZ
; sltargsmore GetBaseObject
; sltargsmore GetCurrentDestructionStage
; sltargsmore GetCurrentLocation
; sltargsmore GetCurrentScene
; sltargsmore GetEditorLocation
; sltargsmore GetFactionOwner
; sltargsmore GetHeight
; sltargsmore GetItemHealthPercent
; sltargsmore GetKey
; sltargsmore GetLength
; sltargsmore GetLockLevel
; sltargsmore GetMass
; sltargsmore GetOpenState
; sltargsmore GetParentCell
; sltargsmore GetPositionX
; sltargsmore GetPositionY
; sltargsmore GetPositionZ
; sltargsmore GetScale
; sltargsmore GetTriggerObjectCount
; sltargsmore GetVoiceType
; sltargsmore GetWidth
; sltargsmore GetWorldSpace
; sltargsmore IsActivationBlocked
; sltargsmore Is3DLoaded
; sltargsmore IsDeleted
; sltargsmore IsDisabled
; sltargsmore IsEnabled
; sltargsmore IsIgnoringFriendlyHits
; sltargsmore IsInDialogueWithPlayer
; sltargsmore IsInInterior
; sltargsmore IsLocked
; sltargsmore IsMapMarkerVisible
; sltargsmore IsNearPlayer
; sltargsmore ;;;; These are from SKSE
; sltargsmore GetNumItems
; sltargsmore GetTotalItemWeight
; sltargsmore GetTotalArmorWeight
; sltargsmore IsHarvested
; sltargsmore GetItemMaxCharge
; sltargsmore GetItemCharge
; sltargsmore IsOffLimits
; sltargsmore GetDisplayName
; sltargsmore GetEnableParent
; sltargsmore GetEnchantment
; sltargsmore GetNumReferenceAliases
; sltsamp actor_dogetter CanFlyHere
; sltsamp if $$ = 1 ICanFlyAroundHere
; sltsamp if $$ = 0 IAmGroundedLikeAlways
function objectreference_dogetter(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string result

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        ObjectReference _target = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        
        if _target
            string _theAction = CmdPrimary.Resolve(param[2])

            if _theAction
                result = _slt_objectreference_dogetter(CmdPrimary, _target, _theAction)
                if !result
                    SquawkFunctionError(CmdPrimary, "objectreference_dogetter: action returned empty string result, likely a problem(" + _theAction + ")")
                endif
            endif
        endIf
    endif

    CmdPrimary.MostRecentResult = result

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_dogetter
; sltgrup Actor
; sltdesc For the targeted Actor, set $$ to the result of the specified getter
; sltdesc 'Getter' in this case specifically refers to functions that take no parameters but return a value
; sltdesc https://ck.uesp.net/wiki/Actor_Script
; sltargs actor: target Actor  (accepts special variable names ($self, $player) and both relative "Skyrim.esm:0f" and absolute "0f" values)
; sltargs getter: getter name
; sltargsmore ;;;; These are from Actor
; sltargsmore CanFlyHere
; sltargsmore Dismount
; sltargsmore GetActorBase
; sltargsmore GetBribeAmount
; sltargsmore GetCrimeFaction
; sltargsmore GetCombatState
; sltargsmore GetCombatTarget
; sltargsmore GetCurrentPackage
; sltargsmore GetDialogueTarget
; sltargsmore GetEquippedShield
; sltargsmore GetEquippedShout
; sltargsmore GetFlyingState
; sltargsmore GetForcedLandingMarker
; sltargsmore GetGoldAmount
; sltargsmore GetHighestRelationshipRank
; sltargsmore GetKiller
; sltargsmore GetLevel
; sltargsmore GetLeveledActorBase
; sltargsmore GetLightLevel
; sltargsmore GetLowestRelationshipRank
; sltargsmore GetNoBleedoutRecovery
; sltargsmore GetPlayerControls
; sltargsmore GetRace
; sltargsmore GetSitState
; sltargsmore GetSleepState
; sltargsmore GetVoiceRecoveryTime
; sltargsmore IsAlarmed
; sltargsmore IsAlerted
; sltargsmore IsAllowedToFly
; sltargsmore IsArrested
; sltargsmore IsArrestingTarget
; sltargsmore IsBeingRidden - not a SexLab setting
; sltargsmore IsBleedingOut
; sltargsmore IsBribed
; sltargsmore IsChild
; sltargsmore IsCommandedActor
; sltargsmore IsDead
; sltargsmore IsDoingFavor
; sltargsmore IsEssential
; sltargsmore IsFlying
; sltargsmore IsGhost
; sltargsmore IsGuard
; sltargsmore IsInCombat
; sltargsmore IsInKillMove
; sltargsmore IsIntimidated
; sltargsmore IsOnMount - see IsBeingRidden
; sltargsmore IsPlayersLastRiddenHorse - I don't even need to comment now, do I?
; sltargsmore IsPlayerTeammate
; sltargsmore IsRunning
; sltargsmore IsSneaking
; sltargsmore IsSprinting
; sltargsmore IsTrespassing
; sltargsmore IsUnconscious
; sltargsmore IsWeaponDrawn
; sltargsmore ;;;; These are from SKSE
; sltargsmore GetSpellCount
; sltargsmore IsAIEnabled
; sltargsmore IsSwimming
; sltargsmore ;;;; These are Special Edition exclusive
; sltargsmore WillIntimidateSucceed
; sltargsmore IsOverEncumbered
; sltargsmore GetWarmthRating
; sltsamp actor_dogetter CanFlyHere
; sltsamp if $$ = 1 ICanFlyAroundHere
; sltsamp if $$ = 0 IAmGroundedLikeAlways
function actor_dogetter(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string result

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _target = CmdPrimary.ResolveForm(param[1]) as Actor
        
        if _target
            string _theAction = CmdPrimary.Resolve(param[2])

            if _theAction
                result = _slt_actor_dogetter(CmdPrimary, _target, _theAction)
                if !result
                    SquawkFunctionError(CmdPrimary, "actor_dogetter: action returned empty string result, likely a problem(" + _theAction + ")")
                endif
            endif
        endIf
    endif

    CmdPrimary.MostRecentResult = result

	CmdPrimary.CompleteOperationOnActor()
endFunction


bool function _slt_form_doconsumer(sl_triggersCmd CmdPrimary, Form _target, string _theAction, string[] param) global
    if _target && _theAction
        if _theAction == "SetPlayerKnows"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetPlayerKnows(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "SetWorldModelPath"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetWorldModelPath(CmdPrimary.Resolve(param[3]))
            endif
        elseif _theAction == "SetName"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetName(CmdPrimary.Resolve(param[3]))
            endif
        elseif _theAction == "SetWeight"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetWeight(CmdPrimary.Resolve(param[3]) as float)
            endif
        elseif _theAction == "SetGoldValue"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetGoldValue(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "SendModEvent"
            if ParamLengthGT(CmdPrimary, param.Length, 3)
                string _eventname = CmdPrimary.Resolve(param[3])
                string _strarg
                float _fltarg
                if param.Length > 4
                    _strarg = CmdPrimary.Resolve(param[4])
                    if param.Length > 5
                        _fltarg = CmdPrimary.Resolve(param[5]) as float
                    endif
                endif
                _target.SendModEvent(_eventname, _strarg, _fltarg)
            endif
        else
            return false
        endif
        return true
    endif    
    return false
endFunction

bool function _slt_objectreference_doconsumer(sl_triggersCmd CmdPrimary, ObjectReference _target, string _theAction, string[] param) global
    if _target && _theAction
        if _theAction == "Activate"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    _target.Activate(_obj)
                endif
            endif
        elseif _theAction == "AddInventoryEventFilter"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Form _obj = CmdPrimary.ResolveForm(param[3])
                if _obj
                    _target.AddInventoryEventFilter(_obj)
                endif
            endif
        elseif _theAction == "AddItem"
            if ParamLengthGT(CmdPrimary, param.Length, 3)
                Form itemToAdd = CmdPrimary.ResolveForm(param[3])
                if itemToAdd
                    int itemCount = 1
                    bool isSilent
                    if param.Length > 4
                        itemCount = CmdPrimary.Resolve(param[4]) as int
                        if param.Length > 5
                            isSilent = CmdPrimary.Resolve(param[5]) as int
                        endif
                    endif
                    _target.AddItem(itemToAdd, itemCount, isSilent)
                endif
            endif
        elseif _theAction == "AddKeyIfNeeded"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    _target.AddKeyIfNeeded(_obj)
                endif
            endif
        elseif _theAction == "AddToMap"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.AddToMap(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "ApplyHavokImpulse"
            if ParamLengthEQ(CmdPrimary, param.Length, 7)
                _target.ApplyHavokImpulse(CmdPrimary.Resolve(param[3]) as float, CmdPrimary.Resolve(param[4]) as float, CmdPrimary.Resolve(param[5]) as float, CmdPrimary.Resolve(param[6]) as float)
            endif
        elseif _theAction == "BlockActivation"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.BlockActivation(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "CreateDetectionEvent"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Actor _akOwner = CmdPrimary.ResolveForm(param[3]) as Actor
                if _akOwner
                    _target.CreateDetectionEvent(_akOwner, CmdPrimary.Resolve(param[4]) as int)
                endif
            endif
        elseif _theAction == "DamageObject"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.DamageObject(CmdPrimary.Resolve(param[3]) as float)
            endif
        elseif _theAction == "Disable"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.Disable(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "DisableLinkChain"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Keyword _apKeyword = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _apKeyword
                    _target.DisableLinkChain(_apKeyword, CmdPrimary.Resolve(param[4]) as int)
                endif
            endif
        elseif _theAction == "DisableNoWait"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.DisableNoWait(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "DropObject"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Form _akObject = CmdPrimary.ResolveForm(param[3])
                if _akObject
                    _target.DropObject(_akObject, CmdPrimary.Resolve(param[4]) as int)
                endif
            endif
        elseif _theAction == "Enable"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.Enable(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "EnableFastTravel"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.EnableFastTravel(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "EnableLinkChain"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Keyword _apKeyword = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _apKeyword
                    _target.EnableLinkChain(_apKeyword)
                endif
            endif
        elseif _theAction == "EnableNoWait"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.EnableNoWait(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "IgnoreFriendlyHits"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.IgnoreFriendlyHits(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "KnockAreaEffect"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.KnockAreaEffect(CmdPrimary.Resolve(param[3]) as float, CmdPrimary.Resolve(param[4]) as float)
            endif
        elseif _theAction == "Lock"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.Lock(CmdPrimary.Resolve(param[3]) as int, CmdPrimary.Resolve(param[4]) as int)
            endif
        elseif _theAction == "MoveTo"
            if ParamLengthEQ(CmdPrimary, param.Length, 8)
                ObjectReference _akTarget = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _akTarget
                    _target.MoveTo(_akTarget, CmdPrimary.Resolve(param[4]) as float, CmdPrimary.Resolve(param[5]) as float, CmdPrimary.Resolve(param[6]) as float, CmdPrimary.Resolve(param[7]) as int)
                endif
            endif
        elseif _theAction == "MoveToInteractionLocation"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _akTarget = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _akTarget
                    _target.MoveToInteractionLocation(_akTarget)
                endif
            endif
        elseif _theAction == "MoveToNode"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                ObjectReference _akTarget = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _akTarget
                    _target.MoveToNode(_akTarget, CmdPrimary.Resolve(param[4]))
                endif
            endif
        elseif _theAction == "PlayTerrainEffect"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.PlayTerrainEffect(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]))
            endif
        elseif _theAction == "ProcessTrapHit"
            if ParamLengthEQ(CmdPrimary, param.Length, 14)
                ObjectReference _akTrap = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _akTrap
                    _target.ProcessTrapHit(_akTrap, CmdPrimary.Resolve(param[4]) as float, CmdPrimary.Resolve(param[5]) as float, CmdPrimary.Resolve(param[6]) as float, CmdPrimary.Resolve(param[7]) as float, CmdPrimary.Resolve(param[8]) as float, CmdPrimary.Resolve(param[9]) as float, CmdPrimary.Resolve(param[10]) as float, CmdPrimary.Resolve(param[11]) as float, CmdPrimary.Resolve(param[12]) as int, CmdPrimary.Resolve(param[13]) as float)
                endif
            endif
        elseif _theAction == "PushActorAway"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Actor _akActor = CmdPrimary.ResolveForm(param[3]) as Actor
                if _akActor
                    _target.PushActorAway(_akActor, CmdPrimary.Resolve(param[4]) as int)
                endif
            endif
        elseif _theAction == "RemoveAllItems"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                ObjectReference _akTransferTo = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                _target.RemoveAllItems(_akTransferTo, CmdPrimary.Resolve(param[4]) as int, CmdPrimary.Resolve(param[5]) as int)
            endif
        elseif _theAction == "RemoveInventoryEventFilter"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Form _akObject = CmdPrimary.ResolveForm(param[3])
                if _akObject
                    _target.RemoveInventoryEventFilter(_akObject)
                endif
            endif
        elseif _theAction == "RemoveItem"
            if ParamLengthEQ(CmdPrimary, param.Length, 7)
                Form _toRemove = CmdPrimary.ResolveForm(param[3])
                ObjectReference _akTransferTo = CmdPrimary.ResolveForm(param[6]) as ObjectReference
                _target.RemoveItem(_toRemove, CmdPrimary.Resolve(param[4]) as int, CmdPrimary.Resolve(param[5]) as int, _akTransferTo)
            endif
        elseif _theAction == "Reset"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _akTarget = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                _target.Reset(_akTarget)
            endif
        elseif _theAction == "Say"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                Topic _topic = CmdPrimary.ResolveForm(param[3]) as Topic
                if _topic
                    Actor _speakAs = CmdPrimary.ResolveForm(param[4]) as Actor
                    bool _inPlayerHead = CmdPrimary.Resolve(param[5]) as int
                    _target.Say(_topic, _speakAs, _inPlayerHead)
                endif
            endif
        elseif _theAction == "SendStealAlarm"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _akActor = CmdPrimary.ResolveForm(param[3]) as Actor
                if _akActor
                    _target.SendStealAlarm(_akActor)
                endif
            endif
        elseif _theAction == "SetActorCause"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _akActor = CmdPrimary.ResolveForm(param[3]) as Actor
                if _akActor
                    _target.SetActorCause(_akActor)
                endif
            endif
        elseif _theAction == "SetActorOwner"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ActorBase _akActorBase = CmdPrimary.ResolveForm(param[3]) as ActorBase
                if _akActorBase
                    _target.SetActorOwner(_akActorBase)
                endif
            endif
        elseif _theAction == "SetAngle"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                _target.SetAngle(CmdPrimary.Resolve(param[3]) as float, CmdPrimary.Resolve(param[4]) as float, CmdPrimary.Resolve(param[5]) as float)
            endif
        elseif _theAction == "SetAnimationVariableBool"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetAnimationVariableBool(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as int)
            endif
        elseif _theAction == "SetAnimationVariableFloat"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetAnimationVariableFloat(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as float)
            endif
        elseif _theAction == "SetAnimationVariableInt"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetAnimationVariableInt(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as int)
            endif
        elseif _theAction == "SetDestroyed"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetDestroyed(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "SetFactionOwner"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Faction _akfaction = CmdPrimary.ResolveForm(param[3]) as Faction
                if _akfaction
                    _target.SetFactionOwner(_akfaction)
                endif
            endif
        elseif _theAction == "SetLockLevel"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetLockLevel(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "SetMotionType"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetMotionType(CmdPrimary.Resolve(param[3]) as int, CmdPrimary.Resolve(param[4]) as int)
            endif
        elseif _theAction == "SetNoFavorAllowed"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetNoFavorAllowed(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "SetOpen"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetOpen(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "SetPosition"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                _target.SetPosition(CmdPrimary.Resolve(param[3]) as float, CmdPrimary.Resolve(param[4]) as float, CmdPrimary.Resolve(param[5]) as float)
            endif
        elseif _theAction == "SetScale"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetScale(CmdPrimary.Resolve(param[3]) as float)
            endif
        elseif _theAction == "TetherToHorse"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _akHorse = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _akHorse
                    _target.TetherToHorse(_akHorse)
                endif
            endif
        elseif _theAction == "TranslateTo"
            if ParamLengthEQ(CmdPrimary, param.Length, 11)
                _target.TranslateTo(CmdPrimary.Resolve(param[3]) as float, CmdPrimary.Resolve(param[4]) as float, CmdPrimary.Resolve(param[5]) as float, CmdPrimary.Resolve(param[6]) as float, CmdPrimary.Resolve(param[7]) as float, CmdPrimary.Resolve(param[8]) as float, CmdPrimary.Resolve(param[9]) as float, CmdPrimary.Resolve(param[10]) as float)
            endif
        elseif _theAction == "TranslateToRef"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                ObjectReference _akref = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _akref
                    _target.TranslateToRef(_akref, CmdPrimary.Resolve(param[4]) as float, CmdPrimary.Resolve(param[5]) as float)
                endif
            endif
        elseif _theAction == "SetHarvested"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetHarvested(CmdPrimary.Resolve(param[3]) as int)
            endif
        elseif _theAction == "SetItemHealthPercent"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetItemHealthPercent(CmdPrimary.Resolve(param[3]) as float)
            endif
        elseif _theAction == "SetItemMaxCharge"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetItemMaxCharge(CmdPrimary.Resolve(param[3]) as float)
            endif
        elseif _theAction == "SetItemCharge"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetItemCharge(CmdPrimary.Resolve(param[3]) as float)
            endif
        elseif _theAction == "SetEnchantment"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Enchantment _ench = CmdPrimary.ResolveForm(param[3]) as Enchantment
                if _ench
                    _target.SetEnchantment(_ench, CmdPrimary.Resolve(param[4]) as float)
                endif
            endif
        elseif _theAction == "CreateEnchantment"
            if ParamLengthGT(CmdPrimary, param.Length, 7)
                float _maxCharge = param[3] as float
                int i = 4
                int needlen = (param.Length - 4) / 4
                if needlen > 127
                    needlen = 127
                endif
                int listindex = 0
                MagicEffect[] _mgefs    = sl_triggersListGenerators.CreateMGEFList(needlen)
                float[] _mags           = PapyrusUtil.FloatArray(needlen)
                int[] _areas            = PapyrusUtil.IntArray(needlen)
                int[] _durations        = PapyrusUtil.IntArray(needlen)
                while (i + 3) < param.Length
                    _mgefs[listindex] = CmdPrimary.ResolveForm(param[i]) as MagicEffect
                    _mags[listindex] = CmdPrimary.Resolve(param[i + 1]) as float
                    _areas[listindex] = CmdPrimary.Resolve(param[i + 2]) as int
                    _durations[listindex] = CmdPrimary.Resolve(param[i + 3]) as int

                    listindex += 1
                    i += 4
                endwhile
                _target.CreateEnchantment(_maxCharge, _mgefs, _mags, _areas, _durations)
            endif
        else
            return _slt_form_doconsumer(CmdPrimary, _target, _theAction, param)
        endif
        return true
    endif    
    return false
endFunction

bool function _slt_actor_doconsumer(sl_triggersCmd CmdPrimary, Actor _target, string _theAction, string[] param) global
    if _target && _theAction
        if _theAction == "AddPerk"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Perk _obj = CmdPrimary.ResolveForm(param[3]) as Perk
                if _obj
				    _target.AddPerk(_obj)
                endif
			endif
		elseif _theAction == "AddToFaction"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Faction _obj = CmdPrimary.ResolveForm(param[3]) as Faction
                if _obj
				    _target.AddToFaction(_obj)
                endif
			endif
		elseif _theAction == "AllowBleedoutDialogue"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.AllowBleedoutDialogue(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "AllowPCDialogue"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.AllowPCDialogue(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "AttachAshPile"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Form _obj = CmdPrimary.ResolveForm(param[3])
                if _obj
				    _target.AttachAshPile(_obj)
                endif
			endif
		elseif _theAction == "DamageActorValue"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
				_target.DamageActorValue(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as float)
			endif
		elseif _theAction == "DamageAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
				_target.DamageAV(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as float)
			endif
		elseif _theAction == "DoCombatSpellApply"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Spell _obj = CmdPrimary.ResolveForm(param[3]) as Spell
                ObjectReference _obj2 = CmdPrimary.ResolveForm(param[4]) as ObjectReference
                if _obj && _obj2
				    _target.DoCombatSpellApply(_obj, _obj2)
                endif
			endif
		elseif _theAction == "EnableAI"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.EnableAI(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "EquipItem"
			if ParamLengthEQ(CmdPrimary, param.Length, 6)
                Form _obj = CmdPrimary.ResolveForm(param[3])
                if _obj
				    _target.EquipItem(_obj, CmdPrimary.Resolve(param[4]) as int, CmdPrimary.Resolve(param[5]) as int)
                endif
			endif
		elseif _theAction == "EquipShout"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Shout _obj = CmdPrimary.ResolveForm(param[3]) as Shout
                if _obj
				    _target.EquipShout(_obj)
                endif
			endif
		elseif _theAction == "EquipSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Spell _obj = CmdPrimary.ResolveForm(param[3]) as Spell
                if _obj
				    _target.EquipSpell(_obj, CmdPrimary.Resolve(param[4]) as int)
                endif
			endif
		elseif _theAction == "ForceActorValue"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.ForceActorValue(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as float)
			endif
		elseif _theAction == "ForceAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.ForceAV(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as float)
			endif
		elseif _theAction == "KeepOffsetFromActor"
			if ParamLengthEQ(CmdPrimary, param.Length, 11)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
				    _target.KeepOffsetFromActor(_obj, CmdPrimary.Resolve(param[4]) as float, CmdPrimary.Resolve(param[5]) as float, CmdPrimary.Resolve(param[6]) as float, CmdPrimary.Resolve(param[7]) as float, CmdPrimary.Resolve(param[8]) as float, CmdPrimary.Resolve(param[9]) as float, CmdPrimary.Resolve(param[10]) as float)
                endif
			endif
		elseif _theAction == "Kill"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
				    _target.Kill(_obj)
                endif
			endif
		elseif _theAction == "KillEssential"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
				    _target.KillEssential(_obj)
                endif
			endif
		elseif _theAction == "KillSilent"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
				    _target.KillSilent(_obj)
                endif
			endif
		elseif _theAction == "ModActorValue"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.ModActorValue(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as float)
			endif
		elseif _theAction == "ModAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.ModAV(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as float)
			endif
		elseif _theAction == "ModFactionRank"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Faction _obj = CmdPrimary.ResolveForm(param[3]) as Faction
                if _obj
				    _target.ModFactionRank(_obj, CmdPrimary.Resolve(param[4]) as int)
                endif
			endif
		elseif _theAction == "OpenInventory"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.OpenInventory(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "PlaySubGraphAnimation"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.PlaySubGraphAnimation(CmdPrimary.Resolve(param[3]))
			endif
		elseif _theAction == "RemoveFromFaction"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Faction _obj = CmdPrimary.ResolveForm(param[3]) as Faction
                if _obj
				    _target.RemoveFromFaction(_obj)
                endif
			endif
		elseif _theAction == "RemovePerk"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Perk _obj = CmdPrimary.ResolveForm(param[3]) as Perk
                if _obj
				    _target.RemovePerk(_obj)
                endif
			endif
		elseif _theAction == "RestoreActorValue"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.RestoreActorValue(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as float)
			endif
		elseif _theAction == "RestoreAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.RestoreAV(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as float)
			endif
		elseif _theAction == "SendTrespassAlarm"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
				    _target.SendTrespassAlarm(_obj)
                endif
			endif
		elseif _theAction == "SetActorValue"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetActorValue(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as float)
			endif
		elseif _theAction == "SetAlert"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetAlert(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetAllowFlying"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetAllowFlying(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetAllowFlyingEx"
			if ParamLengthEQ(CmdPrimary, param.Length, 6)
				_target.SetAllowFlyingEx(CmdPrimary.Resolve(param[3]) as int, CmdPrimary.Resolve(param[4]) as int, CmdPrimary.Resolve(param[5]) as int)
			endif
		elseif _theAction == "SetAlpha"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetAlpha(CmdPrimary.Resolve(param[3]) as float, CmdPrimary.Resolve(param[4]) as int)
			endif
		elseif _theAction == "SetAttackActorOnSight"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetAttackActorOnSight(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetAV(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as float)
			endif
		elseif _theAction == "SetBribed"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetBribed(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetCrimeFaction"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Faction _obj = CmdPrimary.ResolveForm(param[3]) as Faction
                if _obj
                    _target.SetCrimeFaction(_obj)
                endif
			endif
		elseif _theAction == "SetCriticalStage"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetCriticalStage(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetDoingFavor"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetDoingFavor(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetDontMove"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetDontMove(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetExpressionOverride"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
				_target.SetExpressionOverride(CmdPrimary.Resolve(param[3]) as int, CmdPrimary.Resolve(param[4]) as int)
			endif
		elseif _theAction == "SetEyeTexture"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                TextureSet _obj = CmdPrimary.ResolveForm(param[3]) as TextureSet
                if _obj
                    _target.SetEyeTexture(_obj)
                endif
			endif
		elseif _theAction == "SetFactionRank"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Faction _obj = CmdPrimary.ResolveForm(param[3]) as Faction
                if _obj
                    _target.SetFactionRank(_obj, CmdPrimary.Resolve(param[4]) as int)
                endif
			endif
		elseif _theAction == "SetForcedLandingMarker"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    _target.SetForcedLandingMarker(_obj)
                endif
			endif
		elseif _theAction == "SetGhost"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetGhost(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetHeadTracking"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetHeadTracking(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetIntimidated"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetIntimidated(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetLookAt"
			if ParamLengthGT(CmdPrimary, param.Length, 3)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    bool pathingLookAt
                    if param.Length > 4
                        pathingLookAt = CmdPrimary.Resolve(param[4]) as Int
                    endif
                    _target.SetLookAt(_obj, pathingLookAt)
                endif
			endif
		elseif _theAction == "SetNoBleedoutRecovery"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetNoBleedoutRecovery(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetNotShowOnStealthMeter"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetNotShowOnStealthMeter(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetOutfit"
			if ParamLengthGT(CmdPrimary, param.Length, 3)
                Outfit _obj = CmdPrimary.ResolveForm(param[3]) as Outfit
                if _obj
                    bool _boolval
                    if param.Length > 4
                        _boolval = CmdPrimary.Resolve(param[4]) as Int
                    endif
                    _target.SetOutfit(_obj, _boolval)
                endif
			endif
		elseif _theAction == "SetPlayerControls"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetPlayerControls(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetPlayerTeammate"
			if ParamLengthGT(CmdPrimary, param.Length, 3)
                bool _bv1 = true
                bool _bv2 = true
                if param.Length > 3
                    _bv1 = CmdPrimary.Resolve(param[3]) as int
                    if param.Length > 4
                        _bv2 = CmdPrimary.Resolve(param[4]) as int
                    endif
                endif
				_target.SetPlayerTeammate(_bv1, _bv2)
			endif
		elseif _theAction == "SetRace"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Race _obj = CmdPrimary.ResolveForm(param[3]) as Race
                if _obj
                    _target.SetRace(_obj)
                endif
			endif
		elseif _theAction == "SetRelationshipRank"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
                    _target.SetRelationshipRank(_obj, CmdPrimary.Resolve(param[4]) as int)
                endif
			endif
		elseif _theAction == "SetRestrained"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetRestrained(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetSubGraphFloatVariable"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
                    _target.SetSubGraphFloatVariable(_obj, CmdPrimary.Resolve(param[4]) as float)
                endif
			endif
		elseif _theAction == "SetUnconscious"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetUnconscious(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SetVehicle"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    _target.SetVehicle(_obj)
                endif
			endif
		elseif _theAction == "SetVoiceRecoveryTime"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetVoiceRecoveryTime(CmdPrimary.Resolve(param[3]) as float)
			endif
		elseif _theAction == "StartCannibal"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
                    _target.StartCannibal(_obj)
                endif
			endif
		elseif _theAction == "StartCombat"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
                    _target.StartCombat(_obj)
                endif
			endif
		elseif _theAction == "StartVampireFeed"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
                    _target.StartVampireFeed(_obj)
                endif
			endif
		elseif _theAction == "UnequipItem"
			if ParamLengthGT(CmdPrimary, param.Length, 3)
                Form _obj = CmdPrimary.ResolveForm(param[3])

                if _obj
                    bool _bv1
                    bool _bv2
                    if param.Length > 3
                        _bv1 = CmdPrimary.Resolve(param[3]) as int
                        if param.Length > 4
                            _bv2 = CmdPrimary.Resolve(param[4]) as int
                        endif
                    endif
                    _target.UnequipItem(_obj, _bv1, _bv2)
                endif
			endif
		elseif _theAction == "UnequipItemSlot"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.UnequipItemSlot(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "UnequipShout"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Shout _obj = CmdPrimary.ResolveForm(param[3]) as Shout
                if _obj
                    _target.UnequipShout(_obj)
                endif
			endif
		elseif _theAction == "UnequipSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Spell _obj = CmdPrimary.ResolveForm(param[3]) as Spell
                if _obj
                    _target.UnequipSpell(_obj, CmdPrimary.Resolve(param[4]) as int)
                endif
			endif
		elseif _theAction == "SendLycanthropyStateChanged"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SendLycanthropyStateChanged(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "SendVampirismStateChanged"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SendVampirismStateChanged(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "EquipItemEx"
			if ParamLengthGT(CmdPrimary, param.Length, 4)
                Form _obj = CmdPrimary.ResolveForm(param[3])

                if _obj
                    int _slot = CmdPrimary.Resolve(param[4]) as int
                    bool _bv1
                    bool _bv2
                    if param.Length > 5
                        _bv1 = CmdPrimary.Resolve(param[5]) as int
                        if param.Length > 6
                            _bv2 = CmdPrimary.Resolve(param[6]) as int
                        endif
                    endif
                    _target.EquipItemEx(_obj, _slot, _bv1, _bv2)
                endif
			endif
		elseif _theAction == "EquipItemById"
			if ParamLengthGT(CmdPrimary, param.Length, 5)
                Form _obj = CmdPrimary.ResolveForm(param[3])

                if _obj
                    int _itemid = CmdPrimary.Resolve(param[4]) as int
                    int _slot = CmdPrimary.Resolve(param[5]) as int
                    bool _bv1
                    bool _bv2
                    if param.Length > 6
                        _bv1 = CmdPrimary.Resolve(param[6]) as int
                        if param.Length > 7
                            _bv2 = CmdPrimary.Resolve(param[7]) as int
                        endif
                    endif
                    _target.EquipItemById(_obj, _itemid, _slot, _bv1, _bv2)
                endif
			endif
		elseif _theAction == "UnequipItemEx"
			if ParamLengthGT(CmdPrimary, param.Length, 4)
                Form _obj = CmdPrimary.ResolveForm(param[3])

                if _obj
                    int _slot = CmdPrimary.Resolve(param[4]) as int
                    bool _bv1
                    if param.Length > 5
                        _bv1 = CmdPrimary.Resolve(param[5]) as int
                    endif
                    _target.UnequipItemEx(_obj, _slot, _bv1)
                endif
			endif
		elseif _theAction == "ChangeHeadPart"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                HeadPart _obj = CmdPrimary.ResolveForm(param[3]) as HeadPart

                if _obj
                    _target.ChangeHeadPart(_obj)
                endif
			endif
		elseif _theAction == "ReplaceHeadPart"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                HeadPart _obj = CmdPrimary.ResolveForm(param[3]) as HeadPart

                if _obj
                    HeadPart _newObj = CmdPrimary.ResolveForm(param[4]) as HeadPart
                    _target.ReplaceHeadPart(_obj, _newObj)
                endif
			endif
		elseif _theAction == "UpdateWeight"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.UpdateWeight(CmdPrimary.Resolve(param[3]) as float)
			endif
        else
            return _slt_objectreference_doconsumer(CmdPrimary, _target, _theAction, param)
        endif
        return true
    endif    
    return false
endFunction

; sltname form_consumer
; sltgrup Form
; sltdesc For the specified Form, perform the requested consumer, provided the appropriate additional parameters
; sltdesc 'Consumer' in this case specifically refers to functions that take parameters but return no result
; sltdesc https://ck.uesp.net/wiki/Form_Script
; sltargs form: target Form (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)
; sltargs consumer: consumer name
; sltargsmore SetPlayerKnows
; sltargsmore SetWorldModelPath
; sltargsmore SetName
; sltargsmore SetWeight
; sltargsmore SetGoldValue
; sltargsmore SendModEvent
; sltsamp actor_dogetter GetEquippedShield
; sltsamp set $shieldFormID $$
; sltsamp form_consumer $shieldFormID SetWeight 0.1 ; featherweight shield
function form_doconsumer(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string result

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Form _target = CmdPrimary.ResolveForm(param[1])
        
        if _target
            string _theAction = CmdPrimary.Resolve(param[2])

            if _theAction
                result = _slt_form_doconsumer(CmdPrimary, _target, _theAction, param)
                if !result
                    SquawkFunctionError(CmdPrimary, "form_doconsumer: unrecognized action(" + _theAction + ")")
                endif
            endif
        endIf
    endif

    CmdPrimary.MostRecentResult = result

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname objectreference_doconsumer
; sltgrup ObjectReference
; sltdesc For the specified ObjectReference, perform the requested consumer, provided the appropriate additional parameters
; sltdesc 'Consumer' in this case specifically refers to functions that take parameters but return no result
; sltdesc https://ck.uesp.net/wiki/ObjectReference_Script
; sltargs objectreference: target ObjectReference (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)
; sltargs consumer: consumer name
; sltargsmore Activate
; sltargsmore AddInventoryEventFilter
; sltargsmore AddItem
; sltargsmore AddKeyIfNeeded
; sltargsmore AddToMap
; sltargsmore ApplyHavokImpulse
; sltargsmore BlockActivation
; sltargsmore CreateDetectionEvent
; sltargsmore DamageObject
; sltargsmore Disable
; sltargsmore DisableLinkChain
; sltargsmore DisableNoWait
; sltargsmore DropObject
; sltargsmore Enable
; sltargsmore EnableFastTravel
; sltargsmore EnableLinkChain
; sltargsmore EnableNoWait
; sltargsmore IgnoreFriendlyHits
; sltargsmore KnockAreaEffect
; sltargsmore Lock
; sltargsmore MoveTo
; sltargsmore MoveToInteractionLocation
; sltargsmore MoveToNode
; sltargsmore PlayTerrainEffect
; sltargsmore ProcessTrapHit
; sltargsmore PushActorAway
; sltargsmore RemoveAllItems
; sltargsmore RemoveInventoryEventFilter
; sltargsmore RemoveItem
; sltargsmore Reset
; sltargsmore Say
; sltargsmore SendStealAlarm
; sltargsmore SetActorCause
; sltargsmore SetActorOwner
; sltargsmore SetAngle
; sltargsmore SetAnimationVariableBool
; sltargsmore SetAnimationVariableFloat
; sltargsmore SetAnimationVariableInt
; sltargsmore SetDestroyed
; sltargsmore SetFactionOwner
; sltargsmore SetLockLevel
; sltargsmore SetMotionType
; sltargsmore SetNoFavorAllowed
; sltargsmore SetOpen
; sltargsmore SetPosition
; sltargsmore SetScale
; sltargsmore SplineTranslateTo
; sltargsmore SplineTranslateToRef
; sltargsmore SplineTranslateToRefNode
; sltargsmore TetherToHorse
; sltargsmore TranslateTo
; sltargsmore TranslateToRef
; sltargsmore SetHarvested
; sltargsmore SetItemHealthPercent
; sltargsmore SetItemMaxCharge
; sltargsmore SetItemCharge
; sltargsmore SetEnchantment
; sltargsmore CreateEnchantment
; sltsamp actor_dogetter GetEquippedShield
; sltsamp set $shieldFormID $$
; sltsamp objectreference_doconsumer $shieldFormID CreateEnchantment 200.0 "Skyrim.esm:form-id-for-MGEF" 20.0 0.0 30.0
function objectreference_doconsumer(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string result

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        ObjectReference _target = CmdPrimary.resolveActor(param[1]) as ObjectReference
        
        if _target
            string _theAction = CmdPrimary.Resolve(param[2])

            if _theAction
                result = _slt_objectreference_doconsumer(CmdPrimary, _target, _theAction, param)
                if !result
                    SquawkFunctionError(CmdPrimary, "objectreference_doconsumer: unrecognized action(" + _theAction + ")")
                endif
            endif
        endIf
    endif

    CmdPrimary.MostRecentResult = result

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_doconsumer
; sltgrup Actor
; sltdesc For the specified Actor, perform the requested consumer, provided the appropriate additional parameters
; sltdesc 'Consumer' in this case specifically refers to functions that take parameters but return no result
; sltdesc https://ck.uesp.net/wiki/Actor_Script
; sltargs actor: target Actor (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)
; sltargs consumer: consumer name
; sltargsmore AddPerk
; sltargsmore AddToFaction
; sltargsmore AllowBleedoutDialogue
; sltargsmore AllowPCDialogue
; sltargsmore AttachAshPile
; sltargsmore DamageActorValue
; sltargsmore DamageAV
; sltargsmore DoCombatSpellApply
; sltargsmore EnableAI
; sltargsmore EquipItem
; sltargsmore EquipShout
; sltargsmore EquipSpell
; sltargsmore ForceActorValue
; sltargsmore ForceAV
; sltargsmore KeepOffsetFromActor
; sltargsmore Kill
; sltargsmore KillEssential
; sltargsmore KillSilent
; sltargsmore ModActorValue
; sltargsmore ModAV
; sltargsmore ModFactionRank
; sltargsmore OpenInventory
; sltargsmore PlaySubGraphAnimation
; sltargsmore RemoveFromFaction
; sltargsmore RemovePerk
; sltargsmore RestoreActorValue
; sltargsmore RestoreAV
; sltargsmore SendTrespassAlarm
; sltargsmore SetActorValue
; sltargsmore SetAlert
; sltargsmore SetAllowFlying
; sltargsmore SetAllowFlyingEx
; sltargsmore SetAlpha
; sltargsmore SetAttackActorOnSight
; sltargsmore SetAV
; sltargsmore SetBribed
; sltargsmore SetCrimeFaction
; sltargsmore SetCriticalStage
; sltargsmore SetDoingFavor
; sltargsmore SetDontMove
; sltargsmore SetExpressionOverride
; sltargsmore SetEyeTexture
; sltargsmore SetFactionRank
; sltargsmore SetForcedLandingMarker
; sltargsmore SetGhost
; sltargsmore SetHeadTracking
; sltargsmore SetIntimidated
; sltargsmore SetLookAt
; sltargsmore SetNoBleedoutRecovery
; sltargsmore SetNotShowOnStealthMeter
; sltargsmore SetOutfit
; sltargsmore SetPlayerControls
; sltargsmore SetPlayerTeammate
; sltargsmore SetRace
; sltargsmore SetRelationshipRank
; sltargsmore SetRestrained
; sltargsmore SetSubGraphFloatVariable
; sltargsmore SetUnconscious
; sltargsmore SetVehicle
; sltargsmore SetVoiceRecoveryTime
; sltargsmore StartCannibal
; sltargsmore StartCombat
; sltargsmore StartVampireFeed
; sltargsmore UnequipItem
; sltargsmore UnequipItemSlot
; sltargsmore UnequipShout
; sltargsmore UnequipSpell
; sltargsmore SendLycanthropyStateChanged
; sltargsmore SendVampirismStateChanged
; sltargsmore EquipItemEx
; sltargsmore EquipItemById
; sltargsmore UnequipItemEx
; sltargsmore ChangeHeadPart
; sltargsmore ReplaceHeadPart
; sltargsmore UpdateWeight
; sltsamp set $newGhostStatus 1
; sltsamp actor_doconsumer $self SetGhost $newGhostStatus
function actor_doconsumer(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string result

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Actor _target = CmdPrimary.ResolveForm(param[1]) as Actor
        
        if _target
            string _theAction = CmdPrimary.Resolve(param[2])

            if _theAction
                result = _slt_actor_doconsumer(CmdPrimary, _target, _theAction, param)
                if !result
                    SquawkFunctionError(CmdPrimary, "actor_doconsumer: unrecognized action(" + _theAction + ")")
                endif
            endif
        endIf
    endif

    CmdPrimary.MostRecentResult = result

	CmdPrimary.CompleteOperationOnActor()
endFunction

string Function _slt_form_dofunction(sl_triggersCmd CmdPrimary, Form _target, string _theAction, string[] param) global
    string result

    if _target && _theAction
        if _theAction == "HasKeywordString"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				result = _target.HasKeywordString(CmdPrimary.Resolve(param[3])) as int
			endif
        elseif _theAction == "HasKeyword"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Keyword _obj = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _obj
				    result = _target.HasKeyword(_obj) as int
                endif
			endif
        elseif _theAction == "GetNthKeyword"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Keyword _obj = _target.GetNthKeyword(CmdPrimary.Resolve(param[3]) as int)
                if _obj
				    result = _obj.GetFormID()
                endif
			endif
        elseif _theAction == "GetWorldModelNthTextureSet"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                TextureSet _obj = _target.GetWorldModelNthTextureSet(CmdPrimary.Resolve(param[3]) as int)
                if _obj
				    result = _obj.GetFormID()
                endif
			endif
        endif
    endif

    return result
endFunction

string Function _slt_objectreference_dofunction(sl_triggersCmd CmdPrimary, ObjectReference _target, string _theAction, string[] param) global
    string result

    if _target && _theAction
        if _theAction == "CalculateEncounterLevel"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                result = _target.CalculateEncounterLevel(CmdPrimary.Resolve(param[3]) as int)
            endif
		elseif _theAction == "CountLinkedRefChain"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Keyword _obj = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _obj
                    result = _target.CountLinkedRefChain(_obj, CmdPrimary.Resolve(param[4]) as int)
                endif
            endif
		elseif _theAction == "GetAnimationVariableBool"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                result = _target.GetAnimationVariableBool(CmdPrimary.Resolve(param[3])) as int
            endif
		elseif _theAction == "GetAnimationVariableFloat"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                result = _target.GetAnimationVariableFloat(CmdPrimary.Resolve(param[3]))
            endif
		elseif _theAction == "GetAnimationVariableInt"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                result = _target.GetAnimationVariableInt(CmdPrimary.Resolve(param[3]))
            endif
		elseif _theAction == "GetDistance"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    result = _target.GetDistance(_obj)
                endif
            endif
		elseif _theAction == "GetHeadingAngle"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    result = _target.GetHeadingAngle(_obj)
                endif
            endif
		elseif _theAction == "GetItemCount"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Form _obj = CmdPrimary.ResolveForm(param[3])
                if _obj
                    result = _target.GetItemCount(_obj)
                endif
            endif
		elseif _theAction == "HasEffectKeyword"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Keyword _obj = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _obj
                    result = _target.HasEffectKeyword(_obj) as int
                endif
            endif
		elseif _theAction == "HasNode"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                result = _target.HasNode(CmdPrimary.Resolve(param[3])) as int
            endif
		elseif _theAction == "HasRefType"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                LocationRefType _obj = CmdPrimary.ResolveForm(param[3]) as LocationRefType
                if _obj
                    result = _target.HasRefType(_obj) as int
                endif
            endif
		elseif _theAction == "IsActivateChild"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    result = _target.IsActivateChild(_obj) as int
                endif
            endif
		elseif _theAction == "IsFurnitureInUse"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                result = _target.IsFurnitureInUse(CmdPrimary.Resolve(param[3]) as int) as int
            endif
		elseif _theAction == "IsFurnitureMarkerInUse"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                result = _target.IsFurnitureMarkerInUse(CmdPrimary.Resolve(param[3]) as int, CmdPrimary.Resolve(param[4])) as int
            endif
		elseif _theAction == "IsInLocation"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Location _obj = CmdPrimary.ResolveForm(param[3]) as Location
                if _obj
                    result = _target.IsInLocation(_obj) as int
                endif
            endif
		elseif _theAction == "MoveToIfUnloaded"
            if ParamLengthEQ(CmdPrimary, param.Length, 7)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    result = _target.MoveToIfUnloaded(_obj, CmdPrimary.Resolve(param[4]) as float, CmdPrimary.Resolve(param[5]) as float, CmdPrimary.Resolve(param[6]) as float) as int
                endif
            endif
		elseif _theAction == "PlayAnimation"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                result = _target.PlayAnimation(CmdPrimary.Resolve(param[3])) as int
            endif
		elseif _theAction == "PlayAnimationAndWait"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                result = _target.PlayAnimationAndWait(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4])) as int
            endif
		elseif _theAction == "PlayGamebryoAnimation"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                result = _target.PlayGamebryoAnimation(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]) as int, CmdPrimary.Resolve(param[5]) as float) as int
            endif
		elseif _theAction == "PlayImpactEffect"
            if ParamLengthEQ(CmdPrimary, param.Length, 11)
                ImpactDataSet _obj = CmdPrimary.ResolveForm(param[3]) as ImpactDataSet
                if _obj
                    result = _target.PlayImpactEffect(_obj, CmdPrimary.Resolve(param[4]), CmdPrimary.Resolve(param[5]) as float, CmdPrimary.Resolve(param[6]) as float, CmdPrimary.Resolve(param[7]) as float, CmdPrimary.Resolve(param[8]) as float, CmdPrimary.Resolve(param[9]) as int, CmdPrimary.Resolve(param[10]) as int) as int
                endif
            endif
		elseif _theAction == "PlaySyncedAnimationAndWaitSS"
            if ParamLengthEQ(CmdPrimary, param.Length, 8)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[5]) as ObjectReference
                if _obj
                    result = _target.PlaySyncedAnimationAndWaitSS(CmdPrimary.Resolve(param[3]), CmdPrimary.Resolve(param[4]), _obj, CmdPrimary.Resolve(param[6]), CmdPrimary.Resolve(param[7])) as int
                endif
            endif
		elseif _theAction == "PlaySyncedAnimationSS"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[4]) as ObjectReference
                if _obj
                    result = _target.PlaySyncedAnimationSS(CmdPrimary.Resolve(param[3]), _obj, CmdPrimary.Resolve(param[5])) as int
                endif
            endif
		elseif _theAction == "RampRumble"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                result = _target.RampRumble(CmdPrimary.Resolve(param[3]) as float, CmdPrimary.Resolve(param[4]) as float, CmdPrimary.Resolve(param[5]) as float) as int
            endif
		elseif _theAction == "WaitForAnimationEvent"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                result = _target.WaitForAnimationEvent(CmdPrimary.Resolve(param[3])) as int
            endif
		elseif _theAction == "SetDisplayName"
            if ParamLengthGT(CmdPrimary, param.Length, 3)
                bool force
                if param.Length > 4
                    force = CmdPrimary.Resolve(param[4]) as int
                endif
                result = _target.SetDisplayName(CmdPrimary.Resolve(param[3]), force) as int
            endif
		elseif _theAction == "GetNthForm"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Form _obj = _target.GetNthForm(CmdPrimary.Resolve(param[3]) as int)
                if _obj
                    result = _obj.GetFormID()
                endif
            endif
            ;/
		elseif _theAction == "GetNthReferenceAlias"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ReferenceAlias _obj = _target.GetNthReferenceAlias(CmdPrimary.Resolve(param[3]) as int)
                if _obj
                    result = _obj.GetFormID()
                endif
            endif
            /;
		elseif _theAction == "PlaceActorAtMe"
            if ParamLengthGT(CmdPrimary, param.Length, 3)
                ActorBase _obj = CmdPrimary.ResolveForm(param[3]) as ActorBase
                if _obj
                    int aiLevelMod = 4
                    EncounterZone akZone
                    if param.Length > 4
                        aiLevelMod = CmdPrimary.Resolve(param[4]) as int
                        if param.Length > 5
                            akZone = CmdPrimary.ResolveForm(param[5]) as EncounterZone
                        endif
                    endif
                    Actor _actor = _target.PlaceActorAtMe(_obj, aiLevelMod, akZone)
                    if _actor
                        result = _actor.GetFormID()
                    endif
                endif
            endif
		elseif _theAction == "PlaceAtMe"
            if ParamLengthGT(CmdPrimary, param.Length, 3)
                Form _obj = CmdPrimary.ResolveForm(param[3])
                if _obj
                    int aiCount = 1
                    if param.Length > 4
                        aiCount = CmdPrimary.Resolve(param[4]) as int
                    endif
                    ObjectReference _placed = _target.PlaceAtMe(_obj, aiCount)
                    if _placed
                        result = _placed.GetFormID()
                    endif
                endif
            endif
		elseif _theAction == "GetLinkedRef"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Keyword _obj = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _obj
                    ObjectReference linkref = _target.GetLinkedRef(_obj)
                    if linkref
                        result = linkref.GetFormID()
                    endif
                endif
            endif
		elseif _theAction == "GetNthLinkedRef"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference linkref = _target.GetNthLinkedRef(CmdPrimary.Resolve(param[3]) as int)
                if linkref
                    result = linkref.GetFormID()
                endif
            endif
        else
            return _slt_form_dofunction(CmdPrimary, _target, _theAction, param)
        endif
    endif

    return result
endFunction

string Function _slt_actor_dofunction(sl_triggersCmd CmdPrimary, Actor _target, string _theAction, string[] param) global
    string result

    if _target && _theAction
        if _theAction == "AddShout"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Shout _obj = CmdPrimary.ResolveForm(param[3]) as Shout
                if _obj
				    result = _target.AddShout(_obj) as int
                endif
			endif
		elseif _theAction == "AddSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Spell _obj = CmdPrimary.ResolveForm(param[3]) as Spell
                if _obj
				    result = _target.AddSpell(_obj) as int
                endif
			endif
		elseif _theAction == "DispelSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Spell _obj = CmdPrimary.ResolveForm(param[3]) as Spell
                if _obj
				    result = _target.DispelSpell(_obj) as int
                endif
			endif
		elseif _theAction == "GetActorValue"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				result = _target.GetActorValue(CmdPrimary.Resolve(param[3]))
			endif
		elseif _theAction == "GetActorValuePercentage"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				result = _target.GetActorValuePercentage(CmdPrimary.Resolve(param[3]))
			endif
		elseif _theAction == "GetAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				result = _target.GetAV(CmdPrimary.Resolve(param[3]))
			endif
		elseif _theAction == "GetAVPercentage"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				result = _target.GetAVPercentage(CmdPrimary.Resolve(param[3]))
			endif
		elseif _theAction == "GetBaseActorValue"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				result = _target.GetBaseActorValue(CmdPrimary.Resolve(param[3]))
			endif
		elseif _theAction == "GetBaseAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				result = _target.GetBaseAV(CmdPrimary.Resolve(param[3]))
			endif
		elseif _theAction == "GetEquippedItemType"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				result = _target.GetEquippedItemType(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "GetFactionRank"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Faction _obj = CmdPrimary.ResolveForm(param[3]) as Faction
                if _obj
				    result = _target.GetFactionRank(_obj)
                endif
			endif
		elseif _theAction == "GetFactionReaction"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
				    result = _target.GetFactionReaction(_obj)
                endif
			endif
		elseif _theAction == "GetRelationshipRank"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
				    result = _target.GetRelationshipRank(_obj)
                endif
			endif
		elseif _theAction == "HasAssociation"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                AssociationType _assoc = CmdPrimary.ResolveForm(param[3]) as AssociationType
                if _assoc
                    Actor _obj = CmdPrimary.ResolveForm(param[4]) as Actor
                    if _obj
                        result = _target.HasAssociation(_assoc, _obj) as int
                    endif
                endif
			endif
		elseif _theAction == "HasFamilyRelationship"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
				    result = _target.HasFamilyRelationship(_obj) as int
                endif
			endif
		elseif _theAction == "HasLOS"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
				    result = _target.HasLOS(_obj) as int
                endif
			endif
		elseif _theAction == "HasMagicEffect"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                MagicEffect _obj = CmdPrimary.ResolveForm(param[3]) as MagicEffect
                if _obj
				    result = _target.HasMagicEffect(_obj) as int
                endif
			endif
		elseif _theAction == "HasMagicEffectWithKeyword"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Keyword _obj = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _obj
				    result = _target.HasMagicEffectWithKeyword(_obj) as int
                endif
			endif
		elseif _theAction == "HasParentRelationship"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
				    result = _target.HasParentRelationship(_obj) as int
                endif
			endif
		elseif _theAction == "HasPerk"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Perk _obj = CmdPrimary.ResolveForm(param[3]) as Perk
                if _obj
				    result = _target.HasPerk(_obj) as int
                endif
			endif
		elseif _theAction == "HasSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Spell _obj = CmdPrimary.ResolveForm(param[3]) as Spell
                if _obj
				    result = _target.HasSpell(_obj) as int
                endif
			endif
		elseif _theAction == "IsDetectedBy"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
				    result = _target.IsDetectedBy(_obj) as int
                endif
			endif
		elseif _theAction == "IsEquipped"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Form _obj = CmdPrimary.ResolveForm(param[3])
                if _obj
				    result = _target.IsEquipped(_obj) as int
                endif
			endif
		elseif _theAction == "IsHostileToActor"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
				    result = _target.IsHostileToActor(_obj) as int
                endif
			endif
		elseif _theAction == "IsInFaction"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Faction _obj = CmdPrimary.ResolveForm(param[3]) as Faction
                if _obj
				    result = _target.IsInFaction(_obj) as int
                endif
			endif
		elseif _theAction == "PathToReference"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
				    result = _target.PathToReference(_obj, CmdPrimary.Resolve(param[4]) as float) as int
                endif
			endif
		elseif _theAction == "PlayIdle"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Idle _obj = CmdPrimary.ResolveForm(param[3]) as Idle
                if _obj
				    result = _target.PlayIdle(_obj) as int
                endif
			endif
		elseif _theAction == "PlayIdleWithTarget"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Idle _obj = CmdPrimary.ResolveForm(param[3]) as Idle
                if _obj
                    ObjectReference _objref = CmdPrimary.ResolveForm(param[4]) as ObjectReference
                    if _objref
				        result = _target.PlayIdleWithTarget(_obj, _objref) as int
                    endif
                endif
			endif
		elseif _theAction == "RemoveShout"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Shout _obj = CmdPrimary.ResolveForm(param[3]) as Shout
                if _obj
				    result = _target.RemoveShout(_obj) as int
                endif
			endif
		elseif _theAction == "RemoveSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Spell _obj = CmdPrimary.ResolveForm(param[3]) as Spell
                if _obj
				    result = _target.RemoveSpell(_obj) as int
                endif
			endif
		elseif _theAction == "TrapSoul"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveForm(param[3]) as Actor
                if _obj
				    result = _target.TrapSoul(_obj) as int
                endif
			endif
		elseif _theAction == "WornHasKeyword"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Keyword _obj = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _obj
				    result = _target.WornHasKeyword(_obj) as int
                endif
			endif
		elseif _theAction == "GetActorValueMax"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				result = _target.GetActorValueMax(CmdPrimary.Resolve(param[3]))
			endif
		elseif _theAction == "GetAVMax"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				result = _target.GetAVMax(CmdPrimary.Resolve(param[3]))
			endif
		elseif _theAction == "GetEquippedItemId"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				result = _target.GetEquippedItemId(CmdPrimary.Resolve(param[3]) as int)
			endif
		elseif _theAction == "GetEquippedSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Spell _obj = _target.GetEquippedSpell(CmdPrimary.Resolve(param[3]) as int)
                if _obj
				    result = _obj.GetFormID()
                endif
			endif
		elseif _theAction == "GetEquippedWeapon"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Weapon _obj = _target.GetEquippedWeapon(CmdPrimary.Resolve(param[3]) as int)
                if _obj
				    result = _obj.GetFormID()
                endif
			endif
		elseif _theAction == "GetEquippedArmorInSlot"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Armor _obj = _target.GetEquippedArmorInSlot(CmdPrimary.Resolve(param[3]) as int)
                if _obj
				    result = _obj.GetFormID()
                endif
			endif
		elseif _theAction == "GetWornForm"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Form _obj = _target.GetWornForm(CmdPrimary.Resolve(param[3]) as int)
                if _obj
				    result = _obj.GetFormID()
                endif
			endif
		elseif _theAction == "GetEquippedObject"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Form _obj = _target.GetEquippedObject(CmdPrimary.Resolve(param[3]) as int)
                if _obj
				    result = _obj.GetFormID()
                endif
			endif
		elseif _theAction == "GetNthSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Spell _obj = _target.GetNthSpell(CmdPrimary.Resolve(param[3]) as int)
                if _obj
				    result = _obj.GetFormID()
                endif
			endif
        else
            return _slt_objectreference_dofunction(CmdPrimary, _target, _theAction, param)
        endif
    endif

    return result
endFunction

; sltname form_dofunction
; sltgrup Form
; sltdesc For the targeted Form, set $$ to the result of the specified function
; sltdesc 'Function' in this case specifically refers to functions that take one or more parameters and return a value
; sltdesc https://ck.uesp.net/wiki/Form_Script
; sltargs actor: target Form  (accepts special variable names ($self, $player) and both relative "Skyrim.esm:0f" and absolute "0f" values)
; sltargs function: function name
; sltargsmore HasKeywordString
; sltargsmore HasKeyword
; sltargsmore GetNthKeyword
; sltargsmore GetWorldModelNthTextureSet
function form_dofunction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string result

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Form _target = CmdPrimary.ResolveForm(param[1])
        if _target
            string _theAction = CmdPrimary.Resolve(param[2])

            if _theAction
                result = _slt_form_dofunction(CmdPrimary, _target, _theAction, param)
                if !result
                    SquawkFunctionError(CmdPrimary, "form_dofunction: unrecognized action(" + _theAction + ")")
                endif
            endif
        endif
    endif

    CmdPrimary.MostRecentResult = result

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname objectreference_dofunction
; sltgrup ObjectReference
; sltdesc For the targeted ObjectReference, set $$ to the result of the specified function
; sltdesc 'Function' in this case specifically refers to functions that take one or more parameters and return a value
; sltdesc https://ck.uesp.net/wiki/ObjectReference_Script
; sltargs actor: target ObjectReference  (accepts special variable names ($self, $player) and both relative "Skyrim.esm:0f" and absolute "0f" values)
; sltargs function: function name
; sltargsmore CalculateEncounterLevel
; sltargsmore CountLinkedRefChain
; sltargsmore GetAnimationVariableBool
; sltargsmore GetAnimationVariableFloat
; sltargsmore GetAnimationVariableInt
; sltargsmore GetDistance
; sltargsmore GetHeadingAngle
; sltargsmore GetItemCount
; sltargsmore HasEffectKeyword
; sltargsmore HasNode
; sltargsmore HasRefType
; sltargsmore IsActivateChild
; sltargsmore IsFurnitureInUse
; sltargsmore IsFurnitureMarkerInUse
; sltargsmore IsInLocation
; sltargsmore MoveToIfUnloaded
; sltargsmore PlayAnimation
; sltargsmore PlayAnimationAndWait
; sltargsmore PlayGamebryoAnimation
; sltargsmore PlayImpactEffect
; sltargsmore PlaySyncedAnimationAndWaitSS
; sltargsmore PlaySyncedAnimationSS
; sltargsmore RampRumble
; sltargsmore WaitForAnimationEvent
; sltargsmore SetDisplayName
; sltargsmore GetNthForm
; sltargsmore PlaceActorAtMe
; sltargsmore PlaceAtMe
; sltargsmore GetLinkedRef
; sltargsmore GetNthLinkedRef
function objectreference_dofunction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string result

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        ObjectReference _target = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        if _target
            string _theAction = CmdPrimary.Resolve(param[2])

            if _theAction
                result = _slt_objectreference_dofunction(CmdPrimary, _target, _theAction, param)
                if !result
                    SquawkFunctionError(CmdPrimary, "objectreference_dofunction: unrecognized action(" + _theAction + ")")
                endif
            endif
        endif
    endif

    CmdPrimary.MostRecentResult = result

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_dofunction
; sltgrup Actor
; sltdesc For the targeted Actor, set $$ to the result of the specified Function
; sltdesc 'Function' in this case specifically refers to functions that take one or more parameters and return a value
; sltdesc https://ck.uesp.net/wiki/Actor_Script
; sltargs actor: target Actor  (accepts special variable names ($self, $player) and both relative "Skyrim.esm:0f" and absolute "0f" values)
; sltargs function: function name
; sltargsmore AddShout
; sltargsmore AddSpell
; sltargsmore DispelSpell
; sltargsmore GetActorValue
; sltargsmore GetActorValuePercentage
; sltargsmore GetAV
; sltargsmore GetAVPercentage
; sltargsmore GetBaseActorValue
; sltargsmore GetBaseAV
; sltargsmore GetEquippedItemType
; sltargsmore GetFactionRank
; sltargsmore GetFactionReaction
; sltargsmore GetRelationshipRank
; sltargsmore HasAssociation
; sltargsmore HasFamilyRelationship
; sltargsmore HasLOS
; sltargsmore HasMagicEffect
; sltargsmore HasMagicEffectWithKeyword
; sltargsmore HasParentRelationship
; sltargsmore HasPerk
; sltargsmore HasSpell
; sltargsmore IsDetectedBy
; sltargsmore IsEquipped
; sltargsmore IsHostileToActor
; sltargsmore IsInFaction
; sltargsmore PathToReference
; sltargsmore PlayIdle
; sltargsmore PlayIdleWithTarget
; sltargsmore RemoveShout
; sltargsmore RemoveSpell
; sltargsmore TrapSoul
; sltargsmore WornHasKeyword
; sltargsmore GetActorValueMax
; sltargsmore GetAVMax
; sltargsmore GetEquippedItemId
; sltargsmore GetEquippedSpell
; sltargsmore GetEquippedWeapon
; sltargsmore GetEquippedArmorInSlot
; sltargsmore GetWornForm
; sltargsmore GetEquippedObject
; sltargsmore GetNthSpell
; sltsamp 
function actor_dofunction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string result

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Actor _target = CmdPrimary.ResolveForm(param[1]) as Actor
        if _target
            string _theAction = CmdPrimary.Resolve(param[2])

            if _theAction
                result = _slt_actor_dofunction(CmdPrimary, _target, _theAction, param)
                if !result
                    SquawkFunctionError(CmdPrimary, "actor_dofunction: unrecognized action(" + _theAction + ")")
                endif
            endif
        endif
    endif

    CmdPrimary.MostRecentResult = result

	CmdPrimary.CompleteOperationOnActor()
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
        ImageSpaceModifier thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[1])) as ImageSpaceModifier
    
        if thing
            thing.ApplyCrossFade(CmdPrimary.Resolve(param[2]) as float)
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
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
        Form thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[1]))
    
        if thing
            ImageSpaceModifier.RemoveCrossFade(CmdPrimary.Resolve(param[2]) as float)
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
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
        string ss1 = CmdPrimary.Resolve(param[1])
        string ss2
        if param.Length > 2
            ss2 = CmdPrimary.Resolve(param[2])
        endif
        float  p3
        if param.Length > 3
            p3 = CmdPrimary.Resolve(param[3]) as float
        endif
        
        CmdTargetActor.SendModEvent(ss1, ss2, p3)
    endif

	CmdPrimary.CompleteOperationOnActor()
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
        string eventName = CmdPrimary.Resolve(param[1])
        if eventName
            int eid = ModEvent.Create(eventName)
            
            if eid
                string typeId
                string ss
                
                int idxArg = 2 
                while idxArg + 1 < param.Length
                    typeId = CmdPrimary.Resolve(param[idxArg])
                    if typeId == "bool"
                        ss = CmdPrimary.Resolve(param[idxArg + 1])
                        if (ss as int)
                            ModEvent.PushBool(eid, true)
                        else
                            ModEvent.PushBool(eid, false)
                        endIf
                    elseif typeId == "int"
                        ss = CmdPrimary.Resolve(param[idxArg + 1])
                        ModEvent.PushInt(eid, ss as int)
                    elseif typeId == "float"
                        ss = CmdPrimary.Resolve(param[idxArg + 1])
                        ModEvent.PushFloat(eid, ss as float)
                    elseif typeId == "string"
                        ss = CmdPrimary.Resolve(param[idxArg + 1])
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

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
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

	CmdPrimary.CompleteOperationOnActor()
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
        string p1 = CmdPrimary.Resolve(param[1])
        
        if "IncrementStat" == p1
            string p2 = CmdPrimary.Resolve(param[2])
            int iModAmount
            if param.Length > 3
                iModAmount = CmdPrimary.Resolve(param[3]) as Int
            endif
            Game.IncrementStat(p2, iModAmount)
        elseIf "QueryStat" == p1
            string p2 = CmdPrimary.Resolve(param[2])
            CmdPrimary.MostRecentResult = Game.QueryStat(p2) as string
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
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
        Sound   thing = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[1])) as Sound
        Actor   _targetActor = CmdPrimary.ResolveActor(param[2])
        int     retVal
        if thing && _targetActor
            nextResult = thing.Play(_targetActor)
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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
        int    soundId = CmdPrimary.Resolve(param[1]) as int
        float  vol     = CmdPrimary.Resolve(param[2]) as float
        Sound.SetInstanceVolume(soundId, vol)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname snd_stop
; sltgrup Sound
; sltdesc Stops the audio specified by the sound instance handle (from snd_play)
; sltargs handle: sound instance handle from snd_play
; sltsamp snd_stop $1
function snd_stop(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        int    soundId = CmdPrimary.Resolve(param[1]) as int
        Sound.StopInstance(soundId)
    endif

	CmdPrimary.CompleteOperationOnActor()
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
                ss = CmdPrimary.Resolve(param[idx])
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

	CmdPrimary.CompleteOperationOnActor()
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
            int p1 = CmdPrimary.Resolve(param[2]) as Int
            int p2 = CmdPrimary.Resolve(param[3]) as Int
            int p3 = CmdPrimary.Resolve(param[4]) as Int
            
            sl_TriggersMfg.mfg_SetPhonemeModifier(_targetActor, p1, p2, p3)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
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
            int p1 = CmdPrimary.Resolve(param[2]) as Int
            int p2 = CmdPrimary.Resolve(param[3]) as Int
        
            nextResult = sl_TriggersMfg.mfg_GetPhonemeModifier(_targetActor, p1, p2)
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult as string

	CmdPrimary.CompleteOperationOnActor()
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
            ss = CmdPrimary.Resolve(param[idx])
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

	CmdPrimary.CompleteOperationOnActor()
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
        string pname = CmdPrimary.Resolve(param[1])
        string ptype = CmdPrimary.Resolve(param[2])
        string pkey  = CmdPrimary.Resolve(param[3])
        string pdef
        if param.Length > 4
            pdef = CmdPrimary.Resolve(param[4])
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

	CmdPrimary.CompleteOperationOnActor()
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
        string pname = CmdPrimary.Resolve(param[1])
        string ptype = CmdPrimary.Resolve(param[2])
        string pkey  = CmdPrimary.Resolve(param[3])
        string pdef  = CmdPrimary.Resolve(param[4])
    
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

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname json_save
; sltgrup JSON
; sltdesc Tells JsonUtil to immediately save the specified file from cache
; sltargs filename: name of file, rooted from 'Data/SKSE/Plugins/sl_triggers'
; sltsamp json_save "../somefolder/afile"
function json_save(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        string pname = CmdPrimary.Resolve(param[1])
        if pname
            JsonUtil.Save(pname)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
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
                suform = CmdPrimary.GetFormById(CmdPrimary.Resolve(param[2]))
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

	CmdPrimary.CompleteOperationOnActor()
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
        string ss1 = CmdPrimary.Resolve(param[1])
        
        if ss1 == "GetClassification"
            Weather curr = Weather.GetCurrentWeather()
            if curr
                nextResult = curr.GetClassification() as string
            endIf
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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
        string ss1 = CmdPrimary.Resolve(param[1])
        string ss2
        int    ii1
        float  ff1
        
        if ss1 == "asint"
            ss2 = CmdPrimary.Resolve(param[2])
            if ss2 
                ii1 = ss2 as int
            else
                ii1 = 0
            endIf
            nextResult = ii1 as string
        elseIf ss1 == "floor"
            ss1 = CmdPrimary.Resolve(param[2])
            ii1 = Math.floor(ss1 as float)
            nextResult = ii1 as string
        elseIf ss1 == "ceiling"
            ss1 = CmdPrimary.Resolve(param[2])
            ii1 = Math.Ceiling(ss1 as float)
            nextResult = ii1 as string
        elseIf ss1 == "abs"
            ss1 = CmdPrimary.Resolve(param[2])
            ff1 = Math.abs(ss1 as float)
            nextResult = ff1 as string
        elseIf ss1 == "toint"
            ss2 = CmdPrimary.Resolve(param[2])
            if ss2 && (StringUtil.GetNthChar(ss2, 0) == "0")
                ii1 = GlobalHexToInt(ss2)
            elseIf ss2
                ii1 = ss2 as int
            else 
                ii1 = 0
            endIf
            nextResult = ii1 as string
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname topicinfo_getresponsetext
; sltgrup TopicInfo
; sltdesc Attempts to return a single response text associated with the provided TopicInfo (by editorID or FormID)
; sltdesc Note: This is more beta than normal; it isn't obvious whether in some cases multiple strings should actually be returned.
; sltargs topicinfo: <formID> or <editorID> for the desired TopicInfo (not Topic)
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

    CmdPrimary.MostRecentResult = responsetext

	CmdPrimary.CompleteOperationOnActor()
endFunction
