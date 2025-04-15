scriptname defaultadditemscript extends actor  
form property itemtoadd auto hidden
int property count = 1 auto
bool property parentunique = true auto hidden
bool property shouldequip = false auto
bool property forceequip = false auto
event onload()
endevent
event onreset()
endevent
function additemifneeded()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1