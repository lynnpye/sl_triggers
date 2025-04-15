scriptname ms06aliassetstagetriggerplus extends referencealias  
int property ms06stagetoset auto
quest property ms05 auto
quest property mq302 auto
int property ms05donotstartrangeloweststage auto
int property ms05donotstartrangehigheststage auto
auto state waitingforplayer
event ontriggerenter(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1