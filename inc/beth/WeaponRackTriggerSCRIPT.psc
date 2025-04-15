scriptname weaponracktriggerscript extends objectreference hidden 
keyword property wrackactivator auto
objectreference property activatorref auto hidden
objectreference property refcurrentlyintrig auto hidden
bool property hasbeentriggered auto hidden
int property numintrig auto hidden
bool property alreadyinit auto hidden
bool property ignorearmor = false auto
event onreset()
endevent
event onload()
endevent
auto state waitingforreference
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1