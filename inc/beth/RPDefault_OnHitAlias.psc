scriptname rpdefault_onhitalias extends referencealias hidden
bool property bplayeronly = true auto
bool property bonlytriggeronce = true auto
weapon[] property source_specificweapons auto
spell[] property source_specificspells auto
explosion[] property source_specificexplosions auto
ingredient[] property source_specificingredients auto
potion[] property source_specificpotions auto
enchantment[] property source_specificenchantment auto
projectile property specificprojectile auto
bool property bonlycountpowerattacks = false auto
bool property bonlycountsneakattacks = false auto
bool property bonlycountbashattacks = false auto
bool property bignoreblockedhits = false auto
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
state completed
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
bool function handlehit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1