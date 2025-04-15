scriptname rpdefault_onlockstatechangealias extends referencealias hidden
bool property bonlock = false auto
bool property bonlytriggeronce = true auto
event onlockstatechanged()
endevent
state completed
event onlockstatechanged()
endevent
endstate
bool function handlelockstatechanged()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1