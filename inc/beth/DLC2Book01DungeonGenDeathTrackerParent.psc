scriptname dlc2book01dungeongendeathtrackerparent extends objectreference
int property totaldeathneeded = 3 auto
int property currentdeaths = 0 auto hidden
objectreference property objecttoactivate auto
bool property benablelinkedrefchain auto
bool property bdisablelinkedrefchain auto
bool property fadeinorout = true auto
float property waitbeforeenabledisable = 2.0 auto
auto state waiting
function incrementdeathtracker()
endfunction
endstate
state done 
function incrementdeathtracker()
endfunction
function checkdeathsneeded()
endfunction
endstate
function triggerendevent()
endfunction
function incrementdeathtracker()
endfunction
function changetotaldeathsneeded(int newtotaldeaths)
endfunction
function checkdeathsneeded()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1