scriptname pressureplate extends traptriggerbase
weapon property presseffect auto
ammo property presseffectammo auto
state active
event onbeginstate()
endevent
event ontriggerenter( objectreference triggerref ) 
endevent
event ontriggerleave( objectreference triggerref )
endevent
endstate
state donothing   ;dummy state, don't do anything if animating
event ontriggerenter( objectreference triggerref ) 
endevent
event ontrigger( objectreference triggerref ) 
endevent
event ontriggerleave( objectreference triggerref )
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1