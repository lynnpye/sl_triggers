scriptname dlc1eclipseattackscript extends quest  
dlc1radiantscript property dlc1radiant  auto  
referencealias[] property spawnpointaliases auto
referencealias[] property attackeraliases auto
globalvariable property gamedayspassed auto
globalvariable property dlc1eclipseattacknextwait auto  ;next allowed is today + this
globalvariable property dlc1eclipseattacknextallowed auto ;today + nextwait
globalvariable property dlc1eclipseattacknextchanceeclipse auto ;starts at 100, then drops to 25
globalvariable property dlc1eclipseattacknextchancenight auto ;starts at 100, then drops to 5
globalvariable property dlc1eclipseattacknextgauranteed auto ;next time we should make sure this happens - today + nextmaxwait
globalvariable property dlc1eclipseattacknextmaxwait auto ;today + this
globalvariable property dlc1eclipseactive auto
quest property dlc1vq01miscobjective auto
globalvariable property dlc1eclipseattackguardhellos  auto  
function moveandenableattackerstofathestspawnpointalias()
endfunction
objectreference function getfarthestaliasfromplayer()
endfunction
function movealiasestoref(objectreference reftomoveto)
endfunction
function setcontrollingglobals()
endfunction
function setnextallowed()
endfunction
function setnextchance()
endfunction
function setnextgauranteed()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1