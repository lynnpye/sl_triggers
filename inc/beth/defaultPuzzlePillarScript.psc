scriptname defaultpuzzlepillarscript extends objectreference
int property initialstate auto
int property solvestate auto
event oncellload()
endevent
function rotatepillartostate(int statenumber, int animeventnumber)
endfunction
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
;This file was cleaned with PapyrusSourceHeadliner 1