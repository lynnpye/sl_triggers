;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_Dflow_081F12A4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(Tool.Q as QF__Gift_09000D62).BuyDebt()
Tool.LDC.AddDeviceByKeyWord(Tool.LDC.Libs.zad_DeviousPlugAnal);
Utility.Wait(8.0)
Tool.LDC.AddDeviceByKeyWord(Tool.LDC.Libs.zad_DeviousPlugVaginal)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_DFtools Property tool  Auto  
