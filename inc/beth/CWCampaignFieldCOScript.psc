scriptname cwcampaignfieldcoscript extends referencealias  
bool property atdestination  auto hidden ;used by cwsiegequickstartscript.psc to know that the fieldco arrived before moving the player to him
state traveling
event onbeginstate()
endevent
event onupdate()
endevent
endstate
function starttraveling(objectreference reftotravelto, float radius = 1000.0)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1