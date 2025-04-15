scriptname defaultaliasrespawnscript extends referencealias  
function respawnifdead()
endfunction
auto state normal
event ondeath(actor akkiller)
endevent
endstate
state respawning
event ondeath(actor akkiller)
endevent
endstate
bool property brespawningon = true auto  
;This file was cleaned with PapyrusSourceHeadliner 1