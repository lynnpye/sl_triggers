scriptname sl_triggersCmdLibSexLab

import sl_triggersStatics

sl_triggersExtensionSexLab Function GetExtension() global
    return GetForm_SLT_ExtensionSexLab() as sl_triggersExtensionSexLab
EndFunction

; sltname util_waitforend
; sltgrup SexLab
; sltdesc Wait until specified actor is not in SexLab scene
; sltargs actor: target Actor
; sltsamp util_waitforend $self
; sltrslt Wait until the scene ends
function util_waitforend(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

	if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        Faction anmfc = slExtension.SexLabAnimatingFaction
        
        while _targetActor.GetFactionRank(anmfc) >= 0 && CmdPrimary.InSameCell(_targetActor)
            Utility.wait(4)
        endWhile
    endif
endFunction

; sltname sl_getrndactor
; sltgrup SexLab
; sltdesc Return a random actor within specified range of self
; sltargs range: (0 - all | >0 - range in Skyrim units)
; sltargs option: (0 - all | 1 - not in SexLab scene | 2 - must be in SexLab scene) (optional: default 0 - all)
; sltsamp sl_getrndactor 500 2
; sltsamp actor_isvalid $actor
; sltsamp if $$ = 0 end
; sltsamp msg_notify "Someone is watching you!"
; sltsamp [end]
function sl_getrndactor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    Actor nextIterActor

    if ParamLengthLT(CmdPrimary, param.Length, 4)
        Actor[] inCell = MiscUtil.ScanCellNPCs(CmdPrimary.PlayerRef, CmdPrimary.resolve(param[1]) as float)
        if inCell.Length
            int mode
            if param.Length > 2
                mode = CmdPrimary.resolve(param[2]) as int
            endif
        
            Keyword ActorTypeNPC = GetForm_Skyrim_ActorTypeNPC() as Keyword
            Cell    cc = CmdPrimary.PlayerRef.getParentCell()
            Faction anmfc = slExtension.SexLabAnimatingFaction
            bool xenabled = slExtension.IsEnabled
        
            int i = 0
            int nuns = 0
            while i < inCell.Length
                Actor _targetActor = inCell[i]
                if !_targetActor || _targetActor == CmdPrimary.PlayerRef || !_targetActor.isEnabled() || _targetActor.isDead() || _targetActor.isInCombat() || _targetActor.IsUnconscious() || (ActorTypeNPC && !_targetActor.HasKeyWord(ActorTypeNPC)) || !_targetActor.Is3DLoaded() || (cc && cc != _targetActor.getParentCell()) || (mode == 1 && xenabled &&  _targetActor.IsInFaction(anmfc)) || (mode == 2 && xenabled && !_targetActor.IsInFaction(anmfc))
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
endfunction
function util_getrndactor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
    sl_getrndactor(CmdTargetActor, _CmdPrimary, param)
endFunction

; sltname actor_say
; sltgrup Actor
; sltdesc Causes the actor to 'say' the topic indicated by FormId; not usable on the Player
; sltargs actor: target Actor
; sltargs topic: Topic FormID
; sltsamp actor_say $actor "Skyrim.esm:1234"
function actor_say(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Topic thing = CmdPrimary.GetFormId(CmdPrimary.resolve(param[2])) as Topic
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            if !slExtension.IsEnabled || !slExtension.SexLab.Config.ToggleFreeCamera || _targetActor != CmdPrimary.PlayerRef
                _targetActor.Say(thing)
            endif
        endIf
    endif
endFunction

; sltname actor_race
; sltgrup Actor
; sltdesc Returns the race name based on sub-function. Blank, empty sub-function returns Vanilla racenames. e.g. "SL" can return SexLab race keynames.
; sltargs actor: target Actor
; sltargs sub-function: sub-function
; sltargsmore if parameter 2 is "": return actors race name. Skyrims, original name. Like: "Nord", "Breton"
; sltargsmore if parameter 2 is "SL": return actors Sexlab frameworks race key name. Like: "dogs", "bears", etc. Note: will return "" if actor is humanoid
; sltsamp actor_race $self "SL"
; sltsamp msg_notify "  Race SL: " $$
function actor_race(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    string nextResult = ""

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.resolveActor(param[1])
        if _targetActor
            string ss1
            if param.Length > 2
                ss1 = CmdPrimary.resolve(param[2])
            endif
            if !ss1 || !slExtension.IsEnabled
                nextResult = _targetActor.GetRace().GetName()
            elseIf "SL" == ss1 && slExtension.IsEnabled
                nextResult = sslCreatureAnimationSlots.GetRaceKey(_targetActor.GetRace())
            endIf
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname util_waitforkbd
; sltgrup Utility
; sltdesc Returns the keycode pressed after waiting for user to press any of the specified keys or for the end of the SexLab scene
; sltargs actor: target Actor
; sltargs dxscancode: DXScanCode of key [<DXScanCode of key> ...]
; sltsamp util_waitforkbd 74 78 181 55
; sltsamp if $$ = 74 MINUS
; sltsamp ...
; sltsamp if $$ < 0 END
; sltrslt Wait for Num-, Num+, Num/, or Num*, or animation expired, and then do something based on the result.
function util_waitforkbd(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    int nextResult = -1

	if ParamLengthGT(CmdPrimary, param.Length, 1)
        string ss
        string ssx
        int cnt = param.length
        int idx
        int startidx = 1
        int scancode

        if CmdTargetActor
            if (CmdTargetActor != CmdPrimary.PlayerRef) || (cnt <= 1) || !(slExtension.IsEnabled && CmdPrimary.PlayerRef.GetFactionRank(slExtension.SexLabAnimatingFaction) >= 0)
                nextResult = -1
            else
                CmdPrimary.UnregisterForAllKeys()
            
                idx = startidx
                while idx < cnt
                    ss = CmdPrimary.resolve(param[idx])
                    scancode = ss as int
                    if scancode > 0
                        CmdPrimary.RegisterForKey(scanCode)
                    endIf
                    idx += 1
                endWhile
                
                CmdPrimary.LastKey = 0

                Actor plyrf = CmdPrimary.PlayerRef
                Faction anfac = slExtension.SexLabAnimatingFaction
                
                while CmdPrimary && CmdPrimary.LastKey == 0 && (slExtension.IsEnabled && plyrf.GetFactionRank(anfac) >= 0)
                    Utility.Wait(0.5)
                endWhile
                
                if CmdPrimary
                    CmdPrimary.UnregisterForAllKeys()
                    
                    if slExtension.IsEnabled && !(plyrf.GetFactionRank(anfac) >= 0)
                        nextResult = -1
                    else
                        nextResult = CmdPrimary.LastKey
                    endIf
                endif
            endIf
        endif
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname sl_isin
; sltgrup SexLab
; sltdesc Sets $$ to 1 if the specified actor is in a SexLab scene, 0 otherwise
; sltargs actor: target Actor
; sltsamp sl_isin $self
function sl_isin(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()
    
    int nextResult = 0

	if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor && _targetActor.GetFactionRank(slExtension.SexLabAnimatingFaction) >= 0 && CmdPrimary.InSameCell(_targetActor)
            nextResult = 1
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname sl_hastag
; sltgrup SexLab
; sltdesc Sets $$ to 1 if the SexLab scene has the specified tag, 0 otherwise
; sltargs tag: tag name e.g. "Oral", "Anal", "Vaginal"
; sltargs actor: target Actor
; sltsamp sl_hastag "Oral" $self
; sltsamp if $$ = 1 ORAL
function sl_hastag(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    int nextResult = 0
	
	if slExtension.IsEnabled && ParamLengthLT(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdTargetActor
        if param.Length > 2
            _targetActor = CmdPrimary.ResolveActor(param[2])
        endif
        sslThreadController thread = slExtension.GetThreadForActor(_targetActor)
        if thread
            string ss = CmdPrimary.resolve(param[1])
            if thread.Animation.HasTag(ss)
                nextResult = 1
            endIf
        endIf
    endif
    
    CmdPrimary.MostRecentResult = nextResult

	return
endFunction

; sltname sl_animname
; sltgrup SexLab
; sltdesc Sets $$ to the current SexLab animation name
; sltsamp sl_animname $self
; sltsamp msg_notify "Playing: " $$
function sl_animname(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    string nextResult = ""
	
	if slExtension.IsEnabled && ParamLengthLT(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdTargetActor
        if param.Length > 1
            _targetActor = CmdPrimary.ResolveActor(param[1])
        endif
        sslThreadController thread = slExtension.GetThreadForActor(_targetActor)
        if thread
            nextResult = thread.Animation.Name
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult

	return
endFunction

; sltname sl_getprop
; sltgrup SexLab
; sltdesc Sets $$ to the value of the requested property
; sltargs property:  Stage | ActorCount
; sltargs actor: target Actor
; sltsamp sl_getprop Stage $self
; sltsamp msg_notify "Current Stage: " $$
function sl_getprop(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    string nextResult = ""
	
	if slExtension.IsEnabled && ParamLengthLT(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdTargetActor
        if param.Length > 2
            _targetActor = CmdPrimary.ResolveActor(param[2])
        endif
        sslThreadController thread = slExtension.GetThreadForActor(_targetActor)
        if thread
            string ss = CmdPrimary.resolve(param[1])
            if ss == "Stage"
                nextResult = thread.Stage as string
            elseif ss == "ActorCount"
                nextResult = thread.ActorCount as string
            endIf
        endIf
    endif

    CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname sl_advance
; sltgrup SexLab
; sltdesc Changes the stage of the current SexLab scene, for the target Actor; advances a single stage if positive, reverses a single stage if negative
; sltargs direction: integer, <negative - backwards / non-negative (including zero) - forwards>
; sltargs actor: target Actor
; sltsamp sl_advance -3 $self
; sltrslt Only goes back one stage
function sl_advance(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

	if slExtension.IsEnabled && ParamLengthLT(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdTargetActor
        if param.Length > 2
            _targetActor = CmdPrimary.ResolveActor(param[2])
        endif
        sslThreadController thread = slExtension.GetThreadForActor(_targetActor)
        int ss = CmdPrimary.resolve(param[1]) as int
        thread.AdvanceStage(ss < 0)
    endif
endFunction

; sltname sl_isinslot
; sltgrup SexLab
; sltdesc Sets $$ to 1 if the specified actor is in the specified SexLab scene slot, 0 otherwise
; sltargs actor: target Actor
; sltargs slotnumber: 1-based SexLab thread slot number
; sltsamp sl_isinslot $player 1
function sl_isinslot(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    int nextResult = 0
	
	if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            sslThreadController thread = slExtension.GetThreadForActor(_targetActor)
            if thread
                int slPosition = CmdPrimary.resolve(param[2]) as int
                if slPosition > 0 && slPosition < 5
                    int actorIdx = 0
                    while actorIdx < thread.Positions.Length
                        if slPosition == actorIdx + 1 && thread.Positions[actorIdx]
                            if _targetActor ==  thread.Positions[actorIdx]
                                nextResult = 1
                                actorIdx = thread.Positions.Length
                            endif
                        endif
                        actorIdx += 1
                    endwhile
                endif
            endif
        endif
	endif
	
	CmdPrimary.MostRecentResult = nextResult
endFunction

; sltname sl_orgasm
; sltgrup SexLab
; sltdesc Immediately forces the specified actor to have a SexLab orgasm.
; sltargs actor: target Actor
; sltsamp sl_orgasm $self
; sltsamp sl_orgasm $partner
; sltrslt Simultaneous orgasms
function sl_orgasm(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()
    
    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            sslThreadController thread = slExtension.GetThreadForActor(_targetActor)
            thread.ActorAlias(_targetActor).OrgasmEffect()
        endif
    endif
endFunction

; sltname df_resetall
; sltgrup Devious Followers
; sltdesc Resets all Devious Followers values (i.e. quest states, deal states, boredom, debt)
; sltdesc back to values as if having just started out.
; sltsamp df_resetall
; sltrslt Should be free of all debts, deals, and rules
function df_resetall(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 1)
        Form dfMCM_form = GetForm_DeviousFollowers_MCM()

        if dfMCM_form
            _DFlowMCM dfMCM = dfMCM_form as _DFlowMCM
            dfMCM.ResetQuests(true)
        endif
    endif
endFunction

; sltname df_setdebt
; sltgrup Devious Followers
; sltdesc Sets current debt to the specified amount
; sltargs newdebt: new debt value
; sltsamp df_setdebt 0
; sltrslt We all know what you are going to use it for
function df_setdebt(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Form dfQuest_form = GetForm_DeviousFollowers_dfQuest()

        if dfQuest_form
            QF__Gift_09000D62 dfQuest = dfQuest_form as QF__Gift_09000D62
            if dfQuest
                int debt = param[1] as int
                dfQuest.SetDebt(debt)
            endif
        endif
    endif
endFunction

; sltname dd_unlockslot
; sltgrup Devious Devices
; sltdesc Attempts to unlock any device in the specified slot
; sltargs actor: target Actor
; sltargs armorslot: int value armor slot e.g. 32 is body armor
; sltargs force: "force" to force an unlock, anything else otherwise
; sltsamp dd_unlockslot $self 32 force
; sltrslt Should remove anything in body slot e.g. corset, harness, etc., and forced, so including quest items (be careful!)
function dd_unlockslot(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthLT(CmdPrimary, param.Length, 5)
        zadLibs ddlib = GetForm_DeviousDevices_zadLibs() as zadLibs
        
        if ddlib
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            if _targetActor
                bool force = (param.Length > 3 && param[3] == "force")
                int i = param[2] as int

                Armor device = _targetActor.GetEquippedArmorInSlot(i)
                if device
                    Keyword ddkeyword = ddlib.GetDeviceKeyword(device)
                    if ddkeyword
                        Armor renderedDevice = ddlib.GetRenderedDevice(device)
                        if renderedDevice && (force || (!renderedDevice.HasKeyWord(ddlib.zad_QuestItem) && !device.HasKeyword(ddlib.zad_QuestItem)))
                            ddlib.UnlockDevice(_targetActor, device, renderedDevice)
                        endif
                    endif
                endif
            endif
        endif
    endif
endFunction

; sltname dd_unlockall
; sltgrup Devious Devices
; sltdesc Attempts to unlock all devices locked on the actor
; sltargs actor: target Actor
; sltargs force: "force" to force an unlock, anything else otherwise
; sltsamp dd_unlockall $self force
; sltrslt Will attempt to (forcibly if necessary, e.g. quest locked items) unlock all lockable items on targeted actor.
function dd_unlockall(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthLT(CmdPrimary, param.Length, 4)
        zadLibs ddlib = GetForm_DeviousDevices_zadLibs() as zadLibs

        if ddlib
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            if _targetActor
                bool force = (param.Length > 2 && param[2] == "force")
                bool lockable
                int i = 0
                Armor device
                Armor renderedDevice
                while i < 61
                    device = _targetActor.GetEquippedArmorInSlot(i)
                    if device
                        renderedDevice = ddlib.GetRenderedDevice(device)
                        lockable = device.HasKeyword(ddlib.zad_lockable) || renderedDevice.HasKeyword(ddlib.zad_lockable)

                        if lockable && (force || (!(renderedDevice && renderedDevice.HasKeyWord(ddlib.zad_QuestItem)) && !device.HasKeyword(ddlib.zad_QuestItem)))
                            ddlib.UnlockDevice(_targetActor, device, renderedDevice)
                        endif
                    endif
            
                    i += 1
                endwhile
            endif
        endif
    endif
endFunction

