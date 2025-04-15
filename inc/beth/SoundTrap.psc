scriptname soundtrap extends traptriggerbase
weapon property triggereffect auto
ammo property triggereffectammo auto
explosion property havoknudge auto
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
event oncellattach()
endevent
endstate
event oncellattach()
endevent
event oncelldetach()
endevent
event onreset()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1