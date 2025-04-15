scriptname dgintimidateplayerscript extends referencealias  
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
event onenterbleedout()
endevent
event onlocationchange(location akoldloc, location aknewloc)
endevent
weapon property unarmedweapon  auto  
referencealias property opponent  auto  
referencealias property opponentfriend  auto  
;This file was cleaned with PapyrusSourceHeadliner 1