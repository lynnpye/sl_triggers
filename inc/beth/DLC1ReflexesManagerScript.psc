scriptname dlc1reflexesmanagerscript extends referencealias  
event oninit()
endevent
event onspellcast(form akspellcast)
endevent
event onupdategametime()
endevent
globalvariable property dlc1reflexescount  auto  
race property vampirelordrace auto
spell property dlc1supernaturalreflexes  auto  
message property dlc1reflexeswaitmessage  auto  
message property dlc1reflexesreadymessage  auto  
float property reflexescooldown  auto  
spell property currentequippedpower  auto  
int property reflexesmaxuses  auto  
;This file was cleaned with PapyrusSourceHeadliner 1