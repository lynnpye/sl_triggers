scriptname dlc1trappoisonbloom extends traptriggerbase
weapon property presseffect auto
ammo property presseffectammo auto
sound property warningsound auto
sound property releasesound auto
int property mysoundinstance auto hidden
ingredient property myingredient auto
miscobject property mymiscobject auto
potion property mypotion auto
string property openanim = "playanim02" auto
string property closeanim = "playanim01" auto
float property poisonreleasedelay = 2.0 auto
bool property waitingforwarnend = false auto hidden
state active
event onbeginstate()
endevent
event ontriggerenter( objectreference triggerref ) 
endevent
event ontriggerleave( objectreference triggerref )
endevent
endstate
state reset
event onbeginstate()
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
state done
event onbeginstate()
endevent
event onactivate(objectreference akactivator)
endevent
event ontriggerenter( objectreference triggerref ) 
endevent
event ontriggerleave( objectreference triggerref )
endevent
endstate
state disarmed
event onbeginstate()
endevent
event onactivate(objectreference akactivator)
endevent
event ontriggerenter( objectreference triggerref ) 
endevent
event ontriggerleave( objectreference triggerref )
endevent
endstate
state firing
event onactivate(objectreference akactivator)
endevent
event ontriggerenter( objectreference triggerref ) 
endevent
event ontriggerleave( objectreference triggerref )
endevent
endstate
event onupdate()
endevent
event onactivate(objectreference akactivator)
endevent
bool function acceptabletrigger(objectreference triggerref)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1