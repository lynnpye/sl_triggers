scriptname sl_triggersCmdLibOStim

import sl_triggersStatics

sl_triggersExtensionOstim Function GetExtension() global
    return GetForm_SLT_ExtensionOstim() as sl_triggersExtensionOstim
EndFunction

; sltname util_waitforend
; sltgrup OStim
; sltdesc Wait until specified actor is not in OStim scene
; sltargs actor: target Actor
; sltsamp util_waitforend $self
; sltrslt Wait until the scene ends
function util_waitforend(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()

	if sltrex.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        
        while OActor.IsInOStim(_targetActor) && CmdPrimary.InSameCell(_targetActor)
            Utility.wait(4)
        endWhile
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ostim_getrndactor
; sltgrup OStim
; sltdesc Return a random actor within specified range of self
; sltargs range: (0 - all | >0 - range in Skyrim units)
; sltargs option: (0 - all | 1 - not in OStim scene | 2 - must be in OStim scene) (optional: default 0 - all)
; sltsamp ostim_getrndactor 500 2
; sltsamp actor_isvalid $actor
; sltsamp if $$ = 0 end
; sltsamp msg_notify "Someone is watching you!"
; sltsamp [end]
function ostim_getrndactor(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()

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
            bool isInOStimScene
            bool xenabled = sltrex.IsEnabled
        
            int i = 0
            int nuns = 0
            while i < inCell.Length
                Actor _targetActor = inCell[i]
                isInOStimScene = OActor.IsInOStim(_targetActor)
                if !_targetActor || _targetActor == CmdPrimary.PlayerRef || !_targetActor.isEnabled() || _targetActor.isDead() || _targetActor.isInCombat() || _targetActor.IsUnconscious() || (ActorTypeNPC && !_targetActor.HasKeyWord(ActorTypeNPC)) || !_targetActor.Is3DLoaded() || (cc && cc != _targetActor.getParentCell()) || (mode == 1 && xenabled && isInOStimScene) || (mode == 2 && xenabled && !isInOStimScene)
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

; sltname ostim_waitforkbd
; sltgrup OStim
; sltdesc Returns the keycode pressed after waiting for user to press any of the specified keys or for the end of the OStim scene
; sltdesc (See https://ck.uesp.net/wiki/Input_Script for the DXScanCodes)
; sltargs actor: target Actor
; sltargs dxscancode: DXScanCode of key [<DXScanCode of key> ...]
; sltsamp ostim_waitforkbd 74 78 181 55
; sltsamp if $$ = 74 MINUS
; sltsamp ...
; sltsamp if $$ < 0 END
; sltrslt Wait for Num-, Num+, Num/, or Num*, or animation expired, and then do something based on the result.
function ostim_waitforkbd(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()

    int nextResult = -1

	if ParamLengthGT(CmdPrimary, param.Length, 1)
        int cnt = param.length
        int idx
        int startidx = 1
        int scancode

        if CmdTargetActor
            bool playerInOStim =  OActor.IsInOStim(CmdPrimary.PlayerRef)
            if (CmdTargetActor != CmdPrimary.PlayerRef) || (cnt <= 1) || !(sltrex.IsEnabled && playerInOStim)
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
                
                while CmdPrimary && CmdPrimary.LastKey == 0 && (sltrex.IsEnabled && playerInOStim)
                    Utility.Wait(0.5)
                endWhile
                
                if CmdPrimary
                    CmdPrimary.UnregisterForAllKeys()
                    
                    if sltrex.IsEnabled && !playerInOStim
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

; stlname ostim_getexcitement
; sltgrup OStim
; sltdesc float: Returns current actor excitement
; sltargs actor: target Actor
; sltsamp ostim_getexcitement $system.player
function ostim_getexcitement(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()

    float nextResult = 0

	if sltrex.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor && OActor.IsInOStim(_targetActor)
            nextResult = OActor.GetExcitement(_targetActor)
        endIf
    endif

    CmdPrimary.MostRecentFloatResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; stlname ostim_setexcitement
; sltgrup OStim
; sltdesc float: Sets current actor excitement
; sltargs actor: target Actor
; sltargs value: new excitement value (float)
; sltsamp ostim_setexcitement $system.player 20.0
function ostim_setexcitement(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()

	if sltrex.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor && OActor.IsInOStim(_targetActor)
            OActor.SetExcitement(_targetActor, CmdPrimary.ResolveFloat(param[2]))
        endIf
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; stlname ostim_getexcitementmultiplier
; sltgrup OStim
; sltdesc float: Returns current actor excitementmultiplier
; sltargs actor: target Actor
; sltsamp ostim_getexcitementmultiplier $system.player
function ostim_getexcitementmultiplier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()

    float nextResult = 0

	if sltrex.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor && OActor.IsInOStim(_targetActor)
            nextResult = OActor.GetExcitementMultiplier(_targetActor)
        endIf
    endif

    CmdPrimary.MostRecentFloatResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; stlname ostim_setexcitementmultiplier
; sltgrup OStim
; sltdesc float: Sets current actor excitementmultiplier
; sltargs actor: target Actor
; sltargs value: new excitementmultiplier value (float)
; sltsamp ostim_setexcitementmultiplier $system.player 20.0
function ostim_setexcitementmultiplier(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()

	if sltrex.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor && OActor.IsInOStim(_targetActor)
            OActor.SetExcitementMultiplier(_targetActor, CmdPrimary.ResolveFloat(param[2]))
        endIf
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; stlname ostim_modifyexcitement
; sltgrup OStim
; sltdesc float: Modifies current actor excitement by the given amount
; sltargs Actor actor: target Actor
; sltargs float modvalue: excitement value (float) to apply to excitement
; sltargs bool respectMultiplier: (optional; default:false) will the modvalue have the OStim ExcitementMultiplier applied
; sltsamp ostim_modifyexcitement $system.player 20.0 true
; sltsamp ; this call will have the multiplier applied
function ostim_modifyexcitement(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()

	if sltrex.IsEnabled && ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor && OActor.IsInOStim(_targetActor)
            bool respectMultiplier = false
            If (param.Length > 3)
                respectMultiplier = CmdPrimary.ResolveBool(param[3])
            EndIf
            OActor.ModifyExcitement(_targetActor, CmdPrimary.ResolveFloat(param[2]), respectMultiplier)
        endIf
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ostim_isin
; sltgrup OStim
; sltdesc Sets $$ to true if the specified actor is in a OStim scene, false otherwise
; sltargs actor: target Actor
; sltsamp ostim_isin $system.self
function ostim_isin(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()
    
    bool nextResult = false

	if sltrex.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor && CmdPrimary.InSameCell(_targetActor)
            nextResult = OActor.IsInOStim(_targetActor)
        endIf
    endif

    CmdPrimary.MostRecentBoolResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ostim_findaction
; sltgrup OStim
; sltdesc int: Returns the action index if the OStim scene metadata has the specified action, -1 otherwise
; sltargs string: action: action name e.g. "vaginalsex", "analsex", "blowjob"
; sltargs actor: (optional; default:Player) target Actor
; sltsamp ostim_findaction "blowjob" $system.self
; sltsamp if $$ = true [doORALthing]
function ostim_findaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()
    
    int nextResult = -1
	
	if sltrex.IsEnabled && ParamLengthLT(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdTargetActor
        if param.Length > 2
            _targetActor = CmdPrimary.ResolveActor(param[2])
        endif
        int tid = OActor.GetSceneID(_targetActor)
        If (tid > -1)
            string sceneID = OThread.GetScene(tid)
            nextResult = OMetadata.FindAction(sceneID, CmdPrimary.ResolveString(param[1]))
        EndIf
    endif
    
    CmdPrimary.MostRecentIntResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ostim_hasaction
; sltgrup OStim
; sltdesc bool: Returns true if the OStim scene metadata has the specified action, false otherwise
; sltargs string: action: action name e.g. "vaginalsex", "analsex", "blowjob"
; sltargs actor: (optional; default:Player) target Actor
; sltsamp ostim_hasaction "blowjob" $system.self
; sltsamp if $$ = true [doORALthing]
function ostim_hasaction(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()
    
    bool nextResult
	
	if sltrex.IsEnabled && ParamLengthLT(CmdPrimary, param.Length, 4)
        Actor _targetActor = CmdTargetActor
        if param.Length > 2
            _targetActor = CmdPrimary.ResolveActor(param[2])
        endif
        int tid = OActor.GetSceneID(_targetActor)
        If (tid > -1)
            string sceneID = OThread.GetScene(tid)
            nextResult = (OMetadata.FindAction(sceneID, CmdPrimary.ResolveString(param[1])) > -1)
        EndIf
    endif
    
    CmdPrimary.MostRecentBoolResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ostim_stallclimax
; sltgrup OStim
; sltdesc prevents this actor from climaxing, including the prevention of auto climax animations
; sltdesc does not prevent the climaxes of auto climax animations that already started
; sltargs actor: target Actor
; sltsamp ostim_stallclimax $system.player
function ostim_stallclimax(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()
	
	if sltrex.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            OActor.StallClimax(_targetActor)
        endif
	endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ostim_permitclimax
; sltgrup OStim
; sltdesc permits this actor to climax again (as in it undoes ostim_stallclimax)
; sltargs actor: target Actor
; sltsamp ostim_permitclimax $system.player
function ostim_permitclimax(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()
	
	if sltrex.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            OActor.PermitClimax(_targetActor)
        endif
	endif

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ostim_isclimaxstalled
; sltgrup OStim
; sltdesc returns whether the actor is prevented from climaxing
; sltargs actor: target Actor
; sltsamp ostim_isclimaxstalled $system.player
function ostim_isclimaxstalled(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()

    bool nextResult
	
	if sltrex.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            nextResult = OActor.IsClimaxStalled(_targetActor)
        endif
	endif

    CmdPrimary.MostRecentBoolResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ostim_getthreadid
; sltgrup OStim
; sltdesc int: returns the ThreadID for the OStim thread the target actor is in; -1 if not in a thread
; sltsamp ostim_getthreadid $system.self
function ostim_getthreadid(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()

    int nextResult
	
	if sltrex.IsEnabled && ParamLengthLT(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdTargetActor
        if param.Length > 1
            _targetActor = CmdPrimary.ResolveActor(param[1])
        endif
        nextResult = OActor.GetSceneId(_targetActor)
    endif

    CmdPrimary.MostRecentIntResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ostim_getsceneid
; sltgrup OStim
; sltdesc string: returns the SceneID the targetActor is in; "" if not in a scene
; sltsamp ostim_getsceneid $system.self
; sltsamp msg_notify "SceneID: " $$
function ostim_getsceneid(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()

    string nextResult = ""
	
	if sltrex.IsEnabled && ParamLengthLT(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdTargetActor
        if param.Length > 1
            _targetActor = CmdPrimary.ResolveActor(param[1])
        endif
        nextResult = OThread.GetScene(OActor.GetSceneId(_targetActor))
    endif

    CmdPrimary.MostRecentStringResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ostim_animname
; sltgrup OStim
; sltdesc Sets $$ to the current OStim animation name
; sltsamp ostim_animname $system.self
; sltsamp msg_notify "Playing: " $$
function ostim_animname(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()

    string nextResult = ""
	
	if sltrex.IsEnabled && ParamLengthLT(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdTargetActor
        if param.Length > 1
            _targetActor = CmdPrimary.ResolveActor(param[1])
        endif
        nextResult = OMetadata.GetName(OThread.GetScene(OActor.GetSceneId(_targetActor)))
    endif

    CmdPrimary.MostRecentStringResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ostim_actorcount
; sltgrup OStim
; sltdesc Returns the actorcount of the OStim scene the targetActor is in; 0 if not in a scene
; sltargs Actor: targetActor: the actor whose scene you want the actor count from
; sltsamp ostim_actorcount $system.self
function ostim_actorcount(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()

    int nextResult
	
	if sltrex.IsEnabled && ParamLengthLT(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdTargetActor
        if param.Length > 1
            _targetActor = CmdPrimary.ResolveActor(param[1])
        endif
        nextResult = OMetadata.GetActorCount(OThread.GetScene(OActor.GetSceneId(_targetActor)))
    endif

    CmdPrimary.MostRecentIntResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ostim_isinslot
; sltgrup OStim
; sltdesc Sets $$ to true if the specified actor is in the specified OStim scene slot, false otherwise
; sltargs actor: target Actor
; sltargs slotnumber: 1-based OStim actor position number
; sltsamp ostim_isinslot $system.player 1
function ostim_isinslot(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()
    
    bool nextResult = false
	
	if sltrex.IsEnabled && ParamLengthEQ(CmdPrimary, param.Length, 3)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            int tid = OActor.GetSceneID(_targetActor)

            int actorpos = OThread.GetActorPosition(tid, _targetActor) + 1
            nextResult = (actorPos == CmdPrimary.ResolveInt(param[2]))
        endif
	endif
	
	CmdPrimary.MostRecentBoolResult = nextResult

    CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname ostim_climax
; sltgrup OStim
; sltdesc Immediately forces the specified actor to have a OStim orgasm.
; sltdesc May only work during OStim scenes
; sltargs actor: target Actor
; sltargs bool: ignoreStall: (optional; default:false) should the ClimaxStalled setting be ignored
; sltsamp ostim_climax $system.self
; sltsamp ostim_climax $system.partner
; sltrslt Simultaneous orgasms
function ostim_climax(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    sl_triggersExtensionOstim sltrex = GetExtension()
    
    if sltrex.IsEnabled && ParamLengthGT(CmdPrimary, param.Length, 1)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
            bool ignoreStall
            If (param.Length > 2)
                ignoreStall = CmdPrimary.ResolveBool(param[2])
            EndIf
            OActor.Climax(_targetActor, ignoreStall)
        endif
    endif

    CmdPrimary.CompleteOperationOnActor()
endFunction