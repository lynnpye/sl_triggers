scriptname ccbgssse001_miscsolitude_trigscript extends objectreference  
actor property playerref auto
formlist property foodlist auto
quest property myquest auto
int property myqueststagetoset auto
message property missingitemsmsg auto
auto state waiting
event onactivate(objectreference akactionref)
endevent
endstate
state busy
event onactivate(objectreference akactionref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1