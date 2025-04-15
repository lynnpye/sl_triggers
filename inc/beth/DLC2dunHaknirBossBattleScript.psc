scriptname dlc2dunhaknirbossbattlescript extends actor 
quest property dlc2dunhaknirtreasureqst auto
objectreference property dlc2dungyldenhulhaknirspawn01 auto
objectreference property dlc2dungyldenhulhaknirspawn02 auto
objectreference property dlc2dungyldenhulhaknirspawn03 auto
objectreference property dlc2dungyldenhulhaknirspawn04 auto
objectreference property dlc2dungyldenhulritual01 auto
objectreference property dlc2dungyldenhulritual02 auto
objectreference property dlc2dungyldenhulritual03 auto
objectreference property dlc2dungyldenhulhaknirsafety auto
objectreference property dlc2dungyldenhulbattlemanager01 auto
objectreference property dlc2dungyldenhulbattlemanager02 auto
objectreference property dlc2dungyldenhulbattlemanager03 auto
objectreference property dlc2dungyldenhulcomplete01 auto
objectreference property dlc2dungyldenhulcomplete02 auto
objectreference property dlc2dungyldenhulcomplete03 auto
spell property dlc2dunhaknirbuff auto
weapon property dlc2dunhaknirscimitar02 auto
activator property summonvalortargetfxactivator auto ;distortion
sound property magflamesimpact auto
actor property player auto
explosion property defaultghostdeathexplosion auto
effectshader property pghostfxshader auto
container property pdefaultghostcorpse auto
explosion property pdefaultghostdeathexplosion auto
leveleditem property pdefaultghostleveledlist auto
spell property pghostabilitynew auto
spell property pghostresistsability auto
float property fdelay = 0.75 auto
float property fdelayend = 1.65 auto
float property shaderduration = 0.00 auto
activator property pdefaultashpileghost auto
bool property bsetalphazero = true auto
formlist property pdisintegrationmainimmunitylist auto
effectshader property pghostdeathfxshader auto
event oninit()
endevent
event onload()
endevent
function ondying(actor killer)
endfunction 
function startbattlephase(int newphase)
endfunction
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onupdate()
endevent
function enablerituallights(objectreference rituallight, float delay)
endfunction
function disablerituallights(objectreference rituallight)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1