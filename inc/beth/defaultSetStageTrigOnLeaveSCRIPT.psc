scriptname defaultsetstagetrigonleavescript extends objectreference  
quest property myquest auto 
int property stage auto
bool property doonce = true auto
int property prereqstageopt = -1 auto
bool property disablewhendone = true auto
auto state waitingforplayer
event ontriggerleave(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1