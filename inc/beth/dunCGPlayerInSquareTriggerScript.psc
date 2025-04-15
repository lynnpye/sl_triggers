scriptname duncgplayerinsquaretriggerscript extends objectreference  
quest property duncgqst auto
actor property mydragon auto
event onload()
endevent
event onupdate()
endevent
auto state waiting
event ontriggerenter (objectreference triggerref)
endevent
event ontriggerleave (objectreference triggerref)
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1