scriptname dlc1mistformmanagerscript extends referencealias  
event oninit()
endevent
event onspellcast(form akspellcast)
endevent
event onupdategametime()
endevent
globalvariable property dlc1mistformcount  auto  
race property vampirelordrace auto
spell property dlc1mistform  auto  
message property dlc1mistformwaitmessage  auto  
message property dlc1mistformreadymessage  auto  
float property mistformcooldown  auto  
spell property currentequippedpower  auto  
int property mistformmaxuses  auto  
;This file was cleaned with PapyrusSourceHeadliner 1