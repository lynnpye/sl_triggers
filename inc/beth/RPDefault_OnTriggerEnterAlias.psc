scriptname rpdefault_ontriggerenteralias extends referencealias hidden
bool property bplayeronly = true auto
bool property bonlytriggeronce = true auto
event ontriggerenter(objectreference akactionref)
endevent
state completed
event ontriggerenter(objectreference akactionref)
endevent
endstate
bool function handletriggerenter(objectreference akactionref)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1