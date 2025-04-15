scriptname vampirediseaseeffectscript extends activemagiceffect  
event onupdate()
endevent
event onupdategametime()
endevent
event oneffectstart(actor target, actor caster)
endevent
message property vampiresunrisemessage auto
message property vampiresunsetmessage auto
message property vampiresleepmessage auto
imagespacemodifier property absorbredimod  auto  
sound property introsoundfx  auto  
sound property outrosoundfx  auto  
message property vampirediseasemessage auto
float property vampirechangetimer auto
globalvariable property gamehour auto
globalvariable property gamedayspassed auto
perk property vampirefeed auto
playervampirequestscript property playervampirequest auto
imagespacemodifier property vampiretransformincreaseismd  auto
imagespacemodifier property vampiretransformdecreaseismd  auto 
;This file was cleaned with PapyrusSourceHeadliner 1