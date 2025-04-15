scriptname dragonpriestultramaskeffect extends activemagiceffect  
actor property selfref auto hidden
magiceffect property dragonpriestmaskfirecloakffself auto
float property hpthreshold = 0.20 auto
float property effectchance = 0.25 auto
float property rareeffectchance = 0.05 auto
explosion property fakeforceball1024 auto
spell property flamecloak auto
spell property grandhealing auto
spell property rarespell  auto
magiceffect property rareeffect auto
event oneffectstart(actor target, actor caster)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1