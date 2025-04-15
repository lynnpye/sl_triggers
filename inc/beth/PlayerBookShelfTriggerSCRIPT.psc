scriptname playerbookshelftriggerscript extends objectreference  
objectreference property shelfcontainer auto hidden
bool property alreadyloaded = false auto hidden
event oncellload()
endevent
auto state waitforbooks
event onbeginstate()
endevent
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
state ignorebooks
event onbeginstate()
endevent
endstate
int property testint  auto  
;This file was cleaned with PapyrusSourceHeadliner 1