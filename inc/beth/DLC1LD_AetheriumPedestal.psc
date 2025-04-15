scriptname dlc1ld_aetheriumpedestal extends referencealias
quest property dlc1ld auto
referencealias property crestpedestal auto
referencealias property shard1 auto
referencealias property shard2 auto
referencealias property shard3 auto
referencealias property shard4 auto
referencealias property crest auto
referencealias property katria auto
message property dlc1ld_pedestalfailmessage auto
message property dlc1ld_pedestalfailcombatmessage auto
auto state ready
event oncellattach()
endevent
event onactivate(objectreference akactivator)
endevent
endstate
state animating
event oncellattach()
endevent
event onactivate(objectreference akactivator)
endevent
endstate
state toweropened
endstate
function openbthalft()
endfunction
function referenceattach()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1