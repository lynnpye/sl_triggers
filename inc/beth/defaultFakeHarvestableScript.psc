scriptname defaultfakeharvestablescript extends objectreference
ingredient property ingredientharvested auto
potion property potionharvested auto
bool property deleteselfonharvest = false auto
message property harvestmessage auto
message property failuremessage auto
globalvariable property daystoresetfakeharvest auto
float property lastharvestedday auto hidden
sound property harvestsound auto
auto state readyforharvest
event onactivate(objectreference akactivator)
endevent
endstate
state waitingtorespawn
event onbeginstate()
endevent
event onactivate(objectreference akactivator)
endevent
event oncellload()
endevent
endstate
function fakeharvest(objectreference akactivator)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1