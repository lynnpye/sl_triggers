scriptname dlc1vcembertogglescript extends objectreference
bool property init = false auto hidden
sound property lightupsound auto
bool property islit
function set(bool newlitstate)
endfunction 
bool function get() 
endfunction 
endproperty
event onload()
endevent
event onactivate(objectreference activateref)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1