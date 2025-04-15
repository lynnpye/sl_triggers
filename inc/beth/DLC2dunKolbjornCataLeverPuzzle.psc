scriptname dlc2dunkolbjorncataleverpuzzle extends objectreference
objectreference property bar1 auto
objectreference property bar2 auto
objectreference property bar3 auto
objectreference property chain1 auto
objectreference property chain2 auto
objectreference property endtrigger auto
objectreference property gate1 auto
objectreference property gate2 auto
objectreference property gate3 auto
objectreference property gate1collision auto
objectreference property gate2collision auto
objectreference property gate3collision auto
bool property gate1open = false auto
bool property gate2open = true auto
bool property gate3open = true auto
bool property done = false auto
auto state waitingforplayer
event onactivate (objectreference triggerref)
endevent
endstate
state waitingforpullbar
event onactivate(objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1