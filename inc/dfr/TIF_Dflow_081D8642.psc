;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_Dflow_081D8642 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningQuest() as _DFlowModDealController).SetAliasForScene(AkSpeaker)

(GetOwningQuest() as _DFlowModDealController).StartInnScene()
(GetOwningQuest() as _DFlowModDealController).CheckTrigger(13)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Alias Property Guard  Auto  

ReferenceAlias Property Guard1  Auto  
