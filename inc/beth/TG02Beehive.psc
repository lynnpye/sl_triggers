scriptname tg02beehive extends trapexplosivegas
quest property ptg02quest auto
objectreference property mysmoke auto
event onload()
endevent
function gasexplode(objectreference causeactor)
endfunction
state donothing
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
event ontriggerenter(objectreference triggerref)
endevent
endstate
event ondestructionstagechanged(int aioldstage, int aicurrentstage)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1