scriptname rpdefault_setstageonhit extends rpdefault_onhit
quest property targetquest auto
int property prereqstage = -1 auto
int property stagetoset auto
bool function handlehit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1