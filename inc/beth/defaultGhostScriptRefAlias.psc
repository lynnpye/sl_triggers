scriptname defaultghostscriptrefalias extends referencealias  
effectshader property pghostfxshader auto
formlist property pdefaultghostweaponflickerlist auto
container property pdefaultghostcorpse auto
explosion property pdefaultghostdeathexplosion auto
bool property bflicker=false auto
spell property pghostabilitynew auto
spell property pghostresistsability auto
perk property pghosthalfdamageperk auto
bool property bfade=false auto
event onload()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function ghostflash(float time)
endfunction
event ondying(actor killer)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1