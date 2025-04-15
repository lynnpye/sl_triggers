scriptname dlc2book01puzzlebookholder extends objectreference
quest property dlc2book01puzzleqst auto
dlc2book01puzzlequestscript property questscript auto hidden
int property booknumber = 1 auto
globalvariable property dlc2book01takenbookinparta auto
bool property islastbook = false auto
auto state waiting
event onactivate(objectreference akactivator)
endevent
endstate
state done
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1