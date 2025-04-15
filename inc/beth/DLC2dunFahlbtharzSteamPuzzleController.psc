scriptname dlc2dunfahlbtharzsteampuzzlecontroller extends objectreference
bool property isbusy = false auto hidden
int property startingsteamcharge = 0 auto hidden
int property currentsteamcharge auto hidden
int property sucessfulsteamcharge = 20 auto
objectreference property steamfail auto
objectreference property steamsuccess auto
objectreference property lightchain auto
objectreference[] property dlc2dunfahlbtharzresonatorarray auto
objectreference property dlc2dunfahlbtharzpuzzledoor auto
float property lightchangerate = 0.1 auto hidden
int property failuretotal = 0 auto hidden
objectreference property dlc2dunfahlbtharzpuzzlefaillinker001 auto
objectreference property dlc2dunfahlbtharzpuzzlefaillinker002 auto
objectreference property dlc2dunfahlbtharzpuzzlefaillinker003 auto
sound property objfahlbtharzfail auto
sound property objfahlbtharzsuccess auto
event onreset()
endevent
function addsteam(int steamcharge, objectreference resonator)
endfunction
function controllights(int endcharge)
endfunction
function resetresonators()
endfunction
function startsteamvent()
endfunction
function endsteamvent()
endfunction
function opendoor()
endfunction
function punishfailure()
endfunction
bool function getisbusy()
endfunction
function setisbusy(bool busystate = true)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1