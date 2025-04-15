scriptname dunriftenjailsetstageonopen extends objectreference
quest property myquest auto 
int property stage auto
key property dunriftenjailkey auto
objectreference property fgguard02 auto
objectreference property fgguard04 auto
int property prereqstageopt = -1 auto
auto state waitingforplayer
event onactivate(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1