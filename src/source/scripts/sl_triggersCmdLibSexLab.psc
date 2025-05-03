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

; sltname util_waitforend
; sltdesc Wait until specified actor is not in SexLab scene
; sltargs <actor variable>
; sltsamp util_waitforend $self
function util_waitforend(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	if !GetSexLab()
		return
	endif

    if ParamLengthNEQ(CmdPrimary, param.Length, 1)
        return
    endif
	
    Actor mate = CmdPrimary.ResolveActor(param[1])
	
    while mate.GetFactionRank(GetSexLabAnimatingFaction()) >= 0 && CmdPrimary.InSameCell(mate)
        Utility.wait(4)
    endWhile

	return
endFunction

; sltname util_getrndactor
; sltdesc Return a random actor within specified range of self
; sltargs <range: 0 - all | >0 skyrim units> <mode: 0 - all, 1 - not in SexLab scene, 2 - must be in SexLab scene>
; sltsamp util_getrndactor 320 2
function util_getrndactor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
        return
    endif
    
    Actor[] inCell = MiscUtil.ScanCellNPCs(CmdPrimary.PlayerRef, CmdPrimary.resolve(param[1]) as float)
    if !(inCell.Length)
        return 
    endif

    int mode = CmdPrimary.resolve(param[2]) as int

    Keyword ActorTypeNPC = Game.GetFormFromFile(0x13794, "Skyrim.esm") as Keyword
    Cell    cc = CmdPrimary.PlayerRef.getParentCell()

    int i = 0
    int nuns = 0
    while i < inCell.Length
        Actor mate = inCell[i]
        if !mate || mate == CmdPrimary.PlayerRef || !mate.isEnabled() || mate.isDead() || mate.isInCombat() || mate.IsUnconscious() || !mate.HasKeyWord(ActorTypeNPC) || !mate.Is3DLoaded() || cc != mate.getParentCell() || (mode == 1 && mate.IsInFaction(GetSexLabAnimatingFaction())) || (mode == 2 && !mate.IsInFaction(GetSexLabAnimatingFaction()))
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

	return
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
        Actor mate = CmdPrimary.ResolveActor(param[1])
        if !(mate == CmdPrimary.PlayerRef && GetSexLab() && GetSexLab().Config.ToggleFreeCamera)
            mate.Say(thing)
        endIf
    endIf

	return
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
    
    string result = ""
    if mate
        string ss1 = CmdPrimary.resolve(param[2])
        if ss1 == ""
            result = mate.GetRace().GetName()
        elseIf ss1 == "SL"
            result = sslCreatureAnimationSlots.GetRaceKey(mate.GetRace())
        endIf
    endIf
    CmdPrimary.MostRecentResult = result
endFunction

; sltname util_waitforkbd
; sltdesc Returns the keycode pressed after waiting for user to press any of the specified keys or for the end of the SexLab scene
; sltargs <DXScanCode of key> [<DXScanCode of key> ...]
; sltsamp util_waitforkbd 74 78 181 55
function util_waitforkbd(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	if !GetSexLab()
        CmdPrimary.MostRecentResult = "-1"
		return
	endif
	
    if ParamLengthLT(CmdPrimary, param.Length, 2)
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
    
    CmdPrimary.UnregisterForAllKeys()
    
    if !(CmdPrimary.PlayerRef.GetFactionRank(GetSexLabAnimatingFaction()) >= 0)
        CmdPrimary.MostRecentResult = "-1"
    else
        CmdPrimary.MostRecentResult = CmdPrimary.lastKey as string
    endIf

	return
endFunction

; sltname sl_isin
; sltdesc Returns 1 if the specified actor is in a SexLab scene, 0 otherwise
; sltargs <actor variable>
; sltsamp sl_isin $player
function sl_isin(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	if !GetSexLab()
        CmdPrimary.MostRecentResult = "0"
		return
	endif
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
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

; sltname sl_hastag
; sltdesc Returns 1 if the SexLab scene has the specified tag, 0 otherwise
; sltargs <tag name>
; sltsamp sl_hastag "Oral"
function sl_hastag(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
	if !GetSexLab()
        CmdPrimary.MostRecentResult = "0"
		return
	endif
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
	
    sslThreadController thread = GetThread(CmdTargetActor)

    if thread
        string ss = CmdPrimary.resolve(param[1])
        if thread.Animation.HasTag(ss)
            CmdPrimary.MostRecentResult = "1"
            return
        endIf
    endIf
    
    CmdPrimary.MostRecentResult = "0"

	return
endFunction

; sltname sl_animname
; sltdesc Returns the current SexLab animation name
; sltargs <tag name>
; sltsamp sl_animname
function sl_animname(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    CmdPrimary.MostRecentResult = ""
	
	if !GetSexLab()
		return
	endif
    
    sslThreadController thread = GetThread(CmdTargetActor)
    
    if thread
        CmdPrimary.MostRecentResult = thread.Animation.Name
    else
        CmdPrimary.MostRecentResult = ""
    endIf

	return
endFunction

; sltname sl_getprop
; sltdesc Returns the value of the requested property
; sltargs <property name: Stage | ActorCount>
; sltsamp sl_getprop Stage
function sl_getprop(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
	if !GetSexLab()
		return
	endif
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    sslThreadController thread = GetThread(CmdTargetActor)
    
    if thread
        string ss = CmdPrimary.resolve(param[1])
        if ss == "Stage"
            CmdPrimary.MostRecentResult = thread.Stage as string
            return
        elseif ss == "ActorCount"
            CmdPrimary.MostRecentResult = thread.ActorCount as string
            return
        endIf
    endIf

    CmdPrimary.MostRecentResult = ""

	return
endFunction

; sltname sl_advance
; sltdesc Changes the stage of the current SexLab scene; advances a single stage if positive, reverses a single stage if negative
; sltargs <integer direction: negative - backwards / positive - forwards>
; sltsamp sl_advance -3 ; still only goes back one stage
function sl_advance(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

	if !GetSexLab()
		return
	endif
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif
    
    sslThreadController thread = GetThread(CmdTargetActor)
	
	int ss = CmdPrimary.resolve(param[1]) as int
	thread.AdvanceStage(ss < 0)
	return
endFunction

; sltname sl_isinslot
; sltdesc Returns 1 if the specified actor is in the specified SexLab scene slot, 0 otherwise
; sltargs <actor variable> <1-based SexLab thread slot number>
; sltsamp sl_isinslot $player 1
function sl_isinslot(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
	
	if !GetSexLab()
	    CmdPrimary.MostRecentResult = "0"
		return
	endif
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 3)
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
                return
            endif

            return
        endif
        actorIdx += 1
    endwhile
	
	CmdPrimary.MostRecentResult = "0"
	return
endFunction

; sltname sl_orgasm
; sltdesc Immediately forces the specified actor to have a SexLab orgasm.
; sltargs <actor variable>
; sltsamp sl_orgasm $player
function sl_orgasm(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    if !GetSexLab()
        return
    endif
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
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
	
    if ParamLengthNEQ(CmdPrimary, param.Length, 2)
        return
    endif

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
	
    if ParamLengthLT(CmdPrimary, param.Length, 2)
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

