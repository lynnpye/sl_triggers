scriptname springtrap extends traptriggerbase
weapon property presseffect auto
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
event ontriggerleave( objectreference triggerref ) 
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1