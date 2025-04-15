scriptname dragonactorscript extends actor
imagespacemodifier property dragonfovfx auto
float property deathfxrange = 1024.0 auto
quest property mqkilldragon auto
actor property player auto hidden
float property fovfalloff auto hidden
sound property npcdragonflyby auto
explosion property knockbackexplosion auto
armor property snowdragonskin auto
armor property tundradragonskin auto
armor property forestdragonskin auto
int property dragonbreed = 0 auto
wifunctionsscript property wi auto  ;added by jduvall
impactdataset property fxdragontakeoffimpactset auto
impactdataset property fxdragonlandingimpactset auto
impactdataset property fxdragontailstompimpactset auto
location property dlc2apocryphalocation auto
worldspace property dlc2apocryphaworld auto
event oninit()
endevent
event onreset()
endevent
event onload()
endevent
event onlocationchange(location akoldloc, location aknewloc)
endevent
state alive
event oncombatstatechanged(actor aktarget, int aecombatstate)  
endevent
event onanimationevent(objectreference deliverator, string eventname)
endevent
event ondeath(actor killer)
endevent
endstate
state deadandwaiting
event onbeginstate()
endevent
endstate
state deaddisintegrated
endstate
function animatefov(float ffovfalloff = 1600.0)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1