scriptname defaultenablelinkedrefonlostlos extends objectreference  
bool property benableonlostlos = true  auto  
objectreference property mylooktarget auto
keyword property linkedrefkeyword  auto  
event onlostlos(actor akviewer, objectreference aktarget)
endevent
auto state waiting
event ontriggerenter(objectreference triggerref)
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1