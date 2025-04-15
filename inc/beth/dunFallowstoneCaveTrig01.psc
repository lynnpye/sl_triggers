scriptname dunfallowstonecavetrig01 extends objectreference  
objectreference property yamarzref auto ;yamarz, must be set in editor
quest property myquest auto
int property stage auto
auto state waitingfortrigger
event ontriggerenter(objectreference triggerref)
endevent
endstate
state hastriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1