scriptname doorbar extends objectreference
bool property startopen = false auto
message property barredmsg auto
keyword property barreddoornavcutkeyword auto
event oncellload()
endevent
state down
event onactivate(objectreference actronaut)
endevent
event setbarposition(bool setbarup)
endevent
endstate
state up
event onactivate(objectreference actronaut)
endevent
event setbarposition(bool setbarup)
endevent
endstate
state busy
endstate
event setbarposition(bool setbarup)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1