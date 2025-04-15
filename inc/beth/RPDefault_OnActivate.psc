scriptname rpdefault_onactivate extends objectreference hidden
bool property bplayeronly = true auto
bool property bonlytriggeronce = true auto
event onactivate(objectreference akactivatedby)
endevent
state completed
event onactivate(objectreference akactivatedby)
endevent
endstate
bool function handleactivate(objectreference akactivatedby)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1