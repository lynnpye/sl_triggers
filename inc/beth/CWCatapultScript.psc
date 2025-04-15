scriptname cwcatapultscript extends objectreference  
weapon property weapontofire auto
ammo property ammotofire auto
globalvariable property cwbattlephase auto
keyword property cw1 auto
keyword property cw2 auto
keyword property cw3 auto
keyword property cw4 auto
keyword property cw5 auto
keyword property cwallphases auto
message property cwcatapultmsgangle auto
message property cwcatapultmsgposition auto
float property minstrikespawnertime = 5.0  auto
float property maxstrikespawnertime = 10.0  auto
bool property aim auto
objectreference property facetarget auto
bool property usecwcatapultstrikespawners auto  ;when this is true, don't launch normally, but instead call in special effect explosions (this is set to true when the object is unloaded)
bool property turnedon auto   ;*** when we are done setting up this should be off by defailt and turned on with a function
event onload()
endevent
event onunload()
endevent
state busy
event onbeginstate()
endevent
event onactivate(objectreference akactionref)
endevent
endstate
auto state ready
event onbeginstate()
endevent
event onactivate(objectreference akactionref)
endevent
endstate
state fired
event onbeginstate()
endevent
event onactivate(objectreference akactionref)
endevent
endstate
event onanimationevent(objectreference aksource, string aseventname)
endevent
function turnon()
endfunction
function turnoff(bool anddisable = true)
endfunction
float function gettimetonextlaunch()
endfunction
function startspawningcatapultstrikes()
endfunction
function launch()
endfunction
function reload()
endfunction
function showaimingmenu()
endfunction
function showpositioningmenu()
endfunction
function logpositionandangle()
endfunction
float function getfacingtotarget(objectreference targetref, bool invertfacing = false)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1