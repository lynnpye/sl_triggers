scriptname rpdefault_onaggroalias extends referencealias hidden
bool property bplayeronly = false auto
bool property bonlytriggeronce = true auto
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
state testingcombatstate
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
endstate
state testingonhit
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state completed 
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
bool function handlecombatstatechanged(actor aktarget, int aecombatstate)
endfunction
bool function handlehit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endfunction
bool function handleaggro()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1