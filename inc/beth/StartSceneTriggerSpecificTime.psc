scriptname startscenetriggerspecifictime extends objectreference  
scene property scenetostart  auto  
bool property doonce = true auto  
objectreference property triggeractor auto
quest property prereqquest = none  auto  
int property prereqstage = -1 auto  
globalvariable property gamehour auto
float property noearlierthan = -1.0 auto  
float property nolaterthan  = -1.0 auto  
auto state waiting
event ontriggerenter(objectreference actronaut)
endevent
endstate
state done
endstate
bool function istimevalid()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1