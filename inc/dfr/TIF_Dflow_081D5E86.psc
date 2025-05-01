;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname TIF_Dflow_081D5E86 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
tool.LDC.EquipDeviceByKeyword(libs.Zad_DeviousPetSuit)
(GetOwningQuest() as _DFlowModDealController).PetSuitInTownRule = 3
(GetOwningQuest() as _DFlowModDealController).CheckTrigger(11)
DFR_DeviceController.Get().BlockRemoval(5, "deviousfollowers/core/heavybondage", 1)
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
