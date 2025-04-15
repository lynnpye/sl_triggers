scriptname duntreasmapdragonbridgescript extends objectreference
keyword property mykeyword auto
event oncellload()
endevent
auto state waiting
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
event onread()
endevent
endstate
state done
event onread()
endevent
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1