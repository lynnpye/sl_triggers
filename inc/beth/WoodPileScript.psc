scriptname woodpilescript extends objectreference  
miscobject property firewood auto  
int property firewoodcount = 3 auto
event onload()
endevent
auto state normal
event onactivate(objectreference akactionref)
endevent
endstate
state busy
endstate
event onanimationevent(objectreference aksource, string aseventname)
endevent
function unregisterforevents(objectreference aksource)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1