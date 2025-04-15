scriptname dlc2mh02campdetectplayerpresence extends objectreference conditional
quest property dlc2mh02 auto
bool property playerpresent = false auto conditional
event ontriggerenter(objectreference akactivator)
endevent
event ontriggerleave(objectreference akactivator)
endevent
function checkattack()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1