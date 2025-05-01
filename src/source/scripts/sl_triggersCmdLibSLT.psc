scriptname sl_triggersCmdLibSLT

import sl_triggersStatics
 

function hextun_test(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    msg_console(CmdTargetActor, _CmdPrimary, param)
endFunction

function hextun_test2(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    msg_console(CmdTargetActor, _CmdPrimary, param)
endFunction

function CustomResolve(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string _code)
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    if CmdPrimary.CustomResolveReady
        return
    endif
	int varindex = -1
    if StringUtil.getNthChar(_code, 0) == "$"
        if _code == "$$"
            CmdPrimary._slt_SetCustomResolveResult(CmdPrimary.MostRecentResult)
        else
			varindex = CmdPrimary.IsVarStringG(_code)
			if varindex >= 0
                CmdPrimary._slt_SetCustomResolveResult(CmdPrimary.SLT.globalvars_get(varindex))
            else
                varindex = CmdPrimary.IsVarString(_code)
                if varindex >= 0
                    CmdPrimary._slt_SetCustomResolveResult(CmdPrimary.vars_get(varindex))
                endif
			endif
        endIf
    endIf
endFunction

function CustomResolveActor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string _code)
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    if CmdPrimary.CustomResolveActorReady
        return
    endif
    
    if _code == "$self"
        CmdPrimary._slt_SetCustomResolveActorResult(CmdPrimary.CmdTargetActor)
    elseIf _code == "$player"
        CmdPrimary._slt_SetCustomResolveActorResult(CmdPrimary.PlayerRef)
    elseIf _code == "$actor"
        CmdPrimary._slt_SetCustomResolveActorResult(CmdPrimary.iterActor)
    endif
endFunction

function CustomResolveCond(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string _p1, string _p2, string _oper)
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    if CmdPrimary.CustomResolveCondReady
        return
    endif
    if _oper == "="
        if (_p1 as float) == (_p2 as float)
            CmdPrimary._slt_SetCustomResolveCondResult(true)
        endif
    elseIf _oper == "!="
        if (_p1 as float) != (_p2 as float)
            CmdPrimary._slt_SetCustomResolveCondResult(true)
        endif
    elseIf _oper == ">"
        if (_p1 as float) > (_p2 as float)
            CmdPrimary._slt_SetCustomResolveCondResult(true)
        endif
    elseIf _oper == ">="
        if (_p1 as float) >= (_p2 as float)
            CmdPrimary._slt_SetCustomResolveCondResult(true)
        endif
    elseIf _oper == "<"
        if (_p1 as float) < (_p2 as float)
            CmdPrimary._slt_SetCustomResolveCondResult(true)
        endif
    elseIf _oper == "<="
        if (_p1 as float) <= (_p2 as float)
            CmdPrimary._slt_SetCustomResolveCondResult(true)
        endif
    elseIf _oper == "&="
        if _p1 == _p2
            CmdPrimary._slt_SetCustomResolveCondResult(true)
        endif
    elseIf _oper == "&!="
        if _p1 != _p2
            CmdPrimary._slt_SetCustomResolveCondResult(true)
        endif
    endif
endFunction

function set(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	int varindex
	
	varindex = CmdPrimary.IsVarStringG(param[1])
	if varindex >= 0
		if param.length == 3
			CmdPrimary.SLT.globalvars_set(varindex, CmdPrimary.resolve(param[2]))
		elseif param.length == 5
			if param[3] == "+"
				float p1 = CmdPrimary.resolve(param[2]) as float
				float p2 = CmdPrimary.resolve(param[4]) as float
				CmdPrimary.SLT.globalvars_set(varindex, (p1 + p2) as string)
			elseIf param[3] == "-"
				CmdPrimary.SLT.globalvars_set(varindex, ((CmdPrimary.resolve(param[2]) as float) - (CmdPrimary.resolve(param[4]) as float)) as string)
			elseIf param[3] == "*"
				CmdPrimary.SLT.globalvars_set(varindex, ((CmdPrimary.resolve(param[2]) as float) * (CmdPrimary.resolve(param[4]) as float)) as string)
			elseIf param[3] == "/"
				CmdPrimary.SLT.globalvars_set(varindex, ((CmdPrimary.resolve(param[2]) as float) / (CmdPrimary.resolve(param[4]) as float)) as string)
			elseIf param[3] == "&"
				CmdPrimary.SLT.globalvars_set(varindex, CmdPrimary.resolve(param[2]) + CmdPrimary.resolve(param[4]))
			endIf
		endif
    else
        varindex = CmdPrimary.IsVarString(param[1])
        if varindex >= 0
            if param.length == 3
                CmdPrimary.vars_set(varindex, CmdPrimary.resolve(param[2]))
            elseif param.length == 5
                if param[3] == "+"
                    float p1 = CmdPrimary.resolve(param[2]) as float
                    float p2 = CmdPrimary.resolve(param[4]) as float
                    CmdPrimary.vars_set(varindex, (p1 + p2) as string)
                elseIf param[3] == "-"
                    CmdPrimary.vars_set(varindex, ((CmdPrimary.resolve(param[2]) as float) - (CmdPrimary.resolve(param[4]) as float)) as string)
                elseIf param[3] == "*"
                    CmdPrimary.vars_set(varindex, ((CmdPrimary.resolve(param[2]) as float) * (CmdPrimary.resolve(param[4]) as float)) as string)
                elseIf param[3] == "/"
                    CmdPrimary.vars_set(varindex, ((CmdPrimary.resolve(param[2]) as float) / (CmdPrimary.resolve(param[4]) as float)) as string)
                elseIf param[3] == "&"
                    CmdPrimary.vars_set(varindex, CmdPrimary.resolve(param[2]) + CmdPrimary.resolve(param[4]))
                endIf
            endif
        endif
	endif

	return
endFunction


function inc(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    if StringUtil.getNthChar(param[1], 0) == "$"
        int idx = StringUtil.getNthChar(param[1], 1) as int
        if idx >= 0 && idx <= 9
            CmdPrimary.vars_set(idx, ((CmdPrimary.vars_get(idx) as float) + (CmdPrimary.resolve(param[2]) as float)) as string)
        else
            Debug.Notification("Bad var: " +  CmdPrimary.cmdName + "(" + CmdPrimary.cmdIdx + ")")
        endIf
    endIf

	return
endFunction
 

function cat(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    if StringUtil.getNthChar(param[1], 0) == "$"
        int idx = StringUtil.getNthChar(param[1], 1) as int
        if idx >= 0 && idx <= 9
            CmdPrimary.vars_set(idx, CmdPrimary.vars_get(idx) + CmdPrimary.resolve(param[2]))
        else
            Debug.Notification("Bad var: " +  CmdPrimary.cmdName + "(" + CmdPrimary.cmdIdx + ")")
        endIf
    endIf

	return
endFunction
 

function av_restore(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    
    mate = CmdPrimary.resolveActor(param[1])
    mate.RestoreActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)

	return
endFunction
 

function av_damage(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    mate = CmdPrimary.resolveActor(param[1])
    mate.DamageActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)

	return
endFunction
 

function av_mod(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    
    mate = CmdPrimary.resolveActor(param[1])
    mate.ModActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)

	return
endFunction
 

function av_set(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    
    mate = CmdPrimary.resolveActor(param[1])
    mate.SetActorValue(CmdPrimary.resolve(param[2]), CmdPrimary.resolve(param[3]) as float)

	return
endFunction
 

function av_getbase(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    float val
    
    mate = CmdPrimary.resolveActor(param[1])
    val = mate.GetBaseActorValue(CmdPrimary.resolve(param[2]))
    
    CmdPrimary.MostRecentResult = val as string
    

	return
endFunction
 

function av_get(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    float val
    
    mate = CmdPrimary.resolveActor(param[1])
    val = mate.GetActorValue(CmdPrimary.resolve(param[2]))
    
    CmdPrimary.MostRecentResult = val as string
    

	return
endFunction
 

function av_getmax(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    float val
    
    mate = CmdPrimary.resolveActor(param[1])
    val = mate.GetActorValueMax(CmdPrimary.resolve(param[2]))
    
    CmdPrimary.MostRecentResult = val as string

	return
endFunction
 


function av_getpercent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    float val
    
    mate = CmdPrimary.resolveActor(param[1])
    val = mate.GetActorValuePercentage(CmdPrimary.resolve(param[2]))
    val = val * 100.0
    
    CmdPrimary.MostRecentResult = val as string

	return
endFunction
 

function spell_cast(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Spell thing
    Actor mate
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
    if thing
        mate = CmdPrimary.resolveActor(param[2])
        thing.RemoteCast(mate, mate, mate)
    endIf

	return
endFunction
 

function spell_dcsa(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Spell thing
    Actor mate
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
    if thing
        mate = CmdPrimary.resolveActor(param[2])
        mate.DoCombatSpellApply(thing, mate)
    endIf

	return
endFunction
 

function spell_dispel(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Spell thing
    Actor mate
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
    if thing
        mate = CmdPrimary.resolveActor(param[2])
        mate.DispelSpell(thing)
    endIf

	return
endFunction
 

function spell_add(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Spell thing
    Actor mate
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
    if thing
        mate = CmdPrimary.resolveActor(param[2])
        mate.AddSpell(thing)
    endIf

	return
endFunction
 

function spell_remove(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Spell thing
    Actor mate
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Spell
    if thing
        mate = CmdPrimary.resolveActor(param[2])
        mate.RemoveSpell(thing)
    endIf

	return
endFunction
 


function item_add(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Form thing
    Actor mate
    int count
    bool isSilent
    
    mate = CmdPrimary.resolveActor(param[1])
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
    if thing
        count = CmdPrimary.resolve(param[3]) as int
        isSilent = CmdPrimary.resolve(param[4]) as int
        mate.AddItem(thing, count, isSilent)
    endIf

	return
endFunction
 

function item_addex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Form thing
    Actor mate
    int count
    bool isSilent
    
    mate = CmdPrimary.resolveActor(param[1])
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
    if thing
        count = CmdPrimary.resolve(param[3]) as int
        isSilent = CmdPrimary.resolve(param[4]) as int
        
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
        EndIf
        
    endIf

	return
endFunction
 

function item_remove(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Form thing
    Actor mate
    int count
    bool isSilent
    
    mate = CmdPrimary.resolveActor(param[1])
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
    if thing
        count = CmdPrimary.resolve(param[3]) as int
        isSilent = CmdPrimary.resolve(param[4]) as int
        mate.RemoveItem(thing, count, isSilent)
    endIf

	return
endFunction
 

function item_adduse(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Form thing
    Actor mate
    int count
    bool isSilent
    
    mate = CmdPrimary.resolveActor(param[1])
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
    if thing
        count = CmdPrimary.resolve(param[3]) as int
        isSilent = CmdPrimary.resolve(param[4]) as int
        mate.AddItem(thing, count, isSilent)
        mate.EquipItem(thing, false, isSilent)
    endIf

	return
endFunction
 


function item_equipex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Form thing
    Actor mate
    int slotId
    bool isSilent
    
    mate = CmdPrimary.resolveActor(param[1])
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
    if thing
        slotId = CmdPrimary.resolve(param[3]) as int
        isSilent = CmdPrimary.resolve(param[4]) as int
        mate.EquipItemEx(thing, slotId, false, isSilent)
    endIf

	return
endFunction
 

function item_equip(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Form thing
    Actor mate
    int slotId
    bool isSilent
    
    mate = CmdPrimary.resolveActor(param[1])
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
    if thing
        slotId = CmdPrimary.resolve(param[3]) as int
        isSilent = CmdPrimary.resolve(param[4]) as int
        mate.EquipItem(thing, slotId, isSilent)
    endIf

	return
endFunction
 

function item_unequipex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Form thing
    Actor mate
    int slotId
    bool isSilent
    
    mate = CmdPrimary.resolveActor(param[1])
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
    if thing
        slotId = CmdPrimary.resolve(param[3]) as int
        mate.UnEquipItemEx(thing, slotId)
    endIf

	return
endFunction
 

function item_getcount(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Form thing
    Actor mate
    int retVal

    mate = CmdPrimary.resolveActor(param[1])
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
    if thing
        retVal = mate.GetItemCount(thing)
        CmdPrimary.MostRecentResult = retVal as string
    endIf

	return
endFunction
 

function msg_notify(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    string ss
    string ssx
    int cnt
    int idx
    
    cnt = param.length
    idx = 1
    while idx < cnt
        ss = CmdPrimary.resolve(param[idx])
        ssx += ss
        idx += 1
    endWhile
    
    Debug.Notification(ssx)

	return
endFunction
 

function msg_console(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    string ss
    string ssx
    int cnt
    int idx
    
    cnt = param.length
    idx = 1
    while idx < cnt
        ss = CmdPrimary.resolve(param[idx])
        ssx += ss
        idx += 1
    endWhile

    MiscUtil.PrintConsole(ssx)

	return
endFunction
 


function rnd_list(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    string ss
    int cnt
    int idx
    
    cnt = param.length
    idx = utility.RandomInt(1, cnt - 1)
    ss = CmdPrimary.resolve(param[idx])
    CmdPrimary.MostRecentResult = ss
    

	return
endFunction
 

function rnd_int(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    string ss
    int idx
    int p1
    int p2
    
    ss = CmdPrimary.resolve(param[1])
    p1 = ss as int
    ss = CmdPrimary.resolve(param[2])
    p2 = ss as int
    
    idx = utility.RandomInt(p1, p2)
    CmdPrimary.MostRecentResult = idx as string
    

	return
endFunction
 

function util_wait(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    string ss
    ss = CmdPrimary.resolve(param[1])
    Utility.wait(ss as float)

	return
endFunction
 

function util_getrndactor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    string ss
    float  p1
    int    opt
    
    ss = CmdPrimary.resolve(param[1])
    p1 = ss as float
    
    ss = CmdPrimary.resolve(param[2])
    opt = ss as int
    
    Actor[] inCell = MiscUtil.ScanCellNPCs(CmdPrimary.PlayerRef, p1)
    Actor   lastFound
    Cell    cc = CmdPrimary.PlayerRef.getParentCell()
    int     idx
    int     cnt
    int     idxRnd
    Keyword ActorTypeNPC = Game.GetFormFromFile(0x13794, "Skyrim.esm") as Keyword

    CmdPrimary.iterActor = none
    cnt = inCell.Length
    if cnt < 1
        return
    endIf
    
    idxRnd = Utility.RandomInt(0, cnt)
    idx = 0
    while idx < cnt
		Actor mate = inCell[idx]
        
		if mate && mate != CmdPrimary.PlayerRef && mate.isEnabled() && !mate.isDead() && !mate.isInCombat() && !mate.IsUnconscious() && mate.HasKeyWord(ActorTypeNPC) && mate.Is3DLoaded() && cc == mate.getParentCell()
            if idx > idxRnd
                idx = cnt + 1
            else
                lastFound = mate
            endIf
		endIf
    
        idx += 1
    endWhile
    
    CmdPrimary.iterActor = lastFound

	return
endFunction
 

function perk_addpoints(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    string ss
    int    p1
    ss = CmdPrimary.resolve(param[1])
    p1 = ss as int
    Game.AddPerkPoints(p1)

	return
endFunction
 

function perk_add(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Perk thing
    Actor mate
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Perk
    if thing
        mate = CmdPrimary.resolveActor(param[2])
        mate.AddPerk(thing)
    endIf

	return
endFunction
 

function perk_remove(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Perk thing
    Actor mate
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Perk
    if thing
        mate = CmdPrimary.resolveActor(param[2])
        mate.RemovePerk(thing)
    endIf

	return
endFunction
 


function actor_advskill(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    string skillName
    string ss
    int    p1
    
    mate = CmdPrimary.resolveActor(param[1])
    skillName = CmdPrimary.resolve(param[2])
    ss = CmdPrimary.resolve(param[3])
    p1 = ss as int

    if mate == CmdPrimary.playerRef
        Game.AdvanceSkill(skillName, p1)
    endIf


	return
endFunction
 

function actor_incskill(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    string skillName
    string ss
    int    p1
    
    mate = CmdPrimary.resolveActor(param[1])
    skillName = CmdPrimary.resolve(param[2])
    ss = CmdPrimary.resolve(param[3])
    p1 = ss as int
    
    if mate == CmdPrimary.playerRef
        Game.IncrementSkillBy(skillName, p1)
    else
        mate.ModActorValue(skillName, p1)
    endIf


	return
endFunction
 

function actor_isvalid(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    Cell  cc = CmdPrimary.PlayerRef.getParentCell()
    
    mate = CmdPrimary.resolveActor(param[1])
    if mate && mate.isEnabled() && !mate.isDead() && !mate.isInCombat() && !mate.IsUnconscious() && mate.Is3DLoaded() && cc == mate.getParentCell()
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf


	return
endFunction
 

function actor_haslos(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    Actor mate2
    
    mate = CmdPrimary.resolveActor(param[1])
    mate2 = CmdPrimary.resolveActor(param[2])
    if mate.hasLOS(mate2)
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf


	return
endFunction
 

function actor_name(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    
    mate = CmdPrimary.resolveActor(param[1])
    CmdPrimary.MostRecentResult = CmdPrimary.ActorName(mate)


	return
endFunction
 

function actor_modcrimegold(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    string ss
    int    p1
    
    mate = CmdPrimary.resolveActor(param[1])
    ss = CmdPrimary.resolve(param[2])
    p1 = ss as int
    
	Faction crimeFact = mate.GetCrimeFaction()
	if crimeFact
		crimeFact.ModCrimeGold(p1, false)
    endIf


	return
endFunction
 

function actor_qnnu(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    
    mate = CmdPrimary.resolveActor(param[1])
    mate.QueueNiNodeUpdate()


	return
endFunction
 

function actor_isguard(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    
    mate = CmdPrimary.resolveActor(param[1])
    if mate.IsGuard()
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
    

	return
endFunction
 

function actor_isquard(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	return actor_isguard(CmdTargetActor, CmdPrimary, param)
endFunction
 

function actor_isplayer(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    
    mate = CmdPrimary.resolveActor(param[1])
    if mate == CmdPrimary.PlayerRef
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
    

	return
endFunction
 

function actor_getgender(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    int   gender
    
    mate = CmdPrimary.resolveActor(param[1])
    gender = CmdPrimary.ActorGender(mate)
    
    CmdPrimary.MostRecentResult = gender as int

	return
endFunction
 

function actor_say(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    Topic thing
    
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Topic
    if thing
        mate = CmdPrimary.resolveActor(param[1])
        mate.Say(thing)
    endIf

	return
endFunction
 

function actor_haskeyword(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    string ss
    Keyword keyw
    
    mate = CmdPrimary.resolveActor(param[1])
    ss = CmdPrimary.resolve(param[2])    
    
    keyw = Keyword.GetKeyword(ss)
    
    if keyw && mate.HasKeyword(keyw)
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf

	return
endFunction
 

function actor_iswearing(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	Actor mate
	Form thing
	
	mate = CmdPrimary.resolveActor(param[1])
	thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
	
	if thing && mate.IsEquipped(thing)
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
	

	return
endFunction


function actor_worninslot(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	Actor mate
	int slot = param[2] as int
	
	mate = CmdPrimary.resolveActor(param[1])
	if mate && mate.GetEquippedArmorInSlot(slot)
		CmdPrimary.MostRecentResult = "1"
	else
		CmdPrimary.MostRecentResult = "0"
	endIf

	return
endFunction


function actor_wornhaskeyword(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    string ss
    Keyword keyw
    
    mate = CmdPrimary.resolveActor(param[1])
    ss = CmdPrimary.resolve(param[2])    
    
    keyw = Keyword.GetKeyword(ss)
    
    if keyw && mate.WornHasKeyword(keyw)
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
    

	return
endFunction
 

function actor_lochaskeyword(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    string ss
    Keyword keyw
    
    mate = CmdPrimary.resolveActor(param[1])
    ss = CmdPrimary.resolve(param[2])    
    
    keyw = Keyword.GetKeyword(ss)
    
    if keyw && mate.GetCurrentLocation().HasKeyword(keyw)
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
    

	return
endFunction
 

function actor_getrelation(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate1
    Actor mate2
    int   ret
    
    mate1 = CmdPrimary.resolveActor(param[1])
    mate2 = CmdPrimary.resolveActor(param[2])
    
    ret = mate1.GetRelationshipRank(mate2)
    CmdPrimary.MostRecentResult = ret as int
    

	return
endFunction
 

function actor_setrelation(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate1
    Actor mate2
    string  ss
    int   p1
    
    mate1 = CmdPrimary.resolveActor(param[1])
    mate2 = CmdPrimary.resolveActor(param[2])
    ss = CmdPrimary.resolve(param[3])
    p1 = ss as int
    
    mate1.SetRelationshipRank(mate2, p1)
    

	return
endFunction
 

function actor_infaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    Faction thing
    
    mate = CmdPrimary.resolveActor(param[1])
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Faction
    
    CmdPrimary.MostRecentResult = "0"
    if thing
        if mate.IsInFaction(thing)
            CmdPrimary.MostRecentResult = "1"
        endif
    endif
    

	return
endFunction
 


function actor_getfactionrank(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    Faction thing
    int retVal
    
    mate = CmdPrimary.resolveActor(param[1])
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Faction
    
    CmdPrimary.MostRecentResult = "0"
    if thing
        retVal = mate.GetFactionRank(thing)
        CmdPrimary.MostRecentResult = retVal as Int
    endif
    

	return
endFunction
 

function actor_setfactionrank(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    Faction thing
    string ss
    int p1
    
    mate = CmdPrimary.resolveActor(param[1])
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Faction
    ss = CmdPrimary.resolve(param[3])
    p1 = ss as int
    
    if thing
        mate.SetFactionRank(thing, p1)
    endif
    

	return
endFunction
 

function actor_isaffectedby(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	Actor mate
	Form thing
	
	mate = CmdPrimary.resolveActor(param[1])
	if !mate
		CmdPrimary.MostRecentResult = "0"
		return
	endif
	
	thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2]))
	
	
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
	return
endFunction


function actor_removefaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    Faction thing
    
    mate = CmdPrimary.resolveActor(param[1])
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Faction

    if thing
        mate.RemoveFromFaction(thing)
    endif
    

	return
endFunction
 

function actor_playanim(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    string ss
    
    mate = CmdPrimary.resolveActor(param[1])
    ss = CmdPrimary.resolve(param[2])
    
    Debug.SendAnimationEvent(mate, ss)
    

	return
endFunction
 

function actor_sendmodevent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    string ss1
    string ss2
    string ss3
    float  p3
    
    mate = CmdPrimary.resolveActor(param[1])
    ss1 = CmdPrimary.resolve(param[2])
    ss2 = CmdPrimary.resolve(param[3])
    ss3 = CmdPrimary.resolve(param[4])
    p3 = ss3 as float
    
    if mate 
        mate.SendModEvent(ss1, ss2, p3)
    endIf


	return
endFunction
 

function actor_state(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    string ss1
    
    mate = CmdPrimary.resolveActor(param[1])
    ss1 = CmdPrimary.resolve(param[2])
    
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
            int p3
            p3 = CmdPrimary.resolve(param[3]) as int
            mate.SetPlayerTeammate(p3 as bool)
        elseif ss1 == "SendAssaultAlarm"
            mate.SendAssaultAlarm()
        endIf
    endIf


	return
endFunction
 

function actor_body(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    string ss1
    string ss2
    
    mate = CmdPrimary.resolveActor(param[1])
    ss1 = CmdPrimary.resolve(param[2])
    
    CmdPrimary.MostRecentResult = ""
    if mate 
        if ss1 == "ClearExtraArrows"
            mate.ClearExtraArrows()
        elseif ss1 == "RegenerateHead"
            mate.RegenerateHead()
        elseif ss1 == "GetWeight"
            CmdPrimary.MostRecentResult = mate.GetActorBase().GetWeight() as string
        elseif ss1 == "SetWeight"
            float baseW
            float newW
            float neckD
        
            ss2 = CmdPrimary.resolve(param[3])
            
            baseW = mate.GetActorBase().GetWeight()
            newW  = ss2 as float
            If newW < 0
                newW = 0
            ElseIf newW > 100
                newW = 100
            EndIf
            neckD = (baseW - newW) / 100
	
            If neckD
                mate.GetActorBase().SetWeight(newW)
                mate.UpdateWeight(neckD)
            EndIf
        endIf
    endIf


	return
endFunction
 

function actor_race(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    string ss1
    
    mate = CmdPrimary.resolveActor(param[1])
    ss1 = CmdPrimary.resolve(param[2])
    
    CmdPrimary.MostRecentResult = ""
    if mate 
        if ss1 == ""
            CmdPrimary.MostRecentResult = mate.GetRace().GetName()
        elseIf ss1 == "SL"
            CmdPrimary.MostRecentResult = sslCreatureAnimationSlots.GetRaceKey(mate.GetRace())
        endIf
    endIf


	return
endFunction
 


function ism_applyfade(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Form   thing
    string ss
    float  p1

    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1]))
    ss = CmdPrimary.resolve(param[2])
    p1 = ss as float

    if thing
        (thing as ImageSpaceModifier).ApplyCrossFade(p1)
    endIf


	return
endFunction
 


function ism_removefade(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Form   thing
    string ss
    float  p1

    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1]))
    ss = CmdPrimary.resolve(param[2])
    p1 = ss as float

    if thing
        ImageSpaceModifier.RemoveCrossFade(p1)
    endIf


	return
endFunction
 


function util_sendmodevent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    string ss1
    string ss2
    string ss3
    float  p3
    
    ss1 = CmdPrimary.resolve(param[1])
    ss2 = CmdPrimary.resolve(param[2])
    ss3 = CmdPrimary.resolve(param[3])
    p3 = ss3 as float
    
    CmdTargetActor.SendModEvent(ss1, ss2, p3)


	return
endFunction
 

function util_sendevent(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    string eventName
    string typeId
    string ss
    int idxArg
    
    eventName = CmdPrimary.resolve(param[1])
    int eid = ModEvent.Create(eventName)
    
    if eid
        idxArg = 2 
        while idxArg < param.Length
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
    

	return
endFunction
 

function util_getgametime(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    float dayTime = Utility.GetCurrentGameTime()
    
    CmdPrimary.MostRecentResult = dayTime as string
    

	return
endFunction
 

function util_gethour(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	float dayTime = Utility.GetCurrentGameTime()
 
	dayTime -= Math.Floor(dayTime)
	dayTime *= 24
    
    int theHour = dayTime as int
    
    CmdPrimary.MostRecentResult = theHour as string
    

	return
endFunction
 

function util_game(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
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
    

	return
endFunction
 

function snd_play(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Sound   thing
    Actor   mate
    int     retVal
    
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[1])) as Sound
    mate = CmdPrimary.resolveActor(param[2])
    
    if thing
        retVal = thing.Play(mate)
        CmdPrimary.MostRecentResult = retVal as string
    endIf


	return
endFunction
 

function snd_setvolume(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    string ss
    int    soundId
    float  vol
    
    ss = CmdPrimary.resolve(param[1])
    soundId = ss as int
    
    ss = CmdPrimary.resolve(param[2])
    vol = ss as float

    
    Sound.SetInstanceVolume(soundId, vol)


	return
endFunction
 

function snd_stop(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    string ss
    int    soundId

    ss = CmdPrimary.resolve(param[1])
    soundId = ss as int
    
    
    Sound.StopInstance(soundId)


	return
endFunction
 

function console(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
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
    

	return
endFunction
 

function mfg_reset(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    
    mate = CmdPrimary.resolveActor(param[1])

    sl_TriggersMfg.mfg_reset(mate)
    

	return
endFunction
 

function mfg_setphonememodifier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    int   p1
    int   p2
    int   p3
    
    mate = CmdPrimary.resolveActor(param[1])
    p1 = CmdPrimary.resolve(param[2]) as Int
    p2 = CmdPrimary.resolve(param[3]) as Int
    p3 = CmdPrimary.resolve(param[4]) as Int
    
    sl_TriggersMfg.mfg_SetPhonemeModifier(mate, p1, p2, p3)
    

	return
endFunction
 

function mfg_getphonememodifier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    int   p1
    int   p2
    int   retVal
    
    mate = CmdPrimary.resolveActor(param[1])
    p1 = CmdPrimary.resolve(param[2]) as Int
    p2 = CmdPrimary.resolve(param[3]) as Int
    
    retVal = sl_TriggersMfg.mfg_GetPhonemeModifier(mate, p1, p2)
    CmdPrimary.MostRecentResult = retVal as string
    

	return
endFunction
 

function util_waitforkbd(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
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
    
	return
endFunction
 

function json_getvalue(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
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
    

	return
endFunction
 

function json_setvalue(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
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
    

	return
endFunction
 

function json_save(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    string pname
    
    pname = CmdPrimary.resolve(param[1])
    
    JsonUtil.Save(pname)
    

	return
endFunction
 

function weather_state(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
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


	return
endFunction
 

function math(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
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


	return
endFunction
 