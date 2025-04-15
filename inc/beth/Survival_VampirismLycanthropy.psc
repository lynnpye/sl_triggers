scriptname survival_vampirismlycanthropy extends referencealias
survival_needhunger property hunger auto
survival_needexhaustion property exhaustion auto
formlist property survival_survivaldiseases auto
event onlycanthropystatechanged(bool abiswerewolf)
endevent
event onvampirismstatechanged(bool abisvampire)
endevent
event onvampirefeed(actor aktarget)
endevent
function removesurvivaldiseases()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1