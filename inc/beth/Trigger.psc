scriptname trigger extends objectreference  
objectreference property targetref auto
event onload()
endevent
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
bool function istargetintrigger()
endfunction
function settargetintrigger(bool isintrigger)
endfunction
function firetriggerevent()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1