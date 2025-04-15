scriptname dlc2mqbosstentaclecontroller extends objectreference
objectreference property dlc2mqbosstentaclechainstart001 auto
objectreference property dlc2mqbosstentaclechainstart002 auto
objectreference property dlc2mqbosstentaclechainstart003 auto
objectreference property dlc2mqbosstentaclechainstart004 auto
objectreference property dlc2mqbosstentaclechainstart005 auto
objectreference property dlc2mqbosstentaclechainstart006 auto
objectreference property dlc2mqbosstentaclechainstartcenter auto
objectreference property dlc2mqbosstentaclechainend001 auto
objectreference property dlc2mqbosstentaclechainend002 auto
objectreference property dlc2mqbosstentaclechainend003 auto
objectreference property dlc2mqbosstentaclechainend004 auto
objectreference property dlc2mqbosstentaclechainend005 auto
objectreference property dlc2mqbosstentaclechainend006 auto
objectreference property dlc2mqbosstentaclechainendcenter auto
bool property fullsweep auto hidden
int property targetarea = 0 auto hidden
bool property clockwise = false auto hidden
float property attacktimer = 0.5 auto hidden
auto state waiting
event onupdate()
endevent
endstate
state busy
event onupdate()
endevent
endstate
function attackwithfullsweep()
endfunction
function attacktargetarea()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1