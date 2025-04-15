scriptname rpdefault_ontriggerleave extends objectreference hidden
bool property bplayeronly = true auto
bool property bonlytriggeronce = true auto
event ontriggerleave(objectreference akactionref)
endevent
state completed
event ontriggerleave(objectreference akactionref)
endevent
endstate
bool function handletriggerleave(objectreference akactionref)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1