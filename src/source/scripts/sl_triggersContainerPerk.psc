;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 24
scriptname sl_triggersContainerPerk extends Perk Hidden

;BEGIN FRAGMENT Fragment_18
Function Fragment_18(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
    SignalContainerActivation(akActor, akTargetRef, false, (akTargetRef.GetNumItems() == 0))
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
    SignalContainerActivation(akActor, akTargetRef, true, (akTargetRef.GetNumItems() == 0))
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

;i;mport sl_triggersStatics

Actor Property                          PlayerRef Auto
sl_triggersMain Property                SLTRMain auto
sl_triggersExtensionCore Property       SLTRCore auto
ObjectReference Property                ContainerRef Auto

int Property IS_CORPSE = 1 autoreadonly Hidden
int Property IS_CONTAINER = 2 AutoReadOnly Hidden

int dt_origintype = 0
bool is_container_empty

Function SignalContainerActivation(Actor _akActor, ObjectReference _containerRef, bool is_origin_corpse, bool is_target_empty)
    ; we should probably do something here
    if SLTRCore
        if _akActor == PlayerRef
            SLTRCore.SLTR_Internal_PlayerActivatedContainer(_containerRef, is_origin_corpse, is_target_empty)
        ;else
            ;sl_triggersStatics.SLTDebugMsg("\n\n\t\t>>>>>>>>>>    Perk.SignalContainerActivation for Actor(" + _akActor + ")")
            ;sl_triggersStatics.SLTDebugMsg("\n\n\t\t>>>>>>>>>>    _containerRef(" + _containerRef + ") corpse(" + is_origin_corpse + ") empty(" + is_target_empty + ")")
        endif
    else
        sl_triggersStatics.SLTErrMsg("Perk.SignalContainerActivation: SLTRCore is not available; this is bad")
    endif
EndFunction
