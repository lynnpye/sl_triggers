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

    CmdPrimary.CompleteOperationOnActor()
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
        Actor[] inCell = MiscUtil.ScanCellNPCs(CmdPrimary.PlayerRef, CmdPrimary.ResolveFloat(param[1]))
        if inCell.Length
            int mode
            if param.Length > 2
                mode = CmdPrimary.ResolveInt(param[2])
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

    CmdPrimary.CompleteOperationOnActor()
endfunction

; xsltname actor_say
; xsltgrup Actor
; xsltdesc Causes the actor to 'say' the topic indicated by FormId; not usable on the Player
; xsltargs actor: target Actor
; xsltargs topic: Topic FormID
; xsltsamp actor_say $actor "Skyrim.esm:1234"
;/
 Disabling this variant as the restriction about player/freecam may not be an actual restriction
 And that logically devolves to the baseline version.
 Keeping this one commented for now
function actor_say(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    
    sl_triggersExtensionSexLab slExtension = GetExtension()

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        string thingFormId = CmdPrimary.Resolve(param[2])
        Topic thing = CmdPrimary.GetFormId(thingFormId) as Topic
        if thing
            Actor _targetActor = CmdPrimary.ResolveActor(param[1])
            if _targetActor
                if _targetActor == CmdPrimary.PlayerRef && (slExtension.IsEnabled && slExtension.SexLab && slExtension.SexLab.Config.ToggleFreeCamera)
                    ; nop
                else
                    _targetActor.Say(thing)
                endif
            endif
        endIf
    endif

    CmdPrimary.CompleteOperationOnActor()    
endFunction
/;

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

    if CmdPrimary.SLT.Debug_Cmd_Functions
        CmdPrimary.SFD("SexLab.actor_race")
    endif

    string nextResult

    if param.Length == 2
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        
        if _targetActor
            if CmdPrimary.SLT.Debug_Cmd_Functions
                Race tr = _targetActor.GetRace()
                string nm = tr.GetName()
                CmdPrimary.SFD("SexLab.actor_race: _targetActor(" + _targetActor + ") race(" + tr + ") name(" + nm + ")")
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
                CmdPrimary.SFD("SexLab.actor_race: ss1(" + ss1 + ") _targetActor(" + _targetActor + ") race(" + tr + ") name(" + nm + ")")
            endif
            if !ss1 || !slExtension.IsEnabled
                nextResult = _targetActor.GetRace().GetName()
            elseif "SL" == ss1 && slExtension.IsEnabled
                nextResult = sslCreatureAnimationSlots.GetRaceKey(_targetActor.GetRace())
            endIf
        else
            CmdPrimary.SFW("actor_race: Unable to resolve actor token(" + param[1] + ")")
        endIf
    else
        CmdPrimary.SFE("actor_race: invalid parameter count")
    endif

    if CmdPrimary.SLT.Debug_Cmd_Functions
        CmdPrimary.SFD("SexLab.actor_race supposed to return(" + nextResult + ")")
    endif
    CmdPrimary.MostRecentStringResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
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
                    scancode = CmdPrimary.ResolveInt(param[idx])
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

    CmdPrimary.MostRecentIntResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; stlname sl_adjustenjoyment
; sltgrup SexLab
; sltdesc Calls sslActorAlias.AdjustEnjoyment()
; sltdesc Should work for both SexLab and SexLab P+
; sltargs actor: target Actor
; sltargs enjoymentAdjustment: int, amount to adjust by
; sltsamp sl_adjustenjoyment $player 30
function sl_adjustenjoyment(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

	if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            sslThreadController tc = (slExtension.SexLabForm as SexLabFramework).GetActorController(_targetActor)
            if tc
                sslActorAlias talias = tc.ActorAlias(_targetActor)
                if talias
                    talias.AdjustEnjoyment(CmdPrimary.ResolveInt(param[2]))
                endif
            endif
        endIf
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_isin
; sltgrup SexLab
; sltdesc Sets $$ to 1 if the specified actor is in a SexLab scene, 0 otherwise
; sltargs actor: target Actor
; sltsamp sl_isin $self
function sl_isin(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()
    
    bool nextResult = false

	if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor && _targetActor.GetFactionRank(slExtension.SexLabAnimatingFaction) >= 0 && CmdPrimary.InSameCell(_targetActor)
            nextResult = true
        endIf
    endif

    CmdPrimary.MostRecentBoolResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
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
    
    bool nextResult = false
	
	if slExtension.IsEnabled && ParamLengthLT(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdTargetActor
        if param.Length > 2
            _targetActor = CmdPrimary.ResolveActor(param[2])
        endif
        sslThreadController thread = slExtension.GetThreadForActor(_targetActor)
        if thread
            string ss = CmdPrimary.ResolveString(param[1])
            if thread.Animation.HasTag(ss)
                nextResult = true
            endIf
        endIf
    endif
    
    CmdPrimary.MostRecentBoolResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_disableorgasm
; sltgrup SexLab
; sltdesc 
; sltargs actor: target Actor
; sltargs disable: 1 to disable, 0 to enable
; sltsamp sl_disableorgasm $system.player 1
; sltsamp ; this disables orgasm for the player
; sltsamp sl_disableorgasm $system.player 0
; sltsamp ; this enables orgasm for the player
function sl_disableorgasm(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()
	
	if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            sslThreadController thread = slExtension.GetThreadForActor(_targetActor)
            thread.ActorAlias(_targetActor).DisableOrgasm(CmdPrimary.ResolveBool(param[2]))
        endif
	endif

    CmdPrimary.CompleteOperationOnActor()
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

    CmdPrimary.MostRecentStringResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
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
            string ss = CmdPrimary.ResolveString(param[1])
            if ss == "Stage"
                nextResult = thread.Stage as string
            elseif ss == "ActorCount"
                nextResult = thread.ActorCount as string
            endIf
        endIf
    endif

    CmdPrimary.MostRecentStringResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
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
        int ss = CmdPrimary.ResolveInt(param[1])
        thread.AdvanceStage(ss < 0)
    endif

    CmdPrimary.CompleteOperationOnActor()
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
    
    bool nextResult = false
	
	if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            sslThreadController thread = slExtension.GetThreadForActor(_targetActor)
            if thread
                int slPosition = CmdPrimary.ResolveInt(param[2])
                if slPosition > 0 && slPosition < 5
                    int actorIdx = 0
                    while actorIdx < thread.Positions.Length
                        if slPosition == actorIdx + 1 && thread.Positions[actorIdx]
                            if _targetActor ==  thread.Positions[actorIdx]
                                nextResult = true
                                actorIdx = thread.Positions.Length
                            endif
                        endif
                        actorIdx += 1
                    endwhile
                endif
            endif
        endif
	endif
	
	CmdPrimary.MostRecentBoolResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
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

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname slso_bonus_enjoyment
; sltgrup SexLab Separate Orgasms
; sltdesc Applies BonusEnjoyment to the specified actor
; sltargs actor: target Actor
; sltargs enjoyment: int, 1-100?
; sltsamp slso_bonus_enjoyment $self 30
function slso_bonus_enjoyment(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            int enjoyment = CmdPrimary.ResolveInt(param[2])

            sslThreadController thread = slExtension.GetThreadForActor(_targetActor)
            if thread
                sslActorAlias saa = thread.ActorAlias(_targetActor)
                if saa
                    saa.BonusEnjoyment(_targetActor, enjoyment)
                endif
            endif
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
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
        else
            CmdPrimary.SFE("df_resetall: Unable to retrieve the DeviousFollowers MCM Form using (" + GetModFilename_DeviousFollowers_MCM() + ":" + GetRelativeFormID_DeviousFollowers_MCM() + ")")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
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
                int debt = CmdPrimary.ResolveInt(param[1])
                dfQuest.SetDebt(debt)
            endif
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
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
                bool force = (param.Length > 3 && CmdPrimary.ResolveString(param[3]) == "force")
                int i = CmdPrimary.ResolveInt(param[2])

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

    CmdPrimary.CompleteOperationOnActor()
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
                bool force = (param.Length > 2 && CmdPrimary.ResolveString(param[2]) == "force")
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

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_get_version
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Returns the version of SexLabAroused or OSLAroused
; sltsamp sla_get_version
; sltsamp msg_console "Version is: " $$
function sla_get_version(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentIntResult = sl_triggersAdapterSLA.GetVersion()

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_get_arousal
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Returns the current arousal of the actor as an int
; sltargs actor: target Actor
; sltsamp sla_get_arousal
function sla_get_arousal(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterSLA.GetArousal(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentIntResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_get_exposure
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Returns the current exposure level of the actor as an int
; sltargs actor: target Actor
; sltsamp sla_get_exposure $system.self
function sla_get_exposure(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterSLA.GetExposure(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentIntResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_set_exposure
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Sets the exposure for the target actor and returns the new amount as an int
; sltargs actor: target Actor
; sltargs exposureAmount: int; amount of exposure update to set
; sltsamp sla_set_exposure $system.self 25
function sla_set_exposure(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        int value = CmdPrimary.ResolveInt(param[2])
        if _targetActor
            newResult = sl_triggersAdapterSLA.SetExposure(_targetActor, value)
        endif
    endif

    CmdPrimary.MostRecentIntResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_update_exposure
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Updates the exposure for the target actor and returns the updated amount as an int.
; sltdesc This uses the API, not a modevent directly (though the API may still be sending a modevent behind the scenes)
; sltargs actor: target Actor
; sltargs exposureAmount: int; amount of exposure update to apply
; sltsamp sla_update_exposure $system.self 5
function sla_update_exposure(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        int value = CmdPrimary.ResolveInt(param[2])
        if _targetActor
            newResult = sl_triggersAdapterSLA.UpdateExposure(_targetActor, value)
        endif
    endif

    CmdPrimary.MostRecentIntResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_send_exposure_event
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Sends the "slaUpdateExposure" modevent. No return value.
; sltargs actor: target Actor
; sltargs exposureAmount: float; amount of exposure update to send
; sltsamp sla_send_exposure_event $system.self 5.0
function sla_send_exposure_event(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        float value = CmdPrimary.ResolveFloat(param[2])
        if _targetActor
            sl_triggersAdapterSLA.SendUpdateExposureEvent(_targetActor, value)
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_get_actor_days_since_last_orgasm
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Returns the days since the actor last had an orgasm as a float
; sltargs actor: target Actor
; sltsamp sla_get_actor_days_since_last_orgasm $system.self
function sla_get_actor_days_since_last_orgasm(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterSLA.GetActorDaysSinceLastOrgasm(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sla_get_actor_hours_since_last_sex
; sltgrup SexLab Aroused/OSLAroused
; sltdesc Returns the in-game hours since the actor last had sex as an int
; sltargs actor: target Actor
; sltsamp sla_get_actor_hours_since_last_sex $system.self
function sla_get_actor_hours_since_last_sex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    int newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterSLA.GetActorHoursSinceLastSex(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentIntResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_get_arousal
; sltgrup OSLAroused
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.GetArousal()
; sltargs actor: target Actor
; sltsamp osla_get_arousal $self
; sltsamp msg_console "Arousal is: " $$
function osla_get_arousal(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterOSLA.GetArousal(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_get_arousal_multiplier
; sltgrup OSLAroused
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.GetArousal()
; sltargs actor: target Actor
; sltsamp osla_get_arousal_multiplier $self
; sltsamp msg_console "Arousal multiplier is: " $$
function osla_get_arousal_multiplier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterOSLA.GetArousalMultiplier(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_get_exposure
; sltgrup OSLAroused
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.GetArousal()
; sltargs actor: target Actor
; sltsamp osla_get_exposure $self
; sltsamp msg_console "Exposure is: " $$
function osla_get_exposure(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterOSLA.GetExposure(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_get_actor_days_since_last_orgasm
; sltgrup OSLAroused
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.GetArousal()
; sltargs actor: target Actor
; sltsamp osla_get_actor_days_since_last_orgasm $self
; sltsamp msg_console "Arousal is: " $$
function osla_get_actor_days_since_last_orgasm(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            newResult = sl_triggersAdapterOSLA.GetActorDaysSinceLastOrgasm(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_modify_arousal
; sltgrup OSLAroused
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.ModifyArousal(Actor, float, string)
; sltargs actor: target Actor
; sltargs value: float value
; sltargs reason: string, optional (default "unknown")
; sltsamp osla_modify_arousal $self 20.0 "for reasons"
function osla_modify_arousal(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            float value = CmdPrimary.ResolveFloat(param[2])
            string reason
            if param.Length > 3
                reason = CmdPrimary.ResolveString(param[3])
            endif
            newResult = sl_triggersAdapterOSLA.ModifyArousal(_targetActor, value, reason)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_set_arousal
; sltgrup OSLAroused
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.SetArousal(Actor, float, string)
; sltargs actor: target Actor
; sltargs value: float value
; sltargs reason: string, optional (default "unknown")
; sltsamp osla_set_arousal $self 50.0 "for reasons"
function osla_set_arousal(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            float value = CmdPrimary.ResolveFloat(param[2])
            string reason
            if param.Length > 3
                reason = CmdPrimary.ResolveString(param[3])
            endif
            newResult = sl_triggersAdapterOSLA.SetArousal(_targetActor, value, reason)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_modify_arousal_multiplier
; sltgrup OSLAroused
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.ModifyArousalMultiplier(Actor, float, string)
; sltargs actor: target Actor
; sltargs value: float value
; sltargs reason: string, optional (default "unknown")
; sltsamp osla_modify_arousal_multiplier $self 0.5 "for reasons"
function osla_modify_arousal_multiplier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            float value = CmdPrimary.ResolveFloat(param[2])
            string reason
            if param.Length > 3
                reason = CmdPrimary.ResolveString(param[3])
            endif
            newResult = sl_triggersAdapterOSLA.ModifyArousalMultiplier(_targetActor, value, reason)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname osla_set_arousal_multiplier
; sltgrup OSLAroused
; sltdesc Sets $$ to the result of OSLAroused_ModInterface.SetArousalMultiplier(Actor, float, string)
; sltargs actor: target Actor
; sltargs value: float value
; sltargs reason: string, optional (default "unknown")
; sltsamp osla_set_arousal_multiplier $self 2.0 "for reasons"
function osla_set_arousal_multiplier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    float newResult

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            float value = CmdPrimary.ResolveFloat(param[2])
            string reason
            if param.Length > 3
                reason = CmdPrimary.ResolveString(param[3])
            endif
            newResult = sl_triggersAdapterOSLA.SetArousalMultiplier(_targetActor, value, reason)
        endif
    endif

    CmdPrimary.MostRecentFloatResult = newResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

