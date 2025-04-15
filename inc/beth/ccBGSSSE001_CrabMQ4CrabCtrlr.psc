scriptname ccbgssse001_crabmq4crabctrlr extends objectreference  
actor property playerref auto
message property invulnerablemsg auto
sound property ccbgssse001_npcgiantmudcrabinjuredsm auto
explosion property groundimpactexplosion auto
explosion property waterimpactexplosion auto
effectshader property ghosteffect auto
objectreference property rightimpactmarker auto
objectreference property rightfarimpactmarker auto
objectreference property leftimpactmarker auto
objectreference property leftfarimpactmarker auto
objectreference property leftnearimpactmarker auto
float property death_failsafe_duration = 5.0 autoreadonly
float property attack_failsafe_duration = 10.0 autoreadonly
float property attack_time_offset = 2.0 autoreadonly
int property attack_id_left = 0 autoreadonly
int property attack_id_leftfar = 1 autoreadonly
int property attack_id_leftnear = 2 autoreadonly
int property attack_id_right = 3 autoreadonly
int property attack_id_rightfar = 4 autoreadonly
string property anim_idle = "forceidle" autoreadonly
string property anim_attackleft = "attackleft" autoreadonly
string property anim_attackleftfar = "attackleftfar" autoreadonly
string property anim_attackleftnear = "attackleftnear" autoreadonly
string property anim_attackright = "attackright" autoreadonly
string property anim_attackrightfar = "attackrightfar" autoreadonly
string property anim_die = "die" autoreadonly
int property death_state_dying = 1 autoreadonly
int property death_state_dead = 2 autoreadonly
string property anim_event_clawimpact = "clawimpact" autoreadonly
string property anim_event_transitioncomplete = "transitioncomplete" autoreadonly
projectile property catapultprojectile auto
auto state readyforhit
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state busy
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
function catapulthit()
endfunction
event onload()
endevent
event onunload()
endevent
event onupdate()
endevent
function killemperorcrabguardian()
endfunction
function registerfornextattack()
endfunction
function performrandomattack()
endfunction
event onanimationevent(objectreference aksource, string aseventname)
endevent
function playimpactexplosion()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1