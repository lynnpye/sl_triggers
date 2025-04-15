scriptname defaultsetstagealiasscript extends referencealias  
int property stage auto
int property prereqstageopt = -1 auto
auto state waitingforplayer
event onactivate(objectreference triggerref)
endevent
event ondeath(actor akkiller)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ontriggerenter(objectreference triggerref)
endevent
event onequipped(actor akactor)
endevent
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event oncellload()
endevent
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
event onopen(objectreference akactionref)
endevent
event onread()
endevent
event onenterbleedout()
endevent
endstate
state hasbeentriggered
event onactivate(objectreference triggerref)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ontriggerenter(objectreference triggerref)
endevent
event onequipped(actor akactor)
endevent
endstate
event onactivate(objectreference triggerref)
endevent
function testfortrigger(objectreference triggerref, int ptesttriggertype)
endfunction
int property triggertype = 0 auto  
;This file was cleaned with PapyrusSourceHeadliner 1