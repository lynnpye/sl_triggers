scriptname mq203puzzleringscript extends objectreference  
bool property bpuzzring1 auto
bool property bpuzzring2 auto
bool property bpuzzring3 auto
bool property bpuzzring4 auto
objectreference property controllerscript auto
event onload()
endevent
auto state waiting
event onactivate ( objectreference triggerref )
endevent
endstate
state active
event onactivate ( objectreference triggerref )
endevent
endstate
state busy
event onactivate(objectreference trigref)
endevent
endstate
quest property mq203  auto  
bool property activatorflag  auto  
function finishcheck()
endfunction
function ringfinish()
endfunction
function initializerings()
endfunction
objectreference property lightenabler  auto  
objectreference property bloodsealeffect  auto  
;This file was cleaned with PapyrusSourceHeadliner 1