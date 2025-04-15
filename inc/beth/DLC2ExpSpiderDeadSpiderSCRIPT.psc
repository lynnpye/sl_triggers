scriptname dlc2expspiderdeadspiderscript extends objectreference  
explosion property spiderexplosion1 auto
explosion property spiderexplosion2 auto
explosion property spiderexplosion3 auto
explosion property spiderexplosion4 auto
explosion property spiderexplosion5 auto
explosion property spiderexplosion6 auto
faction property dlc2expspiderenemyfaction auto
bool property bfriendlybomb = true auto
event onload()
endevent
auto state waitingfortrigger
event ontriggerenter(objectreference akactionref)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state beentriggered
endstate
function doexplosion()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1