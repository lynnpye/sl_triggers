scriptname dlc2qaspawnnpclist extends objectreference  
objectreference property spawnlocation  auto  
formlist property npclist  auto  
message property npcoptions auto
event oncellattach()
endevent
auto state open
event onactivate(objectreference akactivator)
endevent
endstate
state waiting
endstate
;This file was cleaned with PapyrusSourceHeadliner 1