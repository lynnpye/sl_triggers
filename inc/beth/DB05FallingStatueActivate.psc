scriptname db05fallingstatueactivate extends objectreference
int property damage = 10000 auto hidden
int property soundlevel = 100 auto 
int property trappushback auto
sound property traphitsound auto
weapon property hitfx auto
ammo property hitfxammo auto
bool property trapcausesstagger = false auto
bool property rumble = false auto
float property rumbleamount = 0.7 auto
float property rumbleduration = 0.5 auto
bool property camerashake = false auto
float property camerashakeamount = 0.7 auto
float property staggeramount = 0.0 auto
explosion property pushbackexplosion auto
explosion property placedexplosion auto
float property damagevelocitythreshold = 0.2 auto
objectreference property mytargetref auto
objectreference property fallingmarker auto
float property movespeed = 300.0 auto
quest property myquest auto 
int property stagetoset auto
bool property causecrimegold = true auto
bool property triggeronhit = false auto
state inactive
endstate
auto state waiting
event onactivate(objectreference triggerref)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state falling
event onbeginstate()
endevent
event ontraphitstart(objectreference aktarget, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
endstate
state complete
event onbeginstate()
endevent
endstate
event onload()
endevent
function triggerstatuefalling()
endfunction
bool function acceptablevelocitydelta(float targetvelocity, float afxvel, float afyvel, float afzvel)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1