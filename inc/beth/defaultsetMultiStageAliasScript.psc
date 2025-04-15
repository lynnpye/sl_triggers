scriptname defaultsetmultistagealiasscript extends referencealias  
int property triggertype = 0 auto  
int property prereqstage1 auto
int property resultstage1 auto
int property prereqstage2 auto
int property resultstage2 auto
auto state waitingforplayer
event onactivate(objectreference triggerref)
endevent
event ondeath(actor akkiller)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ontriggerenter(objectreference triggerref)
endevent
endstate
state hasbeentriggered
event onactivate(objectreference triggerref)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ontriggerenter(objectreference triggerref)
endevent
endstate
event onactivate(objectreference triggerref)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1