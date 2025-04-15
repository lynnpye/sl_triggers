scriptname dlc2dwekineticresonatorscript extends objectreference
bool property startinactivestate = false auto
keyword property linkkeyword auto
function oncellload()
endfunction
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
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onactivate(objectreference akactivator)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1