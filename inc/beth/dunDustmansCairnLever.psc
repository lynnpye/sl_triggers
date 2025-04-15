scriptname dundustmanscairnlever extends objectreference
message property cannotbeactivatedmessage auto
objectreference property mycollbox auto
objectreference property dundustmanscairntrapsceneprimmarker auto
objectreference property mycollbox2 auto
objectreference property dundustmanscairntrapsceneprim2marker auto
objectreference property dundustmanscairnlevercollmarker auto
objectreference property c01companiontriggerbox auto
bool property secondlever auto
scene property ambushscene auto
quest property c01 auto
referencealias property observer auto
cell property mycell auto
quest property dlc1playervampirequest auto
bool property triggerlock = false auto
auto state pulledposition
event onactivate (objectreference triggerref)
endevent
endstate
state done
event onbeginstate()
endevent
event onactivate(objectreference akactivator)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
event oncellload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1