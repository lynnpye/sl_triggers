scriptname ms06introtrigscript extends objectreference  
quest property myquest auto 
int property stage auto
quest property ms05 auto 
int property ms05prereqstageopt = 5000 auto
int property ms05prereqstageopt2 = 5000 auto
auto state waitingforplayer
event ontriggerenter(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1