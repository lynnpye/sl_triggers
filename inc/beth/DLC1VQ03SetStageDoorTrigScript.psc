scriptname dlc1vq03setstagedoortrigscript extends objectreference
quest property myquest auto 
quest property dlc1vq03hunter auto
quest property dlc1vq03vampire auto
int property stage = 60 auto
bool property doonce = true auto
int property prereqstageopt = -1 auto
bool property disablewhendone = true auto
auto state waitingforplayer
event ontriggerenter(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1