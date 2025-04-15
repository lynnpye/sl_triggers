scriptname dlc1vq04bloodbowlfurniturescript extends objectreference
quest property dlc1vq04 auto
int property stage = 90 auto
objectreference property dlc1seranaref auto
float property rumbleamount1 = 0.5 auto
float property rumbleduration = 7.0 auto
float property camerashakeamount1 = 0.8 auto
auto state waiting
event onactivate(objectreference activateref)
endevent
endstate
state busy
endstate
state done
event onbeginstate()
endevent
endstate
event onanimationevent(objectreference aksource, string aseventname)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1