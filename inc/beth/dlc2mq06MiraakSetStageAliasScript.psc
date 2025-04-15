scriptname dlc2mq06miraaksetstagealiasscript extends referencealias  
int property stage auto
int property prereqstageopt = -1 auto
auto state waitingforplayer
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1