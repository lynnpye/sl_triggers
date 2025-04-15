scriptname blackreachlockscript extends objectreference
miscobject property dwarvenkey auto
message property lacktheitem auto
objectreference property dwebrentrancestair auto hidden
bool property isanimating = false auto hidden
string property openanim = "unlock" auto hidden
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