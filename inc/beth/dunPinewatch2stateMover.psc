scriptname dunpinewatch2statemover extends objectreference
objectreference property position1ref auto
objectreference property position2ref auto
sound property movesound auto
float property movespeed = 200.0 auto
auto state position1
event onactivate(objectreference triggerref) ;activated while in position 1, move to position 2
endevent
endstate
state movingtoposition2
event onactivate(objectreference triggerref) ;activated while moving to position 2, move back to position 1
endevent
endstate
state position2
event onactivate(objectreference triggerref) ;activated while in position 2, move to position 1
endevent
endstate
state movingtoposition1
event onactivate(objectreference triggerref) ;activated while moving to position 1, move back to position 2
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1