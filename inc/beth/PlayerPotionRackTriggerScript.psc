scriptname playerpotionracktriggerscript extends objectreference   
objectreference property shelfcontainer auto hidden
bool property alreadyloaded = false auto hidden
event oncellload()
endevent
state waitforbooks
event onbeginstate()
endevent
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
auto state ignorebooks
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1