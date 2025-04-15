scriptname dunreachwaterrocksigdisbossbattle extends referencealias
weapon property gauldurblackbow auto
actor property duplicate1actor auto
actor property duplicate2actor auto
actor property duplicate3actor auto
referencealias property duplicate1alias auto
referencealias property duplicate2alias auto
referencealias property duplicate3alias auto
objectreference property duplicate1setuppoint auto
objectreference property duplicate2setuppoint auto
objectreference property duplicate3setuppoint auto
actorbase property duplicateactorbase auto
int property duplicatelevelmod auto
encounterzone property duplicateenczone auto
keyword property linkcustom02 auto
objectreference property position1 auto
objectreference property position2 auto
objectreference property position3 auto
objectreference property position4 auto
objectreference property position5 auto
objectreference property position6 auto
activator property summonfx auto
activator property banishfx auto
spell property dispel auto
referencealias property summonfxmanager auto
referencealias property banishfxmanager auto
spell property ghostabilitynew auto
spell property ghostabilitysigdis auto
effectshader property ghosteffect auto
quest property dungauldursonqst auto
function beginsigdisbattle()
endfunction
event onupdate()
endevent
function endsigdisbattle()
endfunction
function updateloop()
endfunction
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function assessduplicates()
endfunction
event ondying(actor killer)
endevent
function duplicate()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1