scriptname darttrap extends trapbase
float property initialdelay = 0.2 auto
float property firingdelay = 0.03 auto
int property numshots =1 auto
bool property isfiring auto hidden
bool property isloaded auto hidden
function initialize()
endfunction
function resetlimiter()
endfunction
function firetrap()
endfunction
state reset
event onbeginstate()
endevent
event onactivate( objectreference activateref )
endevent
endstate
event oncellattach()
endevent
event oncelldetach()
endevent
int property lvlthreshold1 auto
weapon property lvlweapon1 auto
int property lvlthreshold2 auto
weapon property lvlweapon2 auto
int property lvlthreshold3 auto
weapon property lvlweapon3 auto
int property lvlthreshold4 auto
weapon property lvlweapon4 auto
int property lvlthreshold5 auto
weapon property lvlweapon5 auto
weapon property lvlweapon6 auto
ammo property dartammo auto
function resolveleveledweapon ()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1