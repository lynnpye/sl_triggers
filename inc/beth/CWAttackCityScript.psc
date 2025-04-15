scriptname cwattackcityscript extends cwmissionscript  conditional
scene property cwattackcityconfrontationscene auto
scene property cwattackcitysurrenderscene auto
scene property cwattackcityjarlbleedingoutscene auto
quest property cwsiegeobj auto
referencealias property cwsiegeobjjarl auto
int property jarlwillsurrender auto hidden conditional
int property jarlhassurrendered auto hidden conditional
locationalias property city auto
actorbase property cwsiegewhiterunimperialsoldier  auto  
actorbase property cwsiegesonssoldier auto
musictype property muscombatcivilwar  auto  
outfit property armorbalgruufsteelplatenohelmetoutfit auto
outfit property jarlclothesbalgruuf auto
cwsiegescript property cwsieges auto
weather property skyrimovercastwar  auto  
event onupdate()  ;registered in stage 9000
endevent
;This file was cleaned with PapyrusSourceHeadliner 1