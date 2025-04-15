scriptname headchopblockhookupscript extends objectreference
idle property animidle auto
idle property playeranimidle auto
keyword property executionerkeyword auto
keyword property executionguardkeyword auto
quest property mq101 auto
auto state readytochop
event onactivate( objectreference akactionref )
endevent
endstate
state chopping
endstate
event onupdate() 
endevent
;This file was cleaned with PapyrusSourceHeadliner 1