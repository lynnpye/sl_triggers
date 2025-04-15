scriptname norlever01script extends objectreference conditional
bool property isinpullposition = true auto
event onload()
endevent
event onreset()
endevent
function setdefaultstate()
endfunction
auto state pulledposition
event onactivate (objectreference triggerref)
endevent
endstate
state pushedposition
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1