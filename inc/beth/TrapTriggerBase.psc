scriptname traptriggerbase extends objectreference hidden
int property countused auto hidden       ;used to compare times triggered to max triggers allowed
int property type auto hidden         ;this is to determine trigger to send to the trap
sound property triggersound auto
objectreference property lasttriggerref auto hidden
int property soundlevel = 10 auto
int property objectsintrigger hidden 
function set(int value) 
endfunction 
int function get() 
endfunction 
endproperty
faction property owningfaction auto
actorbase property owningactorbase auto
bool property dooncebase = false auto hidden
bool property playeronlytrigger = false auto
bool property checkforlightfootperk = false auto
bool property checkforlighthandsperk = false auto
perk property lightfootperk auto
globalvariable property lightfootglobalvar auto
perk property lighthandsperk auto
globalvariable property lighthandsglobalvar auto
bool property blockactivate = false auto
bool property finiteuse auto
bool property istriggervolume = false auto
int property triggercount
int function get()
endfunction
function set (int value)
endfunction
endproperty
int property triggertype
int function get()
endfunction
function set (int value)
endfunction
endproperty
int property storedtriggertype auto hidden
event oncellattach()
endevent
event oncellload()
endevent
event onactivate(objectreference akactivator)
endevent
auto state inactive
event onbeginstate()
endevent
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
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
endstate
bool function acceptabletrigger(objectreference triggerref)
endfunction
bool function checkperks(objectreference triggerref)
endfunction
function localactivatefunction() ;placeholder function for anything that may need to be on the child activate event
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1