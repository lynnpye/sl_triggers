scriptname dlc1cavewormtriggercontrolscript extends objectreference
int property itriggernumber auto hidden ;increased(ontriggerenter) and decreased(ontriggerleave) by the caveworms - if this is > 1, then the worms should be closed
bool property bishit = false auto hidden
int property ihitcounter = 0 auto hidden
auto state waiting
event onactivate(objectreference akactionref)
endevent
endstate
state gothit
event onbeginstate()
endevent
event onactivate(objectreference akactionref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1