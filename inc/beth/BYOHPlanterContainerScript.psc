scriptname byohplantercontainerscript extends objectreference  
formlist property flplanterplantableitem auto ;formlist of plantable items
formlist property flplanterplantedflora auto ;formlist of planted flora
form property planteditem auto hidden
form property planteditemref auto hidden
form property plantedflorabase auto hidden
objectreference property plantedfloraref auto hidden
objectreference property mysoilref auto hidden
int property planteditemindex auto hidden
message property planternotplantablemessage auto
message property planteronlyoneitemmessage auto
message property planterpreviousitemremovedmessage auto
bool property containerproccessed = false auto hidden
globalvariable property gamedayspassed auto
float property growdays = 1.0 auto
float property resetdays = 3.0 auto
event onitemremoved(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference akdestcontainer)
endevent
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
event onclose(objectreference akactionref)
endevent
function setplanteditem()
endfunction
event oncellattach()
endevent
function growplanteditem()
endfunction
message property planteritemplantedmessage  auto  
;This file was cleaned with PapyrusSourceHeadliner 1