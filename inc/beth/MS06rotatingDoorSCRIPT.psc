scriptname ms06rotatingdoorscript extends objectreference
objectreference property mydoor auto
bool property startactive auto
sound property drsstonerotatingdisclpm auto
event onload()
endevent
auto state offpos
event onactivate (objectreference triggerref)
endevent
endstate
state leftpos
event onbeginstate()
endevent
event onactivate(objectreference triggerref)
endevent
event onendstate()
endevent
endstate
state rightpos
event onbeginstate()
endevent
event onactivate(objectreference triggerref)
endevent
event onendstate()
endevent
endstate
state busystate
endstate
;This file was cleaned with PapyrusSourceHeadliner 1