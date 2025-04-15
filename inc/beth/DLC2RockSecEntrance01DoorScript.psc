scriptname dlc2rocksecentrance01doorscript extends objectreference
bool property doonce = false auto
auto state waiting
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1