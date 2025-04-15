scriptname dlc2pillarshouttriggerscript extends objectreference  
spell property dlc2voicebendtowill1 auto
spell property dlc2voicebendtowill2 auto
spell property dlc2voicebendtowill3 auto
keyword property dlc2linkpillartoggle auto
keyword property dlc2linkpillarmonster auto
keyword property dlc2linkpillarstandingstone auto
quest property dlc2pillardestroyed auto
keyword property dlc2pillardestroyedstart auto
explosion property tempexplosion auto
actorbase property dlc2pillarmonster auto
objectreference[] property refstodisablearray auto
quest  property questtosetstagesin auto ;would be dlc2mq03
referencealias property questmonsteralias auto
int property queststagetosetwhenpillarisdestroyed auto
int property queststagetosetwhenlurkerspawned auto
int property queststagetosetwhenlurkerdies auto
objectreference[] property refstoenableandactivatearray auto
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function stoneexplodes()
endfunction
function stoneexplodessfx()
endfunction
function stoneexplodesdisablerefs()
endfunction
function gatherspectators()
endfunction
function monsterappears()
endfunction
function enableandactivate()
endfunction
function registermonsterdeath(dlc2pillarmonsterscript deadmonster)  ;called by dlc2pillarmonsterscript on mymonster
endfunction
bool function shouldmonsterdisableonload()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1