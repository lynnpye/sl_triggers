scriptname defaultghostscript extends actor  
effectshader property pghostfxshader auto
formlist property pdefaultghostweaponflickerlist auto
container property pdefaultghostcorpse auto
explosion property pdefaultghostdeathexplosion auto
leveleditem property pdefaultghostleveledlist auto
bool property bdefaultloot=false auto
bool property bflicker=false auto
spell property pghostabilitynew auto
spell property pghostresistsability auto
perk property pghosthalfdamageperk auto
bool property bfade=false auto
float property fdelay = 0.75 auto
float property fdelayend = 1.65 auto
float property shaderduration = 0.00 auto
activator property pdefaultashpileghost auto
bool property bsetalphazero = true auto
formlist property pdisintegrationmainimmunitylist auto
effectshader property pghostdeathfxshader auto
event onload()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function ghostflash(float time)
endfunction
event ondying(actor killer)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1