scriptname dunvaltheimsetstageonunload extends objectreference
quest property dunvaltheimkeepqst auto
int property stagetoset = 100 auto
auto state waiting
event oncelldetach()
endevent
endstate
state inactive
event onreset()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1