scriptname defaultenableenclinkedref extends objectreference
bool property playeronly = true auto
bool property fade = false auto
globalvariable property encounterglobal auto
event oncellload()
endevent
auto state waiting
event ontriggerenter(objectreference triggerref)
endevent
endstate
state done
event ontriggerenter(objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1