scriptname dlc2dbbooklevelenabledisablescript extends objectreference hidden 
int property triggertype auto
bool property playeronly = true auto
bool property fade = false auto
bool property shoulddisable = true auto
float property delay = 0.0 auto
bool property shouldactivate = false auto
auto state waiting
event ontriggerenter(objectreference triggerref)
endevent
event onactivate(objectreference triggerref)
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1