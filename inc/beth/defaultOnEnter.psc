scriptname defaultonenter extends objectreference  conditional
actorbase property triggeractor1 auto
actorbase property triggeractor2 auto
actorbase property triggeractor3 auto
actorbase property triggeractor4 auto
referencealias property triggeralias1 auto
bool property disablewhendone = false  auto
event oninit()
endevent
auto state waiting
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
function modtargetcount(int modvalue)
endfunction
int function getcurrenttargetcount()
endfunction
int function gettotaltargetcount()
endfunction
bool function istriggerready()
endfunction
bool function checktriggerref(objectreference triggerref)
endfunction
function triggerme()
endfunction
bool property balltargetsintrigger = false auto  conditional
;This file was cleaned with PapyrusSourceHeadliner 1