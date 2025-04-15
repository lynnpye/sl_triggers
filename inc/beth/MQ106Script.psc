scriptname mq106script extends quest  conditional
objectreference property roommarker  auto  
location property kynesgrovelocation  auto  
location property riverwoodlocation  auto  
objectreference property dragonresurrectmarker   auto  
event onupdate()
endevent
event ongainlos(actor akviewer, objectreference aktarget)
endevent
int property roomcost = 10 auto  conditional
miscobject property gold  auto  
bool property playerinroom auto conditional
referencealias property alias_delphine  auto  
referencealias property alias_dragon  auto  
faction property mqkilldragonfaction auto
location property kynesgroveburialmoundlocation  auto  
bool property dragonhitbyshout auto conditional
mq00questscript property mq00  auto  
;This file was cleaned with PapyrusSourceHeadliner 1