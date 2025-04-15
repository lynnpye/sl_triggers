scriptname mg07dunlabyrinthianthrallscript extends actor  
quest property dunlabyrinthian auto
int property mystage auto
race property skeletonrace auto
objectreference property mycastdummy auto
event onactivate(objectreference actronaut)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function breakchannel(objectreference whotoblame)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1