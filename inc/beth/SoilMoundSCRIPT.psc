scriptname soilmoundscript extends objectreference  
activator property justplantedbase auto
objectreference property justplantedref auto hidden
auto state emptyplot
event onactivate(objectreference triggerref)
endevent
endstate
state justplanted
event onactivate(objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1