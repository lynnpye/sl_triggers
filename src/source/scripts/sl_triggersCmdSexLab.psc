scriptname sl_triggersCmdSexLab extends sl_triggersCmdBase

import sl_triggersStatics
import sl_triggersHeap

Actor	aPartner1
Actor	aPartner2
Actor	aPartner3
Actor	aPartner4
sslThreadController	thread

Event OnEffectStart(Actor akTarget, Actor akCaster)	
	SLTOnEffectStart(akCaster)
	
    aPartner1 = none
    aPartner2 = none
    aPartner3 = none
    aPartner4 = none
	
	thread = MyExtension().Sexlab.GetActorController(CmdTargetActor)
	int actorIdx = 0
	while actorIdx < thread.Positions.Length
		Actor theOther = thread.Positions[actorIdx]
		if theOther != CmdTargetActor
			if !aPartner1
				aPartner1 = theOther
			elseif !aPartner2
				aPartner2 = theOther
			elseif !aPartner3
				aPartner3 = theOther
			elseif !aPartner4
				aPartner4 = theOther
			endIf
		endif
		actorIdx += 1
	endWhile
	
	QueueUpdateLoop(0.1)
EndEvent

Event OnUpdate()
	QueueUpdateLoop(DefaultGetKeepAliveTimeWithJitter(15.0))
EndEvent

bool function oper(string[] param)
	return false
endFunction

Actor Function CustomResolveActor(string _code)
    If _code == "$partner"
        return aPartner1
    elseIf _code == "$partner2"
        return aPartner2
    elseIf _code == "$partner3"
        return aPartner3
    elseIf _code == "$partner4"
        return aPartner4
    endIf
    return none
EndFunction

sl_triggersExtensionSexLab Function MyExtension()
	return CmdExtension as sl_triggersExtensionSexLab
EndFunction

State cmd_util_waitforend ;util_waitforend
bool function oper(string[] param)
	if !MyExtension().SexLab
		return false
	endif
	
    Actor mate
    
    mate = resolveActor(param[1])

	; got to be a better way
    while mate.GetFactionRank(MyExtension().SexLabAnimatingFaction) >= 0 && inSameCell(mate)
        Utility.wait(6)
    endWhile

	return true
endFunction
EndState 

State cmd_util_getrndactor ;util_getrndactor "range", "option"
bool function oper(string[] param)
    string ss
    float  p1
    int    opt
    
    ss = resolve(param[1])
    p1 = ss as float
    ;0 - any, 1 - not in SL, 2 - is in SL
    ss = resolve(param[2])
    opt = ss as int
    
    Actor[] inCell = MiscUtil.ScanCellNPCs(PlayerRef, p1)
    Actor   lastFound
    Cell    cc = PlayerRef.getParentCell()
    int     idx
    int     cnt
    int     idxRnd

    CmdPrimary.iterActor = none
    cnt = inCell.Length
    if cnt < 1
        return false
    endIf
    
    idxRnd = Utility.RandomInt(0, cnt)
    idx = 0
    while idx < cnt
		Actor mate = inCell[idx]
        
		if mate && mate != PlayerRef && mate.isEnabled() && !mate.isDead() && !mate.isInCombat() && !mate.IsUnconscious() && mate.HasKeyWord(ActorTypeNPC) && mate.Is3DLoaded() && cc == mate.getParentCell()
            if idx > idxRnd
                idx = cnt + 1
            elseif opt == 0
                lastFound = mate
            elseif opt == 1
                if !mate.IsInFaction(MyExtension().SexLabAnimatingFaction)
                    lastFound = mate
                endIf
            elseif opt == 2
                if mate.IsInFaction(MyExtension().SexLabAnimatingFaction)
                    lastFound = mate
                endIf
            endIf
		endIf
    
        idx += 1
    endWhile
    
    CmdPrimary.iterActor = lastFound

	return true
endFunction
EndState 

State cmd_actor_say ;actor_say "$self", "topic id"
bool function oper(string[] param)
    Actor mate
    Topic thing
    
    thing = GetFormId(resolve(param[2])) as Topic
    if thing
        mate = resolveActor(param[1])
        if mate == PlayerRef && MyExtension().SexLab && MyExtension().SexLab.Config.ToggleFreeCamera
            ;mate.Say(thing, mate, true)
        else
            mate.Say(thing)
        endIf
    endIf

	return true
endFunction
EndState 

