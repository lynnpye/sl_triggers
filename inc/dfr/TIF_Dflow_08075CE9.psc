;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname TIF_Dflow_08075CE9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int a = Dealq.getstage() as int
a += 1
Dealq.setstage(a)
(tool as _DFtools).ReduceResist(a)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
q.DealDebt()
(GetOwningQuest() as  QF__DflowDealController_0A01C86D).DealAdd(1)
if Dealq.GetStage() == 3
(GetOwningQuest() as  QF__DflowDealController_0A01C86D).DealMaxAdd(1)
Endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property q Auto
Quest Property Dealq  Auto  
Quest Property tool Auto
