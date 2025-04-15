scriptname dlc2rieklingbarrelambushscript extends actor  
explosion property dlc2srieklinghavokexplosion auto
faction property dunprisonerfaction auto
string property sactorvariable = "variable01"  auto hidden
float property factorvariable = 1.0 auto hidden
float property factorvariableonreset = 0.0 auto hidden
float property faggression = 2.0 auto hidden
float property faggressiononreset = 0.0 auto hidden
keyword property linkkeyword auto
event onreset()
endevent
auto state waiting
event oncellattach()
endevent
event onactivate(objectreference triggerref)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ongetup(objectreference myfurniture)
endevent
event oncombatstatechanged(actor actorref,int aecombatstate)
endevent
event onendstate()
endevent
endstate
state alldone
endstate
;This file was cleaned with PapyrusSourceHeadliner 1