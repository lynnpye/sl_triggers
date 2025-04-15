scriptname trapdwethresher extends movingtrap
bool property startspinning = false auto hidden
string property startspinninganim = "end" auto
float property initialdelay = 0.25 auto
int property movementtype = 0 auto
bool property loadedonce = false auto hidden
function firetrap()
endfunction
function resetlimiter()
endfunction
event oncellload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1