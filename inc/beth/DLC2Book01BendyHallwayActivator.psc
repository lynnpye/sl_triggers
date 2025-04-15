scriptname dlc2book01bendyhallwayactivator extends objectreference
int property triggertype = 0 auto
int property bendtype auto
bool property doonlyonce = true auto
bool property revertbendonsecondactivate = false auto
bool property secondbend = false auto hidden
int property activationsneeded = 1 auto
int property currentactivations = 0 auto hidden
bool property playeronly = false auto hidden
bool property triggering = false auto hidden
function mybend()
endfunction
auto state waiting
event ontriggerenter(objectreference triggerref)
endevent
event onactivate(objectreference activateref)
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1