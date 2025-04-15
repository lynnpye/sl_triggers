scriptname mineorefurniturescript extends objectreference  conditional
objectreference property lastactivateref auto hidden
objectreference property objself auto hidden
bool property isregisteredforevents = false auto hidden
bool property canbeactivated = true auto hidden
idle property pickaxeexit auto
bool property playerisleavingfurniture = false auto hidden
bool property playerisinfurniture = false auto hidden
faction property currentfollowerfaction auto
globalvariable property miningskillincrement auto
event onload()
endevent
event onunload()
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
auto state normal
event onbeginstate()
endevent
event onactivate(objectreference akactionref)
endevent
endstate
state busy
event onbeginstate()
endevent
event onactivate(objectreference akactionref)
endevent
endstate
state reseting
event onbeginstate()
endevent
endstate
state depleted
event onbeginstate()
endevent
event onactivate(objectreference akactionref)
endevent
endstate
function gotodepletedstate()
endfunction
function registerforevents()
endfunction
function unregisterforevents()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1