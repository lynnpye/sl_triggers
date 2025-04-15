scriptname defaultquestrespawnscript extends quest  
objectreference property respawnmarker1 auto  
objectreference property respawnmarker2 auto  
objectreference property respawnmarker3 auto  
objectreference property respawnmarkerfailsafe  auto  
int property startstage = 0  auto  
int property donestage = 0  auto  
int property respawntimemin = 5 auto
int property respawntimemax = 10 auto
int property respawnpool = 0 auto
function respawn(referencealias aliastorespawn)
endfunction
function trytorespawn(referencealias aliastorespawn)
endfunction
objectreference function getrespawnmarker(objectreference marker1, objectreference marker2, objectreference marker3)
endfunction
globalvariable property debugflag  auto  
;This file was cleaned with PapyrusSourceHeadliner 1