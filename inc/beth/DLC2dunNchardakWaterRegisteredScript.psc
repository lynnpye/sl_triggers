scriptname dlc2dunnchardakwaterregisteredscript extends objectreference
keyword property linkcustom10 auto ;linkedref to the water plane.
int property submergeheight = 50 auto  ;amount of water in which this object must be submerged before we act on it. defaults to 100.
event oncellload()
endevent
function waterupdate(float waterz)
endfunction
event onupdate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1