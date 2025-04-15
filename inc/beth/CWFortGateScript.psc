scriptname cwfortgatescript extends objectreference  
bool property openme auto hidden
bool property closeme auto hidden
bool property isopen = false auto
int property updatefrequency = 5 auto
globalvariable property debugon auto
event oninit()
endevent
event onupdate()
endevent
state busy
event onactivate(objectreference triggerref)
endevent
event onupdate()
endevent
function open()
endfunction
function close()
endfunction
endstate
state upposition ; this is the state i'm in when open and at rest
event onactivate(objectreference triggerref)
endevent
endstate
state downposition ; this is the state i'm in when i'm closed and at rest
event onactivate(objectreference triggerref)
endevent
endstate
function open()
endfunction
function close()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1