scriptname dunmarkarthwizardplatesystemplate extends pressureplate
message property failmessage auto
objectreference property systemmanager auto
function onenter(objectreference triggerref)
endfunction
function onleave(objectreference triggerref)
endfunction
bool function getintrigger()
endfunction
function playup()
endfunction
function playdown()
endfunction
auto state inactive
event onbeginstate()
endevent
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
state active
event onbeginstate()
endevent
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1