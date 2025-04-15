scriptname dgintimidatealiasscript extends referencealias  
faction property dgintimidatefaction auto
event onupdate()
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
event onenterbleedout()
endevent
weapon property unarmedweapon  auto  
;This file was cleaned with PapyrusSourceHeadliner 1