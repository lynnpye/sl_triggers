scriptname perkavoiddeathscript extends activemagiceffect  
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked )
endevent
spell property healspell  auto  
globalvariable property perkavoiddeathtimer  auto  
globalvariable property gamedayspassed  auto  
float property percenthealth = 100.0 auto  
;This file was cleaned with PapyrusSourceHeadliner 1