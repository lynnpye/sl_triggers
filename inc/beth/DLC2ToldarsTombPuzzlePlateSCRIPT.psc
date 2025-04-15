scriptname dlc2toldarstombpuzzleplatescript extends objectreference hidden 
bool property showdebugmessages = true auto
sound property triggersound auto
auto state waitingfortrigger
event ontriggerenter(objectreference triggerref)
endevent
endstate
state beentriggered
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
state puzzlesolved
event onbeginstate()
endevent
endstate
state suspended
event onbeginstate()
endevent
endstate
event onactivate(objectreference akactionref)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1