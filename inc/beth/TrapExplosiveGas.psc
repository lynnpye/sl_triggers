scriptname trapexplosivegas extends objectreference
formlist property flexplodesgastraponhit auto
formlist property flexplodesgastraponenter auto
formlist property flexplodesgastraponmagiceffectapply auto
formlist property flexplodesgastrapequippedspell auto
formlist property trapgasweapon auto
bool property checkactorequippeditems = true auto
bool property checkactormagic = true auto
keyword property flamekeyword auto
keyword property lightningkeyword auto 
bool property lightningignites = false auto
light property torch01 auto
projectile property storedprojectile auto hidden
objectreference property storedobjref auto hidden
magiceffect property storedeffect1 auto hidden
magiceffect property storedeffect2 auto hidden
magiceffect property storedeffect3 auto hidden
magiceffect property storedeffect4 auto hidden
int property storedeffectincrement =  1 auto hidden
auto state waiting
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
event ontriggerenter(objectreference triggerref)
endevent
endstate
function gasexplode(objectreference causeactor)
endfunction
function checkactorweapons(actor triggeractor)
endfunction
event onreset()
endevent
event ondestructionstagechanged(int aioldstage, int aicurrentstage)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1