scriptname hallofstorieskeyholescript extends objectreference
bool property puzzlesolved auto hidden
bool property dooropened auto hidden
int property numringssolved auto hidden
message property activatewithoutobjmessage auto
objectreference property doorbase auto
objectreference property largering auto
objectreference property mediumring auto
objectreference property smallring auto
objectreference property doorfx auto
int property ringcount auto
bool property allownonplayeractivation = false auto
objectreference property refactonfailure01 auto
objectreference property refactonfailure02 auto
objectreference property refactonfailure03 auto
objectreference property refactonfailure04 auto
objectreference property refactonsuccess auto
miscobject property mymiscobject auto
quest property myquest auto
quest property altquest auto
int property myqueststagesuccess auto
int property myaltqueststagesuccess auto
objectreference property backdooractivator auto
bool property activationalwayssucceeds = false auto
function opendoor()
endfunction
function checksuccess()
endfunction
auto state mainstate
event onload()
endevent
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
state done
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1