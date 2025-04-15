scriptname fxskuldafnportal extends objectreference  
objectreference property mylight auto 
objectreference property qstsovengardeportalopenref auto 
objectreference property qstsovengardeportalon2dlpmref auto 
objectreference property qstsovengardeportalfarlpmref auto 
objectreference property qstsovengardeportalonmonolpmref auto 
sound property qstsovengardeportalclosesdref auto
bool property isopen = true auto conditional
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onload()
endevent
auto state waiting ; waiting to be activated
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onanimationevent(objectreference aksource, string aseventname)
endevent
endstate
function openportal(objectreference triggerref, bool abopen = true, bool abquickopen = false)
endfunction
function closeportal()
endfunction
objectreference property mydoor  auto  
objectreference property seal  auto  
objectreference property mystaff  auto  
weapon property mq303dragonprieststaff  auto  
;This file was cleaned with PapyrusSourceHeadliner 1