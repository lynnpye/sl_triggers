scriptname defaultactivatelinkdooncescript extends objectreference
objectreference property onlyactor auto
bool property doonce auto
function activatenow(objectreference trigref)
endfunction
auto state waiting
event ontriggerenter(objectreference actronaut)
endevent
endstate
state alldone
endstate
;This file was cleaned with PapyrusSourceHeadliner 1