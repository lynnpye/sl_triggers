scriptname defaultplayeffectonactivate extends objectreference
string property anim01 = "playanim01" auto
string property animendevent = "endanim" auto
bool property waitforendevent = false auto
auto state waiting
event onactivate(objectreference triggerref)
endevent
endstate
state donothing
endstate
;This file was cleaned with PapyrusSourceHeadliner 1