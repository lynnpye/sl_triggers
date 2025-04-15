scriptname sarcophagusskulllock01script extends objectreference  
keyword property linkcustom01 auto
objectreference property mylock auto hidden
objectreference property mypartnerslot auto hidden
objectreference property mykey01 auto
objectreference property mykey02 auto
quest property myquest auto
int property stagesetonfirstactivate auto
message property emptyslotmessage auto
int property stagesetonunlock auto
bool property alreadyloaded = false auto hidden
int property itemthatunlockedme auto hidden
bool property lastunlocked = false auto hidden
event onload()
endevent
auto state waitingforkey
event onactivate(objectreference activateref)
endevent
endstate
state unlocked
event onbeginstate()
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
endstate
state readytotake
event onactivate(objectreference activateref)
endevent
endstate
state alldone
endstate
function unlocksequence()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1