scriptname dlc2goldpilescript extends objectreference  
globalvariable property imperialluck auto
miscobject property gold001 auto
int property minvalue = 75 auto
int property maxvalue = 100 auto
event onload()
endevent
auto state waiting
event onactivate(objectreference akactivator)
endevent
endstate
state done
event onactivate(objectreference akactivator)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1