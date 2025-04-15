scriptname bwcnightingaleghostscript extends actor  
effectshader property ghosteffect auto
float property ghostalpha=0.3 auto
container property ghostcorpse auto
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
event onanimationevent(objectreference aksource, string eventname)
endevent
event ondying(actor killer)
endevent
function ghostflash()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1