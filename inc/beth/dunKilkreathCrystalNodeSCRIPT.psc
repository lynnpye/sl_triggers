scriptname dunkilkreathcrystalnodescript extends objectreference  
objectreference property nexttoactivate auto
quest property myquest auto
int property startstage auto
spell property beamspell auto 
objectreference property beamtarget auto
objectreference property door01 auto
objectreference property door02 auto
objectreference property loaddoor auto
float property waittimebeam = 1.0 auto
float property waittimedoor = 1.0 auto
float property waittimenextbeam = 1.0 auto
bool property istriggered = false auto hidden
sound property startsound  auto 
event oncellload()
endevent
event onactivate(objectreference akactionref)
endevent
function firebeam()
endfunction     
function resetbeam()
endfunction
function unlockopendoor(objectreference doorref)
endfunction
function unlockdoor(objectreference doorref)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1