scriptname dunfellglow_prisonerfactionmanager extends objectreference
objectreference property actor01 auto
objectreference property actor02 auto
objectreference property actor03 auto
faction property prisonerfaction auto
function setwarlocksdead()
endfunction
auto state preactivation
event onactivate(objectreference obj) 
endevent
endstate
state postactivation
endstate
;This file was cleaned with PapyrusSourceHeadliner 1