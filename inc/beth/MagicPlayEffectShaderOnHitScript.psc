scriptname magicplayeffectshaderonhitscript extends activemagiceffect  
effectshader property magiceffectshader auto
float property shaderduration = 0.00 auto
event oneffectstart(actor target, actor caster)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1