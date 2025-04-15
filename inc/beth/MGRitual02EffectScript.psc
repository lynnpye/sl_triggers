scriptname mgritual02effectscript extends activemagiceffect  
float property fdelay auto
imagespacemodifier property introfx auto
imagespacemodifier property mainfx auto
imagespacemodifier property outrofx auto
sound property introsoundfx auto ; create a sound property we'll point to in the editor
sound property outrosoundfx auto ; create a sound property we'll point to in the editor
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
quest property ritualquest  auto  
referencealias property book01  auto  
referencealias property book02  auto  
referencealias property book03  auto  
referencealias property book04  auto  
;This file was cleaned with PapyrusSourceHeadliner 1