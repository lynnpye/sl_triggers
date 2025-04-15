scriptname dlc1cavewormtriggerscript extends objectreference
function closeworm()
endfunction
function openworm()
endfunction
event onactivate(objectreference akactionref)
endevent
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1