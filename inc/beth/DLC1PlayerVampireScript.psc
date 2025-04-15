scriptname dlc1playervampirescript extends referencealias  
event oninit()
endevent
event onraceswitchcomplete()
endevent
event onplayerloadgame()
endevent
event onspellcast(form akspellcast)
endevent
event onupdategametime()
endevent
globalvariable property dlc1batscount  auto  
race property vampirelordrace auto
spell property dlc1vampirebats  auto  
message property dlc1batswaitmessage  auto  
message property dlc1batsreadymessage  auto  
float property batscooldown  auto  
spell property currentequippedpower  auto  
int property batsoutdoormaxuses  auto  
int property batsindoormaxuses  auto  
spell property dlc1mistform  auto  
;This file was cleaned with PapyrusSourceHeadliner 1