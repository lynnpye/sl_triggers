scriptname cwfortsiegescript extends cwsiegescript  
int property queststagetocompleteorfailmeetarmyobjective = 50 auto hidden
int property distancetoarmytocompleteobjective = 5000 auto hidden  ;see quest stage 50
int property queststageforphase2 = 200 auto hidden
activator property cwfortsiegephase1trigger auto
activator property cwfortsiegephase2trigger auto
activator property cwfortsiegephase3trigger auto
activator property cwfortsiegephase4trigger auto
activator property cwfortsiegephase5trigger auto
int property barricadedestructionstagetocheckfor = 4 auto hidden    ;see checkbarricadesdestroyedthensetstage() below
referencealias property barricade1 auto
referencealias property barricade2 auto
referencealias property barricade3 auto
referencealias property barricade4 auto
referencealias property barricade5 auto
actorbase property cwfortsiegeimperial auto
actorbase property cwfortsiegesons auto
referencealias property attacker1 auto
referencealias property attacker2 auto
referencealias property attacker3 auto
referencealias property attacker4 auto
referencealias property attacker5 auto
referencealias property attacker6 auto
referencealias property attacker7 auto
referencealias property attacker8 auto
referencealias property attacker9 auto
referencealias property attacker10 auto
referencealias property defender1 auto
referencealias property defender2 auto
referencealias property defender3 auto
referencealias property defender4 auto
referencealias property defender5 auto
referencealias property defender6 auto
referencealias property defender7 auto
referencealias property defender8 auto
referencealias property defender9 auto
referencealias property defender10 auto
referencealias property interiorspawner1 auto hidden
referencealias property interiorspawner2 auto hidden
referencealias property interiorspawner3 auto hidden
referencealias property interiorspawner4 auto hidden
referencealias property interiorspawner5 auto hidden
referencealias property interiorspawner6 auto hidden
referencealias property interiorspawner7 auto hidden
referencealias property interiorspawner8 auto hidden
referencealias property interiorspawner9 auto hidden
referencealias property interiorspawner10 auto hidden
referencealias property interiorspawner11 auto hidden
referencealias property interiorspawner12 auto hidden
referencealias property interiorspawner13 auto hidden
referencealias property interiorspawner14 auto hidden
referencealias property interiorspawner15 auto hidden
referencealias property interiorspawner16 auto hidden
referencealias property interiordefender1 auto hidden
referencealias property interiordefender2 auto hidden
referencealias property interiordefender3 auto hidden
referencealias property interiordefender4 auto hidden
referencealias property interiordefender5 auto hidden
referencealias property interiordefender6 auto hidden
referencealias property interiordefender7 auto hidden
referencealias property interiordefender8 auto hidden
referencealias property interiordefender9 auto hidden
referencealias property interiordefender10 auto hidden
referencealias property interiordefender11 auto hidden
referencealias property interiordefender12 auto hidden
referencealias property interiordefender13 auto hidden
referencealias property interiordefender14 auto hidden
referencealias property interiordefender15 auto hidden
referencealias property interiordefender16 auto hidden
referencealias property triggerphase2a auto
referencealias property triggerphase2b auto
referencealias property triggerphase2c auto
referencealias property triggerphase2d auto
referencealias property triggerphase2e auto
referencealias property triggerphase3a auto
referencealias property triggerphase3b auto
referencealias property triggerphase3c auto
referencealias property triggerphase3d auto
referencealias property triggerphase3e auto
referencealias property triggerphase4a auto
referencealias property triggerphase4b auto
referencealias property triggerphase4c auto
referencealias property triggerphase4d auto
referencealias property triggerphase4e auto
referencealias property triggerphase5a auto
referencealias property triggerphase5b auto
referencealias property triggerphase5c auto
referencealias property triggerphase5d auto
referencealias property triggerphase5e auto
scene property cwfortsiegecapitalsurrenderscene auto
locationalias property fort auto
bool function isplayerattacking()
endfunction
function setstagebasedontrigger(objectreference triggerref)
endfunction
function enablebarricadesifisplayerattacking()
endfunction
function enablebarricades()
endfunction
function disablebarricades()
endfunction
function checkbarricadesdestroyedthensetstage()
endfunction
function registerinteriorspawneraliases(referencealias refalias1, referencealias refalias2, referencealias refalias3, referencealias refalias4, referencealias refalias5, referencealias refalias6, referencealias refalias7, referencealias refalias8, referencealias refalias9, referencealias refalias10, referencealias refalias11, referencealias refalias12, referencealias refalias13, referencealias refalias14, referencealias refalias15, referencealias refalias16)
endfunction
function registerinteriordefenderaliases(referencealias refalias1, referencealias refalias2, referencealias refalias3, referencealias refalias4, referencealias refalias5, referencealias refalias6, referencealias refalias7, referencealias refalias8, referencealias refalias9, referencealias refalias10, referencealias refalias11, referencealias refalias12, referencealias refalias13, referencealias refalias14, referencealias refalias15, referencealias refalias16)
endfunction
function createinteriordefenders(location fortlocation)
endfunction
function trytocreateinteriordefender(location fortlocation, referencealias interiorspawner, referencealias interiordefender)
endfunction
function disableinteriordefenders()
endfunction
function trytodisablealias(referencealias aliastodisable)
endfunction
function enableinteriordefenders()
endfunction
function trytoenablealias(referencealias aliastoenable)
endfunction
function deletewhenableinteriordefenders()
endfunction
function trytodeletewhenablealias(referencealias aliastodeletewhenable)
endfunction
function setnewowneroffort(int stagethatmeansdefenderslost, int stagethatmeansattackerslost)
endfunction
function pulsetriggers()
endfunction
function trytopulsetrigger(referencealias triggeraliastotry)
endfunction
bool function isplayerisnearafriendly(bool playerisattacking)
endfunction
function startfinalcityinteriorbattle()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1