scriptname dlc2dunfahlbtharzresonatorscript extends objectreference
int property steamcharge = 0 auto
float property steamreleasetime = 0.5 auto hidden
objectreference property dlc2dunfahlbtharzsteampuzzlecontrollerref auto
dlc2dunfahlbtharzsteampuzzlecontroller property steamcontroller auto hidden
bool property wasreset = false auto hidden
event onload()
endevent
auto state inactive
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onactivate(objectreference akactivator)
endevent
endstate
state active
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onactivate(objectreference akactivator)
endevent
endstate
state busy
endstate
state reset
event onbeginstate()
endevent
endstate
function activatesteamchain(int steamchargechange)
endfunction
function turnoffsteam()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1