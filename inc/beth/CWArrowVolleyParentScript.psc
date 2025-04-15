scriptname cwarrowvolleyparentscript extends objectreference  
weapon property weapontofire auto
ammo property ammotofire auto
globalvariable property cwbattlephase auto
float property waittimemin = 3.0  auto
float property waittimemax = 5.0  auto
int property timestofiremin = 1 auto
int property timestofiremax = 0 auto
bool property fireinphase1 = false auto
bool property fireinphase2 = false auto
bool property fireinphase3 = false auto
bool property fireinphase4 = false auto
bool property fireinphase5 = false auto
float property aimdeviancevertical = 5.0 auto
float property aimdeviancehorizontal = 5.0 auto
float property timetofiredeviance= 0.0 auto
bool property startfiringonload = true auto
int property debugforcecwbattlephaseonload = -1 auto
bool property firing auto hidden
float property initialanglex auto hidden
float property initialanglez auto hidden
event onload()
endevent
event onunload()
endevent
function startfiring()
endfunction
function stopfiring()
endfunction
function fireselfandlinkedrefs()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1