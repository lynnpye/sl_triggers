scriptname survival_conditionsscript extends quest conditional
actor property playerref auto
bool property isridingdragon = false auto conditional hidden
bool property isfasttravelcontrolsenabled = true auto conditional hidden
bool property isswimminginfreezingwater = false auto conditional hidden
bool property isinplaneofoblivion = false auto conditional hidden
bool property isbeastrace = false auto conditional hidden
bool property ismoving = false auto conditional hidden
objectreference property lastheatsourcetrigger auto conditional hidden
bool function isplayernearheat()
endfunction
int property isholdingtorch = 0 auto conditional hidden
function incrementholdingtorch()
endfunction
function decrementholdingtorch()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1