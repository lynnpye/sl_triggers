scriptname pnightmotherdawnstartriggerscript extends objectreference  
quest property db11  auto  
quest property dbrecurring  auto
scene property pnightmotherdawnstarscene  auto  
scene property pnightmotherrecurringscene1  auto    
event ontriggerenter(objectreference akactivator)
endevent
event ontriggerleave(objectreference akactionref)
endevent
bool function isplayerintrigger()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1