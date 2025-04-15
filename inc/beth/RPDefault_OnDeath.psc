scriptname rpdefault_ondeath extends actor hidden
bool property bkilledbyplayeronly = false auto
bool property bonlytriggeronce = true auto
event ondeath(actor akkiller)
endevent
state completed
event ondeath(actor akkiller)
endevent
endstate
bool function handledeath(actor akkiller)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1