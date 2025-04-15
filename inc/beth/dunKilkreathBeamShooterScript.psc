scriptname dunkilkreathbeamshooterscript extends objectreference  
quest property myquest auto
int property startstage auto
objectreference property beamtarget auto
objectreference property nexttoactivate auto
objectreference property door01 auto
objectreference property door02 auto
objectreference property loaddoor auto
objectreference property triggerref auto
int property translatespeed = 100 auto
spell property beam auto 
float property waittimebeam auto
float property waittimedoor auto
float property waittimenextbeam = 1.0 auto
bool property flip = false auto 
bool property starton = false auto
bool property istriggered = false auto hidden
event onload()
endevent
event oncellload()
endevent
event onactivate(objectreference akactionref)
endevent
float function getfacingtotargetz(objectreference targetref, bool invertfacing = false)
endfunction
function firebeam()
endfunction       
function unlockopendoor(objectreference doorref)
endfunction
function unlockdoor(objectreference doorref)
endfunction
function aim()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1