;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname TIF_Dflow_07041EEB Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.EquipDevice(libs.PlayerRef, I , R, libs.zad_DeviousArmbinder)
(GetOwningQuest() as _DDeal).Triggered = True
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

_DFtools Property tool  Auto  

Actor Property PlayerRef  Auto  

Keyword Property kw  Auto  

MiscObject Property Gold001  Auto  

Armor Property R  Auto  

Armor Property I  Auto  

Quest Property Humility Auto
