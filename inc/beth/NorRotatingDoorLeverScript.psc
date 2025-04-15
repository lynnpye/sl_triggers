scriptname norrotatingdoorleverscript extends objectreference
objectreference property door01 auto
objectreference property door02 auto
objectreference property door03 auto
objectreference property door04 auto
objectreference property door05 auto
sound property drsstonerotatingdisclpm auto
bool property startactive auto
event oninit()
endevent
auto state offpos
event onactivate (objectreference triggerref)
endevent
endstate
state leftpos
event onbeginstate()
endevent
event onactivate(objectreference triggerref)
endevent
event onendstate()
endevent
endstate
state rightpos
event onbeginstate()
endevent
event onactivate(objectreference triggerref)
endevent
event onendstate()
endevent
endstate
state busystate
endstate
;This file was cleaned with PapyrusSourceHeadliner 1