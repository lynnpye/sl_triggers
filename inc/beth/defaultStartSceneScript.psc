scriptname defaultstartscenescript extends objectreference  
scene property scenetostart  auto  
bool property doonce = true auto  
objectreference property triggeractor auto
event onactivate(objectreference actronaut)
endevent
quest property prereqquest = none  auto  
int property prereqstage = -1 auto  
;This file was cleaned with PapyrusSourceHeadliner 1