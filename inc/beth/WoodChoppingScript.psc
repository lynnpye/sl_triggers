scriptname woodchoppingscript extends objectreference  
weapon property axe auto  
message property failuremessage auto  
miscobject property firewood auto  
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
function registerforevents()
endfunction
function unregisterforevents()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1