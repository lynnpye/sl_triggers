scriptname sayonhitbymagiceffectscript extends activemagiceffect  
topic property topictosay auto
event oneffectstart(actor aktarget, actor akcaster)
endevent
int property allowforteammate = 0 auto  
topic property combattopictosay  auto  
globalvariable property wicastnonhostiletimer  auto  
globalvariable property gamedayspassed  auto  
;This file was cleaned with PapyrusSourceHeadliner 1