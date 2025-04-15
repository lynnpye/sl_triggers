scriptname dlc2dunkarstaagbattlescript extends referencealias
spell property dlc2dunkarstaagfrostcloak auto
spell property dlc2dunkarstaagblizzard auto
spell property dlc2dunkarstaagconjureicewraith auto
quest property dlc2dunkarstaagqst auto
static property dlc2dunkarstaagicewraithsummonpoint1 auto
static property dlc2dunkarstaagicewraithsummonpoint2 auto
static property dlc2dunkarstaagicewraithsummonpoint3 auto
scene property dlc2dunkarstaagqst_blizzard auto
scene property dlc2dunkarstaagqst_icewraiths auto
int property counticewraiththreshold = 0 auto hidden conditional ;0=not used, 1=80%, 2=40%, 3=15%.
event startbattle()
endevent
event resetbattle()
endevent
event ondeath(actor akkiller)
endevent
event onupdate()
endevent
event onanimationevent(objectreference source, string eventname)
endevent
auto state normal
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state busy
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
function processhit(objectreference aggressor)
endfunction
function summonicewraiths()
endfunction
function recordicewraith(objectreference wraith)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1