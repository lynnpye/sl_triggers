scriptname dunblindcliffgoaheadscript extends objectreference  
objectreference property goalmarker auto
objectreference property mynpc auto
keyword property goallink auto
quest property myquest auto
int property prereqstage auto
auto state ready
event ontriggerenter(objectreference actronaut)
endevent
event onactivate(objectreference actronaut)
endevent
endstate
state inactive
endstate
function advancegoal()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1