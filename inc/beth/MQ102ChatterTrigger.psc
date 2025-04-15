scriptname mq102chattertrigger extends objectreference  
quest property mq102a auto 
quest property mq102b auto 
int property chattervalue auto
faction property triggerfaction auto
auto state waitingforactor
event ontriggerenter(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
function setchattervalue(quest myquest, int newvalue)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1