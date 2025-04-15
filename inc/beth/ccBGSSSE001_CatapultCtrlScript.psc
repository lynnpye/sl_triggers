scriptname ccbgssse001_catapultctrlscript extends objectreference  
actor property playerref auto
spell property catapultvolley auto
objectreference[] property reloadtriggers auto
objectreference[] property firetriggers auto
message property nopoterrormessage auto
miscobject property flamingpot auto
ccbgssse001_catapultmonitor property catapultmonitor auto
int property nopotobjective auto
int property state_fired = 0 autoreadonly
int property state_reloading = 1 autoreadonly
int property state_loaded = 2 autoreadonly
int property state_firing = 3 autoreadonly
int property state_disabled = 4 autoreadonly
int property allow_interact_stage = 300 autoreadonly
string property anim_fire = "fire" autoreadonly      ; cause the catapult arm to fly up and launch the payload
string property anim_reload = "reload" autoreadonly     ; cause the catapult arm to lower and spawn a new payload
string property anim_start_fired = "startfired" autoreadonly  ; start catapult in the fired position
string property anim_event_launch = "launch" autoreadonly   ; sent at the moment the payload leaves the arm
string property anim_event_fired = "fired" autoreadonly    ; sent when the launch animation is complete and it's safe to allow activate events to load it again
string property anim_event_reloaded = "reloaded" autoreadonly  ; sent when the reload animation is finished and it's safe to allow activate events to launch it again
event onload()
endevent
function waitforcatapultloaded()
endfunction
event onunload()
endevent
function registerforanimationevents()
endfunction
function unregisterforanimationevents()
endfunction
function reload(objectreference akactivator)
endfunction
function fire(objectreference akactivator)
endfunction
function setreloadingstate()
endfunction
function setloadedstate()
endfunction
function setfiringstate()
endfunction
function setfiredstate()
endfunction
function enablefiretriggers()
endfunction
function disablefiretriggers()
endfunction
function enablereloadtriggers()
endfunction
function disablereloadtriggers()
endfunction
function setstatedisabled()
endfunction
state busy
function reload(objectreference akactivator)
endfunction
function fire(objectreference akactivator)
endfunction
endstate
;This file was cleaned with PapyrusSourceHeadliner 1