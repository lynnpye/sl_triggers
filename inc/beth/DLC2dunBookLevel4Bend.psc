scriptname dlc2dunbooklevel4bend extends objectreference
int property triggertype = 0 auto
int property bendtype auto
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