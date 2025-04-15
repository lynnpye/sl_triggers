scriptname rpdefault_onlocationchange extends actor hidden
bool property blocationenter = true auto
location property locationtowatch auto
bool property bonlytriggeronce = true auto
event onlocationchange(location akoldloc, location aknewloc)
endevent
state completed
event onlocationchange(location akoldloc, location aknewloc)
endevent
endstate
bool function handlelocationchange(location akoldloc, location aknewloc)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1