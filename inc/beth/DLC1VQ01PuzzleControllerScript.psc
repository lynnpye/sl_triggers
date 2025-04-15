scriptname dlc1vq01puzzlecontrollerscript extends objectreference  
quest property dlc1vq01 auto
objectreference property puzzlebase auto 
objectreference property coffinactivator auto
objectreference property buttonfurniture auto
objectreference property gate auto
objectreference property seranaref auto 
objectreference property brazier01 auto 
objectreference property brazier02 auto 
objectreference property brazier03 auto 
objectreference property brazier04 auto 
objectreference property brazier05 auto 
message property combatmessage auto
int property lightpoint = 1 auto hidden
sound property qstseranatombmagicambience2d auto
event oncellattach()
endevent
auto state start
event onactivate(objectreference triggerref)
endevent
endstate
state solution
event onactivate(objectreference triggerref)
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1