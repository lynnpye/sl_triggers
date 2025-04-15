scriptname dunansilvundscript extends quest
referencealias property femaledraugralias auto
referencealias property maledraugralias auto
referencealias property delosialias auto
objectreference property whitesoulgem auto
objectreference property redsoulgem auto
faction property ansilvunddraugrfaction auto
faction property ansilvundbanditfaction auto
faction property ansilvunddelosifaction auto
bool property soulgemplaced = false auto
bool property delosikilled = false auto
bool property questcomplete = false auto
auto state starting ;kill rats
event onupdate()
endevent
endstate
state delosihaswarnedplayer
endstate
state fightingdelosi
event onupdate()
endevent
endstate
state soulgemplaced
endstate
state delosikilled
event onbeginstate()
endevent
endstate
state questcomplete
event onbeginstate()
endevent
endstate
function delosisummon()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1