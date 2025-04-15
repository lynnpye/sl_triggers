scriptname trapfireplate extends traptriggerbase
ammo property presseffectammo auto
hazard property firehazard auto hidden
objectreference property myhazardref auto hidden
bool property weaponresolved = false auto hidden
int property traplevel = 1 auto
state active
event onbeginstate()
endevent
event ontriggerenter( objectreference triggerref ) 
endevent
event ontrigger( objectreference triggerref ) 
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
function removemyhazard()
endfunction
auto state inactive
event onbeginstate()
endevent
event ontriggerenter (objectreference triggerref)
endevent
event ontriggerleave (objectreference triggerref)
endevent
endstate
event oncellattach()
endevent
int property lvlthreshold1 auto
int property lvlthreshold2 auto
int property lvlthreshold3 auto
int property lvlthreshold4 auto
int property lvlthreshold5 auto
hazard property trapfireplatefxhaz01 auto
hazard property trapfireplatefxhaz02 auto
hazard property trapfireplatefxhaz03 auto
hazard property trapfireplatefxhaz04 auto
hazard property trapfireplatefxhaz05 auto
hazard property trapfireplatefxhaz06 auto
function resolveleveledhazard ()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1