State cmd_util_waitforkbd ;util_waitfokbd "keycode", "keycode", ...
bool function oper(string[] param)
	if !MyExtension().SexLab
        stack[0] = "-1"
		return false
	endif
	
    string ss
    string ssx
    int cnt
    int idx
    int scancode

    cnt = param.length

    if (CmdTargetActor != PlayerRef) || (cnt <= 1) || !(PlayerRef.GetFactionRank(MyExtension().SexLabAnimatingFaction) >= 0)
        stack[0] = "-1"
        return false
    endIf

    UnregisterForAllKeys()

    idx = 1
    while idx < cnt
        ss = resolve(param[idx])
        scancode = ss as int
        if scancode > 0
            RegisterForKey(scanCode)
            ;MiscUtil.PrintConsole("RegKey: " + scanCode)
        endIf
        idx += 1
    endWhile
    
    CmdPrimary.LastKey = 0
    
    while Self && CmdPrimary.LastKey == 0 && PlayerRef.GetFactionRank(MyExtension().SexLabAnimatingFaction) >= 0
        Utility.Wait(0.5)
    endWhile
    
    if !(PlayerRef.GetFactionRank(MyExtension().SexLabAnimatingFaction) >= 0)
        stack[0] = "-1"
    else
        stack[0] = CmdPrimary.lastKey as string
    endIf
    
    ;MiscUtil.PrintConsole("RetKey: " + lastKey)
    
    UnregisterForAllKeys()

	return true
endFunction
EndState 

State cmd_sl_isin ;sl_isin "$self"
bool function oper(string[] param)
	if !MyExtension().SexLab
        stack[0] = "0"
		return false
	endif
	
    Actor mate
    int retVal
    
    mate = resolveActor(param[1])
    
    ;if SexLab.ValidateActor(mate) == -10 && inSameCell(mate)
    if mate.GetFactionRank(MyExtension().SexLabAnimatingFaction) >= 0 && inSameCell(mate)
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf
	return true
endFunction
EndState 

State cmd_sl_hastag ;sl_hastag "tag_name"
bool function oper(string[] param)
    stack[0] = "0"
	
	if !MyExtension().SexLab
		return false
	endif
	
    string ss
    
    if thread
        ss = resolve(param[1])
        if thread.Animation.HasTag(ss)
            stack[0] = "1"
        endIf
    endIf

	return true
endFunction
EndState 

State cmd_sl_animname ;sl_animname
bool function oper(string[] param)
    stack[0] = ""
	
	if !MyExtension().SexLab
		return false
	endif
    
    string ss
    
    if thread
        stack[0] = thread.Animation.Name
        ;MiscUtil.PrintConsole("animname: " + stack[0])
    endIf

	return true
endFunction
EndState 

State cmd_sl_getprop ;sl_getprop
bool function oper(string[] param)
    stack[0] = ""
	
	if !MyExtension().SexLab
		return false
	endif
    
    string ss
    
    if thread
        ss = resolve(param[1])
        if ss == "Stage"
            stack[0] = thread.Stage as string
        elseif ss == "ActorCount"
            stack[0] = thread.ActorCount as string
        endIf
        ;MiscUtil.PrintConsole("animname: " + stack[0])
    endIf

	return true
endFunction
EndState 

State cmd_sl_advance ;sl_advance "-1" (to go backward)
bool function oper(string[] param)
	if !MyExtension().SexLab || !thread
		return false
	endif
	
	int ss = resolve(param[1]) as int
	thread.AdvanceStage(ss == -1)
	return true
endFunction
EndState

State cmd_sl_isinslot ;sl_isinslot "$self", "1" (SexLab slots numbered 1-5)
bool function oper(string[] param)
	stack[0] = "0"
	
	if !MyExtension().SexLab || !thread
		return true
	endif
	
	int slPosition = resolve(param[2]) as int
	if slPosition < 1 || slPosition > 4
		return true
	endif
	
	if slPosition == 1 && !aPartner1 || slPosition == 2 && !aPartner2 || slPosition == 3 && !aPartner3 || slPosition == 4 && !aPartner4
		return true
	endif
	
	Actor mate = resolveActor(param[1])
	int actorIdx = 0
	while actorIdx < thread.Positions.Length
		if (actorIdx + 1) > slPosition
			return true
		endif
		Actor slActor = thread.Positions[actorIdx]
		; the assumption is that slPosition is 1-based and actorIdx is 0-based
		if slActor == mate
			if (actorIdx + 1) == slPosition
				stack[0] = "1"
			endif
			return true
		endif
	endwhile
	
	return true
endFunction
EndState

State cmd_sl_orgasm ;sl_orgasm "$partner2"
bool function oper(string[] param)
    if !MyExtension().SexLab || !thread
        return true
    endif

    Actor mate = resolveActor(param[1])
    if !mate
        return true
    endif

    thread.ActorAlias(mate).OrgasmEffect()

    return true
endFunction
EndState


State cmd_hextun_test
bool function oper(string[] param)
    DebMsg("hextun_test")
    ActiveMagicEffect[] ames = sl_triggers_internal.SafeGetActiveMagicEffectsForActor(PlayerRef)

    if !ames || ames.Length < 1
        DebMsg("no ames? no dice")
        return true
    endif

    int i = 0
    while i < ames.Length
        ActiveMagicEffect ame = ames[i]
        SLSO_SpellGameScript gsc = ame as SLSO_SpellGameScript
        if gsc
            DebMsg("Found a match at (" + i + ")")
        endif

        i += 1
    endwhile

    return true
endFunction
EndState