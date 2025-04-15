scriptname defaultbipressureplate extends traptriggerbase
float property targetdelay auto
event onload()
endevent
auto state up
event onbeginstate()
endevent
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
state down
event onbeginstate()
endevent
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1