scriptname mq105playeroutroscript extends objectreference  
quest property myquest auto 
int property stage auto
mq105greybeardoutroscript property greybeardtrigger auto
auto state waiting
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
bool function checktriggerref(objectreference triggerref)
endfunction
function triggerme()
endfunction
function greybeardsready()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1