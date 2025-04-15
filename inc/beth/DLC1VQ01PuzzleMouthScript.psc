scriptname dlc1vq01puzzlemouthscript extends objectreference  
message property wontbudge auto
objectreference property puzzlecontroller auto
bool property solved = false auto hidden
int property solvedstate auto
event oncellattach()
endevent 
auto state top
event onactivate(objectreference triggerref)
endevent
endstate
state bot
event onactivate(objectreference triggerref)
endevent
endstate
state mid
event onactivate(objectreference triggerref)
endevent
endstate
state done
event onactivate(objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1