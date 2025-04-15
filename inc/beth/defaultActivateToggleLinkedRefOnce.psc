scriptname defaultactivatetogglelinkedrefonce extends objectreference
keyword property linkkeyword auto
bool property requireplayer = false auto
bool property requirenotplayer = false auto
bool property fade = false auto
bool property reset = true auto
event onreset()
endevent
auto state preactivation
event onactivate(objectreference triggerref)
endevent
endstate
state postactivation
endstate
state donothing
endstate
;This file was cleaned with PapyrusSourceHeadliner 1