scriptname cwcatapultweaponfirescript extends objectreference  
bool property looping auto hidden
float property waittimer auto hidden
ammo property catapultammo auto
weapon property catapultweap auto
event onload() 
endevent
event onunload()
endevent
auto state waiting
endstate
state fireloop
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1