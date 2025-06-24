;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname PF_sl_triggers_PlayerTracker_01002E1B Extends Package Hidden

;BEGIN FRAGMENT Fragment_5
Function Fragment_5(Actor akActor)
;BEGIN CODE
(sltcorequest as sl_triggersExtensionCore).SLTR_Internal_PlayerNewSpaceEvent()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property sltcorequest  Auto  

Quest Property sltmainquest  Auto  
