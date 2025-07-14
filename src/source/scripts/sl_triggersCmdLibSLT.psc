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

Function echo_back_test(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    SLTDebugMsg("echo_back_test: start")

    string arg1 = param[1]

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        arg1 = CmdPrimary.ResolveString(param[1])

        if arg1 == "true"
            CmdPrimary.MostRecentBoolResult = true
        elseif arg1 == "false"
            CmdPrimary.MostRecentBoolResult = false
        else
            string literalNumeric = sl_triggers.GetNumericLiteral(arg1)
            if "invalid" != literalNumeric
                string[] numlitinfo = PapyrusUtil.StringSplit(literalNumeric, ":")
                if !numlitinfo || numlitinfo.Length != 2
                    CmdPrimary.MostRecentStringResult = arg1
                elseif numlitinfo[0] == "int"
                    CmdPrimary.MostRecentIntResult = numlitinfo[1] as int
                elseif numlitinfo[1] == "float"
                    CmdPrimary.MostRecentFloatResult = numlitinfo[1] as float
                endif
            else
                CmdPrimary.MostRecentStringResult = arg1
            endif
        endif
    endif

    SLTDebugMsg("echo_back_test: finish param[1](" + param[1] + ") resolved to(" + arg1 + ") type(" + CmdPrimary.SLT.RT_ToString(CmdPrimary.MostRecentResultType) + ")")

	CmdPrimary.CompleteOperationOnActor()
endFunction

; HAVE TO FIX THE STRING PARAM TO STRING[] PARAM BEFORE YOU CAN USE THIS
function validate_get_numeric_literal(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    SLTDebugMsg("validate_get_numeric_literal begin")

    string literal
    string literalResultCode

    literal = "10"
    literalResultCode = sl_triggers.GetNumericLiteral(literal)
    SLTDebugMsg("testing GetLiteral(" + literal + ") == (" + literalResultCode + ") <int:10>")

    literal = "010"
    literalResultCode = sl_triggers.GetNumericLiteral(literal)
    SLTDebugMsg("testing GetLiteral(" + literal + ") == (" + literalResultCode + ") <int:10>")

    literal = "0x10"
    literalResultCode = sl_triggers.GetNumericLiteral(literal)
    SLTDebugMsg("testing GetLiteral(" + literal + ") == (" + literalResultCode + ") <int:16>")

    literal = "10.0"
    literalResultCode = sl_triggers.GetNumericLiteral(literal)
    SLTDebugMsg("testing GetLiteral(" + literal + ") == (" + literalResultCode + ") <float:10>")

    literal = "010.0"
    literalResultCode = sl_triggers.GetNumericLiteral(literal)
    SLTDebugMsg("testing GetLiteral(" + literal + ") == (" + literalResultCode + ") <float:10>")

    literal = "0x10.0"
    literalResultCode = sl_triggers.GetNumericLiteral(literal)
    SLTDebugMsg("testing GetLiteral(" + literal + ") == (" + literalResultCode + ") <invalid>")

    literal = "true"
    literalResultCode = sl_triggers.GetNumericLiteral(literal)
    SLTDebugMsg("testing GetLiteral(" + literal + ") == (" + literalResultCode + ") <invalid>")

    literal = "false"
    literalResultCode = sl_triggers.GetNumericLiteral(literal)
    SLTDebugMsg("testing GetLiteral(" + literal + ") == (" + literalResultCode + ") <invalid>")

    literal = ""
    literalResultCode = sl_triggers.GetNumericLiteral(literal)
    SLTDebugMsg("testing GetLiteral(" + literal + ") == (" + literalResultCode + ") <invalid>")

    literal = "ff"
    literalResultCode = sl_triggers.GetNumericLiteral(literal)
    SLTDebugMsg("testing GetLiteral(" + literal + ") == (" + literalResultCode + ") <invalid>")

    literal = "0xFF"
    literalResultCode = sl_triggers.GetNumericLiteral(literal)
    SLTDebugMsg("testing GetLiteral(" + literal + ") == (" + literalResultCode + ") <int:255>")
    
    SLTDebugMsg("validate_get_numeric_literal end")

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
            darr[i] = CmdPrimary.ResolveString(param[i])
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
            darr[i] = CmdPrimary.ResolveString(param[i])
            i += 1
        endwhile
        string msg = PapyrusUtil.StringJoin(darr, "")
        Debug.Notification(msg)
        SLTInfoMsg(msg)
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

    Form outcome

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        outcome = CmdPrimary.ResolveForm(param[1])
    endif

    CmdPrimary.MostRecentFormResult = outcome

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
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltargs amount: amount to damage
; sltsamp av_damage $self Health 100
; sltsamp av_damage $self   $3   100 ;where $3 might be "Health"
; sltrslt Damages Health by 100. This can result in death.
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
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltargs amount: amount to modify by
; sltsamp av_mod $self Health 100
; sltsamp av_mod $self   $3   100 ;where $3 might be "Health"
; sltrslt Changes the max value of the actor value. Not the same as restore/damage.
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
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltargs amount: amount to modify by
; sltsamp av_set $self Health 100
; sltsamp av_set $self   $3   100 ;where $3 might be "Health"
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
; sltdesc Sets $$ to the actor's base value for the specified Actor Value
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltsamp av_getbase $self Health
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
; sltdesc Set $$ to the actor's current value for the specified Actor Value
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltsamp av_get $self Health
; sltrslt Sets the actor's current Health into $$
function av_get(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])

        if _targetActor
            nextResult = _targetActor.GetActorValue(CmdPrimary.ResolveString(param[2]))
        endif
    endif

    CmdPrimary.MostRecentFloatResult = nextResult

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
; sltdesc Set $$ to the actor's value as a percentage of max for the specified Actor Value
; sltargs actor: target Actor
; sltargs av name: Actor Value name e.g. Health
; sltsamp av_getpercentage $self Health
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
; sltargs spell: SPEL FormID
; sltargs actor: target Actor
; sltsamp spell_cast "skyrim.esm:275236" $self
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
; sltargs spell: SPEL FormId
; sltargs actor: target Actor
; sltsamp spell_dcsa "skyrim.esm:275236" $self
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
; sltargs spell: SPEL FormId
; sltargs actor: target Actor
; sltsamp spell_dispel "skyrim.esm:275236" $self
; sltrslt If light was currently on $self, it would now be dispelled
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
; sltargs spell: SPEL FormId
; sltargs actor: target Actor
; sltsamp spell_add "skyrim.esm:275236" $self
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
; sltargs spell: SPEL FormId
; sltargs actor: target Actor
; sltsamp spell_remove "skyrim.esm:275236" $self
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
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltargs count: number (optional: default 1)
; sltargs displaymessage: 0 - show message | 1 - silent (optional: default 0 - show message)
; sltsamp item_addex $self "skyrim.esm:15" 10 0
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
        Form thing = CmdPrimary.ResolveForm(param[2])
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])

            if _targetActor
                int count = CmdPrimary.ResolveInt(param[3])
                bool isSilent = false
                if param.Length > 4
                    isSilent = CmdPrimary.ResolveBool(param[4])
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
        Form thing = CmdPrimary.ResolveForm(param[2])
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            if _targetActor
                int slotId = CmdPrimary.ResolveInt(param[3])
                bool isSilent = CmdPrimary.ResolveBool(param[4])
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
; sltdesc Set $$ to how many of a specified item an actor has
; sltargs actor: target Actor
; sltargs item: ITEM FormId
; sltsamp item_getcount $self "skyrim.esm:15"
function item_getcount(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form thing = CmdPrimary.ResolveForm(param[2])
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            if _targetActor
                nextResult = _targetActor.GetItemCount(thing)
            else
                CmdPrimary.SFE("unable to resolve actor variable (" + param[1] + ")")
            endif
        else
            CmdPrimary.SFE("unable to resolve ITEM with FormId (" + param[2] + ")")
        endif
    endif

    CmdPrimary.MostRecentIntResult = nextResult

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
            darr[i] = CmdPrimary.ResolveString(param[i])
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
        nextResult = CmdPrimary.ResolveString(param[idx])
    endif

    CmdPrimary.MostRecentStringResult = nextResult

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

    int nextResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        nextResult = Utility.RandomInt(CmdPrimary.ResolveInt(param[1]), CmdPrimary.ResolveInt(param[2]))
    endif

    CmdPrimary.MostRecentIntResult = nextResult

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
; sltargs duration: float, seconds
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
; sltdesc Sets $iterActor to a random actor within specified range of self
; sltargs range: 0 - all | >0 skyrim units
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
; sltargs perkpointcount: number of perk points to add
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
; sltargs perk: PERK FormID
; sltargs actor: target Actor
; sltsamp perk_add "skyrim.esm:12384" $self
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
; sltargs perk: PERK FormID
; sltargs actor: target Actor
; sltsamp perk_remove "skyrim.esm:12384" $self
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
; sltargs actor: target Actor
; sltargs skill: skillname e.g. Alteration, Destruction
; sltargs value: number
; sltsamp actor_advskill $self Alteration 1
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
; sltdesc Increase targeted actor's skill by specified amount
; sltargs actor: target Actor
; sltargs skill: skillname e.g. Alteration, Destruction
; sltargs value: number
; sltsamp actor_incskill $self Alteration 1
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
; sltdesc Set $$ to 1 if first actor can see second actor, 0 if not.
; sltargs first actor: target Actor
; sltargs second actor: target Actor
; sltsamp actor_haslos $actor $self
; sltsamp if $$ = 0 cannotseeme
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
; sltdesc Set $$ to the actor name
; sltargs actor: target Actor
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
; sltdesc Set $$ to the actor displayName
; sltargs actor: target Actor
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
; sltargs actor: target Actor
; sltargs bounty: number
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
; sltargs actor: target Actor
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
; sltdesc Sets $$ to 1 if actor is guard, 0 otherwise.
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
; sltdesc Sets $$ to the actor's gender, 0 - male, 1 - female, 2 - creature, "" otherwise
; sltargs actor: target Actor
; sltsamp actor_getgender $actor
function actor_getgender(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult

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
; sltargs actor: target Actor
; sltargs topic: TOPIC FormID
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
; sltdesc Sets $$ to 1 if actor has the keyword, 0 otherwise.
; sltargs actor: target Actor
; sltargs keyword: string, keyword name
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
; sltdesc Sets $$ to 1 if actor is wearing the armor indicated by the FormId, 0 otherwise.
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
; sltdesc Sets $$ to the 'scale' value of the specified Actor
; sltdesc Note: this is properly a function of ObjectReference, so may get pushed to a different group at some point
; sltargs actor: target Actor
; sltsamp actor_getscale $self
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
; sltargs actor: target Actor
; sltargs scale: float, new scale value to replace the old
; sltsamp actor_setscale $self 1.01
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
; sltdesc Sets $$ to 1 if actor is wearing armor in the indicated slotId, 0 otherwise.
; sltargs actor: target Actor
; sltargs armorslot: number, e.g. 32 for body slot
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
; sltdesc Sets $$ to 1 if actor is wearing any armor with indicated keyword, 0 otherwise.
; sltargs actor: target Actor
; sltargs keyword: string, keyword name
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
; sltdesc Sets $$ to 1 if actor's current location has the indicated keyword, 0 otherwise.
; sltargs actor: target Actor
; sltargs keyword: string, keyword name
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
; sltargs first actor: target Actor
; sltargs second actor: target Actor
; sltargs rank: number
; sltsamp actor_setrelation $actor $player 0
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
; sltdesc Sets $$ to 1 if actor is in the faction indicated by the FormId, 0 otherwise
; sltargs actor: target Actor
; sltargs faction: FACTION FormID
; sltsamp actor_infaction $actor "skyrim.esm:378958"
; sltrslt $$ will be 1 if $actor is a follower (CurrentFollowerFaction)
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
; sltdesc Sets $$ to the actor's rank in the faction indicated by the FormId
; sltargs actor: target Actor
; sltargs faction: FACTION FormID
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
; sltargs actor: target Actor
; sltargs faction: FACTION FormID
; sltargs rank: number
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
; sltdesc Sets $$ to 1 if the specified actor is currently affected by the MGEF or SPEL indicated by FormID (accepts either)
; sltargs actor: target Actor
; sltargs (optional) "ALL": if specified, all following MGEF or SPEL FormIDs must be found on the target Actor
; sltargs magic effect or spell: MGEF or SPEL FormID [<MGEF or SPEL FormID> <MGEF or SPEL FormID> ...]
; sltsamp actor_isaffectedby $actor "skyrim.esm:1030541"
; sltsamp actor_isaffectedby $actor "skyrim.esm:1030541" "skyrim.esm:1030542" "skyrim.esm:1030543"
; sltsamp actor_isaffectedby $actor ALL "skyrim.esm:1030541" "skyrim.esm:1030542" "skyrim.esm:1030543"
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
; sltargs actor: target Actor
; sltargs faction: FACTION FormID
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
; sltargs actor: target Actor
; sltargs animation: animation name
; sltsamp actor_playanim $self "IdleChildCryingStart"
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

; sltname actor_race
; sltgrup Actor
; sltdesc Sets $$ to the race name based on sub-function. Blank, empty sub-function returns Vanilla racenames. e.g. "SL" can return SexLab race keynames.
; sltargs actor: target Actor
; sltargs sub-function: sub-function
; sltargsmore if parameter 2 is "": return actors race name. Skyrims, original name. Like: "Nord", "Breton"
; sltsamp actor_race $self ""
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
; sltargs actor: target Actor
; sltargs alpha: 0.0 to 1.0 (higher is more visible)
; sltargs fade: 0 - instance | 1 - fade to the new alpha gradually (optional: default 1 - fade)
; sltsamp actor_setalpha $self 0.5 1 
; sltrslt $self will fade to new alpha of 0.5, not instantly
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
; sltsamp form_doaction $system.self StopCombat
function form_doaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form _target = CmdPrimary.ResolveForm(param[1])
        if _target
            string _theAction = CmdPrimary.ResolveString(param[2])

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
; sltsamp objectreference_doaction $system.self StopCombat
function objectreference_doaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        ObjectReference _target = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        if _target
            string _theAction = CmdPrimary.ResolveString(param[2])

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
; sltargs actor: target Actor
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
; sltsamp actor_doaction $system.self StopCombat
function actor_doaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _target = CmdPrimary.ResolveActor(param[1])
        if _target
            string _theAction = CmdPrimary.ResolveString(param[2])

            if _theAction
                if !_slt_actor_doaction(CmdPrimary, _target, _theAction)
                    SquawkFunctionError(CmdPrimary, "actor_doaction: unrecognized action(" + _theAction + ")")
                endif
            endif
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction


bool function _slt_form_dogetter(sl_triggersCmd CmdPrimary, Form _target, string _theAction) global
    if _target && _theAction
        if _theAction == "GetFormID"
            CmdPrimary.MostRecentIntResult = _target.GetFormID()
        elseif _theAction == "GetGoldValue"
            CmdPrimary.MostRecentIntResult = _target.GetGoldValue()
        elseif _theAction == "PlayerKnows"
            CmdPrimary.MostRecentBoolResult = _target.PlayerKnows()
        elseif _theAction == "GetType"
            CmdPrimary.MostRecentIntResult = _target.GetType()
        elseif _theAction == "GetName"
            CmdPrimary.MostRecentStringResult = _target.GetName()
        elseif _theAction == "GetWeight"
            CmdPrimary.MostRecentFloatResult = _target.GetWeight()
        elseif _theAction == "GetNumKeywords"
            CmdPrimary.MostRecentIntResult = _target.GetNumKeywords()
        elseif _theAction == "IsPlayable"
            CmdPrimary.MostRecentBoolResult = _target.IsPlayable()
        elseif _theAction == "HasWorldModel"
            CmdPrimary.MostRecentBoolResult = _target.HasWorldModel()
        elseif _theAction == "GetWorldModelPath"
            CmdPrimary.MostRecentStringResult = _target.GetWorldModelPath()
        elseif _theAction == "GetWorldModelNumTextureSets"
            CmdPrimary.MostRecentIntResult = _target.GetWorldModelNumTextureSets()
        elseif _theAction == "TempClone"
            CmdPrimary.MostRecentFormResult = _target.TempClone()
        else
            return false
        endif
        return true
    endIf

    return false
endFunction

bool function _slt_objectreference_dogetter(sl_triggersCmd CmdPrimary, ObjectReference _target, string _theAction) global
    if _target && _theAction
        if _theAction == "CanFastTravelToMarker"
            CmdPrimary.MostRecentBoolResult = _target.CanFastTravelToMarker()
        elseif _theAction == "GetActorOwner"
            CmdPrimary.MostRecentFormResult = _target.GetActorOwner()
        elseif _theAction == "GetAngleX"
            CmdPrimary.MostRecentFloatResult = _target.GetAngleX()
        elseif _theAction == "GetAngleY"
            CmdPrimary.MostRecentFloatResult = _target.GetAngleY()
        elseif _theAction == "GetAngleZ"
            CmdPrimary.MostRecentFloatResult = _target.GetAngleZ()
        elseif _theAction == "GetBaseObject"
            CmdPrimary.MostRecentFormResult = _target.GetBaseObject()
        elseif _theAction == "GetCurrentDestructionStage"
            CmdPrimary.MostRecentIntResult = _target.GetCurrentDestructionStage()
        elseif _theAction == "GetCurrentLocation"
            CmdPrimary.MostRecentFormResult = _target.GetCurrentLocation()
        elseif _theAction == "GetCurrentScene"
            CmdPrimary.MostRecentFormResult = _target.GetCurrentScene()
        elseif _theAction == "GetEditorLocation"
            CmdPrimary.MostRecentFormResult = _target.GetEditorLocation()
        elseif _theAction == "GetFactionOwner"
            CmdPrimary.MostRecentFormResult = _target.GetFactionOwner()
        elseif _theAction == "GetHeight"
            CmdPrimary.MostRecentFloatResult = _target.GetHeight()
        elseif _theAction == "GetItemHealthPercent"
            CmdPrimary.MostRecentFloatResult = _target.GetItemHealthPercent()
        elseif _theAction == "GetKey"
            CmdPrimary.MostRecentFormResult = _target.GetKey()
        elseif _theAction == "GetLength"
            CmdPrimary.MostRecentFloatResult = _target.GetLength()
        elseif _theAction == "GetLockLevel"
            CmdPrimary.MostRecentIntResult = _target.GetLockLevel()
        elseif _theAction == "GetMass"
            CmdPrimary.MostRecentFloatResult = _target.GetMass()
        elseif _theAction == "GetOpenState"
            CmdPrimary.MostRecentIntResult = _target.GetOpenState()
        elseif _theAction == "GetParentCell"
            CmdPrimary.MostRecentFormResult = _target.GetParentCell()
        elseif _theAction == "GetPositionX"
            CmdPrimary.MostRecentFloatResult = _target.GetPositionX()
        elseif _theAction == "GetPositionY"
            CmdPrimary.MostRecentFloatResult = _target.GetPositionY()
        elseif _theAction == "GetPositionZ"
            CmdPrimary.MostRecentFloatResult = _target.GetPositionZ()
        elseif _theAction == "GetScale"
            CmdPrimary.MostRecentFloatResult = _target.GetScale()
        elseif _theAction == "GetTriggerObjectCount"
            CmdPrimary.MostRecentIntResult = _target.GetTriggerObjectCount()
        elseif _theAction == "GetVoiceType"
            CmdPrimary.MostRecentFormResult = _target.GetVoiceType()
        elseif _theAction == "GetWidth"
            CmdPrimary.MostRecentFloatResult = _target.GetWidth()
        elseif _theAction == "GetWorldSpace"
            CmdPrimary.MostRecentFormResult = _target.GetWorldSpace()
        elseif _theAction == "IsActivationBlocked"
            CmdPrimary.MostRecentBoolResult = _target.IsActivationBlocked()
        elseif _theAction == "Is3DLoaded"
            CmdPrimary.MostRecentBoolResult = _target.Is3DLoaded()
        elseif _theAction == "IsDeleted"
            CmdPrimary.MostRecentBoolResult = _target.IsDeleted()
        elseif _theAction == "IsDisabled"
            CmdPrimary.MostRecentBoolResult = _target.IsDisabled()
        elseif _theAction == "IsEnabled"
            CmdPrimary.MostRecentBoolResult = _target.IsEnabled()
        elseif _theAction == "IsIgnoringFriendlyHits"
            CmdPrimary.MostRecentBoolResult = _target.IsIgnoringFriendlyHits()
        elseif _theAction == "IsInDialogueWithPlayer"
            CmdPrimary.MostRecentBoolResult = _target.IsInDialogueWithPlayer()
        elseif _theAction == "IsInInterior"
            CmdPrimary.MostRecentBoolResult = _target.IsInInterior()
        elseif _theAction == "IsLocked"
            CmdPrimary.MostRecentBoolResult = _target.IsLocked()
        elseif _theAction == "IsMapMarkerVisible"
            CmdPrimary.MostRecentBoolResult = _target.IsMapMarkerVisible()
        elseif _theAction == "IsNearPlayer"
            CmdPrimary.MostRecentBoolResult = _target.IsNearPlayer()
        elseif _theAction == "GetNumItems"
            CmdPrimary.MostRecentIntResult = _target.GetNumItems()
        elseif _theAction == "GetTotalItemWeight"
            CmdPrimary.MostRecentFloatResult = _target.GetTotalItemWeight()
        elseif _theAction == "GetTotalArmorWeight"
            CmdPrimary.MostRecentFloatResult = _target.GetTotalArmorWeight()
        elseif _theAction == "IsHarvested"
            CmdPrimary.MostRecentBoolResult = _target.IsHarvested()
        elseif _theAction == "GetItemMaxCharge"
            CmdPrimary.MostRecentFloatResult = _target.GetItemMaxCharge()
        elseif _theAction == "GetItemCharge"
            CmdPrimary.MostRecentFloatResult = _target.GetItemCharge()
        elseif _theAction == "IsOffLimits"
            CmdPrimary.MostRecentBoolResult = _target.IsOffLimits()
        elseif _theAction == "GetDisplayName"
            CmdPrimary.MostRecentStringResult = _target.GetDisplayName()
        elseif _theAction == "GetEnableParent"
            CmdPrimary.MostRecentFormResult = _target.GetEnableParent()
        elseif _theAction == "GetEnchantment"
            CmdPrimary.MostRecentFormResult = _target.GetEnchantment()
        elseif _theAction == "GetNumReferenceAliases"
            CmdPrimary.MostRecentIntResult = _target.GetNumReferenceAliases()
        else
            return _slt_form_dogetter(CmdPrimary, _target, _theAction)
        endif
        return true
    endIf

    return false
endFunction

bool function _slt_actor_dogetter(sl_triggersCmd CmdPrimary, Actor _target, string _theAction) global
    if _target && _theAction
        if _theAction == "CanFlyHere"
            CmdPrimary.MostRecentBoolResult = _target.CanFlyHere()
        elseif _theAction == "Dismount"
            CmdPrimary.MostRecentBoolResult = _target.Dismount()
        elseif _theAction == "GetActorBase"
            CmdPrimary.MostRecentFormResult = _target.GetActorBase()
        elseif _theAction == "GetBribeAmount"
            CmdPrimary.MostRecentIntResult = _target.GetBribeAmount()
        elseif _theAction == "GetCrimeFaction"
            CmdPrimary.MostRecentFormResult = _target.GetCrimeFaction()
        elseif _theAction == "GetCombatState"
            CmdPrimary.MostRecentIntResult = _target.GetCombatState()
        elseif _theAction == "GetCombatTarget"
            CmdPrimary.MostRecentFormResult = _target.GetCombatTarget()
        elseif _theAction == "GetCurrentPackage"
            CmdPrimary.MostRecentFormResult = _target.GetCurrentPackage()
        elseif _theAction == "GetDialogueTarget"
            CmdPrimary.MostRecentFormResult = _target.GetDialogueTarget()
        elseif _theAction == "GetEquippedShield"
            CmdPrimary.MostRecentFormResult = _target.GetEquippedShield()
        elseif _theAction == "GetEquippedShout"
            CmdPrimary.MostRecentFormResult = _target.GetEquippedShout()
        elseif _theAction == "GetFlyingState"
            CmdPrimary.MostRecentIntResult = _target.GetFlyingState()
        elseif _theAction == "GetForcedLandingMarker"
            CmdPrimary.MostRecentFormResult = _target.GetForcedLandingMarker()
        elseif _theAction == "GetGoldAmount"
            CmdPrimary.MostRecentIntResult = _target.GetGoldAmount()
        elseif _theAction == "GetHighestRelationshipRank"
            CmdPrimary.MostRecentIntResult = _target.GetHighestRelationshipRank()
        elseif _theAction == "GetKiller"
            CmdPrimary.MostRecentFormResult = _target.GetKiller()
        elseif _theAction == "GetLevel"
            CmdPrimary.MostRecentIntResult = _target.GetLevel()
        elseif _theAction == "GetLeveledActorBase"
            CmdPrimary.MostRecentFormResult = _target.GetLeveledActorBase()
        elseif _theAction == "GetLightLevel"
            CmdPrimary.MostRecentFloatResult = _target.GetLightLevel()
        elseif _theAction == "GetLowestRelationshipRank"
            CmdPrimary.MostRecentIntResult = _target.GetLowestRelationshipRank()
        elseif _theAction == "GetNoBleedoutRecovery"
            CmdPrimary.MostRecentBoolResult = _target.GetNoBleedoutRecovery()
        elseif _theAction == "GetPlayerControls"
            CmdPrimary.MostRecentBoolResult = _target.GetPlayerControls()
        elseif _theAction == "GetRace"
            CmdPrimary.MostRecentFormResult = _target.GetRace()
        elseif _theAction == "GetSitState"
            CmdPrimary.MostRecentIntResult = _target.GetSitState()
        elseif _theAction == "GetSleepState"
            CmdPrimary.MostRecentIntResult = _target.GetSleepState()
        elseif _theAction == "GetVoiceRecoveryTime"
            CmdPrimary.MostRecentFloatResult = _target.GetVoiceRecoveryTime()
        elseif _theAction == "IsAlarmed"
            CmdPrimary.MostRecentBoolResult = _target.IsAlarmed() 
        elseif _theAction == "IsAlerted"
            CmdPrimary.MostRecentBoolResult = _target.IsAlerted() 
        elseif _theAction == "IsAllowedToFly"
            CmdPrimary.MostRecentBoolResult = _target.IsAllowedToFly()
        elseif _theAction == "IsArrested"
            CmdPrimary.MostRecentBoolResult = _target.IsArrested() 
        elseif _theAction == "IsArrestingTarget"
            CmdPrimary.MostRecentBoolResult = _target.IsArrestingTarget()
        elseif _theAction == "IsBeingRidden"
            CmdPrimary.MostRecentBoolResult = _target.IsBeingRidden()
        elseif _theAction == "IsBleedingOut"
            CmdPrimary.MostRecentBoolResult = _target.IsBleedingOut()
        elseif _theAction == "IsBribed"
            CmdPrimary.MostRecentBoolResult = _target.IsBribed()
        elseif _theAction == "IsChild"
            CmdPrimary.MostRecentBoolResult = _target.IsChild() 
        elseif _theAction == "IsCommandedActor"
            CmdPrimary.MostRecentBoolResult = _target.IsCommandedActor()
        elseif _theAction == "IsDead"
            CmdPrimary.MostRecentBoolResult = _target.IsDead() 
        elseif _theAction == "IsDoingFavor"
            CmdPrimary.MostRecentBoolResult = _target.IsDoingFavor()
        elseif _theAction == "IsEssential"
            CmdPrimary.MostRecentBoolResult = _target.IsEssential() 
        elseif _theAction == "IsFlying"
            CmdPrimary.MostRecentBoolResult = _target.IsFlying()
        elseif _theAction == "IsGhost"
            CmdPrimary.MostRecentBoolResult = _target.IsGhost()
        elseif _theAction == "IsGuard"
            CmdPrimary.MostRecentBoolResult = _target.IsGuard() 
        elseif _theAction == "IsInCombat"
            CmdPrimary.MostRecentBoolResult = _target.IsInCombat() 
        elseif _theAction == "IsInKillMove"
            CmdPrimary.MostRecentBoolResult = _target.IsInKillMove() 
        elseif _theAction == "IsIntimidated"
            CmdPrimary.MostRecentBoolResult = _target.IsIntimidated()
        elseif _theAction == "IsOnMount"
            CmdPrimary.MostRecentBoolResult = _target.IsOnMount() 
        elseif _theAction == "IsPlayersLastRiddenHorse"
            CmdPrimary.MostRecentBoolResult = _target.IsPlayersLastRiddenHorse()
        elseif _theAction == "IsPlayerTeammate"
            CmdPrimary.MostRecentBoolResult = _target.IsPlayerTeammate()
        elseif _theAction == "IsRunning"
            CmdPrimary.MostRecentBoolResult = _target.IsRunning()
        elseif _theAction == "IsSneaking"
            CmdPrimary.MostRecentBoolResult = _target.IsSneaking()
        elseif _theAction == "IsSprinting"
            CmdPrimary.MostRecentBoolResult = _target.IsSprinting()
        elseif _theAction == "IsTrespassing"
            CmdPrimary.MostRecentBoolResult = _target.IsTrespassing()
        elseif _theAction == "IsUnconscious"
            CmdPrimary.MostRecentBoolResult = _target.IsUnconscious()
        elseif _theAction == "IsWeaponDrawn"
            CmdPrimary.MostRecentBoolResult = _target.IsWeaponDrawn()
        elseif _theAction == "GetSpellCount"
            CmdPrimary.MostRecentIntResult = _target.GetSpellCount()
        elseif _theAction == "IsAIEnabled"
            CmdPrimary.MostRecentBoolResult = _target.IsAIEnabled()
        elseif _theAction == "IsSwimming"
            CmdPrimary.MostRecentBoolResult = _target.IsSwimming()
        elseif _theAction == "WillIntimidateSucceed"
            CmdPrimary.MostRecentBoolResult = _target.WillIntimidateSucceed()
        elseif _theAction == "IsOverEncumbered"
            CmdPrimary.MostRecentBoolResult = _target.IsOverEncumbered()
        elseif _theAction == "GetWarmthRating"
            CmdPrimary.MostRecentFloatResult = _target.GetWarmthRating()
        else
            return _slt_objectreference_dogetter(CmdPrimary, _target, _theAction)
        endif
        return true
    endIf

    return false
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
; sltsamp form_dogetter $system.self IsPlayable
; sltsamp if $$ = 1 itwasplayable
function form_dogetter(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form _target = CmdPrimary.ResolveForm(param[1])
        
        if _target
            string _theAction = CmdPrimary.ResolveString(param[2])

            if _theAction
                if !_slt_form_dogetter(CmdPrimary, _target, _theAction)
                    SquawkFunctionError(CmdPrimary, "form_dogetter: action returned empty string result, possibly a problem(" + _theAction + ")")
                endif
            endif
        endIf
    endif

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
; sltsamp objectreference_dogetter $system.self CanFlyHere
; sltsamp if $$ = 1 ICanFlyAroundHere
; sltsamp if $$ = 0 IAmGroundedLikeAlways
function objectreference_dogetter(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        ObjectReference _target = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        
        if _target
            string _theAction = CmdPrimary.ResolveString(param[2])

            if _theAction
                if !_slt_objectreference_dogetter(CmdPrimary, _target, _theAction)
                    SquawkFunctionError(CmdPrimary, "objectreference_dogetter: action returned empty string result, possibly a problem(" + _theAction + ")")
                endif
            endif
        endIf
    endif

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
; sltsamp actor_dogetter $system.self CanFlyHere
; sltsamp if $$ = 1 ICanFlyAroundHere
; sltsamp if $$ = 0 IAmGroundedLikeAlways
function actor_dogetter(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _target = CmdPrimary.ResolveActor(param[1])
        
        if _target
            string _theAction = CmdPrimary.ResolveString(param[2])

            if _theAction
                if !_slt_actor_dogetter(CmdPrimary, _target, _theAction)
                    SquawkFunctionError(CmdPrimary, "actor_dogetter: action returned empty string result, possibly a problem(" + _theAction + ")")
                endif
            endif
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction


bool function _slt_form_doconsumer(sl_triggersCmd CmdPrimary, Form _target, string _theAction, string[] param) global
    if _target && _theAction
        if _theAction == "SetPlayerKnows"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetPlayerKnows(CmdPrimary.ResolveBool(param[3]))
            endif
        elseif _theAction == "SetWorldModelPath"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetWorldModelPath(CmdPrimary.ResolveString(param[3]))
            endif
        elseif _theAction == "SetName"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetName(CmdPrimary.ResolveString(param[3]))
            endif
        elseif _theAction == "SetWeight"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetWeight(CmdPrimary.ResolveFloat(param[3]))
            endif
        elseif _theAction == "SetGoldValue"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetGoldValue(CmdPrimary.ResolveInt(param[3]))
            endif
        elseif _theAction == "SendModEvent"
            if ParamLengthGT(CmdPrimary, param.Length, 3)
                string _eventname = CmdPrimary.ResolveString(param[3])
                string _strarg
                float _fltarg
                if param.Length > 4
                    _strarg = CmdPrimary.ResolveString(param[4])
                    if param.Length > 5
                        _fltarg = CmdPrimary.ResolveFloat(param[5])
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
                        itemCount = CmdPrimary.ResolveInt(param[4])
                        if param.Length > 5
                            isSilent = CmdPrimary.ResolveBool(param[5])
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
                _target.AddToMap(CmdPrimary.ResolveBool(param[3]))
            endif
        elseif _theAction == "ApplyHavokImpulse"
            if ParamLengthEQ(CmdPrimary, param.Length, 7)
                _target.ApplyHavokImpulse(CmdPrimary.ResolveFloat(param[3]), CmdPrimary.ResolveFloat(param[4]), CmdPrimary.ResolveFloat(param[5]), CmdPrimary.ResolveFloat(param[6]))
            endif
        elseif _theAction == "BlockActivation"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.BlockActivation(CmdPrimary.ResolveBool(param[3]))
            endif
        elseif _theAction == "CreateDetectionEvent"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Actor _akOwner = CmdPrimary.ResolveActor(param[3])
                if _akOwner
                    _target.CreateDetectionEvent(_akOwner, CmdPrimary.ResolveInt(param[4]))
                endif
            endif
        elseif _theAction == "DamageObject"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.DamageObject(CmdPrimary.ResolveFloat(param[3]))
            endif
        elseif _theAction == "Disable"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.Disable(CmdPrimary.ResolveBool(param[3]))
            endif
        elseif _theAction == "DisableLinkChain"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Keyword _apKeyword = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _apKeyword
                    _target.DisableLinkChain(_apKeyword, CmdPrimary.ResolveBool(param[4]))
                endif
            endif
        elseif _theAction == "DisableNoWait"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.DisableNoWait(CmdPrimary.ResolveBool(param[3]))
            endif
        elseif _theAction == "DropObject"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Form _akObject = CmdPrimary.ResolveForm(param[3])
                if _akObject
                    _target.DropObject(_akObject, CmdPrimary.ResolveInt(param[4]))
                endif
            endif
        elseif _theAction == "Enable"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.Enable(CmdPrimary.ResolveBool(param[3]))
            endif
        elseif _theAction == "EnableFastTravel"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.EnableFastTravel(CmdPrimary.ResolveBool(param[3]))
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
                _target.EnableNoWait(CmdPrimary.ResolveBool(param[3]))
            endif
        elseif _theAction == "IgnoreFriendlyHits"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.IgnoreFriendlyHits(CmdPrimary.ResolveBool(param[3]))
            endif
        elseif _theAction == "KnockAreaEffect"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.KnockAreaEffect(CmdPrimary.ResolveFloat(param[3]), CmdPrimary.ResolveFloat(param[4]))
            endif
        elseif _theAction == "Lock"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.Lock(CmdPrimary.ResolveBool(param[3]), CmdPrimary.ResolveBool(param[4]))
            endif
        elseif _theAction == "MoveTo"
            if ParamLengthEQ(CmdPrimary, param.Length, 8)
                ObjectReference _akTarget = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _akTarget
                    _target.MoveTo(_akTarget, CmdPrimary.ResolveFloat(param[4]), CmdPrimary.ResolveFloat(param[5]), CmdPrimary.ResolveFloat(param[6]), CmdPrimary.ResolveBool(param[7]))
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
                    _target.MoveToNode(_akTarget, CmdPrimary.ResolveString(param[4]))
                endif
            endif
        elseif _theAction == "PlayTerrainEffect"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.PlayTerrainEffect(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveString(param[4]))
            endif
        elseif _theAction == "ProcessTrapHit"
            if ParamLengthEQ(CmdPrimary, param.Length, 14)
                ObjectReference _akTrap = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _akTrap
                    _target.ProcessTrapHit(_akTrap, CmdPrimary.ResolveFloat(param[4]), CmdPrimary.ResolveFloat(param[5]), CmdPrimary.ResolveFloat(param[6]), CmdPrimary.ResolveFloat(param[7]), CmdPrimary.ResolveFloat(param[8]), CmdPrimary.ResolveFloat(param[9]), CmdPrimary.ResolveFloat(param[10]), CmdPrimary.ResolveFloat(param[11]), CmdPrimary.ResolveInt(param[12]), CmdPrimary.ResolveFloat(param[13]))
                endif
            endif
        elseif _theAction == "PushActorAway"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Actor _akActor = CmdPrimary.ResolveActor(param[3])
                if _akActor
                    _target.PushActorAway(_akActor, CmdPrimary.ResolveFloat(param[4]))
                endif
            endif
        elseif _theAction == "RemoveAllItems"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                ObjectReference _akTransferTo = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                _target.RemoveAllItems(_akTransferTo, CmdPrimary.ResolveBool(param[4]), CmdPrimary.ResolveBool(param[5]))
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
                _target.RemoveItem(_toRemove, CmdPrimary.ResolveInt(param[4]), CmdPrimary.ResolveBool(param[5]), _akTransferTo)
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
                    Actor _speakAs = CmdPrimary.ResolveActor(param[4])
                    bool _inPlayerHead = CmdPrimary.ResolveBool(param[5])
                    _target.Say(_topic, _speakAs, _inPlayerHead)
                endif
            endif
        elseif _theAction == "SendStealAlarm"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _akActor = CmdPrimary.ResolveActor(param[3])
                if _akActor
                    _target.SendStealAlarm(_akActor)
                endif
            endif
        elseif _theAction == "SetActorCause"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _akActor = CmdPrimary.ResolveActor(param[3])
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
                _target.SetAngle(CmdPrimary.ResolveFloat(param[3]), CmdPrimary.ResolveFloat(param[4]), CmdPrimary.ResolveFloat(param[5]))
            endif
        elseif _theAction == "SetAnimationVariableBool"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetAnimationVariableBool(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveBool(param[4]))
            endif
        elseif _theAction == "SetAnimationVariableFloat"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetAnimationVariableFloat(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveFloat(param[4]))
            endif
        elseif _theAction == "SetAnimationVariableInt"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetAnimationVariableInt(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveInt(param[4]))
            endif
        elseif _theAction == "SetDestroyed"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetDestroyed(CmdPrimary.ResolveBool(param[3]))
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
                _target.SetLockLevel(CmdPrimary.ResolveInt(param[3]))
            endif
        elseif _theAction == "SetMotionType"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetMotionType(CmdPrimary.ResolveInt(param[3]), CmdPrimary.ResolveBool(param[4]))
            endif
        elseif _theAction == "SetNoFavorAllowed"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetNoFavorAllowed(CmdPrimary.ResolveBool(param[3]))
            endif
        elseif _theAction == "SetOpen"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetOpen(CmdPrimary.ResolveBool(param[3]))
            endif
        elseif _theAction == "SetPosition"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                _target.SetPosition(CmdPrimary.ResolveFloat(param[3]), CmdPrimary.ResolveFloat(param[4]), CmdPrimary.ResolveFloat(param[5]))
            endif
        elseif _theAction == "SetScale"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetScale(CmdPrimary.ResolveFloat(param[3]))
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
                _target.TranslateTo(CmdPrimary.ResolveFloat(param[3]), CmdPrimary.ResolveFloat(param[4]), CmdPrimary.ResolveFloat(param[5]), CmdPrimary.ResolveFloat(param[6]), CmdPrimary.ResolveFloat(param[7]), CmdPrimary.ResolveFloat(param[8]), CmdPrimary.ResolveFloat(param[9]), CmdPrimary.ResolveFloat(param[10]))
            endif
        elseif _theAction == "TranslateToRef"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                ObjectReference _akref = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _akref
                    _target.TranslateToRef(_akref, CmdPrimary.ResolveFloat(param[4]), CmdPrimary.ResolveFloat(param[5]))
                endif
            endif
        elseif _theAction == "SetHarvested"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetHarvested(CmdPrimary.ResolveBool(param[3]))
            endif
        elseif _theAction == "SetItemHealthPercent"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetItemHealthPercent(CmdPrimary.ResolveFloat(param[3]))
            endif
        elseif _theAction == "SetItemMaxCharge"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetItemMaxCharge(CmdPrimary.ResolveFloat(param[3]))
            endif
        elseif _theAction == "SetItemCharge"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                _target.SetItemCharge(CmdPrimary.ResolveFloat(param[3]))
            endif
        elseif _theAction == "SetEnchantment"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Enchantment _ench = CmdPrimary.ResolveForm(param[3]) as Enchantment
                if _ench
                    _target.SetEnchantment(_ench, CmdPrimary.ResolveFloat(param[4]))
                endif
            endif
        elseif _theAction == "CreateEnchantment"
            if ParamLengthGT(CmdPrimary, param.Length, 7)
                float _maxCharge = CmdPrimary.ResolveFloat(param[3])
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
                    _mags[listindex] = CmdPrimary.ResolveFloat(param[i + 1])
                    _areas[listindex] = CmdPrimary.ResolveInt(param[i + 2])
                    _durations[listindex] = CmdPrimary.ResolveInt(param[i + 3])

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
				_target.AllowBleedoutDialogue(CmdPrimary.ResolveInt(param[3]))
			endif
		elseif _theAction == "AllowPCDialogue"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.AllowPCDialogue(CmdPrimary.ResolveInt(param[3]))
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
				_target.DamageActorValue(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveFloat(param[4]))
			endif
		elseif _theAction == "DamageAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
				_target.DamageAV(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveFloat(param[4]))
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
				_target.EnableAI(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "EquipItem"
			if ParamLengthEQ(CmdPrimary, param.Length, 6)
                Form _obj = CmdPrimary.ResolveForm(param[3])
                if _obj
				    _target.EquipItem(_obj, CmdPrimary.ResolveBool(param[4]), CmdPrimary.ResolveBool(param[5]))
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
				    _target.EquipSpell(_obj, CmdPrimary.ResolveInt(param[4]))
                endif
			endif
		elseif _theAction == "ForceActorValue"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.ForceActorValue(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveFloat(param[4]))
			endif
		elseif _theAction == "ForceAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.ForceAV(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveFloat(param[4]))
			endif
		elseif _theAction == "KeepOffsetFromActor"
			if ParamLengthEQ(CmdPrimary, param.Length, 11)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
				    _target.KeepOffsetFromActor(_obj, CmdPrimary.ResolveFloat(param[4]), CmdPrimary.ResolveFloat(param[5]), CmdPrimary.ResolveFloat(param[6]), CmdPrimary.ResolveFloat(param[7]), CmdPrimary.ResolveFloat(param[8]), CmdPrimary.ResolveFloat(param[9]), CmdPrimary.ResolveFloat(param[10]))
                endif
			endif
		elseif _theAction == "Kill"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
				    _target.Kill(_obj)
                endif
			endif
		elseif _theAction == "KillEssential"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
				    _target.KillEssential(_obj)
                endif
			endif
		elseif _theAction == "KillSilent"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
				    _target.KillSilent(_obj)
                endif
			endif
		elseif _theAction == "ModActorValue"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.ModActorValue(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveFloat(param[4]))
			endif
		elseif _theAction == "ModAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.ModAV(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveFloat(param[4]))
			endif
		elseif _theAction == "ModFactionRank"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Faction _obj = CmdPrimary.ResolveForm(param[3]) as Faction
                if _obj
				    _target.ModFactionRank(_obj, CmdPrimary.ResolveInt(param[4]))
                endif
			endif
		elseif _theAction == "OpenInventory"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.OpenInventory(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "PlaySubGraphAnimation"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.PlaySubGraphAnimation(CmdPrimary.ResolveString(param[3]))
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
                _target.RestoreActorValue(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveFloat(param[4]))
			endif
		elseif _theAction == "RestoreAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.RestoreAV(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveFloat(param[4]))
			endif
		elseif _theAction == "SendTrespassAlarm"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
				    _target.SendTrespassAlarm(_obj)
                endif
			endif
		elseif _theAction == "SetActorValue"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetActorValue(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveFloat(param[4]))
			endif
		elseif _theAction == "SetAlert"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetAlert(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "SetAllowFlying"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetAllowFlying(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "SetAllowFlyingEx"
			if ParamLengthEQ(CmdPrimary, param.Length, 6)
				_target.SetAllowFlyingEx(CmdPrimary.ResolveBool(param[3]), CmdPrimary.ResolveBool(param[4]), CmdPrimary.ResolveBool(param[5]))
			endif
		elseif _theAction == "SetAlpha"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetAlpha(CmdPrimary.ResolveFloat(param[3]), CmdPrimary.ResolveBool(param[4]))
			endif
		elseif _theAction == "SetAttackActorOnSight"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetAttackActorOnSight(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "SetAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                _target.SetAV(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveFloat(param[4]))
			endif
		elseif _theAction == "SetBribed"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetBribed(CmdPrimary.ResolveBool(param[3]))
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
				_target.SetCriticalStage(CmdPrimary.ResolveInt(param[3]))
			endif
		elseif _theAction == "SetDoingFavor"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetDoingFavor(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "SetDontMove"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetDontMove(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "SetExpressionOverride"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
				_target.SetExpressionOverride(CmdPrimary.ResolveInt(param[3]), CmdPrimary.ResolveInt(param[4]))
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
                    _target.SetFactionRank(_obj, CmdPrimary.ResolveInt(param[4]))
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
				_target.SetGhost(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "SetHeadTracking"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetHeadTracking(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "SetIntimidated"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetIntimidated(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "SetLookAt"
			if ParamLengthGT(CmdPrimary, param.Length, 3)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    bool pathingLookAt
                    if param.Length > 4
                        pathingLookAt = CmdPrimary.ResolveBool(param[4])
                    endif
                    _target.SetLookAt(_obj, pathingLookAt)
                endif
			endif
		elseif _theAction == "SetNoBleedoutRecovery"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetNoBleedoutRecovery(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "SetNotShowOnStealthMeter"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetNotShowOnStealthMeter(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "SetOutfit"
			if ParamLengthGT(CmdPrimary, param.Length, 3)
                Outfit _obj = CmdPrimary.ResolveForm(param[3]) as Outfit
                if _obj
                    bool _boolval
                    if param.Length > 4
                        _boolval = CmdPrimary.ResolveBool(param[4])
                    endif
                    _target.SetOutfit(_obj, _boolval)
                endif
			endif
		elseif _theAction == "SetPlayerControls"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetPlayerControls(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "SetPlayerTeammate"
			if ParamLengthGT(CmdPrimary, param.Length, 3)
                bool _bv1 = true
                bool _bv2 = true
                if param.Length > 3
                    _bv1 = CmdPrimary.ResolveBool(param[3])
                    if param.Length > 4
                        _bv2 = CmdPrimary.ResolveBool(param[4])
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
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
                    _target.SetRelationshipRank(_obj, CmdPrimary.ResolveInt(param[4]))
                endif
			endif
		elseif _theAction == "SetRestrained"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetRestrained(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "SetSubGraphFloatVariable"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
                    _target.SetSubGraphFloatVariable(_obj, CmdPrimary.ResolveFloat(param[4]))
                endif
			endif
		elseif _theAction == "SetUnconscious"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SetUnconscious(CmdPrimary.ResolveBool(param[3]))
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
				_target.SetVoiceRecoveryTime(CmdPrimary.ResolveFloat(param[3]))
			endif
		elseif _theAction == "StartCannibal"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
                    _target.StartCannibal(_obj)
                endif
			endif
		elseif _theAction == "StartCombat"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
                    _target.StartCombat(_obj)
                endif
			endif
		elseif _theAction == "StartVampireFeed"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
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
                        _bv1 = CmdPrimary.ResolveBool(param[3])
                        if param.Length > 4
                            _bv2 = CmdPrimary.ResolveBool(param[4])
                        endif
                    endif
                    _target.UnequipItem(_obj, _bv1, _bv2)
                endif
			endif
		elseif _theAction == "UnequipItemSlot"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.UnequipItemSlot(CmdPrimary.ResolveInt(param[3]))
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
                    _target.UnequipSpell(_obj, CmdPrimary.ResolveInt(param[4]))
                endif
			endif
		elseif _theAction == "SendLycanthropyStateChanged"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SendLycanthropyStateChanged(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "SendVampirismStateChanged"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				_target.SendVampirismStateChanged(CmdPrimary.ResolveBool(param[3]))
			endif
		elseif _theAction == "EquipItemEx"
			if ParamLengthGT(CmdPrimary, param.Length, 4)
                Form _obj = CmdPrimary.ResolveForm(param[3])

                if _obj
                    int _slot = CmdPrimary.ResolveInt(param[4])
                    bool _bv1
                    bool _bv2
                    if param.Length > 5
                        _bv1 = CmdPrimary.ResolveBool(param[5])
                        if param.Length > 6
                            _bv2 = CmdPrimary.ResolveBool(param[6])
                        endif
                    endif
                    _target.EquipItemEx(_obj, _slot, _bv1, _bv2)
                endif
			endif
		elseif _theAction == "EquipItemById"
			if ParamLengthGT(CmdPrimary, param.Length, 5)
                Form _obj = CmdPrimary.ResolveForm(param[3])

                if _obj
                    Form _itemForm = CmdPrimary.ResolveForm(param[4]) 
                    int _itemid 
                    if _itemForm
                        _itemid = _itemForm.GetFormID()
                    else
                        _itemid = CmdPrimary.ResolveInt(param[4])
                        CmdPrimary.SFW("Unable to load Form using (" + param[4] + ") ; resolved for int (" + _itemid + "); good luck")
                    endif
                    int _slot = CmdPrimary.ResolveInt(param[5]) 
                    bool _bv1
                    bool _bv2
                    if param.Length > 6
                        _bv1 = CmdPrimary.ResolveBool(param[6])
                        if param.Length > 7
                            _bv2 = CmdPrimary.ResolveBool(param[7])
                        endif
                    endif
                    _target.EquipItemById(_obj, _itemid, _slot, _bv1, _bv2)
                endif
			endif
		elseif _theAction == "UnequipItemEx"
			if ParamLengthGT(CmdPrimary, param.Length, 4)
                Form _obj = CmdPrimary.ResolveForm(param[3])

                if _obj
                    int _slot = CmdPrimary.ResolveInt(param[4])
                    bool _bv1
                    if param.Length > 5
                        _bv1 = CmdPrimary.ResolveBool(param[5])
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
				_target.UpdateWeight(CmdPrimary.ResolveFloat(param[3]))
			endif
        else
            return _slt_objectreference_doconsumer(CmdPrimary, _target, _theAction, param)
        endif
        return true
    endif    
    return false
endFunction

; sltname form_doconsumer
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
; sltsamp actor_dogetter $system.player GetEquippedShield
; sltsamp set $shieldFormID $$
; sltsamp form_doconsumer $shieldFormID SetWeight 0.1 ; featherweight shield
function form_doconsumer(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Form _target = CmdPrimary.ResolveForm(param[1])
        
        if _target
            string _theAction = CmdPrimary.ResolveString(param[2])

            if _theAction
                if !_slt_form_doconsumer(CmdPrimary, _target, _theAction, param)
                    SquawkFunctionError(CmdPrimary, "form_doconsumer: unrecognized action(" + _theAction + ")")
                endif
            endif
        endIf
    endif

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
; sltsamp actor_dogetter $system.player GetEquippedShield
; sltsamp set $shieldFormID $$
; sltsamp objectreference_doconsumer $shieldFormID CreateEnchantment 200.0 "Skyrim.esm:form-id-for-MGEF" 20.0 0.0 30.0
function objectreference_doconsumer(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        ObjectReference _target = CmdPrimary.ResolveActor(param[1]) as ObjectReference
        
        if _target
            string _theAction = CmdPrimary.ResolveString(param[2])

            if _theAction
                if !_slt_objectreference_doconsumer(CmdPrimary, _target, _theAction, param)
                    SquawkFunctionError(CmdPrimary, "objectreference_doconsumer: unrecognized action(" + _theAction + ")")
                endif
            endif
        endIf
    endif

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
; sltsamp actor_doconsumer $system.self SetGhost $newGhostStatus
function actor_doconsumer(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Actor _target = CmdPrimary.ResolveActor(param[1])
        
        if _target
            string _theAction = CmdPrimary.ResolveString(param[2])

            if _theAction
                if !_slt_actor_doconsumer(CmdPrimary, _target, _theAction, param)
                    SquawkFunctionError(CmdPrimary, "actor_doconsumer: unrecognized action(" + _theAction + ")")
                endif
            endif
        endIf
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

bool Function _slt_form_dofunction(sl_triggersCmd CmdPrimary, Form _target, string _theAction, string[] param) global
    if _target && _theAction
        if _theAction == "HasKeywordString"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				CmdPrimary.MostRecentBoolResult = _target.HasKeywordString(CmdPrimary.ResolveString(param[3]))
			endif
        elseif _theAction == "HasKeyword"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Keyword _obj = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.HasKeyword(_obj)
                endif
			endif
        elseif _theAction == "GetNthKeyword"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Keyword _obj = _target.GetNthKeyword(CmdPrimary.ResolveInt(param[3]))
                if _obj
				    CmdPrimary.MostRecentIntResult = _obj.GetFormID()
                endif
			endif
        elseif _theAction == "GetWorldModelNthTextureSet"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                TextureSet _obj = _target.GetWorldModelNthTextureSet(CmdPrimary.ResolveInt(param[3]))
                if _obj
				    CmdPrimary.MostRecentFormResult = _obj.GetWorldModelNthTextureSet(CmdPrimary.ResolveInt(param[3]))
                endif
			endif
        else
            return false
        endif
        return true
    endif

    return false
endFunction

bool Function _slt_objectreference_dofunction(sl_triggersCmd CmdPrimary, ObjectReference _target, string _theAction, string[] param) global
    if _target && _theAction
        if _theAction == "CalculateEncounterLevel"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                CmdPrimary.MostRecentIntResult = _target.CalculateEncounterLevel(CmdPrimary.ResolveInt(param[3]))
            endif
		elseif _theAction == "CountLinkedRefChain"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                Keyword _obj = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _obj
                    CmdPrimary.MostRecentIntResult = _target.CountLinkedRefChain(_obj, CmdPrimary.ResolveInt(param[4]))
                endif
            endif
		elseif _theAction == "GetAnimationVariableBool"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                CmdPrimary.MostRecentBoolResult = _target.GetAnimationVariableBool(CmdPrimary.ResolveString(param[3]))
            endif
		elseif _theAction == "GetAnimationVariableFloat"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                CmdPrimary.MostRecentFloatResult = _target.GetAnimationVariableFloat(CmdPrimary.ResolveString(param[3]))
            endif
		elseif _theAction == "GetAnimationVariableInt"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                CmdPrimary.MostRecentIntResult = _target.GetAnimationVariableInt(CmdPrimary.ResolveString(param[3]))
            endif
		elseif _theAction == "GetDistance"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    CmdPrimary.MostRecentFloatResult = _target.GetDistance(_obj)
                endif
            endif
		elseif _theAction == "GetHeadingAngle"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    CmdPrimary.MostRecentFloatResult = _target.GetHeadingAngle(_obj)
                endif
            endif
		elseif _theAction == "GetItemCount"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Form _obj = CmdPrimary.ResolveForm(param[3])
                if _obj
                    CmdPrimary.MostRecentIntResult = _target.GetItemCount(_obj)
                endif
            endif
		elseif _theAction == "HasEffectKeyword"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Keyword _obj = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _obj
                    CmdPrimary.MostRecentBoolResult = _target.HasEffectKeyword(_obj)
                endif
            endif
		elseif _theAction == "HasNode"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                CmdPrimary.MostRecentBoolResult = _target.HasNode(CmdPrimary.ResolveString(param[3]))
            endif
		elseif _theAction == "HasRefType"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                LocationRefType _obj = CmdPrimary.ResolveForm(param[3]) as LocationRefType
                if _obj
                    CmdPrimary.MostRecentBoolResult = _target.HasRefType(_obj)
                endif
            endif
		elseif _theAction == "IsActivateChild"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    CmdPrimary.MostRecentBoolResult = _target.IsActivateChild(_obj)
                endif
            endif
		elseif _theAction == "IsFurnitureInUse"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                CmdPrimary.MostRecentBoolResult = _target.IsFurnitureInUse(CmdPrimary.ResolveBool(param[3]))
            endif
		elseif _theAction == "IsFurnitureMarkerInUse"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                CmdPrimary.MostRecentBoolResult = _target.IsFurnitureMarkerInUse(CmdPrimary.ResolveInt(param[3]), CmdPrimary.ResolveBool(param[4]))
            endif
		elseif _theAction == "IsInLocation"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Location _obj = CmdPrimary.ResolveForm(param[3]) as Location
                if _obj
                    CmdPrimary.MostRecentBoolResult = _target.IsInLocation(_obj)
                endif
            endif
		elseif _theAction == "MoveToIfUnloaded"
            if ParamLengthEQ(CmdPrimary, param.Length, 7)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
                    CmdPrimary.MostRecentBoolResult = _target.MoveToIfUnloaded(_obj, CmdPrimary.ResolveFloat(param[4]), CmdPrimary.ResolveFloat(param[5]), CmdPrimary.ResolveFloat(param[6]))
                endif
            endif
		elseif _theAction == "PlayAnimation"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                CmdPrimary.MostRecentBoolResult = _target.PlayAnimation(CmdPrimary.ResolveString(param[3]))
            endif
		elseif _theAction == "PlayAnimationAndWait"
            if ParamLengthEQ(CmdPrimary, param.Length, 5)
                CmdPrimary.MostRecentBoolResult = _target.PlayAnimationAndWait(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveString(param[4]))
            endif
		elseif _theAction == "PlayGamebryoAnimation"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                CmdPrimary.MostRecentBoolResult = _target.PlayGamebryoAnimation(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveBool(param[4]), CmdPrimary.ResolveFloat(param[5]))
            endif
		elseif _theAction == "PlayImpactEffect"
            if ParamLengthEQ(CmdPrimary, param.Length, 11)
                ImpactDataSet _obj = CmdPrimary.ResolveForm(param[3]) as ImpactDataSet
                if _obj
                    CmdPrimary.MostRecentBoolResult = _target.PlayImpactEffect(_obj, CmdPrimary.ResolveString(param[4]), CmdPrimary.ResolveFloat(param[5]), CmdPrimary.ResolveFloat(param[6]), CmdPrimary.ResolveFloat(param[7]), CmdPrimary.ResolveFloat(param[8]), CmdPrimary.ResolveBool(param[9]), CmdPrimary.ResolveBool(param[10]))
                endif
            endif
		elseif _theAction == "PlaySyncedAnimationAndWaitSS"
            if ParamLengthEQ(CmdPrimary, param.Length, 8)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[5]) as ObjectReference
                if _obj
                    CmdPrimary.MostRecentBoolResult = _target.PlaySyncedAnimationAndWaitSS(CmdPrimary.ResolveString(param[3]), CmdPrimary.ResolveString(param[4]), _obj, CmdPrimary.ResolveString(param[6]), CmdPrimary.ResolveString(param[7]))
                endif
            endif
		elseif _theAction == "PlaySyncedAnimationSS"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[4]) as ObjectReference
                if _obj
                    CmdPrimary.MostRecentBoolResult = _target.PlaySyncedAnimationSS(CmdPrimary.ResolveString(param[3]), _obj, CmdPrimary.ResolveString(param[5]))
                endif
            endif
		elseif _theAction == "RampRumble"
            if ParamLengthEQ(CmdPrimary, param.Length, 6)
                CmdPrimary.MostRecentBoolResult = _target.RampRumble(CmdPrimary.ResolveFloat(param[3]), CmdPrimary.ResolveFloat(param[4]), CmdPrimary.ResolveFloat(param[5]))
            endif
		elseif _theAction == "WaitForAnimationEvent"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                CmdPrimary.MostRecentBoolResult = _target.WaitForAnimationEvent(CmdPrimary.ResolveString(param[3]))
            endif
		elseif _theAction == "SetDisplayName"
            if ParamLengthGT(CmdPrimary, param.Length, 3)
                bool force
                if param.Length > 4
                    force = CmdPrimary.ResolveBool(param[4])
                endif
                CmdPrimary.MostRecentBoolResult = _target.SetDisplayName(CmdPrimary.ResolveString(param[3]), force)
            endif
		elseif _theAction == "GetNthForm"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Form _obj = _target.GetNthForm(CmdPrimary.ResolveInt(param[3]))
                if _obj
                    CmdPrimary.MostRecentFormResult = _obj
                endif
            endif
            ;/
		elseif _theAction == "GetNthReferenceAlias"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ReferenceAlias _obj = _target.GetNthReferenceAlias(CmdPrimary.ResolveInt(param[3]))
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
                        aiLevelMod = CmdPrimary.ResolveInt(param[4])
                        if param.Length > 5
                            akZone = CmdPrimary.ResolveForm(param[5]) as EncounterZone
                        endif
                    endif
                    Actor _actor = _target.PlaceActorAtMe(_obj, aiLevelMod, akZone)
                    if _actor
                        CmdPrimary.MostRecentFormResult = _actor
                    endif
                endif
            endif
		elseif _theAction == "PlaceAtMe"
            if ParamLengthGT(CmdPrimary, param.Length, 3)
                Form _obj = CmdPrimary.ResolveForm(param[3])
                if _obj
                    int aiCount = 1
                    if param.Length > 4
                        aiCount = CmdPrimary.ResolveInt(param[4])
                    endif
                    ObjectReference _placed = _target.PlaceAtMe(_obj, aiCount)
                    if _placed
                        CmdPrimary.MostRecentFormResult = _placed
                    endif
                endif
            endif
		elseif _theAction == "GetLinkedRef"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Keyword _obj = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _obj
                    ObjectReference linkref = _target.GetLinkedRef(_obj)
                    if linkref
                        CmdPrimary.MostRecentFormResult = linkref
                    endif
                endif
            endif
		elseif _theAction == "GetNthLinkedRef"
            if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference linkref = _target.GetNthLinkedRef(CmdPrimary.ResolveInt(param[3]))
                if linkref
                    CmdPrimary.MostRecentFormResult = linkref
                endif
            endif
        else
            return _slt_form_dofunction(CmdPrimary, _target, _theAction, param)
        endif
        return true
    endif

    return false
endFunction

bool Function _slt_actor_dofunction(sl_triggersCmd CmdPrimary, Actor _target, string _theAction, string[] param) global
    if _target && _theAction
        if _theAction == "AddShout"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Shout _obj = CmdPrimary.ResolveForm(param[3]) as Shout
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.AddShout(_obj)
                endif
			endif
		elseif _theAction == "AddSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Spell _obj = CmdPrimary.ResolveForm(param[3]) as Spell
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.AddSpell(_obj)
                endif
			endif
		elseif _theAction == "DispelSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Spell _obj = CmdPrimary.ResolveForm(param[3]) as Spell
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.DispelSpell(_obj)
                endif
			endif
		elseif _theAction == "GetActorValue"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				CmdPrimary.MostRecentFloatResult = _target.GetActorValue(CmdPrimary.ResolveString(param[3]))
			endif
		elseif _theAction == "GetActorValuePercentage"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				CmdPrimary.MostRecentFloatResult = _target.GetActorValuePercentage(CmdPrimary.ResolveString(param[3]))
			endif
		elseif _theAction == "GetAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				CmdPrimary.MostRecentFloatResult = _target.GetAV(CmdPrimary.ResolveString(param[3]))
			endif
		elseif _theAction == "GetAVPercentage"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				CmdPrimary.MostRecentFloatResult = _target.GetAVPercentage(CmdPrimary.ResolveString(param[3]))
			endif
		elseif _theAction == "GetBaseActorValue"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				CmdPrimary.MostRecentFloatResult = _target.GetBaseActorValue(CmdPrimary.ResolveString(param[3]))
			endif
		elseif _theAction == "GetBaseAV"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				CmdPrimary.MostRecentFloatResult = _target.GetBaseAV(CmdPrimary.ResolveString(param[3]))
			endif
		elseif _theAction == "GetEquippedItemType"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				CmdPrimary.MostRecentIntResult = _target.GetEquippedItemType(CmdPrimary.ResolveInt(param[3]))
			endif
		elseif _theAction == "GetFactionRank"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Faction _obj = CmdPrimary.ResolveForm(param[3]) as Faction
                if _obj
				    CmdPrimary.MostRecentIntResult = _target.GetFactionRank(_obj)
                endif
			endif
		elseif _theAction == "GetFactionReaction"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
				    CmdPrimary.MostRecentIntResult = _target.GetFactionReaction(_obj)
                endif
			endif
		elseif _theAction == "GetRelationshipRank"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
				    CmdPrimary.MostRecentIntResult = _target.GetRelationshipRank(_obj)
                endif
			endif
		elseif _theAction == "HasAssociation"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                AssociationType _assoc = CmdPrimary.ResolveForm(param[3]) as AssociationType
                if _assoc
                    Actor _obj = CmdPrimary.ResolveActor(param[4])
                    if _obj
                        CmdPrimary.MostRecentBoolResult = _target.HasAssociation(_assoc, _obj)
                    endif
                endif
			endif
		elseif _theAction == "HasFamilyRelationship"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.HasFamilyRelationship(_obj)
                endif
			endif
		elseif _theAction == "HasLOS"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.HasLOS(_obj)
                endif
			endif
		elseif _theAction == "HasMagicEffect"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                MagicEffect _obj = CmdPrimary.ResolveForm(param[3]) as MagicEffect
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.HasMagicEffect(_obj)
                endif
			endif
		elseif _theAction == "HasMagicEffectWithKeyword"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Keyword _obj = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.HasMagicEffectWithKeyword(_obj)
                endif
			endif
		elseif _theAction == "HasParentRelationship"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.HasParentRelationship(_obj)
                endif
			endif
		elseif _theAction == "HasPerk"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Perk _obj = CmdPrimary.ResolveForm(param[3]) as Perk
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.HasPerk(_obj)
                endif
			endif
		elseif _theAction == "HasSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Spell _obj = CmdPrimary.ResolveForm(param[3]) as Spell
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.HasSpell(_obj)
                endif
			endif
		elseif _theAction == "IsDetectedBy"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.IsDetectedBy(_obj)
                endif
			endif
		elseif _theAction == "IsEquipped"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Form _obj = CmdPrimary.ResolveForm(param[3])
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.IsEquipped(_obj)
                endif
			endif
		elseif _theAction == "IsHostileToActor"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.IsHostileToActor(_obj) 
                endif
			endif
		elseif _theAction == "IsInFaction"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Faction _obj = CmdPrimary.ResolveForm(param[3]) as Faction
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.IsInFaction(_obj)
                endif
			endif
		elseif _theAction == "PathToReference"
			if ParamLengthEQ(CmdPrimary, param.Length, 5)
                ObjectReference _obj = CmdPrimary.ResolveForm(param[3]) as ObjectReference
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.PathToReference(_obj, CmdPrimary.ResolveFloat(param[4]))
                endif
			endif
		elseif _theAction == "PlayIdle"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Idle _obj = CmdPrimary.ResolveForm(param[3]) as Idle
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.PlayIdle(_obj)
                endif
			endif
		elseif _theAction == "PlayIdleWithTarget"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Idle _obj = CmdPrimary.ResolveForm(param[3]) as Idle
                if _obj
                    ObjectReference _objref = CmdPrimary.ResolveForm(param[4]) as ObjectReference
                    if _objref
				        CmdPrimary.MostRecentBoolResult = _target.PlayIdleWithTarget(_obj, _objref)
                    endif
                endif
			endif
		elseif _theAction == "RemoveShout"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Shout _obj = CmdPrimary.ResolveForm(param[3]) as Shout
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.RemoveShout(_obj)
                endif
			endif
		elseif _theAction == "RemoveSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Spell _obj = CmdPrimary.ResolveForm(param[3]) as Spell
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.RemoveSpell(_obj)
                endif
			endif
		elseif _theAction == "TrapSoul"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Actor _obj = CmdPrimary.ResolveActor(param[3])
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.TrapSoul(_obj) 
                endif
			endif
		elseif _theAction == "WornHasKeyword"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Keyword _obj = CmdPrimary.ResolveForm(param[3]) as Keyword
                if _obj
				    CmdPrimary.MostRecentBoolResult = _target.WornHasKeyword(_obj)
                endif
			endif
		elseif _theAction == "GetActorValueMax"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				CmdPrimary.MostRecentFloatResult = _target.GetActorValueMax(CmdPrimary.ResolveString(param[3]))
			endif
		elseif _theAction == "GetAVMax"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				CmdPrimary.MostRecentFloatResult = _target.GetAVMax(CmdPrimary.ResolveString(param[3]))
			endif
		elseif _theAction == "GetEquippedItemId"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
				CmdPrimary.MostRecentIntResult = _target.GetEquippedItemId(CmdPrimary.ResolveInt(param[3]))
			endif
		elseif _theAction == "GetEquippedSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Spell _obj = _target.GetEquippedSpell(CmdPrimary.ResolveInt(param[3]))
                if _obj
				    CmdPrimary.MostRecentFormResult = _obj
                endif
			endif
		elseif _theAction == "GetEquippedWeapon"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Weapon _obj = _target.GetEquippedWeapon(CmdPrimary.ResolveBool(param[3]))
                if _obj
				    CmdPrimary.MostRecentFormResult = _obj
                endif
			endif
		elseif _theAction == "GetEquippedArmorInSlot"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Armor _obj = _target.GetEquippedArmorInSlot(CmdPrimary.ResolveInt(param[3]))
                if _obj
				    CmdPrimary.MostRecentFormResult = _obj
                endif
			endif
		elseif _theAction == "GetWornForm"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Form _obj = _target.GetWornForm(CmdPrimary.ResolveInt(param[3]))
                if _obj
				    CmdPrimary.MostRecentFormResult = _obj
                endif
			endif
		elseif _theAction == "GetEquippedObject"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Form _obj = _target.GetEquippedObject(CmdPrimary.ResolveInt(param[3]))
                if _obj
				    CmdPrimary.MostRecentFormResult = _obj
                endif
			endif
		elseif _theAction == "GetNthSpell"
			if ParamLengthEQ(CmdPrimary, param.Length, 4)
                Spell _obj = _target.GetNthSpell(CmdPrimary.ResolveInt(param[3]))
                if _obj
				    CmdPrimary.MostRecentFormResult = _obj
                endif
			endif
        else
            return _slt_objectreference_dofunction(CmdPrimary, _target, _theAction, param)
        endif
        return true
    endif

    return false
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
; sltsamp form_dofunction $system.self HasKeywordString "ActorTypeNPC"
; sltsamp ; $$ should contain true/false based on whether self has the indicated keyword
function form_dofunction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Form _target = CmdPrimary.ResolveForm(param[1])
        if _target
            string _theAction = CmdPrimary.ResolveString(param[2])

            if _theAction
                if !_slt_form_dofunction(CmdPrimary, _target, _theAction, param)
                    SquawkFunctionError(CmdPrimary, "form_dofunction: unrecognized action(" + _theAction + ")")
                endif
            endif
        endif
    endif

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
; sltsamp set $containerFormID "AContainerEditorIDForExample"
; sltsamp objectreference_dofunction $system.self GetItemCount $containerFormID
; sltsamp ; $$ should contain an int value with the number of items in the container
function objectreference_dofunction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        ObjectReference _target = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        if _target
            string _theAction = CmdPrimary.ResolveString(param[2])

            if _theAction
                if !_slt_objectreference_dofunction(CmdPrimary, _target, _theAction, param)
                    SquawkFunctionError(CmdPrimary, "objectreference_dofunction: unrecognized action(" + _theAction + ")")
                endif
            endif
        endif
    endif

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
; sltsamp actor_dofunction $system.self GetBaseAV "Health"
; sltsamp ; $$ should contain a float value with the base "Health" Actor Value
function actor_dofunction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 3)
        Actor _target = CmdPrimary.ResolveActor(param[1])
        if _target
            string _theAction = CmdPrimary.ResolveString(param[2])

            if _theAction
                if !_slt_actor_dofunction(CmdPrimary, _target, _theAction, param)
                    SquawkFunctionError(CmdPrimary, "actor_dofunction: unrecognized action(" + _theAction + ")")
                endif
            endif
        endif
    endif

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
; sltargs item: ITEM FormID
; sltargs duration: fade duration in seconds
; sltsamp ism_removefade $1 2
function ism_removefade(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Form thing = CmdPrimary.ResolveForm(param[1])
    
        if thing
            ImageSpaceModifier.RemoveCrossFade(CmdPrimary.ResolveFloat(param[2]))
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
        CmdPrimary.MostRecentFloatResult = dayTime
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname util_getrealtime
; sltgrup Utility
; sltdesc Sets $$ to the value of Utility.GetCurrentRealTime() (a float value representing the number of seconds since Skyrim.exe was launched this session)
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
; sltdesc Sets $$ to the in-game hour (i.e. 2:30 AM returns 2)
; sltsamp util_getgametime
function util_gethour(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        float dayTime = Utility.GetCurrentGameTime()
    
        dayTime -= Math.Floor(dayTime)
        dayTime *= 24
        
        int theHour = dayTime as int
        
        CmdPrimary.MostRecentIntResult = theHour
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
; sltdesc Return the sound instance handle from playing the specified audio from the specified actor
; sltargs audio: AUDIO FormID
; sltargs actor: target Actor
; sltsamp snd_play "skyrim.esm:318128" $self
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
; sltargs handle: sound instance handle from snd_play
; sltargs actor: target Actor
; sltargs volume: 0.0 - 1.0
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
; sltargs handle: sound instance handle from snd_play
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
; sltargs actor: target Actor
; sltargs command: <command fragment> [<command fragment> ...] ; all <command fragments> will be concatenated
; sltsamp console $self "sgtm" "" "0.5"
; sltsamp console $self "sgtm 0.5"
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
; sltargs actor: target Actor
; sltsamp mfg_reset $self
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
; sltargs actor: target Actor
; sltargs mode: number, 0 - set phoneme | 1 - set modifier
; sltargs id: an id  (I'm not familiar with MfgFix :/)
; sltargs value: int
; sltargs <actor variable> <mode> <id> <value>
; sltsamp mfg_setphonememodifier $self 0 $1 $2
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
; sltdesc Return facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)
; sltargs actor: target Actor
; sltargs mode: number, 0 - set phoneme | 1 - set modifier
; sltargs id: an id (I'm not familiar with MfgFix :/)
; sltsamp mfg_getphonememodifier $self 0 $1
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
; sltdesc Sets $$ to the keycode pressed after waiting for user to press any of the specified keys. (See https://ck.uesp.net/wiki/Input_Script for the DXScanCodes)
; sltargs dxscancode: <DXScanCode of key> [<DXScanCode of key> ...]
; sltsamp util_waitforkbd 74 78 181 55
function util_waitforkbd(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int nextResult = -1
	
    if ParamLengthGT(CmdPrimary, param.Length, 1) && CmdTargetActor == CmdPrimary.PlayerRef
        int cnt         = param.length
        int idx
        int scancode
    
        CmdPrimary.UnregisterForAllKeys()
    
        idx = 1
        while idx < cnt
            scancode = CmdPrimary.ResolveInt(param[idx])
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

    CmdPrimary.MostRecentIntResult = nextResult

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
; sltargs filename: name of file, rooted from 'Data/SKSE/Plugins/sl_triggers'
; sltargs datatype: int, float, string
; sltargs key: the key
; sltargs new value: value to set
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
; sltargs filename: name of file, rooted from 'Data/SKSE/Plugins/sl_triggers'
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
                        string parm5 = CmdPrimary.ResolveString(param[5])
                        string parm6
                        if param.Length > 6
                            parm6 = CmdPrimary.ResolveString(param[6])
                        endif

                        if "set" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.SetIntValue(jfile, jkey, parm5 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentFloatResult = JsonUtil.SetFloatValue(jfile, jkey, parm5 as float)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentStringResult = JsonUtil.SetStringValue(jfile, jkey, parm5)
                            endif
                        elseif "adjust" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.AdjustIntValue(jfile, jkey, parm5 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentFloatResult = JsonUtil.AdjustFloatValue(jfile, jkey, parm5 as float)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentStringResult = ""
                                SquawkFunctionError(CmdPrimary, "jsonutil: 'string' is not a valid type for JsonUtil Adjust")
                            endif
                        elseif "listadd" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListAdd(jfile, jkey, parm5 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FloatListAdd(jfile, jkey, parm5 as float)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.StringListAdd(jfile, jkey, parm5)
                            endif
                        elseif "listget" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListGet(jfile, jkey, parm5 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentFloatResult = JsonUtil.FloatListGet(jfile, jkey, parm5 as int)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentStringResult = JsonUtil.StringListGet(jfile, jkey, parm5 as int)
                            endif
                        elseif "listset" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListSet(jfile, jkey, parm5 as int, parm6 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentFloatResult = JsonUtil.FloatListSet(jfile, jkey, parm5 as int, parm6 as float)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentStringResult = JsonUtil.StringListSet(jfile, jkey, parm5 as int, parm6 as string)
                            endif
                        elseif "listremoveat" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListRemove(jfile, jkey, parm5 as int, parm6 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FloatListRemove(jfile, jkey, parm5 as float, parm6 as int)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.StringListRemove(jfile, jkey, parm5, parm6 as int)
                            endif
                        elseif "listinsertat" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.IntListInsertAt(jfile, jkey, parm5 as int, parm6 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.FloatListInsertAt(jfile, jkey, parm5 as int, parm6 as float)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.StringListInsertAt(jfile, jkey, parm5 as int, parm6)
                            endif
                        elseif "listremoveat" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.IntListRemoveAt(jfile, jkey, parm5 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.FloatListRemoveAt(jfile, jkey, parm5 as int)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.StringListRemoveAt(jfile, jkey, parm5 as int)
                            endif
                        elseif "listcountvalue" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListCountValue(jfile, jkey, parm5 as int, parm6 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FloatListCountValue(jfile, jkey, parm5 as float, parm6 as int)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.StringListCountValue(jfile, jkey, parm5, parm6 as int)
                            endif
                        elseif "listfind" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListFind(jfile, jkey, parm5 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FloatListFind(jfile, jkey, parm5 as float)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.StringListFind(jfile, jkey, parm5)
                            endif
                        elseif "listhas" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.IntListHas(jfile, jkey, parm5 as int) as int
                            elseif "float" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.FloatListHas(jfile, jkey, parm5 as float) as int
                            elseif "string" == jtype
                                CmdPrimary.MostRecentBoolResult = JsonUtil.StringListHas(jfile, jkey, parm5) as int
                            endif
                        elseif "listresize" == func
                            if "int" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.IntListResize(jfile, jkey, parm5 as int, parm6 as int)
                            elseif "float" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.FloatListResize(jfile, jkey, parm5 as int, parm6 as float)
                            elseif "string" == jtype
                                CmdPrimary.MostRecentIntResult = JsonUtil.StringListResize(jfile, jkey, parm5 as int, parm6)
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
                    endif
                elseif "has" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentBoolResult = StorageUtil.HasIntValue(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentBoolResult = StorageUtil.HasFloatValue(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentBoolResult = StorageUtil.HasStringValue(suform, jkey)
                    endif
                elseif "listclear" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.IntListClear(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.FloatListClear(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.StringListClear(suform, jkey)
                    endif
                elseif "listpop" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.IntListPop(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentFloatResult = StorageUtil.FloatListPop(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentStringResult = StorageUtil.StringListPop(suform, jkey)
                    endif
                elseif "listshift" == func
                    if "int" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.IntListShift(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentFloatResult = StorageUtil.FloatListShift(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentStringResult = StorageUtil.StringListShift(suform, jkey)
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
                        CmdPrimary.MostRecentIntResult = StorageUtil.IntListCount(suform, jkey)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.FloatListCount(suform, jkey)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.StringListCount(suform, jkey)
                    endif
                elseif "get" == func
                    string dval
                    if param.Length > 5
                        dval = CmdPrimary.ResolveString(param[5])
                    endif
                    if "int" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.GetIntValue(suform, jkey, dval as int)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentFloatResult = StorageUtil.GetFloatValue(suform, jkey, dval as float)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentStringResult = StorageUtil.GetStringValue(suform, jkey, dval)
                    endif
                elseif "pluck" == func
                    string dval
                    if param.Length > 5
                        dval = CmdPrimary.ResolveString(param[5])
                    endif
                    if "int" == jtype
                        CmdPrimary.MostRecentIntResult = StorageUtil.PluckIntValue(suform, jkey, dval as int)
                    elseif "float" == jtype
                        CmdPrimary.MostRecentFloatResult = StorageUtil.PluckFloatValue(suform, jkey, dval as float)
                    elseif "string" == jtype
                        CmdPrimary.MostRecentStringResult = StorageUtil.PluckStringValue(suform, jkey, dval)
                    endif

                elseif ParamLengthGT(CmdPrimary, param.Length, 5)
                    string parm5 = CmdPrimary.ResolveString(param[5])
                    string parm6
                    if param.Length > 6
                        parm6 = CmdPrimary.ResolveString(param[6])
                    endif

                    if "set" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.SetIntValue(suform, jkey, parm5 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentFloatResult = StorageUtil.SetFloatValue(suform, jkey, parm5 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentStringResult = StorageUtil.SetStringValue(suform, jkey, parm5)
                        endif
                    elseif "adjust" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.AdjustIntValue(suform, jkey, parm5 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentFloatResult = StorageUtil.AdjustFloatValue(suform, jkey, parm5 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentStringResult = ""
                            SquawkFunctionError(CmdPrimary, "jsonutil: 'string' is not a valid type for StorageUtil Adjust")
                        endif
                    elseif "listadd" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListAdd(suform, jkey, parm5 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FloatListAdd(suform, jkey, parm5 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.StringListAdd(suform, jkey, parm5)
                        endif
                    elseif "listget" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListGet(suform, jkey, parm5 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentFloatResult = StorageUtil.FloatListGet(suform, jkey, parm5 as int)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentStringResult = StorageUtil.StringListGet(suform, jkey, parm5 as int)
                        endif
                    elseif "listpluck" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListPluck(suform, jkey, parm5 as int, parm6 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentFloatResult = StorageUtil.FloatListPluck(suform, jkey, parm5 as int, parm6 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentStringResult = StorageUtil.StringListPluck(suform, jkey, parm5 as int, parm6 as string)
                        endif
                    elseif "listset" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListSet(suform, jkey, parm5 as int, parm6 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentFloatResult = StorageUtil.FloatListSet(suform, jkey, parm5 as int, parm6 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentStringResult = StorageUtil.StringListSet(suform, jkey, parm5 as int, parm6 as string)
                        endif
                    elseif "listremoveat" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListRemove(suform, jkey, parm5 as int, parm6 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FloatListRemove(suform, jkey, parm5 as float, parm6 as int)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.StringListRemove(suform, jkey, parm5, parm6 as int)
                        endif
                    elseif "listinsertat" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.IntListInsert(suform, jkey, parm5 as int, parm6 as int) as int
                        elseif "float" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.FloatListInsert(suform, jkey, parm5 as int, parm6 as float) as int
                        elseif "string" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.StringListInsert(suform, jkey, parm5 as int, parm6) as int
                        endif
                    elseif "listadjust" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListAdjust(suform, jkey, parm5 as int, parm6 as int) as int
                        elseif "float" == jtype
                            CmdPrimary.MostRecentFloatResult = StorageUtil.FloatListAdjust(suform, jkey, parm5 as int, parm6 as float) as int
                        elseif "string" == jtype
                            CmdPrimary.MostRecentStringResult = ""
                            SquawkFunctionError(CmdPrimary, "jsonutil: 'string' is not a valid type for StorageUtil List Adjust")
                        endif
                    elseif "listremoveat" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.IntListRemoveAt(suform, jkey, parm5 as int) as int
                        elseif "float" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.FloatListRemoveAt(suform, jkey, parm5 as int) as int
                        elseif "string" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.StringListRemoveAt(suform, jkey, parm5 as int) as int
                        endif
                    elseif "listcountvalue" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListCountValue(suform, jkey, parm5 as int, parm6 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FloatListCountValue(suform, jkey, parm5 as float, parm6 as int)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.StringListCountValue(suform, jkey, parm5, parm6 as int)
                        endif
                    elseif "listfind" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListFind(suform, jkey, parm5 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FloatListFind(suform, jkey, parm5 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.StringListFind(suform, jkey, parm5)
                        endif
                    elseif "listhas" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.IntListHas(suform, jkey, parm5 as int) as int
                        elseif "float" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.FloatListHas(suform, jkey, parm5 as float) as int
                        elseif "string" == jtype
                            CmdPrimary.MostRecentBoolResult = StorageUtil.StringListHas(suform, jkey, parm5) as int
                        endif
                    elseif "listresize" == func
                        if "int" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.IntListResize(suform, jkey, parm5 as int, parm6 as int)
                        elseif "float" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.FloatListResize(suform, jkey, parm5 as int, parm6 as float)
                        elseif "string" == jtype
                            CmdPrimary.MostRecentIntResult = StorageUtil.StringListResize(suform, jkey, parm5 as int, parm6)
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

; sltname util_getrndactor
; sltgrup Utility
; sltdesc Return a random actor within specified range of self
; sltargs range: (0 - all | >0 - range in Skyrim units)
; sltargs option: (0 - all | 1 - not in SexLab scene | 2 - must be in SexLab scene) (optional: default 0 - all)
; sltsamp util_getrndactor 500 2
; sltsamp actor_isvalid $actor
; sltsamp if $$ = 0 end
; sltsamp msg_notify "Someone is watching you!"
; sltsamp [end]
function util_getrndactor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    Actor nextIterActor

    if ParamLengthLT(CmdPrimary, param.Length, 4)
        Actor[] inCell = MiscUtil.ScanCellNPCs(CmdPrimary.PlayerRef, CmdPrimary.ResolveFloat(param[1]))
        if inCell.Length
            int mode
            if param.Length > 2
                mode = CmdPrimary.ResolveInt(param[2])
            endif
        
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

    CmdPrimary.iterActor = nextIterActor

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname weather_state
; sltgrup Utility
; sltdesc Weather related functions based on sub-function
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

    CmdPrimary.MostRecentStringResult = responsetext

	CmdPrimary.CompleteOperationOnActor()
endFunction
