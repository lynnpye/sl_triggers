scriptname volskyggepuzzleholder01 extends objectreference
bool property holdersolved auto hidden
miscobject property puzzlepiece auto
static property puzzlepiecestatic auto
objectreference property puzzleholderlight auto
objectreference property puzzleholder auto
message property holdermessage auto
quest property dunvolskyggeqst auto
event onload()
endevent
auto state holderempty
event onactivate (objectreference triggerref)
endevent
endstate
state done
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1