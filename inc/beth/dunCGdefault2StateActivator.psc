scriptname duncgdefault2stateactivator extends objectreference conditional
bool property isopen = false auto conditional
bool property doonce = false auto
bool property isanimating = false auto hidden
string property openanim = "open" auto
string property closeanim = "close" auto
string property openevent = "opening" auto
string property closeevent = "closing" auto
string property startopenanim = "opened" auto
bool property ballowinterrupt = false auto
bool property zinvertcollision = false auto
int property mystate = 1 auto hidden
keyword property twostatecollisionkeyword auto
objectreference property myotherbridge auto
event onload()
endevent
event onreset()
endevent
function setdefaultstate()
endfunction
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