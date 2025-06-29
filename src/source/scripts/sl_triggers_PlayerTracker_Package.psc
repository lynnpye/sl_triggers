;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname sl_triggers_PlayerTracker_Package Extends Package Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(Actor akActor)
;BEGIN CODE
if !SLTRCore
    SLTRCore = sl_triggersStatics.GetForm_SLT_ExtensionCore() as sl_triggersExtensionCore
    ;sl_triggersStatics.SLTInfoMsg("PlayerTrackePackage.Fragment_1: Initializin SLTRCore")
endif
if SLTRCore
    SLTRCore.SLTR_Internal_PlayerNewSpaceEvent()
else
    sl_triggersStatics.SLTErrMsg("PlayerTrackerPackage.Fragment_1: SLTRCore not available")
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

sl_triggersMain Property SLTRMain Auto
sl_triggersExtensionCore Property SLTRCore Auto
