scriptname ccbgssse001_miscsol_dinnerguestscript extends referencealias  
int property stagetowatch auto
int property stagetosetonsit auto
quest property myquest auto
referencealias property mydiningchair auto
auto state waiting
event onsit(objectreference akfurniture)
endevent
endstate
state done
event onsit(objectreference akfurniture)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1