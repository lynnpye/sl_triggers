scriptname cwsiegecitydoorscript extends referencealias
int property doorblockeduntilstageduringattack auto ;50
int property doorblockeduntilstageduringdefense auto ;200
int property attackqueststagetosetonenter auto ;60
message property cwsiegedoorattackmessage auto 
message property cwsiegedoordefendmessage auto 
quest property cwattackcity auto
referencealias property cwattackcityfriendalias auto
actor property ralofref auto
actor property hadvarref auto
cwscript property cws auto
event onactivate(objectreference triggerref)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1