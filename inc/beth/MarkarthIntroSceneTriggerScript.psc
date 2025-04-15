scriptname markarthintroscenetriggerscript extends objectreference
referencealias property pactor1 auto
referencealias property pactor2 auto
int property itriggercount auto
quest property pmyquest auto
function incrementscenecount()
endfunction
function decrementscenecount()
endfunction
auto state waiting
event ontriggerenter(objectreference akactionref) 
endevent
event ontriggerleave(objectreference akactionref)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1