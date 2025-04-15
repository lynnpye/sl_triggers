scriptname ms01guardtriggerscript extends referencealias
quest property ms01 auto 
int property stage auto
int property prereqstageopt = -1 auto
auto state waitingforplayer
event ontriggerenter(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1