scriptname dunlabyrinthianmazetabletscript extends objectreference  
bool property isdestruction auto
bool property isalteration auto
bool property isrestoration auto
bool property isillusion auto
sound property wrongspellsfx  auto  
sound property correctspellsfx  auto  
dunlabyrinthianmazecontrolscript property mazecontrol auto
bool property done auto
bool property fxon auto hidden
objectreference property linktoactivate auto
event onload()
endevent
event onupdate()
endevent
event onactivate(objectreference actronaut)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
function solveme(objectreference whosolved)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1