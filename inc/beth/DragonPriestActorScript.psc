scriptname dragonpriestactorscript extends activemagiceffect  
armor property dragonpriestarmor01 auto
visualeffect property dragonpriestparticlesfx auto
visualeffect property dragonpriesteyeglowfx auto
visualeffect property fxfallingsanddragonpriesteffect auto
explosion property fxdragonpriestsmallexplosion auto
explosion property fxdragonpriestlargeexplosion auto
activator property ashpileobject auto
event oneffectstart(actor target, actor caster)
endevent
event ongetup(objectreference akfurniture)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ondying(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1