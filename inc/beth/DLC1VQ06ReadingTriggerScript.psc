scriptname dlc1vq06readingtriggerscript extends objectreference  conditional
quest property dlc1vq06  auto  
visualeffect property dlc1readelderscrolleffect auto 
visualeffect property dlc1readelderscrollpartaeffect auto 
visualeffect property dlc1readelderscrollpartbeffect auto 
visualeffect property dlc1readelderscrollpartceffect auto 
visualeffect property dlc1readelderscrollblankeffect auto 
visualeffect property fxreadelderscrolleffect auto
armor property elderscrollhandattacharmor auto
idle property idlereadelderscroll  auto  
sound property objelderscrollblindin2d auto
imagespacemodifier property fxreadscrollsblindimod auto
idle property idlestop  auto
sound property objelderscrollblindout2d auto
sound property qstmq206elderscrollread2dsound  auto
sound property qstdlc01elderscrollread2d  auto
sound property qstdlc01elderscrollread2dheavy  auto
sound property qstdlc01elderscrollread2dlpm  auto
sound property qstdlc01elderscrollreadb2d  auto
sound property qstdlc01elderscrollfinalread2dlpm auto
imagespacemodifier property fadetowhiteholdimod auto
visualeffect property dlc01_scrollattunementeffect auto ;turns off moth glowy effect
event ontriggerenter(objectreference akactionref)
endevent
event ontriggerleave(objectreference akactionref)
endevent
function readscroll(int whichscroll)
endfunction
function playerreadsscroll(int whichscroll, bool openscroll = true)
endfunction
function playergoesblind()
endfunction
function prepforreading(bool disablecontrolscompletely = false)
endfunction
function playreadanimation()
endfunction
function returnfromreading(bool playoutsound = true, bool shouldenablecontrols = true)
endfunction
function playsound(int whichsound)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1