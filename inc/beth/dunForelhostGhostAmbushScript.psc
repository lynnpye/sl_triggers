scriptname dunforelhostghostambushscript extends defaultghostscript
string property sactorvariable = "variable01"  auto hidden
float property factorvariable = 1.0 auto hidden
float property faggression = 2.0 auto hidden
keyword property linkkeyword auto
bool property ambushontrigger = false auto
effectshader property ghostshader auto
float property ghostalpha = 0.3 auto
objectreference property samplepatrolidlemarker auto
function onghostactivation()
endfunction
auto state waiting
event onload()
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