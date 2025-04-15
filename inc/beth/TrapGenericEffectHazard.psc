scriptname trapgenericeffecthazard extends trapbase
weapon property presseffect auto
ammo property presseffectammo auto
hazard property myhazard auto
bool property hazardisplaced auto hidden
bool property finishedplaying auto hidden
bool property isfiring auto hidden
bool property isloaded auto hidden
float property initialdelay = 0.0 auto
float property minimumfiringtime = 3.0 auto
event onload()
endevent
event onunload()
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
;This file was cleaned with PapyrusSourceHeadliner 1