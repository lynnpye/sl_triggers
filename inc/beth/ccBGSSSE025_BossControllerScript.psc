scriptname ccbgssse025_bosscontrollerscript extends quest conditional
referencealias property boss auto
objectreference[] property summonmarkerrefs auto
quest property bossmainquest auto
actor property playerref auto
activator property summonfx auto
actorbase property summonedgoldensaintwarrior auto
actorbase property summonedgoldensaintarcher auto
actorbase property summoneddarkseducerwarrior auto
actorbase property summoneddarkseducerarcher auto
objectreference property battlefieldcenterref auto
objectreference property bosscenterteleportmarkerref auto
effectshader property fadeoutfx auto
visualeffect property trailfxabsorb auto
float property max_boss_wander_distance = 1600.0 autoreadonly hidden
float property teleport_summon_fx_duration = 0.5 autoreadonly hidden
float property teleport_trail_fx_duration = 0.75 autoreadonly hidden
float property health_check_duration = 2.0 autoreadonly hidden
event oninit()
endevent
event onupdate()
endevent
function teleportandsetnewsummonphase(objectreference teleporttarget, int phase)
endfunction
function onbossentercombat()
endfunction
function onbossexitcombat()
endfunction
function onbossdeath()
endfunction
function summonphase(int phase)
endfunction
function summon(actorbase actortosummon, int index)
endfunction
function dispelsummons()
endfunction
function teleporttolocation(objectreference teleportmarker, bool abautodetectplayer = true)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1