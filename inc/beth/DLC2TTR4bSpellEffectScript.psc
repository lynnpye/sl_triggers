scriptname dlc2ttr4bspelleffectscript extends activemagiceffect  
float property delay  auto  
quest property dlc2ttr4b  auto  
imagespacemodifier property fadeimod  auto  
globalvariable property dlc2nelothspellexpire  auto  
event oneffectstart(actor aktarget, actor akcaster)
endevent
event onupdate()
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
imagespacemodifier property fadetoblacktransition  auto  
imagespacemodifier property fadetonormal  auto  
;This file was cleaned with PapyrusSourceHeadliner 1