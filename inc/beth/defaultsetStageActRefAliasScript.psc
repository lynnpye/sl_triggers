scriptname defaultsetstageactrefaliasscript extends referencealias
quest property myquest auto 
int property stage auto
int property prereqstageopt = -1 auto
float property delay = 0.0 auto
bool property requireplayeractivation = true auto
auto state waitingforplayer
event onactivate(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1