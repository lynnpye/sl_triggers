scriptname dlc1trapspotlight extends trapbase
spell property magicweapon auto hidden
float property initialdelay = 0.5 auto hidden
float property firingrate = 4.5 auto hidden
float property firingrateoverride = 0.0 auto
float property firingspinup = 0.5 auto hidden
float property firingtime = 4.5 auto
float property currenttime auto hidden
float property endtime auto hidden
int property castingaim = 0 auto
objectreference property targetref auto hidden
bool property forwardfiring = false auto
int property aaspelltocast = 2 auto
bool property isfiring auto hidden
bool property isloaded auto hidden
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
float property horizontalsweephalf = 90.0 auto
float property verticalsweephalf = 90.0 auto
bool function refisvalidforwardtarget(objectreference testref)
endfunction
int property lvlthreshold1 auto
int property lvlthreshold2 auto
int property lvlthreshold3 auto
int property lvlthreshold4 auto
int property lvlthreshold5 auto
spell property dlc1trapspotlightspell01 auto 
spell property dlc1trapspotlightspell02 auto 
spell property dlc1trapspotlightspell03 auto 
spell property dlc1trapspotlightspell04 auto 
spell property dlc1trapspotlightspell05 auto 
spell property dlc1trapspotlightspell06 auto 
function resolveleveledweapon ()
endfunction
function resolvecastingdelay()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1