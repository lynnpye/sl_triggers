scriptname riftencasketdoorscript extends objectreference  
bool property isopen = false auto conditional
bool property doonce = false auto
bool property isanimating = false auto hidden
string property openanim = "open" auto
string property closeanim = "close" auto
string property snapcloseanim = "snapclose" auto
string property openevent = "done" auto
string property closeevent = "done" auto
string property startopenanim = "opened" auto
bool property ballowinterrupt = false auto
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
state done
event onactivate (objectreference triggerref)
endevent
endstate
function setopen(bool abopen = true)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1