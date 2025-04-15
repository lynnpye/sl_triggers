scriptname blackreachdoorscript extends objectreference conditional
bool property isopen = false auto conditional
bool property isanimating = false auto hidden
string property openanim = "down" auto hidden
string property openevent = "transdown" auto hidden
event onload()
endevent
auto state waiting ; waiting to be activated
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
function setopen(bool abopen = true)
endfunction
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1