scriptname dlc2tamedragonaliasscript extends referencealias  
event onactivate(objectreference akactionref)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, \
bool abbashattack, bool abhitblocked)
endevent
event ondeath(actor akkiller)
endevent
dlc2tamedragonscript property dlc2tamedragon  auto  
;This file was cleaned with PapyrusSourceHeadliner 1