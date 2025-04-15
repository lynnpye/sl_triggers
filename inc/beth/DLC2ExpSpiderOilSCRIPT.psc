scriptname dlc2expspideroilscript extends objectreference hidden 
activator property oilpool auto
float property ftimebetweenplacement = 0.7 auto
keyword property magicdamagefire auto
explosion property dlc2expspideroilcrumbleexplosion auto
explosion property spiderexplosion1 auto
explosion property spiderexplosion2 auto
explosion property spiderexplosion3 auto
explosion property spiderexplosion4 auto
explosion property spiderexplosion5 auto
explosion property spiderexplosion6 auto
explosion property trapoilexplosion01 auto
event onload()
endevent
event oncelldetach()
endevent
event ondying()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function dropoilpools()
endfunction
function spidercrumble()
endfunction
function doexplosion()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1