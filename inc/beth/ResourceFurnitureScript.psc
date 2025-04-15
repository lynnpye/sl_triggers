scriptname resourcefurniturescript extends objectreference  conditional
formlist property requireditemlist auto  
message property failuremessage auto  
miscobject property resource auto  
int property resourcecount = 1 auto
int property maxresourceperactivation = 6 auto
faction property currentfollowerfaction auto
objectreference property npcfollower auto hidden
event onload()
endevent
event onunload()
endevent
auto state normal
event onactivate(objectreference akactionref)
endevent
endstate
state busy
endstate
event onanimationevent(objectreference aksource, string aseventname)
endevent
function registerforevents(objectreference whotoregister)
endfunction
function unregisterforevents(objectreference whotounregister)
endfunction
idle property idlewoodchopexit  auto  
;This file was cleaned with PapyrusSourceHeadliner 1