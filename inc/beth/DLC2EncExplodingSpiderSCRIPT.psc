scriptname dlc2encexplodingspiderscript extends actor hidden 
explosion property spiderexplosion1 auto
explosion property spiderexplosion2 auto
explosion property spiderexplosion3 auto
explosion property spiderexplosion4 auto
explosion property spiderexplosion5 auto
explosion property spiderexplosion6 auto
explosion property spidercrumbleexplosion auto
hazard property spiderexplosionhazard auto
bool property bshouldexplode = true auto
int property ielementalresist = 0 auto
bool property bshouldhandleonhit = true auto
keyword property magicdamagefire auto
keyword property magicdamagefrost auto
keyword property magicdamageshock auto
event onload()
endevent
event onanimationevent(objectreference aksource, string eventname)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ondying(actor akkiller)
endevent
function spiderexplode()
endfunction
function spidercrumble()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1