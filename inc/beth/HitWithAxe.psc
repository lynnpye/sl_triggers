scriptname hitwithaxe extends referencealias  
int property prereqstageopt = -1 auto
referencealias property alias_barbas auto
referencealias property da03ruefelaxe auto
auto state waitingforplayer
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1