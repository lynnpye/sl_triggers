scriptname defaultenablelinkedrefondeath extends actor  
auto state waitingtobeactivated
event ondeath(actor killer)
endevent
endstate
state done
endstate
bool property benableonactivate = true  auto  
keyword property linkedrefkeyword  auto  
;This file was cleaned with PapyrusSourceHeadliner 1