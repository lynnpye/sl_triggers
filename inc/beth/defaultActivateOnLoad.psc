scriptname defaultactivateonload extends objectreference
keyword property linkedrefkeyword auto
bool property doonce auto
auto state preactivation
event onload()
endevent
event onactivate(objectreference obj)
endevent
endstate
state postactivation
endstate
;This file was cleaned with PapyrusSourceHeadliner 1