scriptname valthumecontainerpuzzlescript extends objectreference  
objectreference property controllerscript auto
miscobject property eyes auto 
miscobject property heart auto 
miscobject property brain auto
bool property containereyes auto
bool property containerheart auto
bool property containerbrain auto
message property urnmessage auto
int property button auto hidden
function returnitems()
endfunction
bool function playerplacedall ()
endfunction
function removepart(int i)
endfunction
event oninit ()
endevent
event onactivate (objectreference triggerref)
endevent  
;This file was cleaned with PapyrusSourceHeadliner 1