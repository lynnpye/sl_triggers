scriptname dlc2dunkolbjornrotdoorchainscript extends objectreference
sound property drsstonerotatingdisclpm auto
auto state off
event onactivate(objectreference akactivator)
endevent
endstate
state on
event onactivate(objectreference akactivator)
endevent
endstate
state busy
event onactivate(objectreference akactivator)
endevent
endstate
function onanimationevent(objectreference source, string eventname)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1