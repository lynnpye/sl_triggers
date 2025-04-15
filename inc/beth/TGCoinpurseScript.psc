scriptname tgcoinpursescript extends objectreference  conditional
miscobject property coinobj auto
miscobject property tgcoinpurse auto
int property coinmin auto
int property coinmax auto
event onload()
endevent
function cointake()
endfunction
auto state waiting
event onactivate (objectreference triggerref)
endevent
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1