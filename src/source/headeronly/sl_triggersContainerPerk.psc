;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 24
scriptname sl_triggersContainerPerk extends Perk Hidden

;BEGIN FRAGMENT Fragment_18
Function Fragment_18(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
    sl_triggersStatics.SLTDebugMsg("Perk.Fragment_18")
    if akActor == PlayerRef
        sl_triggersStatics.SLTDebugMsg("ContainerPerk.Fragment_9")
        ContainerRef = akTargetRef
        dt_origintype = IS_CONTAINER

        string name = akTargetRef.GetDisplayName()
        if name == "Sack" || name == "Large Sack" || name == "Burial Urn"
            Utility.WaitMenuMode(0.3) ; Short Container Delay
        else
            Utility.WaitMenuMode(0.8) ; Long Animated Container Delay - includes Barrel and Urn
        endif

        SignalContainerActivation()
    endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
    sl_triggersStatics.SLTDebugMsg("Perk.Fragment_3")
    if akActor == PlayerRef
        sl_triggersStatics.SLTDebugMsg("ContainerPerk.Fragment_3")
        ContainerRef = akTargetRef
        dt_origintype = IS_CORPSE
        SignalContainerActivation()
    endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

import sl_triggersStatics

Actor Property                          PlayerRef Auto
sl_triggersMain Property                SLTRMain auto
sl_triggersExtensionCore Property       SLTRCore auto
ObjectReference Property                ContainerRef Auto

int Property IS_CORPSE = 1 autoreadonly Hidden
int Property IS_CONTAINER = 2 AutoReadOnly Hidden

int dt_origintype = 0
bool is_container_empty

Function SignalContainerActivation()
    sl_triggersStatics.SLTDebugMsg("Perk.SignalContainerActivation")
    ; we should probably do something here
    SLTRCore.SLTR_Internal_PlayerActivatedContainer(ContainerRef, dt_origintype == IS_CORPSE, (ContainerRef.GetNumItems() == 0))
EndFunction