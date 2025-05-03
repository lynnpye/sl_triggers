scriptname sl_triggersCmdLibSexLab

import sl_triggersStatics

SexLabFramework Function GetSexLab() global
    Form slform = Game.GetFormFromFile(0xD62, "SexLab.esm")
    SexLabFramework slf = slform as SexLabFramework
    return slf
EndFunction

Faction Function GetSexLabAnimatingFaction() global
    Form factionform = Game.GetFormFromFile(0xE50F, "SexLab.esm")
    Faction animfaction = factionform as Faction
    return animfaction
EndFunction

sslThreadController Function GetThread(Actor theActor) global
    return GetSexLab().GetActorController(theActor)
EndFunction

; sltname weather_state
; sltdesc Weather related functions based on sub-function
; sltargs <sub-function> ; currently only GetClassification
; sltsamp weather_state GetClassification
function util_waitforend(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	if !GetSexLab()
		return
	endif
	
    Actor mate
    
    mate = CmdPrimary.ResolveActor(param[1])

	
    while mate.GetFactionRank(GetSexLabAnimatingFaction()) >= 0 && CmdPrimary.InSameCell(mate)
        Utility.wait(6)
    endWhile

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
            elseif opt == 0
                lastFound = mate
            elseif opt == 1
                if !mate.IsInFaction(GetSexLabAnimatingFaction())
                    lastFound = mate
                endIf
            elseif opt == 2
                if mate.IsInFaction(GetSexLabAnimatingFaction())
                    lastFound = mate
                endIf
            endIf
		endIf
    
        idx += 1
    endWhile
    
    CmdPrimary.iterActor = lastFound

	return
endFunction
 

function actor_say(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Actor mate
    Topic thing
    
    thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Topic
    if thing
        mate = CmdPrimary.ResolveActor(param[1])
        if mate == CmdPrimary.PlayerRef && GetSexLab() && GetSexLab().Config.ToggleFreeCamera
            
        else
            mate.Say(thing)
        endIf
    endIf

	return
endFunction
 

function actor_race(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    
    Actor mate = CmdPrimary.resolveActor(param[1])
    
    CmdPrimary.MostRecentResult = ""
    if mate
        string ss1 = CmdPrimary.resolve(param[2])
        if ss1 == ""
            CmdPrimary.MostRecentResult = mate.GetRace().GetName()
        elseIf ss1 == "SL"
            CmdPrimary.MostRecentResult = sslCreatureAnimationSlots.GetRaceKey(mate.GetRace())
        endIf
    endIf
endFunction
 

function util_waitforkbd(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	if !GetSexLab()
        CmdPrimary.MostRecentResult = "-1"
		return
	endif
	
    string ss
    string ssx
    int cnt
    int idx
    int scancode

    cnt = param.length

    if (CmdTargetActor != CmdPrimary.PlayerRef) || (cnt <= 1) || !(CmdPrimary.PlayerRef.GetFactionRank(GetSexLabAnimatingFaction()) >= 0)
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
    
    CmdPrimary.LastKey = 0
    
    while CmdPrimary && CmdPrimary.LastKey == 0 && CmdPrimary.PlayerRef.GetFactionRank(GetSexLabAnimatingFaction()) >= 0
        Utility.Wait(0.5)
    endWhile
    
    if !(CmdPrimary.PlayerRef.GetFactionRank(GetSexLabAnimatingFaction()) >= 0)
        CmdPrimary.MostRecentResult = "-1"
    else
        CmdPrimary.MostRecentResult = CmdPrimary.lastKey as string
    endIf
    
    CmdPrimary.UnregisterForAllKeys()

	return
endFunction
 

function sl_isin(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	if !GetSexLab()
        CmdPrimary.MostRecentResult = "0"
		return
	endif
	
    Actor mate
    int retVal
    
    mate = CmdPrimary.ResolveActor(param[1])
    
    
    if mate.GetFactionRank(GetSexLabAnimatingFaction()) >= 0 && CmdPrimary.InSameCell(mate)
        CmdPrimary.MostRecentResult = "1"
    else
        CmdPrimary.MostRecentResult = "0"
    endIf
	return
endFunction
 

function sl_hastag(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    CmdPrimary.MostRecentResult = "0"
	
	if !GetSexLab()
		return
	endif
	
    string ss
    sslThreadController thread = GetThread(CmdTargetActor)

    if thread
        ss = CmdPrimary.resolve(param[1])
        if thread.Animation.HasTag(ss)
            CmdPrimary.MostRecentResult = "1"
        endIf
    endIf

	return
endFunction
 

function sl_animname(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    CmdPrimary.MostRecentResult = ""
	
	if !GetSexLab()
		return
	endif
    
    string ss
    sslThreadController thread = GetThread(CmdTargetActor)
    
    if thread
        CmdPrimary.MostRecentResult = thread.Animation.Name
        
    endIf

	return
endFunction
 

function sl_getprop(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    CmdPrimary.MostRecentResult = ""
	
	if !GetSexLab()
		return
	endif
    
    string ss
    sslThreadController thread = GetThread(CmdTargetActor)
    
    if thread
        ss = CmdPrimary.resolve(param[1])
        if ss == "Stage"
            CmdPrimary.MostRecentResult = thread.Stage as string
        elseif ss == "ActorCount"
            CmdPrimary.MostRecentResult = thread.ActorCount as string
        endIf
        
    endIf

	return
endFunction
 

function sl_advance(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	if !GetSexLab()
		return
	endif
    
    sslThreadController thread = GetThread(CmdTargetActor)
	
	int ss = CmdPrimary.resolve(param[1]) as int
	thread.AdvanceStage(ss == -1)
	return
endFunction


function sl_isinslot(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	CmdPrimary.MostRecentResult = "0"
	
	if !GetSexLab()
		return
	endif
    
    sslThreadController thread = GetThread(CmdTargetActor)
	
	int slPosition = CmdPrimary.resolve(param[2]) as int
	if slPosition < 1 || slPosition > 4
		return
	endif

    int actorIdx = 0
    while actorIdx < thread.Positions.Length
        if slPosition == actorIdx + 1 && thread.Positions[actorIdx]
	        Actor mate = CmdPrimary.ResolveActor(param[1])
            Actor slActor = thread.Positions[actorIdx]

            if slActor == mate
                CmdPrimary.MostRecentResult = "1"
            endif

            return
        endif
        actorIdx += 1
    endwhile
	
	return
endFunction


function sl_orgasm(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    if !GetSexLab()
        return
    endif
    
    sslThreadController thread = GetThread(CmdTargetActor)

    Actor mate = CmdPrimary.ResolveActor(param[1])
    if !mate
        return
    endif

    thread.ActorAlias(mate).OrgasmEffect()

    return
endFunction


function df_setdebt(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Form dfMCM_form = Game.GetFormFromFile(0xC545, "DeviousFollowers.esp")

    if !dfMCM_form
        return
    endif

    _DFlowMCM dfMCM = dfMCM_form as _DFlowMCM

    dfMCM.ResetQuests(true)

    return
endFunction


function df_resetall(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Form dfQuest_form = Game.GetFormFromFile(0xD62, "DeviousFollowers.esp")

    if !dfQuest_form
        return
    endif

    QF__Gift_09000D62 dfQuest = dfQuest_form as QF__Gift_09000D62

    int debt = param[1] as int
    dfQuest.SetDebt(debt)

    return
endFunction


zadLibs Function GetDDLib() global
    zadLibs ddlib = Game.GetFormFromFile(0xF624, "Devious Devices - Integration.esm") as zadLibs
    if !ddlib
        Debug.Trace("Devious Devices zadlibs requested but .esm not found")
    endif
    return ddlib
EndFunction

function dd_unlockslot(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    zadLibs ddlib = GetDDLib()
    if !ddlib
        return
    endif

    bool force = (param[2] == "force")
    int i = param[1] as int
    Armor device = CmdTargetActor.GetEquippedArmorInSlot(i)

    Keyword ddkeyword = ddlib.GetDeviceKeyword(device)
    if !ddkeyword
        return
    endif

    Armor renderedDevice = ddlib.GetRenderedDevice(device)

    if force || (!renderedDevice.HasKeyWord(ddlib.zad_QuestItem) && !device.HasKeyword(ddlib.zad_QuestItem))
        ddlib.UnlockDevice(CmdTargetActor, device, renderedDevice)
    endif

    return
endFunction


function dd_unlockall(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    zadLibs ddlib = GetDDLib()
    if !ddlib
        return
    endif

    bool force = (param[1] == "force")
    bool lockable
    int i = 0
    Armor device
    Armor renderedDevice
    while i < 61
        device = CmdTargetActor.GetEquippedArmorInSlot(i)
        renderedDevice = ddlib.GetRenderedDevice(device)

        lockable = device.HasKeyword(ddlib.zad_lockable) || renderedDevice.HasKeyword(ddlib.zad_lockable)

        if lockable
            if force || (!renderedDevice.HasKeyWord(ddlib.zad_QuestItem) && !device.HasKeyword(ddlib.zad_QuestItem))
                ddlib.UnlockDevice(CmdTargetActor, device, renderedDevice)
            endif
        endif

        i += 1
    endwhile

    return
endFunction

