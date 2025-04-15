scriptname dlc1dragonsummonscript extends objectreference  
auto state begin
event onload()
endevent
endstate
state done 
event onactivate(objectreference akactionref)
endevent
endstate
event onenterbleedout()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, \
bool abbashattack, bool abhitblocked)
endevent
event ondeath(actor akkiller)
endevent
dlc1vqdragonscript property dlc1vqdragon  auto  
;This file was cleaned with PapyrusSourceHeadliner 1