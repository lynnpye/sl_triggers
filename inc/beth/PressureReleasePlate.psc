scriptname pressurereleaseplate extends traptriggerbase
weapon property presseffect auto
ammo property presseffectammo auto
bool property donotallowactors = false auto hidden
objectreference property selfref auto hidden
bool property bdown
bool function get()
endfunction
function set(bool bvalue)
endfunction
endproperty
event oncellattach()
endevent
auto state inactive
event ontriggerenter (objectreference triggerref)
endevent
event ontriggerleave (objectreference triggerref)
endevent
endstate
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
event onreset()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1