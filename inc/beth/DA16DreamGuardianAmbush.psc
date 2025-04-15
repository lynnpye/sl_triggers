scriptname da16dreamguardianambush extends actor
string property sactorvariable = "variable01"  auto hidden
float property factorvariable = 1.0 auto hidden
float property faggression = 2.0 auto hidden
keyword property linkkeyword auto
bool property ambushontrigger = false auto
visualeffect property trailfx auto
visualeffect property trailfx02 auto
objectreference property objself auto hidden
scene property myscene auto
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