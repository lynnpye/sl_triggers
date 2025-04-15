scriptname activateagainafterdelay extends objectreference  
float property fdelay auto
keyword property linksisterswitch auto
objectreference property blocker auto
event onload()
endevent
auto state pulledposition
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1