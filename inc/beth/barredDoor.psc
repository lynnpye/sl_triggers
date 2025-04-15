scriptname barreddoor extends objectreference
bool property barred = true auto hidden
bool property busy = false auto hidden
message property barredmsg auto
message property unlockmemsg auto
sound property barredsfx auto
event oncellload()
endevent
event onactivate(objectreference actronaut)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1