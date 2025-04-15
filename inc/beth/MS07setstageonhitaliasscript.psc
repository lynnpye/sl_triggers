scriptname ms07setstageonhitaliasscript extends referencealias  
int property stage auto
int property prereqstageopt = -1 auto
bool property playeronly = true auto
auto state waitingforplayer
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1