scriptname ccbgs_arbladetrapscript extends movingtrap
auto state waiting
event onactivate(objectreference akactionref)
endevent
endstate
state trapactive
endstate
function firetrap()
endfunction
event onanimationevent(objectreference aksource, string aseventname)
endevent
function resettrap()
endfunction
event onreset()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1