scriptname dlc2tamedragoneffectscript extends activemagiceffect  
auto state begin
event oneffectstart(actor target, actor caster)
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
dlc2tamedragonscript property dlc2tamedragon  auto  
referencealias property mq06ferrydragon  auto  
;This file was cleaned with PapyrusSourceHeadliner 1