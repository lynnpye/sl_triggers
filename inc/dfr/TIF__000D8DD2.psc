;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__000D8DD2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; don't dismiss the follower again if I've already dismissed them
If !(akspeaker.IsInFaction(DismissedFollowerFaction))
  (pDialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property pDialogueFollower  Auto  

Faction Property DismissedFollowerFaction  Auto  
