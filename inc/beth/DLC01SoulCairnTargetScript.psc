scriptname dlc01soulcairntargetscript extends objectreference  
bool property doonce = true  auto
objectreference property mytargetobject auto hidden
static property sc_targetmote auto
auto state waiting
event onload()
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state alldone
endstate
;This file was cleaned with PapyrusSourceHeadliner 1