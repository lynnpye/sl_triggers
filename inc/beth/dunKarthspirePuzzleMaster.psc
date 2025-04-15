scriptname dunkarthspirepuzzlemaster extends objectreference  conditional
int property pillarastate auto hidden conditional
int property pillarbstate auto hidden conditional
int property pillarcstate auto hidden conditional
bool property pillarsolved=false auto hidden conditional
objectreference property flamea auto
objectreference property flameb auto
objectreference property flamec auto
objectreference property flamed auto
bool property platetriggered=false auto hidden conditional  ; set to true when the player triggers a plate
bool property platesolved=false auto hidden conditional
int property ring1state auto hidden
int property ring2state auto hidden
int property ring3state auto hidden
int property ring4state auto hidden
bool property questdone=false auto hidden
objectreference property puzzring1 auto
objectreference property puzzring2 auto
objectreference property puzzring3 auto
objectreference property puzzring4 auto
function ringshift(int ring)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1