scriptname tg04lockeddoor extends objectreference
bool property barred = true auto hidden
bool property accessible = false auto hidden
message property barredmsg auto
message property unlockmemsg auto
sound property barredsfx auto
actor property gulumei auto
event onload()
endevent
event onactivate(objectreference activateref)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1