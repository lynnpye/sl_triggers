scriptname norrotatingdoorscript extends objectreference  
bool property startopen auto
sound property startingsound auto
sound property stoppingsound auto
event onload()
endevent
auto state offpos
event onactivate (objectreference triggerref)
endevent
endstate
state busystate
endstate
;This file was cleaned with PapyrusSourceHeadliner 1