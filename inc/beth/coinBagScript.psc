scriptname coinbagscript extends objectreference  
miscobject property coinobj auto
int property coinmin auto
int property coinmax auto
event onload()
endevent
auto state waiting
event onactivate (objectreference triggerref)
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1