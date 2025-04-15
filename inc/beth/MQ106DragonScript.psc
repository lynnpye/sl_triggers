scriptname mq106dragonscript extends referencealias  
event oncombatstatechanged(actor aktarget,int aecombatstate)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
event ondeath(actor akkiller)
endevent
event onupdate()
endevent
keyword property magicshout  auto  
;This file was cleaned with PapyrusSourceHeadliner 1