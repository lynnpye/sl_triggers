scriptname spriggancallanimalsscript extends activemagiceffect
spell property spelltocast auto
faction property creaturefaction auto
faction property sprigganfaction auto
event oneffectstart(actor result01, actor akcaster)
endevent
event oncombatstatechanged(actor result01, int aecombatstate)
endevent
event onactivate(objectreference actronaut)
endevent
function findnearbyactors()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1