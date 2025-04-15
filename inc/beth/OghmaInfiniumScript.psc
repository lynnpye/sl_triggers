scriptname oghmainfiniumscript extends objectreference  
quest property da04 auto
message property choicemessage auto
int property advancement auto
bool property hasbeenread auto
book property myself auto
function readoghmainfinium(bool fromworld)
endfunction
event onequipped(actor reader)
endevent
event onactivate(objectreference reader)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1