;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname TIF_Dflow_0A0136A6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_7
Function Fragment_7(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Tool.Sex(akspeaker)
Tool.WaitForSex()
MCM.Noti("NipP")
libs.equipDevice(PlayerRef, D , DE, libs.zad_DeviousPiercingsNipple, skipevents = false, skipmutex = true)
GetowningQuest().setstage(102)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

Actor Property PlayerRef  Auto  

Armor Property D  Auto  

Armor Property DE  Auto  

_DflowMCM property MCM Auto
Quest Property GameQ  Auto  
_Dftools property tool auto
