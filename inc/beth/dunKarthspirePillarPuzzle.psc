scriptname dunkarthspirepillarpuzzle extends objectreference  
int property initialstate auto
bool property pillara auto
bool property pillarb auto
bool property pillarc auto
objectreference property controllerscript auto
objectreference property drawbridge auto
quest property mq203 auto
event onload()
endevent
state position01
event onactivate (objectreference triggerref)
endevent
endstate
state position02
event onactivate (objectreference triggerref)
endevent
endstate
state position03
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
function rotatepillar(int statenumber, int animeventnumber)
endfunction
function pillarset(int startstate)
endfunction 
;This file was cleaned with PapyrusSourceHeadliner 1