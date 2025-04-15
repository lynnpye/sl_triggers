scriptname mq206alduinscript extends referencealias  
auto state waitingforhit
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
endstate
state afterhit
endstate
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
magiceffect property dragonrend3effect  auto  
;This file was cleaned with PapyrusSourceHeadliner 1