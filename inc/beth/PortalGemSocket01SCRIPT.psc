scriptname portalgemsocket01script extends objectreference hidden 
form property portalgembluekey auto
form property portalgemgreenkey auto
form property portalgemorangekey auto
form property portalgempurplekey auto
form property portalgemwhitekey auto
sound property objparagonambiencelpmsd auto
int property portalloopinstance auto
formlist property portalgemkeylist auto
message property portalgemplacemessage auto
message property portalgemplacemessagedenied auto
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
keyword property linkcustom04 auto
keyword property linkcustom05 auto
keyword property linkcustom10 auto
auto state waitingforplacement
event onactivate(objectreference akactionref)
endevent
endstate
state waitingforpickup
event onactivate(objectreference akactionref)
endevent
endstate
state busystate
event onactivate(objectreference akactionref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1