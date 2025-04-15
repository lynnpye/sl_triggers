scriptname dlc1radiantmakeaggressivescript extends referencealias  
referencealias[] property aliasestomakeaggressive auto
int property aggressionlevel = 1 auto
bool property aggressiveonhit auto
state done
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1