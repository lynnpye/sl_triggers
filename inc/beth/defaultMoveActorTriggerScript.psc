scriptname defaultmoveactortriggerscript extends objectreference  
objectreference property movetomarker  auto  
objectreference property ignoreme1  auto  
auto state waiting
event ontriggerenter(objectreference triggerref)
endevent
endstate
bool property bdispelallspells = true auto  
actor property setstageactor  auto  
quest property setstagequest  auto  
int property stagetoset = -1  auto  
;This file was cleaned with PapyrusSourceHeadliner 1