scriptname cwsiegeactivatorscript extends objectreference
quest property defendquest auto
quest property attackquest auto
int property defendstage auto
int property attackstage auto
auto state waitingforplayer
event onactivate(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1