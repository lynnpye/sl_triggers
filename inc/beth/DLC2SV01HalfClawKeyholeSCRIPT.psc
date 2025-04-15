scriptname dlc2sv01halfclawkeyholescript extends objectreference hidden 
message property activatewithoutobjmessage auto
quest property myquest auto
int property stagetosetonfirstkey auto
int property stagetosetonsecondkey auto
miscobject property mymiscobject auto
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
keyword property linkcustom04 auto
auto state waitingforactivate
event onactivate(objectreference akactionref)
endevent
endstate
state busy
endstate
state unlocked
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1