scriptname fxshadowmereemergescript extends objectreference  
actor property myshadowmereref auto
weather property weatherform auto
objectreference property shadowmerepoolmistwhite auto
objectreference property shadowmerepoolmistblack auto
objectreference property shadowmerelightref auto
armor property horsesaddleshadowmere auto
event onload() ;once the fxshadowmereemerge activator is emnabled this load block should run and set the stage for shadomeres arrival
endevent
event onactivate(objectreference akactionref); when the player is in the sweet spot trigger the fade it sequence by activating fxshadowmereemer
endevent
event onunload() 
endevent
;This file was cleaned with PapyrusSourceHeadliner 1