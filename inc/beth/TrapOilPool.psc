scriptname trapoilpool extends trapexplosivegas
float property burnduration = 30.0 auto
bool property lightstayson = false auto
bool property deleteselfafterignition = true auto
explosion property oilexplosion auto ;hidden
bool property weaponresolved = false auto hidden
int property traplevel = 1 auto
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