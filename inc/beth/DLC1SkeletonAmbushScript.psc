scriptname dlc1skeletonambushscript extends actor
effectshader property sfx1 auto
effectshader property sfx2 auto
effectshader property sfx3 auto
effectshader property sfx4 auto
string property sactorvariable = "variable01"  auto hidden
float property factorvariable = 1.0 auto hidden
float property factorvariableonreset = 0.0 auto hidden
float property faggression = 2.0 auto hidden
float property faggressiononreset = 0.0 auto hidden
keyword property linkkeyword auto
bool property ambushontrigger = false auto
event onreset()
endevent
auto state waiting
event onactivate(objectreference triggerref)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ongetup(objectreference myfurniture)
endevent
event oncombatstatechanged(actor actorref,int aecombatstate)
endevent
endstate
state alldone
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1