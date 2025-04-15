scriptname tripwire extends traptriggerbase
state active
event onbeginstate()
endevent
event onactivate(objectreference akactivator)
endevent
event ontriggerenter( objectreference triggerref ) 
endevent
event ontriggerleave( objectreference triggerref ) 
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent 
endstate
state donothing   ;dummy state, don't do anything if animating
event onbeginstate()
endevent
event ontriggerenter( objectreference triggerref ) 
endevent
event ontriggerleave( objectreference triggerref ) 
endevent
event oncellattach()
endevent
endstate
event oncellattach()
endevent
function localactivatefunction()
endfunction
event onreset()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1