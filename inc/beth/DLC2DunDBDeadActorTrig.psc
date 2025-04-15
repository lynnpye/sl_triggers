scriptname dlc2dundbdeadactortrig extends objectreference hidden 
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
keyword property linkcustom04 auto
keyword property linkcustom05 auto
quest property myquest auto
int property stagetosetoncomplete auto
auto state waitingforfirstcorpse 
event ontriggerenter(objectreference triggerref)
endevent
endstate
state waitingforsecondcorpse
event ontriggerenter(objectreference triggerref)
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1