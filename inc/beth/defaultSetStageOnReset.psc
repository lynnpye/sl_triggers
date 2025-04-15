scriptname defaultsetstageonreset extends objectreference
quest property myquest auto 
int property stage auto
int property prereqstageopt = -1 auto
bool property disablewhendone = true auto
auto state waitingforplayer
event onreset()
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1