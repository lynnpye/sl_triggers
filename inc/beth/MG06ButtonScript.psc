scriptname mg06buttonscript extends objectreference  conditional
function _open()
endfunction
function _close()
endfunction
function close()
endfunction
function open()
endfunction
event oninit()
endevent
auto state closed
event onbeginstate()
endevent
function open()
endfunction
endstate
state opened
event onbeginstate()
endevent
event onactivate(objectreference akactivator)
endevent
function close()
endfunction
endstate
state busy
function open()
endfunction
function close()
endfunction
endstate
;This file was cleaned with PapyrusSourceHeadliner 1