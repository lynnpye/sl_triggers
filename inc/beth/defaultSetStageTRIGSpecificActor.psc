scriptname defaultsetstagetrigspecificactor extends objectreference  
quest property myquest auto 
int property stage auto
int property prereqstageopt = -1 auto
actorbase property triggeractor auto
bool property disablewhendone = true auto
bool property onlyonce = true auto
auto state waitingforactor
event ontriggerenter(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1