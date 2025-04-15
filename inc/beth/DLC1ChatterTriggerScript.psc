scriptname dlc1chattertriggerscript extends objectreference  
globalvariable property friendtravelchatter auto 
int property chattervalue auto
faction property triggerfaction auto
auto state waitingforactor
event ontriggerenter(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
function setchattervalue(int newvalue)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1