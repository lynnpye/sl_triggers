scriptname removabletorchsconce01script extends objectreference hidden 
light property torch01 auto
activator property removabletorch01 auto
bool property startsempty auto
bool property torchinsconce = true auto hidden
objectreference property placedtorch auto hidden
sound property itmgenericup auto
sound property itmgenericdown auto
event oncellload()
endevent
function removetorch()
endfunction
state hastorch
event onactivate(objectreference triggerref)
endevent
endstate
state notorch
event onactivate(objectreference triggerref)
endevent
endstate
state busy
endstate
state awaitingactivation
event onactivate(objectreference obj)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1