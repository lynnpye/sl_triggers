scriptname dlc1vcmoondialscript extends objectreference conditional
bool property isopen = false auto conditional
bool property tile1placed = false auto hidden
bool property tile2placed = false auto hidden
bool property tile3placed = false auto hidden
bool property isanimating = false auto hidden
string property openanim = "down" auto hidden
string property openevent = "transdown" auto hidden
quest property dlc1vq04 auto
int property minstage = -1 auto
int property stage = 0 auto
event onload()
endevent
auto state waiting
endstate
state busy
endstate
state done
endstate
function setopen(bool abopen = true)
endfunction
function settileplaced(int tiletoplace)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1