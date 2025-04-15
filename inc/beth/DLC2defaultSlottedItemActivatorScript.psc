scriptname dlc2defaultslotteditemactivatorscript extends objectreference  
bool property ison = false auto conditional
bool property itemisnotremovable = false auto
bool property playeronly = false auto
bool property silencecontainermessage auto
bool property doonce = false auto
bool property doesnotremoveitem = false auto
bool property isanimating = false auto hidden
string property onanim = "on" auto
string property offanim = "off" auto
string property startonanim = "starton" auto
string property doneevent = "done" auto
message property itemneededmessage auto
message property busymessage auto
miscobject property requireditem auto
int property mystate = 1 auto hidden
float property waittime = 0.0 auto
bool property noitemrequired = false auto
event onload()
endevent
event onreset()
endevent
auto state off ; waiting to be activated
event onactivate (objectreference akactivator)
endevent
endstate
state busy
event onactivate(objectreference akactivator)
endevent
endstate
state on
event onactivate (objectreference akactivator)
endevent
endstate
state done
event onload()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1