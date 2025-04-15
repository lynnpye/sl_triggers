scriptname defaultenablelinkedrefonactivate extends objectreference  
auto state waitingtobeactivated
event onactivate (objectreference triggerref)
endevent
endstate
state done
endstate
bool property benableonactivate = true  auto  
keyword property linkedrefkeyword  auto  
;This file was cleaned with PapyrusSourceHeadliner 1