scriptname dlc2dunnchardakaqueductcontroller extends objectreference
objectreference property bridge1 auto
objectreference property bridge2 auto
objectreference property bridge3 auto
objectreference property bridgepedestal1 auto
objectreference property bridgepedestal2 auto
objectreference property bridgepedestal3 auto
objectreference property bridge1navcutcollision auto
objectreference property bridge2navcutcollision auto
objectreference property bridge3navcutcollision auto
auto state waitingforplayer
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
event oncellattach()
endevent
function activationcomplete()
endfunction
function updatebridgecollision()
endfunction
function setpuzzlecompleted()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1