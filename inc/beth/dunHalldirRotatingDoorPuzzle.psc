scriptname dunhalldirrotatingdoorpuzzle extends objectreference
int property numpillarssolved auto
sound property failsfx auto
objectreference property door01 auto
int property pillarcount auto
objectreference property refactonfailure01 auto
objectreference property refactonfailure02 auto
objectreference property refactonfailure03 auto
objectreference property refactonfailure04 auto
event onload()
endevent
event onreset()
endevent
auto state waitingforpuzzle
event onactivate(objectreference triggerref)
endevent
endstate
state active
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1