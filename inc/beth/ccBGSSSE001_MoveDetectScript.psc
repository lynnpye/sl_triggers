scriptname ccbgssse001_movedetectscript extends objectreference
ccbgssse001_fishingsystemscript property fishingsystem auto
auto state waiting
event ontriggerleave(objectreference akactionref)
endevent
endstate
state ignoring
event ontriggerleave(objectreference akactionref)
endevent
endstate
function ignoretriggerevents(bool abignore = true)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1