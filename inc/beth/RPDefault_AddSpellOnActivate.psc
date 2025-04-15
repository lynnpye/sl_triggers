scriptname rpdefault_addspellonactivate extends objectreference
bool property bplayeronly = true auto
spell property spelltoadd auto
bool property bdoonce = false auto
event onactivate(objectreference akactivatedby)
endevent
state hasbeentriggered
event onactivate(objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1