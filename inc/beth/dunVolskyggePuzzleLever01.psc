scriptname dunvolskyggepuzzlelever01 extends objectreference
objectreference property puzzleencounter auto
bool property puzzleencounterenabled auto hidden
bool property isonwall auto
bool property isalreadypulled auto
event oninit()
endevent
state upposition ; this is the state i'm in when up and at rest
event onactivate (objectreference triggerref)
endevent
endstate
state downposition ; this is the state i'm in when i'm down and at rest
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1