scriptname magicanomalyspawnerscript extends objectreference  
actorbase property encmagicanomaly auto
explosion property explosionillusionlight01 auto
explosion property explosionillusionmassivelight01 auto
auto state waiting
event onload()
endevent
event ontriggerenter(objectreference akactionref)
endevent
event ontriggerleave(objectreference akactionref)
endevent
endstate
state opened
event onbeginstate()
endevent 
endstate
float function calculateanimationvalue(float playerdistance, float neardistance, float fardistance, float animationmin, float animationmax)
endfunction
function anomalydied()
endfunction
quest property mgr30  auto  
;This file was cleaned with PapyrusSourceHeadliner 1