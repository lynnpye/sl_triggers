scriptname trapbase extends objectreference
bool property init auto hidden    ; this should not be set by the user
bool property trapdisarmed auto hidden ; this should not be set by the user
bool property loop auto hidden    ; this should not be set by the user
objectreference property lastactivateref auto hidden
bool property fireonlyonce auto ;this should be set by the user
sound property windupsound auto ;played when winding up or releasing trap
bool property overrideloop = false auto hidden
int property traplevel = 1 auto
int property damage auto hidden
traphitbase property hitbase auto hidden
function initialize()  ; placeholder - replaced with trap specific function
endfunction
function firetrap()   ; placeholder - replaced with trap specific function
endfunction
function resetlimiter() ; placeholder - replaced with trap specific function
endfunction
auto state idle
event onactivate (objectreference activateref)
endevent
endstate
state doonce               ;type do once
event onactivate( objectreference activateref )
endevent
endstate
state reset
event onbeginstate()
endevent
event onactivate( objectreference activateref )
endevent
endstate
state on
event onactivate (objectreference activateref)
endevent
endstate
state hold   ;hold overrides all other states ***this is kind of a depricated state ***
event onactivate (objectreference activateref)
endevent
endstate
state disarmed
endstate
function resolveleveleddamage ()  ;placeholder function, declared in children
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1