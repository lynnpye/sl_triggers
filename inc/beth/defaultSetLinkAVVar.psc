scriptname defaultsetlinkavvar extends objectreference
string property sactorvariable = "variable01" auto
float property factorvariable = 1.0 auto
objectreference property onlyactor auto
bool property doonce auto
function activatenow(objectreference triggerref)
endfunction
auto state waiting
event ontriggerenter(objectreference triggerref)
endevent
endstate
state alldone
endstate
;This file was cleaned with PapyrusSourceHeadliner 1