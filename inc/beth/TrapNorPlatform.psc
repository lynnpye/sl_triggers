scriptname trapnorplatform extends movingtrap
float property firespeed = 1.0 auto
float property returnspeed = 5.0 auto
float property returndelay = 2.5 auto
float property initialdelay = 0.25 auto
string property fireanim  auto hidden
string property firespeedstring  auto hidden
string property fireevent = "done" auto hidden
string property resetanim auto hidden
string property resetspeedstring  auto hidden
string property resetevent = "done" auto hidden
string property startswunganim auto hidden
bool property startswung = false auto
hazardbase property myhazardbase auto hidden
int property startingheight = 0 auto
int function get()
endfunction
function set (int value)
endfunction
endproperty/;
int property endingheight = 3 auto
event onload()
endevent
function firetrap()
endfunction
state reset
event onbeginstate()
endevent
event onactivate( objectreference activateref )
endevent
endstate
function resetlimiter()
endfunction
function setresetanim()
endfunction
function setfireanim()
endfunction
function resolveleveleddamage()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1