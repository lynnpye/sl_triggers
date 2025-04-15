scriptname defaultdwegearscript extends objectreference
bool property useoffanim = false auto
bool property off = true auto hidden
event onload()
endevent
auto state off
event onactivate(objectreference akactivator)
endevent
endstate
state on
event onactivate(objectreference akactivator)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1