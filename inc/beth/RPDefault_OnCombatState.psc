scriptname rpdefault_oncombatstate extends actor hidden
bool property bplayeronly = false auto
int property icombatstate = 1 auto
bool property bonlytriggeronce = true auto
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
state completed
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
endstate
bool function handlecombatstatechanged(actor aktarget, int aecombatstate)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1