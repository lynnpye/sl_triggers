scriptname craftingactivatelinker extends objectreference
weapon property requiredweapon01 auto  
message property failuremessage auto  
bool property requirestool = false auto
objectreference property objself auto hidden
achievementsscript property achievementsquest auto
event onload()
endevent
event onactivate(objectreference akactivator)
endevent
bool function playerhastools()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1