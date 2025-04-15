scriptname rpdefault_oncontainerchanged extends objectreference hidden
objectreference property specificoldcontainer auto
objectreference property specificnewcontainer auto
bool property bonlytriggeronce = true auto
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
state completed
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
endstate
bool function handlecontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1