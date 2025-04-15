scriptname dunshroudhearthcataleverpuzzle extends objectreference conditional
quest property dunshroudhearthqst auto
action property animaction auto
bool property singleuse auto
bool property hasbeenused auto conditional
bool property inpushedposition auto
int property puzzlelevernumber auto
objectreference property lever1 auto
objectreference property lever2 auto
objectreference property lever3 auto
objectreference property gate1 auto
objectreference property gate2 auto
objectreference property gate3 auto
auto state waitingforplayer
event onactivate (objectreference triggerref)
endevent
endstate
state waitingforlever
event onactivate(objectreference triggerref)
endevent
endstate
event onreset()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1