scriptname triggerboxbase extends objectreference hidden
bool property playeronly = true auto
objectreference property activateref auto
int property whentotrigger = 0 auto
auto state waitingfortrigger
event ontriggerenter (objectreference triggerref)
endevent
event ontriggerleave (objectreference triggerref)
endevent
endstate
state hasbeentriggered
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
function resolvetriggerlogic(objectreference triggerref)
endfunction
function firetriggerevent()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1