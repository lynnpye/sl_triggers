scriptname norportcullisscript extends objectreference
bool property isopening
bool function get()
endfunction
endproperty
bool property isclosing
bool function get()
endfunction
endproperty
bool property isalreadyopen ;set "isopen" to same as property "isalreadyopen"
bool function get ()
endfunction
function set(bool value)
endfunction
endproperty
event onload()
endevent
event onreset()
endevent
function setdefaultstate()
endfunction
state upposition ; this is the state i'm in when open and at rest
event onactivate (objectreference triggerref)
endevent
endstate
state downposition ; this is the state i'm in when i'm closed and at rest
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1