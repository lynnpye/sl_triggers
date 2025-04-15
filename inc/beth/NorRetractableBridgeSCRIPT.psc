scriptname norretractablebridgescript extends objectreference
bool property isalreadylowered ;set "isopen" to same as property "isalreadyopen"
bool function get ()
endfunction
function set(bool value)
endfunction
endproperty
event oninit()
endevent
state loweredposition ; this is the state i'm in when open and at rest
event onactivate (objectreference triggerref)
endevent
endstate
state raisedposition ; this is the state i'm in when i'm closed and at rest
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1