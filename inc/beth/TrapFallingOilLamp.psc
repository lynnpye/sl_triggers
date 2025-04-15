scriptname trapfallingoillamp extends objectreference
message property disarmmessage1 auto
sound property fallingsound auto
weapon property fallingoilweapon auto
ammo property fallingoilammo auto
auto state waiting
event onactivate(objectreference triggerref)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
endstate
state triggered
endstate
function firetrap()
endfunction
event ondeath()
endevent
event ondestructionstagechanged(int aioldstage, int aicurrentstage)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1