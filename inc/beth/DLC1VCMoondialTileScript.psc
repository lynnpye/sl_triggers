scriptname dlc1vcmoondialtilescript extends objectreference
bool property tileplaced = false auto hidden
miscobject property tile auto
objectreference property dlc1vcmoondial auto
dlc1vcmoondialscript property moondialscript auto hidden
quest property dlc1vq04 auto
int property tilenumber = 1 auto
message property dlc1vcmoondialnotilemessage auto
event oncellattach()
endevent
auto state waiting
event onactivate(objectreference activateref)
endevent
endstate
state busy
endstate
function placetile()
endfunction
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1