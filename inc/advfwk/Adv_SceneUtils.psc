scriptname adv_sceneutils extends quest conditional
int property timer = 30 auto hidden
int property expectedprogress = 1000 auto hidden
globalvariable property scenetimeout auto
function begin(referencealias akactoralias, objectreference aktarget = none) global
endfunction
function cancel() global
endfunction
function resettimer() global
endfunction
event onupdate()     
endevent
function waitforscene(actor aktarget, float afdelay = 1.0) global
endfunction
function fillaliases(referencealias[] akaliases, actor[] akactors) global
endfunction
function clearaliases(referencealias[] akaliases) global
endfunction 
function blackfade(bool abenable = true) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1