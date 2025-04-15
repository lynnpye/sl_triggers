scriptname byohplantersoilscript extends objectreference  
objectreference property plantercontainer auto hidden
objectreference property objself auto hidden
bool property alreadyloaded = false auto hidden
int property clearplanterchoice auto hidden
message property planterclearmessage auto
event oncellattach()
endevent
auto state empty
event onactivate(objectreference triggerref)
endevent 
endstate
state planted
event onactivate(objectreference triggerref)
endevent 
endstate
formlist property flplanterplantableitem auto
;This file was cleaned with PapyrusSourceHeadliner 1