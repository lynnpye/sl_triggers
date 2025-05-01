scriptname zaddquestmonitorplayerscript extends referencealias
miscobject property bogusitem auto
book property chastitybook auto
formlist property eligiblelocations auto
key property forbiddenkey auto
zadlibs property libs auto
zaddquestmonitorscript property questmonitor auto
event onplayerloadgame()
endevent
function maintenance()
endfunction
auto state disabled
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
endstate
state enabled
event onlocationchange(location akoldloc, location aknewloc)
endevent
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1