scriptname sl_triggersCmdLibSexLab

import sl_triggersStatics

sl_triggersExtensionSexLab Function GetExtension() global
    return GetForm_SLT_ExtensionSexLab() as sl_triggersExtensionSexLab
EndFunction

; sltname sl_getversion
; sltgrup SexLab
; sltdesc Returns: int: the SexLab version as an int (from SexLabUtil.GetVersion())
; sltsamp set $slversion resultfrom sl_getversion
function sl_getversion(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentIntResult = SexLabUtil.GetVersion()

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_getversionstring
; sltgrup SexLab
; sltdesc Returns: string: the SexLab version as a string (from SexLabUtil.GetStringVer())
; sltsamp set $slversionstring resultfrom sl_getversionstring
function sl_getversionstring(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentStringResult = SexLabUtil.GetStringVer()

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_getapi
; sltgrup SexLab
; sltdesc Returns: Form: the SexLabFramework API object (from SexLabUtil.GetAPI())
; sltsamp set $slapi resultfrom sl_getapi
function sl_getapi(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentFormResult = SexLabUtil.GetAPI()

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_isactive
; sltgrup SexLab
; sltdesc Returns: bool: active status of SexLab (from SexLabUtil.SexLabIsActive()): true if active, false otherwise
; sltsamp set $sl_is_active resultfrom sl_isactive
function sl_isactive(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentBoolResult = SexLabUtil.SexLabIsActive()

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_isready
; sltgrup SexLab
; sltdesc Returns: bool: ready status of SexLab (from SexLabUtil.SexLabIsReady()): true if ready, false otherwise
; sltsamp set $sl_is_ready resultfrom sl_isready
function sl_isready(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentBoolResult = SexLabUtil.SexLabIsReady()

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_getgender
; sltgrup SexLab
; sltdesc Returns: int: the actor's SexLab gender, 0 - male, 1 - female, 2 - male creature, 3 - female creature
; sltargs Form: actor: target Actor
; sltsamp actor_getgender $actor
function actor_getgender(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    int nextResult

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            nextResult = (slExtension.SexLabForm as SexLabFramework).GetGender(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentIntResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname util_waitforend
; sltgrup SexLab
; sltdesc Wait until specified actor is not in SexLab scene
; sltargs Form: actor: target Actor
; sltsamp util_waitforend $system.self
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
; sltdesc Returns: Form: a random actor within specified range of self
; sltargs float: range: (0 - all | >0 - range in Skyrim units)
; sltargs int: option: (0 - all | 1 - not in SexLab scene | 2 - must be in SexLab scene) (optional: default 0 - all)
; sltsamp sl_getrndactor 500 2
; sltsamp actor_isvalid $actor
; sltsamp if $$ = false [end]
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

    CmdPrimary.MostRecentFormResult = nextIterActor
    CmdPrimary.iterActor = nextIterActor

    CmdPrimary.CompleteOperationOnActor()
endfunction

; sltname actor_race
; sltgrup Actor
; sltdesc Returns: string: the race name based on sub-function. Blank, empty sub-function returns Vanilla racenames. e.g. "SL" can return SexLab race keynames.
; sltargs Form: actor: target Actor
; sltargs string: sub-function: sub-function
; sltargsmore if parameter 2 is "": return actors race name. Skyrims, original name. Like: "Nord", "Breton"
; sltargsmore if parameter 2 is "SL": return actors Sexlab frameworks race key name. Like: "dogs", "bears", etc. Note: will return "" if actor is humanoid
; sltsamp actor_race $system.self "SL"
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

; sltname sl_waitforkbd
; sltgrup SexLab
; sltdesc Returns: int: the keycode pressed after waiting for user to press any of the specified keys or for the end of the SexLab scene
; sltdesc (See https://ck.uesp.net/wiki/Input_Script for the DXScanCodes)
; sltdesc Usage 1: sl_waitforkbd <dxscancode> [<dxscancode> ...]
; sltargs int: dxscancode: <DXScanCode of key>
; sltdesc Usage 2: sl_waitforkbd $keylist ; where $keylist is a int[]
; sltargs int[]: keylist: a list of dxscancode
; sltrslt ; These do the same thing
; sltsamp sl_waitforkbd 74 78 181 55
; sltsamp listadd $keystowaitfor 74 78 181 55
; sltsamp sl_waitforkbd $keystowaitfor
; sltsamp if $$ = 74 MINUS
; sltsamp ...
; sltsamp if $$ < 0 END
; sltrslt Wait for Num-, Num+, Num/, or Num*, or animation expired, and then do something based on the result.
function sl_waitforkbd(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
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

                int[] resolvedListInt = CmdPrimary.ResolveListInt(param[1])
                if (resolvedListInt)
                    idx = resolvedListInt.Length
                    while idx
                        idx -= 1
                        scancode = resolvedListInt[idx]
                        if scancode > 0
                            CmdPrimary.RegisterForKey(scanCode)
                        endIf
                    endWhile
                else
                    idx = startidx
                    while idx < cnt
                        scancode = CmdPrimary.ResolveInt(param[idx])
                        if scancode > 0
                            CmdPrimary.RegisterForKey(scanCode)
                        endIf
                        idx += 1
                    endWhile
                endif
                
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
; sltargs Form: actor: target Actor
; sltargs int: enjoymentAdjustment: amount to adjust by
; sltsamp sl_adjustenjoyment $system.player 30
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
; sltdesc Returns: bool: true if the specified actor is in a SexLab scene, false otherwise
; sltargs Form: actor: target Actor
; sltsamp sl_isin $system.self
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
; sltdesc Returns: bool: true if the SexLab scene has the specified tag, false otherwise
; sltargs string: tag: tag name e.g. "Oral", "Anal", "Vaginal"
; sltargs Form: actor: target Actor
; sltsamp sl_hastag "Oral" $system.self
; sltsamp if $$ = true ORAL
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
; sltdesc Disables or enables the ability to orgasm via standard SexLab sex activity (orgasms can still be forced by mods)
; sltdesc Only works if called during a scene, when the SexLab thread is still available
; sltargs Form: actor: target Actor
; sltargs bool: disable: true to disable, false to enable
; sltsamp sl_disableorgasm $system.player true
; sltsamp ; this disables orgasm for the player
; sltsamp sl_disableorgasm $system.player false
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
; sltdesc Returns: string: to the current SexLab animation name
; sltargs Form: actor: target Actor
; sltsamp sl_animname $system.self
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
; sltdesc Returns: string: the value of the requested SexLab thread property
; sltargs string: property:  Stage | ActorCount
; sltargs Form: actor: target Actor
; sltsamp sl_getprop Stage $system.self
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
; sltargs int: direction: <negative - backwards / non-negative (including zero) - forwards>
; sltargs Form: actor: target Actor
; sltsamp sl_advance -3 $system.self
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
; sltdesc Returns: bool: true if the specified actor is in the specified SexLab scene slot, false otherwise
; sltargs Form: actor: target Actor
; sltargs int: slotnumber: 1-based SexLab thread slot number
; sltsamp sl_isinslot $system.player 1
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
; sltargs Form: actor: target Actor
; sltsamp sl_orgasm $system.self
; sltsamp sl_orgasm $system.partner
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
; sltargs Form: actor: target Actor
; sltargs int: enjoyment: bonus enjoyment to apply
; sltsamp slso_bonus_enjoyment $system.self 30
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

; sltname sl_startsex
; sltgrup SexLab
; sltdesc Returns: int: Starts a SexLab scene and returns the threadid
; sltargs Form[]: actors: list containing the Actors to be in the scene, limited to 5
; sltargs Form: submissive: Form (Actor) to be the submissive in the scene; specify 'none' if no submissive to be set; must also be in the actors list
; sltargs string: tags: (From the SexLabFramework source) AnimationTags [OPTIONAL], is the list of tags the animation has to have. You can add more than one tag by separating them by commas "," (Example: "Oral, Aggressive, FemDom"), the animations will be collected if they have at least one of the specified tags.
; sltargs bool: allowBed: true to allow bed use, false otherwise
; sltsamp sl_startsex $actorList none "Oral, Anal" false
; sltsamp ; starts a sex scene with the given actor list, no submissives, oral or anal tagged only, with no beds allowed
; sltsamp sl_startsex $actorList $actorList[0] "Vaginal" true
; sltsamp ; starts a sex scene with the given actor list, the first on the list being the submissive, vaginal tagged only, beds allowed
function sl_startsex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 5)
        Actor[] actors = CmdPrimary.ResolveListActor(param[1])
        Actor submissive = CmdPrimary.ResolveActor(param[2])
        string tags = CmdPrimary.ResolveString(param[3])
        bool allowBeds = CmdPrimary.ResolveBool(param[4])
        sslBaseAnimation[] Anims
        SexLabFramework slapi = slExtension.SexLabForm as SexLabFramework
        if tags != ""
            int[] Genders = slapi.ActorLib.GenderCount(actors)
            if (Genders[2] + Genders[3]) < 1
                Anims = slapi.AnimSlots.GetByTags(actors.Length, tags, "", false)
            else
                Anims = slapi.CreatureSlots.GetByCreatureActorsTags(actors.Length, actors, tags, "", false)
            endif
        endif
        int tid = slapi.StartSex(actors, Anims, submissive, none, allowBeds, "")
        CmdPrimary.MostRecentIntResult = tid
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_find_available_partners
; sltgrup SexLab
; sltdesc Returns: Form[]: a list of Actors that are available for a SexLab scene based on the parameters provided.
; sltdesc Note: Actors you specify in 'requiredActors' are not guaranteed to be valid SexLab actors.
; sltdesc If no matches can be found or if totalRequired is less than requiredActors.Length, requiredActors is returned, even if it is none or an empty list.
; sltargs Form[]: requiredActors: list of Actors you require to be in the scene, limited to 5; size applies to totalRequired; specify none or an empty list if you have no required actors
; sltargs int: totalRequired: the total number of actors desired for the scene (including any in the 'actors' list); should be at least as large as requiredActors.Length and should not be greater than 5
; sltargs int: malesRequired: (optional: default: -1) minimum number of males desired for the scene, out of totalRequired; specify -1 to ignore the requirement
; sltargs int: femalesRequired: (optional: default: -1) minimum number of females desired for the scene, out of totalRequired; specify -1 to ignore the requirement
; sltargs float: radius: (optional: default: 10000.0) distance in Skyrim distance units to search for actors
; sltsamp ; declare a list of actors you require in the scene, in this case, just the player is required, we are looking for partners
; sltsamp   Form[] $playerOnlyList
; sltsamp   listadd $playerOnlyList $system.player
; sltsamp ; Assuming a match can be found, we are looking for having 2 total, starting with the player, adding 1 male, in a 2000 unit radius
; sltsamp   sl_find_available_partners $playerOnlyList 2 1 -1 2000.0
; sltsamp ; If instead you want the player plus 2 men and 1 woman, for a total of 4, searched in the default radius (of 10,000.0 distance units)
; sltsamp   sl_find_available_partners $playerOnlyList 4 2 1
; sltsamp ; Or if you want to match with anyone so long as you have a partner, taking all other defaults (this is the minimum number of arguments required)
; sltsamp   sl_find_available_partners $playerOnlyList 2
; sltsamp ; Make it random? 2-5, inclusive of the player?
; sltsamp   set $sceneSize resultfrom rnd_int 2 5
; sltsamp   set $scenePartners resultfrom sl_find_available_partners $playerOnlyList $sceneSize
; sltsamp ; and then you could call sl_startsex, for example, with the player as the submissive, no tag requirements, no beds allowed
; sltsamp   sl_startsex $scenePartners $system.player "" false
; sltsamp ; or if you want a more consensual scene, you could call sl_startsex, with none as the submissive, "Anal", and "Oral" tag requirements, no beds allowed
; sltsamp   sl_startsex $scenePartners none "Anal, Oral" false
function sl_find_available_partners(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor[] requiredActors = CmdPrimary.ResolveListActor(param[1])
        int totalRequired = CmdPrimary.ResolveInt(param[2])

        int malesRequired       = -1
        int femalesRequired     = -1
        float radius            = 10000.0

        if param.Length > 3
            malesRequired = CmdPrimary.ResolveInt(param[3])
            if param.Length > 4
                femalesRequired = CmdPrimary.ResolveInt(param[4])
                if param.Length > 5
                    radius = CmdPrimary.ResolveFloat(param[5])
                endif
            endif
        endif

        SexLabFramework slapi = slExtension.SexLabForm as SexLabFramework
        Actor[] result = slapi.FindAvailablePartners(requiredActors, totalRequired, malesRequired, femalesRequired, radius)
        Form[] formResult = ActorArrayToFormArray(result)

        CmdPrimary.MostRecentListFormResult = formResult
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_validate_actor
; sltgrup SexLab
; sltdesc Returns an int value
; sltrslt 1 - if valid, negative values with respective meanings for non-validity
; sltrslt -1 = The Actor does not exists (it is None)
; sltrslt -10 = The Actor is already part of a SexLab animation
; sltrslt -11 = The Actor is forbidden form SexLab animations
; sltrslt -12 = The Actor does not have the 3D loaded
; sltrslt -13 = The Actor is dead (He's dead Jim.)
; sltrslt -14 = The Actor is disabled
; sltrslt -15 = The Actor is flying (so it cannot be SexLab animated)
; sltrslt -16 = The Actor is on mount (so it cannot be SexLab animated)
; sltrslt -17 = The Actor is a creature but creature animations are disabled
; sltrslt -18 = The Actor is a creature that is not supported by SexLab
; sltrslt -19 = The Actor is a creature but there are no valid animations for this type of creature
; sltargs Form: actor: the Actor to determine SexLab scene validity for
; sltsamp sl_validate_actor $targetActor
function sl_validate_actor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor theActor = CmdPrimary.ResolveActor(param[1])
        if theActor
            SexLabFramework slapi = slExtension.SexLabForm as SexLabFramework
            CmdPrimary.MostRecentIntResult = slapi.ValidateActor(theActor)
        else
            CmdPrimary.SFW("sl_validate_actor: unable to resolve Actor from (" + param[1] + ")")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_is_valid_actor
; sltgrup SexLab
; sltdesc Returns: bool: true if the actor is valid for SexLab scenes, false otherwise
; sltargs Form: actor: the Actor to determine SexLab scene validity for
; sltsamp sl_is_valid_actor $targetActor
function sl_is_valid_actor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor theActor = CmdPrimary.ResolveActor(param[1])
        if theActor
            SexLabFramework slapi = slExtension.SexLabForm as SexLabFramework
            CmdPrimary.MostRecentBoolResult = slapi.IsValidActor(theActor)
        else
            CmdPrimary.SFW("sl_is_valid_actor: unable to resolve Actor from (" + param[1] + ")")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_allow_actor
; sltgrup SexLab
; sltdesc Allows the Actor to join SexLab scenes. Reverses forbiddance.
; sltargs Form: actor: the Actor to allow to join SexLab scenes
; sltsamp sl_allow_actor $targetActor
function sl_allow_actor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor theActor = CmdPrimary.ResolveActor(param[1])
        if theActor
            SexLabFramework slapi = slExtension.SexLabForm as SexLabFramework
            slapi.AllowActor(theActor)
        else
            CmdPrimary.SFW("sl_allow_actor: unable to resolve Actor from (" + param[1] + ")")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_forbid_actor
; sltgrup SexLab
; sltdesc Forbids the Actor from joining SexLab scenes.
; sltargs Form: actor: the Actor to forbid from joining SexLab scenes
; sltsamp sl_forbid_actor $targetActor
function sl_forbid_actor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor theActor = CmdPrimary.ResolveActor(param[1])
        if theActor
            SexLabFramework slapi = slExtension.SexLabForm as SexLabFramework
            slapi.ForbidActor(theActor)
        else
            CmdPrimary.SFW("sl_forbid_actor: unable to resolve Actor from (" + param[1] + ")")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_is_forbidden
; sltgrup SexLab
; sltdesc Returns: bool: true if the actor is forbidden from SexLab scenes, false otherwise
; sltargs Form: actor: the Actor to query about being forbidden from SexLab scenes
; sltsamp sl_is_forbidden $system.player
function sl_is_forbidden(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor theActor = CmdPrimary.ResolveActor(param[1])
        if theActor
            SexLabFramework slapi = slExtension.SexLabForm as SexLabFramework
            CmdPrimary.MostRecentBoolResult = slapi.IsForbidden(theActor)
        else
            CmdPrimary.SFW("sl_is_forbidden: unable to resolve Actor from (" + param[1] + ")")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_get_skill
; sltgrup SexLab
; sltdesc Returns: float: the float value of the specificed SexLab skill
; sltargs Form: actor: the Actor to query the skill of
; sltargs string: skillId: the SexLab skill ID
; sltargs   * Foreplay
; sltargs   * Vaginal
; sltargs   * Anal
; sltargs   * Oral
; sltargs   * Pure
; sltargs   * Lewd
; sltargs   * Males
; sltargs   * Females
; sltargs   * Creatures
; sltargs   * Masturbations
; sltargs   * Aggressor
; sltargs   * Victim
; sltargs   * SexCount
; sltargs   * PlayerSex
; sltargs   * Sexuality
; sltargs   * TimeSpent
; sltargs   * LastSex.RealTime
; sltargs   * LastSex.GameTime
; sltargs   * VaginalCount
; sltargs   * AnalCount
; sltargs   * OralCount
; sltsamp sl_get_skill $system.player 20
function sl_get_skill(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor theActor = CmdPrimary.ResolveActor(param[1])
        if theActor
            SexLabFramework slapi = slExtension.SexLabForm as SexLabFramework
            CmdPrimary.MostRecentFloatResult = slapi.Stats.GetSkillFloat(theActor, CmdPrimary.ResolveString(param[2]))
        else
            CmdPrimary.SFW("sl_is_forbidden: unable to resolve Actor from (" + param[1] + ")")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction