scriptname defaultbloodpoolscript extends objectreference  
bool property startfull = false auto conditional
string property fillanim = "play" auto
event onload()
endevent
auto state waiting ; waiting to be activated
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1