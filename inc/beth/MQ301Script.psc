scriptname mq301script extends quest  conditional
event onupdate()
endevent
bool function callodahviingtodragonsreach()
endfunction
function startdragonattackscene()
endfunction
bool function advancedragonattackscene(int newstage)
endfunction
function resetdragonattackscene()
endfunction
function tempresetfactions()
endfunction
objectreference property odahviingstartmarker  auto  
scene property dragonattackscene  auto  
location property dragonsreachlocation auto
int property dragonattackstage = 0 auto  conditional
referencealias property alias_odahviing auto
objectreference property mq301startdragonattacktrig  auto  
faction property dragonfaction auto
faction property playerfaction auto
faction property soldierfaction  auto  
referencealias property alias_jarl  auto  
referencealias property alias_soldier1  auto  
referencealias property alias_soldier2  auto  
referencealias property alias_soldier3  auto  
favordialoguescript property dialoguefavorgeneric  auto  
quest property mqcalldragon  auto  
;This file was cleaned with PapyrusSourceHeadliner 1