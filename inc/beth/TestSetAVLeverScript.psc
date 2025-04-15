scriptname testsetavleverscript extends objectreference  
string property sactorvariable = "variable01" auto
float property factorvariable = 1.0 auto
float property factorvariablereset = 0.0 auto
objectreference property onlyactor auto
function activatenow(objectreference triggerref, bool bsetactorvalue = true)
endfunction
auto state normal
event onactivate(objectreference triggerref)
endevent
endstate
state actorvalueset
event onactivate(objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1