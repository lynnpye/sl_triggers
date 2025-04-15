scriptname mgr02questscript extends quest  conditional
int property glovesequipped  auto  conditional
referencealias property point01  auto  
referencealias property point02  auto  
referencealias property point03  auto  
referencealias property point04  auto  
referencealias property point05  auto  
int property randomvalue  auto  
int property pointsdone  auto  conditional
int property creaturespawned  auto  conditional
int property point1done  auto  conditional
int property point2done  auto  conditional
int property point3done  auto  conditional
int property point4done  auto  conditional
int property point5done  auto  conditional
function focuspointactivate(objectreference activateref)
endfunction
globalvariable property favorrewardsmall  auto  
formlist property gemlist  auto  
soulgem property gemreward  auto  
spell property goodspell  auto  
spell property badspell  auto  
objectreference property mgr02castingmarkerref  auto  
;This file was cleaned with PapyrusSourceHeadliner 1