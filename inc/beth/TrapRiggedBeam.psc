scriptname trapriggedbeam extends traptriggerbase
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
event onload()
endevent
event onunload()
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1