scriptname ms11calixtoscript extends referencealias  
scene property killscene auto
event ondeath(actor akkiller)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
function resolveplayerattack()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1