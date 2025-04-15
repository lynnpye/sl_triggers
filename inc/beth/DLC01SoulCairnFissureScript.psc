scriptname dlc01soulcairnfissurescript extends objectreference  
message property nogemmsg auto
message property gemfilledmsg auto
formlist property soulgemsempty auto
formlist property soulgemsfilled auto
bool property ballowblacksouls auto
event onactivate(objectreference actronaut)
endevent
function fillsoul(objectreference recipient, int index)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1