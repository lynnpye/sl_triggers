scriptname skyhavensconcescript extends objectreference  
auto state waitingtobeactivated
event onactivate (objectreference triggerref)
endevent
event onload()
endevent
endstate
state done
endstate
function turnonlight()
endfunction
keyword property sconcekeyword  auto  
keyword property lightkeyword  auto  
objectreference property enableonloadmarker  auto  
;This file was cleaned with PapyrusSourceHeadliner 1