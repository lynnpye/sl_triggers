scriptname dlc2trapapotentacle extends movingtrap
float property initialdelay = 0.25 auto
bool property selftrigger = true auto
string property startdamage = "startdamage" auto hidden
string property stopdamage = "stopdamage" auto hidden
function firetrap()
endfunction
function resetlimiter()
endfunction
auto state idle
event onactivate (objectreference activateref)
endevent
event ontriggerenter(objectreference triggerref)
endevent
endstate
state doonce               ;type do once
event onactivate( objectreference activateref )
endevent
endstate
state reset
event onbeginstate()
endevent
event onactivate( objectreference activateref )
endevent
endstate
state on
event onactivate (objectreference activateref)
endevent
endstate
state hold   ;hold overrides all other states ***this is kind of a depricated state ***
event onactivate (objectreference activateref)
endevent
endstate
state disarmed
endstate
faction property owningfaction auto
actorbase property owningactorbase auto
bool property playeronlytrigger = false auto
bool property checkforlightfootperk = false auto
bool property checkforlighthandsperk = false auto
perk property lightfootperk auto
globalvariable property lightfootglobalvar auto
perk property lighthandsperk auto
globalvariable property lighthandsglobalvar auto
bool function acceptabletrigger(objectreference triggerref)
endfunction
bool function checkperks(objectreference triggerref)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1