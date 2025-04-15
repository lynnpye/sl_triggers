scriptname dunbloatedmansindingscript extends referencealias
quest property da05 auto
quest property dunbloatedmansgrottoqst auto
bool property istryingtosavesinding = true auto
int property failsafestage auto
faction property playerfaction auto
faction property sindingfaction auto
event onload()
endevent
event onunload()
endevent
function updateloop()
endfunction
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ondeath(actor killer)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1