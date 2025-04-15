scriptname we21npcscript extends referencealias
event onload()
endevent
magiceffect property restorehealtheffect auto
keyword property pmagicrestorehealth  auto  
locationalias property pnpclocation auto
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
event onlocationchange(location akoldloc, location aknewloc)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1