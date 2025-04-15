scriptname ccbgssse001_dynamotriggerscript extends objectreference  
bool property ison = false auto
bool property itemisnotremovable = false auto
bool property isanimating = false auto hidden
string property onanim = "on" auto
string property offanim = "off" auto
string property startonanim = "starton" auto
string property doneevent = "done" auto
message property itemneededmessage auto
miscobject property requireditem auto
event onload()
endevent
event onreset()
endevent
auto state off ; waiting to be activated
event onactivate (objectreference akactivator)
endevent
endstate
state busy
event onactivate(objectreference akactivator)
endevent
endstate
state on
event onactivate (objectreference akactivator)
endevent
endstate
function allowitemremoval()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1