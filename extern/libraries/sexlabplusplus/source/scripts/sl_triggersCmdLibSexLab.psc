scriptname sl_triggersCmdLibSexLab

import sl_triggersStatics

sl_triggersExtensionSexLab Function GetExtension() global
    return GetForm_SLT_ExtensionSexLab() as sl_triggersExtensionSexLab
EndFunction

; sltname sl_getversion
; sltgrup SexLab P+
; sltdesc Returns: int: the SexLab version as an int (from SexLabUtil.GetVersion())
; sltsamp set $slversion resultfrom sl_getversion
function sl_getversion(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentIntResult = SexLabUtil.GetVersion()

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_getversionstring
; sltgrup SexLab P+
; sltdesc Returns: string: the SexLab version as a string (from SexLabUtil.GetStringVer())
; sltsamp set $slversionstring resultfrom sl_getversionstring
function sl_getversionstring(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentStringResult = SexLabUtil.GetStringVer()

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_getapi
; sltgrup SexLab P+
; sltdesc Returns: Form: the SexLabFramework API object (from SexLabUtil.GetAPI())
; sltsamp set $slapi resultfrom sl_getapi
function sl_getapi(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentFormResult = SexLabUtil.GetAPI()

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_isactive
; sltgrup SexLab P+
; sltdesc Returns: bool: active status of SexLab (from SexLabUtil.SexLabIsActive()): true if active, false otherwise
; sltsamp set $sl_is_active resultfrom sl_isactive
function sl_isactive(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentBoolResult = SexLabUtil.SexLabIsActive()

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_isready
; sltgrup SexLab P+
; sltdesc Returns: bool: ready status of SexLab (from SexLabUtil.SexLabIsReady()): true if ready, false otherwise
; sltsamp set $sl_is_ready resultfrom sl_isready
function sl_isready(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    CmdPrimary.MostRecentBoolResult = SexLabUtil.SexLabIsReady()

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname actor_getgender
; sltgrup SexLab P+
; sltdesc Returns: int: the actor's SexLab gender, 0 - male, 1 - female, 2 - futa, 3 - male creature, 4 - female creature
; sltargs Form: actor: target Actor
; sltsamp actor_getgender $actor
function actor_getgender(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    int nextResult

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            nextResult = (slExtension.SexLabForm as SexLabFramework).GetSex(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentIntResult = nextResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname util_waitforend
; sltgrup SexLab P+
; sltdesc Wait until specified actor is not in SexLab scene
; sltargs Form: actor: target Actor
; sltsamp util_waitforend $system.self
; sltrslt Wait until the scene ends
function util_waitforend(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

	if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        
        while (slExtension.SexLabForm as SexLabFramework).IsActorActive(_targetActor) && CmdPrimary.InSameCell(_targetActor)
            Utility.wait(4)
        endWhile
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_getrndactor
; sltgrup SexLab P+
; sltdesc Returns: Form: a random actor within specified range of self
; sltargs float: range: (0 - all | >0 - range in Skyrim units)
; sltargs int: option: (0 - all | 1 - not in SexLab scene | 2 - must be in SexLab scene) (optional: default 0 - all)
; sltsamp sl_getrndactor 500 2
; sltsamp actor_isvalid $actor
; sltsamp if $$ = false [end]
; sltsamp msg_notify "Someone is nearby!"
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
            bool xenabled = slExtension.IsEnabled
        
            int i = 0
            int nuns = 0
            while i < inCell.Length
                Actor _targetActor = inCell[i]
                if !_targetActor || _targetActor == CmdPrimary.PlayerRef || !_targetActor.isEnabled() || _targetActor.isDead() || _targetActor.isInCombat() || _targetActor.IsUnconscious() || (ActorTypeNPC && !_targetActor.HasKeyWord(ActorTypeNPC)) || !_targetActor.Is3DLoaded() || (cc && cc != _targetActor.getParentCell()) || (mode == 1 && xenabled &&  (slExtension.SexLabForm as SexLabFramework).IsActorActive(_targetActor)) || (mode == 2 && xenabled && !((slExtension.SexLabForm as SexLabFramework).IsActorActive(_targetActor)))
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
; sltargs actor: target Actor
; sltargs sub-function: sub-function
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
                nextResult = SexlabRegistry.GetRaceKey(_targetActor)
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
; sltgrup SexLab P+
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
            if (CmdTargetActor != CmdPrimary.PlayerRef) || (cnt <= 1) || !(slExtension.IsEnabled && (slExtension.SexLabForm as SexLabFramework).IsActorActive(CmdPrimary.PlayerRef))
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
                
                while CmdPrimary && CmdPrimary.LastKey == 0 && (slExtension.IsEnabled && (slExtension.SexLabForm as SexLabFramework).IsActorActive(plyrf))
                    Utility.Wait(0.5)
                endWhile
                
                if CmdPrimary
                    CmdPrimary.UnregisterForAllKeys()
                    
                    if slExtension.IsEnabled && !((slExtension.SexLabForm as SexLabFramework).IsActorActive(plyrf))
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
; sltgrup SexLab P+
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
; sltgrup SexLab P+
; sltdesc Returns: bool: true if the specified actor is in a SexLab scene, false otherwise
; sltargs Form: actor: target Actor
; sltsamp sl_isin $system.self
function sl_isin(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()
    
    bool nextResult = false

	if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor && (slExtension.SexLabForm as SexLabFramework).IsActorActive(_targetActor) && CmdPrimary.InSameCell(_targetActor)
            nextResult = true
        endIf
    endif

    CmdPrimary.MostRecentBoolResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_hastag
; sltgrup SexLab P+
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
        SexLabThread slthread = (slExtension.SexLabForm as SexLabFramework).GetThreadByActor(_targetActor)
        if slthread
            nextResult = slthread.HasTag(CmdPrimary.ResolveString(param[1]))
        endIf
    endif
    
    CmdPrimary.MostRecentBoolResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_disableorgasm
; sltgrup SexLab P+
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
            SexLabThread slthread = (slExtension.SexLabForm as SexLabFramework).GetThreadByActor(_targetActor)
            slthread.DisableOrgasm(_targetActor, CmdPrimary.ResolveBool(param[2]))
        endif
	endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_animname
; sltgrup SexLab P+
; sltdesc Returns: string: the current SexLab animation name
; sltdesc WARNING: This uses a deprecated API until/unless an up to date alternative can be found.
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
; sltgrup SexLab P+
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
        SexLabThread slthread = (slExtension.SexLabForm as SexLabFramework).GetThreadByActor(_targetActor)
        if slthread
            string ss = CmdPrimary.ResolveString(param[1])
            if ss == "Stage"
                nextResult = slthread.GetActiveStage()
            elseif ss == "ActorCount"
                nextResult = slthread.GetPositions().Length
            endIf
        endIf
    endif

    CmdPrimary.MostRecentStringResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_advance
; sltgrup SexLab P+
; sltdesc Changes the stage of the current SexLab scene, for the target Actor; advances a single stage if positive, reverses a single stage if negative
; sltdesc WARNING: This uses a deprecated API until/unless an up to date alternative can be found.
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
; sltgrup SexLab P+
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
            SexLabThread slthread = (slExtension.SexLabForm as SexLabFramework).GetThreadByActor(_targetActor)
            if slthread
                int slPosition = CmdPrimary.ResolveInt(param[2])
                if slPosition > 0 && slPosition < 5
                    int targetPosition = slthread.GetPositionIdx(_targetActor)
                    nextResult = (targetPosition == (slPosition - 1))
                endif
            endif
        endif
	endif
	
	CmdPrimary.MostRecentBoolResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_orgasm
; sltgrup SexLab P+
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
            SexLabThread slthread = (slExtension.SexLabForm as SexLabFramework).GetThreadByActor(_targetActor)
            if slthread
                slthread.ForceOrgasm(_targetActor)
            endif
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_startsex
; sltgrup SexLab P+
; sltdesc Returns: int: Starts a SexLab scene and returns the threadid
; sltargs Form[]: actors: list containing the Actors to be in the scene, limited to 5
; sltargs Form: submissive: Form (Actor) to be the submissive in the scene; specify 'none' if no submissive to be set; must also be in the actors list
; sltargs string: tags: (From the SexLabFramework source) Requested animation tags (may be empty). Supported prefixes: '-' to disable a tag, '~' for OR-conjunctions
; sltargs                Example: "~A, B, ~C, -D" <=> Animation has tag B, does NOT have tag D and has EITHER tag A or C 
; sltargs int: furniture: 0 - Disable, 1 - Allow, 2 - Prefer
; sltsamp sl_startsex $actorList none "Oral, Anal" 0
; sltsamp ; starts a sex scene with the given actor list, no submissives, oral or anal tagged, with no beds allowed
; sltsamp sl_startsex $actorList $actorList[0] "Vaginal" 1
; sltsamp ; starts a sex scene with the given actor list, the first on the list being the submissive, vaginal tagged, beds allowed but not necessarily preferred
function sl_startsex(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 5)
        Actor[] actors = CmdPrimary.ResolveListActor(param[1])
        Actor submissive = CmdPrimary.ResolveActor(param[2])
        string tags = CmdPrimary.ResolveString(param[3])
        int allowBeds = CmdPrimary.ResolveInt(param[4])

        SexLabFramework slapi = slExtension.SexLabForm as SexLabFramework
        SexLabThread slthread = slapi.StartScene(actors, tags, submissive, none, allowBeds, "")
        CmdPrimary.MostRecentIntResult = slthread.GetThreadId()
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_find_available_partners
; sltgrup SexLab P+
; sltdesc Returns: Form[]: a list of Actors that are available for a SexLab scene based on the parameters provided.
; sltdesc Note: This currently relies on deprecated API calls.
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
; sltgrup SexLab P+
; sltdesc Returns: int: 
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
; sltargs Form actor: the Actor to determine SexLab scene validity for
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
; sltgrup SexLab P+
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
; sltgrup SexLab P+
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
; sltgrup SexLab P+
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
; sltgrup SexLab P+
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

; sltname sl_get_statistic
; sltgrup SexLab P+
; sltdesc Returns: float: the value of the specificed SexLab statistic
; sltargs Form: actor: the Actor to query the statistic of
; sltargs int: statisticID: the SexLab statistic ID
; sltargs   * 0 - LastUpdate_GameTime
; sltargs   * 1 - SecondsInScene
; sltargs   * 2 - XP_Vaginal
; sltargs   * 3 - XP_Anal
; sltargs   * 4 - XP_Oral
; sltargs   * 5 - PartnersMale
; sltargs   * 6 - PartnersFemale
; sltargs   * 7 - PartnersFuta
; sltargs   * 8 - PartnersCreature
; sltargs   * 9 - TimesOral
; sltargs   * 10 - TimesVaginal
; sltargs   * 11 - TimesAnal
; sltargs   * 12 - TimesMasturbated
; sltargs   * 13 - TimesSubmissive
; sltargs   * 14 - TimesDominant
; sltargs   * 15 - TimesTotal
; sltargs   * 16 - Sexuality
; sltargs   * 17 - Arousal
; sltsamp sl_get_statistic $system.player 15
function sl_get_statistic(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor theActor = CmdPrimary.ResolveActor(param[1])
        if theActor
            CmdPrimary.MostRecentFloatResult = SexLabStatistics.GetStatistic(theActor, CmdPrimary.ResolveInt(param[2]))
        else
            CmdPrimary.SFW("sl_is_forbidden: unable to resolve Actor from (" + param[1] + ")")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_count_cum
; sltgrup SexLab P+
; sltdesc Returns: int: count of cum layers for the actor of the specified type(s)
; sltargs Form: actor: the Actor to query about being forbidden from SexLab scenes
; sltargs bool: vaginal: if true, count vaginal cum layers (optional: default: true)
; sltargs bool: oral: if true, count oral cum layers (optional: default: true)
; sltargs bool: anal: if true, count anal cum layers (optional: default: true)
; sltsamp ; to count only vaginal and anal cum layers
; sltsamp sl_count_cum $system.self true false true
; sltsamp ; to count only vaginal layers
; sltsamp sl_count_cum $system.self true
function sl_count_cum(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthGT(CmdPrimary, param.Length, 1)
        Actor theActor = CmdPrimary.ResolveActor(param[1])
        if theActor
            SexLabFramework slapi = slExtension.SexLabForm as SexLabFramework
            bool vaginal = true
            bool oral = true
            bool anal = true
            If (param.Length > 2)
                vaginal = CmdPrimary.ResolveBool(param[2])
                If (param.Length > 3)
                    oral = CmdPrimary.ResolveBool(param[3])
                    If (param.Length > 4)
                        anal = CmdPrimary.ResolveBool(param[4])
                    EndIf
                EndIf
            EndIf
            int count = 0
            If (vaginal)
                count += slapi.CountCumFx(theActor, 0)
            EndIf
            If (anal)
                count += slapi.CountCumFx(theActor, 1)
            EndIf
            If (oral)
                count += slapi.CountCumFx(theActor, 2)
            EndIf
            CmdPrimary.MostRecentIntResult = count
        else
            CmdPrimary.SFW("sl_count_cum: unable to resolve Actor from (" + param[1] + ")")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_clear_cum
; sltgrup SexLab P+
; sltdesc Clears cum layers from the target actor
; sltargs Form: actor: the target Actor
; sltargs bool: vaginal: if true, count vaginal cum layers (optional: default: true)
; sltargs bool: oral: if true, count oral cum layers (optional: default: true)
; sltargs bool: anal: if true, count anal cum layers (optional: default: true)
; sltsamp sl_clear_cum $system.self
function sl_clear_cum(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthGT(CmdPrimary, param.Length, 1)
        Actor theActor = CmdPrimary.ResolveActor(param[1])
        if theActor
            SexLabFramework slapi = slExtension.SexLabForm as SexLabFramework
            bool vaginal = true
            bool oral = true
            bool anal = true
            If (param.Length > 2)
                vaginal = CmdPrimary.ResolveBool(param[2])
                If (param.Length > 3)
                    oral = CmdPrimary.ResolveBool(param[3])
                    If (param.Length > 4)
                        anal = CmdPrimary.ResolveBool(param[4])
                    EndIf
                EndIf
            EndIf
            If (vaginal)
                slapi.RemoveCumFx(theActor, 0)
            EndIf
            If (anal)
                slapi.RemoveCumFx(theActor, 1)
            EndIf
            If (oral)
                slapi.RemoveCumFx(theActor, 2)
            EndIf
        else
            CmdPrimary.SFW("sl_clear_cum: unable to resolve Actor from (" + param[1] + ")")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname sl_add_cum
; sltgrup SexLab P+
; sltdesc Adds a cum layer to each requested slot for the target Actor
; sltargs Form: actor: the Actor to query about being forbidden from SexLab scenes
; sltargs bool: vaginal: if true, count vaginal cum layers (optional: default: true)
; sltargs bool: oral: if true, count oral cum layers (optional: default: true)
; sltargs bool: anal: if true, count anal cum layers (optional: default: true)
; sltargs int: count: number of layers to add (optional: default: 1)
; sltsamp ; to add an anal cum layer
; sltsamp sl_add_cum $system.self false false true
; sltsamp ; to add an oral cum layer
; sltsamp sl_add_cum $system.self false true
; sltsamp ; to add 2 vaginal cum layers
; sltsamp sl_add_cum $system.self true false false 2
; sltsamp ; to add 2 vaginal and anal cum layers
; sltsamp sl_add_cum $system.self true false true 2
function sl_add_cum(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionSexLab slExtension = GetExtension()

    if slExtension.IsEnabled && ParamLengthGT(CmdPrimary, param.Length, 1)
        Actor theActor = CmdPrimary.ResolveActor(param[1])
        if theActor
            SexLabFramework slapi = slExtension.SexLabForm as SexLabFramework
            bool vaginal = true
            bool oral = true
            bool anal = true
            int count = 1
            If (param.Length > 2)
                vaginal = CmdPrimary.ResolveBool(param[2])
                If (param.Length > 3)
                    oral = CmdPrimary.ResolveBool(param[3])
                    If (param.Length > 4)
                        anal = CmdPrimary.ResolveBool(param[4])
                        If (param.Length > 5)
                            count = CmdPrimary.ResolveInt(param[5])
                        EndIf
                    EndIf
                EndIf
            EndIf
            If (vaginal)
                slapi.AddCumFxLayers(theActor, 0, count)
            EndIf
            If (anal)
                slapi.AddCumFxLayers(theActor, 1, count)
            EndIf
            If (oral)
                slapi.AddCumFxLayers(theActor, 2, count)
            EndIf
        else
            CmdPrimary.SFW("sl_add_cum: unable to resolve Actor from (" + param[1] + ")")
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction