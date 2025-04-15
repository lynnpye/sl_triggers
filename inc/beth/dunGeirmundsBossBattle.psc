scriptname dungeirmundsbossbattle extends referencealias
quest property dungeirmundsqst auto
objectreference property secretdoor auto
actor property duplicate1actor auto
actor property duplicate2actor auto
referencealias property duplicate1alias auto
referencealias property duplicate2alias auto
objectreference property duplicate1setuppoint auto
objectreference property duplicate2setuppoint auto
actorbase property duplicateactorbase auto
int property duplicatelevelmod auto
encounterzone property duplicateenczone auto
location property geirmundshalllocation auto
objectreference property position1 auto
objectreference property position2 auto
objectreference property position3 auto
objectreference property position4 auto
activator property summonfx auto
activator property banishfx auto
spell property dispel auto
referencealias property summonfxmanager auto
referencealias property banishfxmanager auto
objectreference property holdinglinker auto
event ongetup(objectreference akfurniture)
endevent
function updateloop()
endfunction
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function assessduplicates()
endfunction
event ondeath(actor akkiller)
endevent
function duplicate()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1