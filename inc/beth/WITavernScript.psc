scriptname witavernscript extends quest conditional
locationalias property mylocation auto
scene property witaverngreeting auto
scene property witavernplayersits auto
int property servergreeted auto hidden conditional  ;used to control behavior of server aliases asking the player if he wants anything
int property playersatdown auto hidden conditional  ;used to control behavior of server aliases asking the player if he wants anything
function playersatdown()
endfunction
function playerchangedlocation()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1