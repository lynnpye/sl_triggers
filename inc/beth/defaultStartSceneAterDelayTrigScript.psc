scriptname defaultstartsceneaterdelaytrigscript extends objectreference  
scene property scenetostart  auto  
int property secondstodelay auto
bool property doonce = true auto  
objectreference property triggeractor auto
auto state waiting
event ontriggerenter(objectreference actronaut)
endevent
endstate
state done
endstate
quest property prereqquest = none  auto  
int property prereqstage = -1 auto  
;This file was cleaned with PapyrusSourceHeadliner 1