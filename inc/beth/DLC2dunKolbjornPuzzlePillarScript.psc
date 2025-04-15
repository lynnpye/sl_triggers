scriptname dlc2dunkolbjornpuzzlepillarscript extends objectreference
int property pillarstate auto hidden ;1 for solution 1 (main), 2 for solution 2 (alt), 3 for neither.
int property initialstate auto
int property solution1 auto
int property solution2 auto
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