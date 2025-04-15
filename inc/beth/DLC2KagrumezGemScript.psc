scriptname dlc2kagrumezgemscript extends objectreference  
miscobject property kagrumezgem01 auto
message property lackitemmessage auto 
message property combatmessage auto 
objectreference property consolemaster auto
bool property isbusy = false auto hidden
bool property hasgem = false auto hidden
int property gemposition auto
int property playergemcount auto hidden
globalvariable property gemplacedcount auto 
auto state default
event onbeginstate()
endevent
event onactivate(objectreference actronaut)
endevent
endstate
state fightstate
event onbeginstate()
endevent
event onactivate(objectreference actronaut)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1