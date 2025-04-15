scriptname dlc2dunildariscript extends actor
armor property myarmor auto
idle property myidle auto
miscobject property myheartstone auto
perk property myperk auto
event oncellattach()
endevent
auto state waiting
event onactivate(objectreference triggerref)
endevent
event onenterbleedout()
endevent
endstate
state ripheartout
event onactivate(objectreference triggerref)
endevent
endstate
state donothing
event onactivate(objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1