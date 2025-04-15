scriptname trapmagicloot extends objectreference
message property disarmtrapmessage auto
message property rearmtrapmessage auto
event oninit()
endevent
auto state waiting
event onactivate (objectreference triggerref)
endevent
endstate
state disarmed
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1