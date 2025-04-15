scriptname dlc1_2stateactivatorwithglobal extends objectreference conditional
string property openanim = "open" auto
string property closeanim = "close" auto
string property openevent = "opening" auto
string property closeevent = "closing" auto
string property startopenanim = "opened" auto
bool property ballowinterrupt = false auto
bool property zinvertcollision = false auto
bool property busy auto hidden
keyword property twostatecollisionkeyword auto
globalvariable property myglobalvar auto
bool property isopen
function set(bool newopenstate)
endfunction 
bool function get() 
endfunction 
endproperty
event onload()
endevent 
event onactivate(objectreference triggerref)
endevent
function setopen(bool abopen = true)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1