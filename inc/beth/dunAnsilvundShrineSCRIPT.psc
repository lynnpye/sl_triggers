scriptname dunansilvundshrinescript extends objectreference hidden
quest property myquest auto
referencealias property whitesoulgem auto
message property shrinemessage1 auto
message property shrinemessage2 auto
auto state notactivated
event onactivate (objectreference triggerref)
endevent
endstate
state activated
event onbeginstate()
endevent
event onactivate (objectreference triggerref)
endevent
endstate
state disabled
endstate
;This file was cleaned with PapyrusSourceHeadliner 1