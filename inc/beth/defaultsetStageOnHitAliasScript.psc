scriptname defaultsetstageonhitaliasscript extends referencealias  
int property stage auto
int property prereqstageopt = -1 auto
bool property playeronly = true auto
auto state waitingforplayer
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
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
int property triggertype = 2 auto  hidden
;This file was cleaned with PapyrusSourceHeadliner 1