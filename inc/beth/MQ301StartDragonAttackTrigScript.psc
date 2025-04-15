scriptname mq301startdragonattacktrigscript extends objectreference  
quest property mq301  auto  
int property dragonattackstage auto
objectreference property triggeractor auto
auto state waiting
event ontriggerenter(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
function resetscene()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1