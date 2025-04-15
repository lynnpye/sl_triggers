scriptname resourceobjectscript extends objectreference  conditional
cwscript property cws auto
keyword property wisabotagestart auto
message property sabotagemessage auto
message property sabotagereadymessage auto
message property repairmessage auto
int property resourcetype auto ;1 = wheat mill(farm), 2 = saw mill, 3 = smelter(mine)
message property busymessage auto
message property readymessage auto
objectreference property worker  auto  
int property resourcestate  auto hidden conditional  ;values determined by needs of children scripts - usually used as variables on actor's packages to get them to interact with various levers, etc.
bool property sabotaged auto hidden
bool property readyforsabotage auto hidden
int property destroyed = -1 auto hidden
int property waiting = 0 auto hidden
int property busy = 1 auto hidden
int property ready = 2 auto hidden
string property strdestroyed = "destroyed" auto hidden
string property strwaiting = "waiting" auto hidden
string property strbusy = "busy" auto hidden
string property strready = "ready" auto hidden
auto state waiting
endstate
state ready
endstate
state destroyed
endstate
state busy
endstate
function changestate(int newstate)
endfunction
event onactivate ( objectreference triggerref )
endevent
state ready
event onactivate ( objectreference triggerref )
endevent
endstate
state busy
event onactivate ( objectreference triggerref )
endevent
endstate
event onanimationevent(objectreference aksource, string aseventname)
endevent
function trytosabotage(objectreference triggerref)
endfunction
int function getresourcetype()
endfunction
bool function issabotaged()
endfunction
bool function promptplayersabotage()
endfunction
bool function promptplayerrepair()
endfunction
function sabotage()
endfunction
function repair()
endfunction
function work()
endfunction
function processanimationevent(string aseventname)
endfunction 
function destroyresource()
endfunction
function repairresource()
endfunction
function workresource()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1