scriptname tgtq04bannerburnscript extends trapexplosivegas
quest property tgtq04 auto
event onload()
endevent
event onreset()
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