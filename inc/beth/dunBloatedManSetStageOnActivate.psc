scriptname dunbloatedmansetstageonactivate extends objectreference
quest property myquest auto 
int property stage auto
int property prereqstageopt = -1 auto
auto state waitingforplayer
event onactivate(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1