scriptname dlc2norrotatingdoorscript extends objectreference  
bool property startopen auto
event oncellattach()
endevent
auto state waiting
event onactivate (objectreference triggerref)
endevent
endstate
state busy
endstate
;This file was cleaned with PapyrusSourceHeadliner 1