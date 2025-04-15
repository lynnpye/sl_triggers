scriptname dlc2pillarplayerscript extends referencealias  
keyword property dlc2loctypepillar auto
topic property dlc2pillarblockingtopic auto 
faction property dlc2pillarbuilderfaction auto
event onupdate()
endevent
event onlocationchange(location akoldloc, location aknewloc)
endevent
function checklocationandregisterforupdate(location loctocheck = none)
endfunction
function findactorandsayline()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1