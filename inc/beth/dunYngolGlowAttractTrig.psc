scriptname dunyngolglowattracttrig extends objectreference
formlist property motelist auto 
auto state inactive
event ontriggerenter(objectreference actronaut)
endevent
endstate
state active
event ontriggerleave(objectreference actronaut)
endevent
endstate
function directmotesat(formlist motelist, objectreference target) global
endfunction
state junkbin
endstate
;This file was cleaned with PapyrusSourceHeadliner 1