scriptname nirnrootactivatorscript extends objectreference hidden 
ingredient property nirnroot auto
message property harvestnirnrootmessage auto
activator property nirnrootglowactivator auto
activator property nirnrootemptyactivator auto
objectreference property nirnrootglowreference auto hidden
objectreference property nirnrootemptyreference auto hidden
objectreference property emptyref auto hidden
bool property hasbeenloaded auto hidden
event oncellattach()
endevent
event onreset()
endevent
auto state waitingforharvest
event onactivate(objectreference triggerref)
endevent
endstate
state alreadyharvested
endstate
;This file was cleaned with PapyrusSourceHeadliner 1