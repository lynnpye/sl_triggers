scriptname oredepositscript extends objectreference
int property hptotal = 100 auto
miscobject property oreobject auto
int property minyeald = 1 auto
int property maxyeald = 3 auto
weapon property pickax auto
auto state unharvested
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state harvested
endstate
function harvest(objectreference triggerref)
endfunction
event oninit()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1