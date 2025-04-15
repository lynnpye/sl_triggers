scriptname dunshroudhearthcloseanddisablerefs extends objectreference
objectreference property door1a auto
objectreference property door2a auto
objectreference property door1b auto
objectreference property door2b auto
function closeanddisable(objectreference doorx, objectreference doory)
endfunction 
auto state preactivation
event onactivate(objectreference triggerref)
endevent
endstate
state postactivation
endstate
;This file was cleaned with PapyrusSourceHeadliner 1