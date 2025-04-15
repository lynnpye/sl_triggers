scriptname dunhillgrundstombboss extends actor
activator property summonfx auto
objectreference property position1 auto
objectreference property position2 auto
objectreference property position3 auto
objectreference property position4 auto
objectreference property position5 auto
objectreference property safeposition auto
objectreference property bosscontroller auto
bool property finalteleport = false auto hidden
float property endteleporttimer auto hidden
auto state waiting
event onactivate(objectreference triggerref)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state active
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onactivate(objectreference triggerref)
endevent
endstate
state mustfight
event onbeginstate()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onactivate(objectreference triggerref)
endevent
endstate
state dead
event onbeginstate()
endevent
endstate
event ondeath(actor akkiller)
endevent
function doteleport()
endfunction
function teleporttosafety()
endfunction
function adjusthealth()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1