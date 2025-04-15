scriptname carryfurniturescript extends objectreference  
miscobject property carryobject auto  
int property carryobjectcount = 1 auto
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