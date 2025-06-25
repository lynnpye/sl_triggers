;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname sl_triggers_PlayerTracker_Package Extends Package Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(Actor akActor)
;BEGIN CODE
SLTRCore.SLTR_Internal_PlayerNewSpaceEvent()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

sl_triggersMain Property SLTRMain Auto
sl_triggersExtensionCore Property SLTRCore Auto
