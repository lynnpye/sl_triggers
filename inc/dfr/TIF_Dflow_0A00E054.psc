;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_Dflow_0A00E054 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(q as _DflowFollowerController).AddFollowerLend(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property HasHirelingGV  Auto  

GlobalVariable Property HirelingRecognizeErik  Auto  
Faction Property fac  Auto  
Quest property q auto

ReferenceAlias Property ra  Auto  
