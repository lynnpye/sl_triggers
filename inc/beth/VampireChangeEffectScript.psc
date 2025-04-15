scriptname vampirechangeeffectscript extends activemagiceffect  
perk property vampirefeed auto
playervampirequestscript property playervampirequest auto
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
float property fdelay  auto  
imagespacemodifier property introfx  auto  
imagespacemodifier property mainfx  auto  
imagespacemodifier property outrofx  auto  
sound property introsoundfx  auto  
sound property outrosoundfx  auto  
playervampirequestscript property vampirequest  auto  
;This file was cleaned with PapyrusSourceHeadliner 1