scriptname dlc2mq05hermaeusmorafxscript extends objectreference  
objectreference[] property myhmface auto
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
function changestate(bool bhermaeusmoraappear = true, int ichangetostate = -1)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1