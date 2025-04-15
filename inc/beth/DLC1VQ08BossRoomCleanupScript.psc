scriptname dlc1vq08bossroomcleanupscript extends objectreference  
event ontriggerenter(objectreference akactionref)
endevent
event ontriggerleave(objectreference akactionref)
endevent
function addtolist(objectreference akactionref)
endfunction
function setactive(bool bactive)
endfunction
function clearlist()
endfunction
bool property bisactive = true auto hidden   ; set to false to turn off tracking
formlist property dlc1vq08flbossroomtrackinglist  auto  
;This file was cleaned with PapyrusSourceHeadliner 1