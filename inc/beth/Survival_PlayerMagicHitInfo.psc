scriptname survival_playermagichitinfo extends referencealias
survival_needcold property cold auto
actor property playerref auto
keyword property magicdamagefrost auto
keyword property magicdamagefire auto
formlist property survival_frostbitepoisoneffects auto
globalvariable property survival_coldneedvalue auto
event onlocationchange(location akoldloc, location aknewloc)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
function getcolderfromspellhit(float amount)
endfunction
function getwarmerfromspellhit(float amount)
endfunction
state processing
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1