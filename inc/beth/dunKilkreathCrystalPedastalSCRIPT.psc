scriptname dunkilkreathcrystalpedastalscript extends objectreference  
objectreference property crystal auto hidden
objectreference property nexttoactivate auto
quest property myquest auto
int property startstage auto
spell property beamspell auto 
objectreference property beamtarget auto
int property translatespeed = 15 auto
int property zdistance = 17 auto
objectreference property door01 auto
objectreference property door02 auto
objectreference property loaddoor auto
objectreference property enablemarker auto
float property waittimebeam = 1.5 auto
float property waittimedoor = 0.5 auto
float property waittimenextbeam = 0.5 auto
bool property istriggered = false auto hidden
objectreference property beamsource auto
sound property soundstart  auto
event oncellload()
endevent
event onactivate(objectreference akactionref)
endevent
function movecrystal()
endfunction
function firebeam()
endfunction     
function unlockopendoor(objectreference doorref)
endfunction
function unlockdoor(objectreference doorref)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1