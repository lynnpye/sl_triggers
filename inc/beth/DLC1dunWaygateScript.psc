scriptname dlc1dunwaygatescript extends objectreference
bool property bisready = false auto
bool property bmovemapmarker = false auto
objectreference property myloopingsound auto
bool property bloopingsoundenabled = false auto
bool property waiting = false auto
auto state waiting
event onactivate(objectreference akactionref)
endevent
endstate
state ready
event onactivate(objectreference akactionref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1