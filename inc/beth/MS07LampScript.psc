scriptname ms07lampscript extends objectreference  
message property lightoutmessage  auto  
message property cannotmessage  auto  
message property lightalreadyoutmessage  auto  
quest property ms07 auto
auto state lampon
event onactivate(objectreference akactionref)
endevent
endstate
state lampoff
event onactivate(objectreference akactionref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1