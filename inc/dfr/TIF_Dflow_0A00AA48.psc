;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 13
Scriptname TIF_Dflow_0A00AA48 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_12
Function Fragment_12(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;WARNING: Unable to load fragment source from function Fragment_11 in script TIF_Dflow_0A00AA48
;Source NOT loaded
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningQuest() as DFR_DeviceController).Remove(5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

Actor Property PlayerRef  Auto  

Armor Property I  Auto  

Armor Property R  Auto  
QF__Gift_09000D62 Property q  Auto  
GlobalVariable Property Lives  Auto  
