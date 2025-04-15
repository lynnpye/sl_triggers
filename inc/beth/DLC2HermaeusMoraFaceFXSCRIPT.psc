scriptname dlc2hermaeusmorafacefxscript extends objectreference  
objectreference property myhmface01 auto
objectreference property myhmface02 auto
objectreference property myhmface03 auto
objectreference property myhmface04 auto
objectreference property myhmface05 auto
objectreference property myhmface06 auto
objectreference property myhmface07 auto
objectreference property myhmface08 auto
auto state waiting
endstate
state hermaeusmoraappear
event onbeginstate() ;;;this bloc makes the hermaeus mora art appear
endevent
endstate
state hermaeusmoradisappear
event onload()
endevent
event onbeginstate() ;;;this bloc makes the hermaeus mora art disappear
endevent
endstate
function changestate(bool bhermaeusmoraappear = true)
endfunction
function waitfor3d(objectreference myface)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1