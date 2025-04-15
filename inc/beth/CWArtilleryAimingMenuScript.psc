scriptname cwartilleryaimingmenuscript extends objectreference  
message property aimingmessageangle auto
message property aimingmessageposition auto
objectreference property facetarget auto
int property buttonangleleft   = 0 auto
int property buttonangleright   = 1 auto
int property buttonangleback   = 2 auto
int property buttonangleforward  = 3 auto
int property buttonangleface   = 4 auto
int property buttonanglenextmenu  = 5 auto
int property buttonanglelog    = 6 auto
int property buttonangledone   = 7 auto
int property buttonpostionleft   = 0 auto
int property buttonpostionright  = 1 auto
int property buttonpostionback  = 2 auto
int property buttonpostionforward = 3 auto
int property buttonpostionup   = 4 auto
int property buttonpostiondown   = 5 auto
int property buttonpostionnextmenu  = 6 auto
int property buttonpostionlog   = 7 auto
int property buttonpostiondone   = 8 auto
bool property aim auto
event oninit()
endevent
event onactivate(objectreference akactionref)
endevent
function showaimingmenu()
endfunction
function showpositioningmenu()
endfunction
function logpositionandangle()
endfunction
float function getfacingtotarget(objectreference targetref, bool invertfacing = false)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1