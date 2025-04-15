scriptname trapfallingoillampcollayer extends objectreference
message property disarmmessage1 auto
sound property fallingsound auto
weapon property fallingoilweapon auto
ammo property fallingoilammo auto
explosion property oilexplosion auto
auto state waiting
event onactivate(objectreference triggerref)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
event ondestructionstagechanged(int aioldstage, int aicurrentstage)
endevent
endstate
function switchtofalling(objectreference causeactor)
endfunction
state triggered
event onbeginstate()
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ontriggerenter(objectreference triggerref)
endevent
event ondestructionstagechanged(int aioldstage, int aicurrentstage) 
endevent
endstate
event onreset()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1