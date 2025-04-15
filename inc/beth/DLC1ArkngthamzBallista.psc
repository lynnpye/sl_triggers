scriptname dlc1arkngthamzballista extends trapbase
int property shotcount = 3 auto
float property initialdelay = 0.0 auto
weapon property ballistaweaponm auto
weapon property ballistaweaponl auto
weapon property ballistaweaponr auto
bool property fireallshots = true auto
bool property isfiring auto hidden
bool property isloaded auto hidden
bool property shotfired = false auto hidden
bool property weaponresolved = false auto hidden
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
int property lvlthreshold1 auto
int property lvlthreshold2 auto
int property lvlthreshold3 auto
int property lvlthreshold4 auto
int property lvlthreshold5 auto
ammo property ballistaammo auto
ammo property trapdweballistaboltammo01 auto
ammo property trapdweballistaboltammo02 auto
ammo property trapdweballistaboltammo03 auto
ammo property trapdweballistaboltammo04 auto
ammo property trapdweballistaboltammo05 auto
ammo property trapdweballistaboltammo06 auto
function resolveleveledweapon ()
endfunction
event onload()
endevent
event onunload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1