scriptname favorquestscript extends quest conditional
referencealias property questgiver auto
globalvariable property gamedayspassed auto
globalvariable property favorspernpcperday auto
int property playerhasquestitem auto conditional
quest property favorcontrolquest auto
globalvariable property pfavortimeleft auto
bool property bdonotresetquest auto
bool property bdisplayobjective  auto  
event oninit()
endevent
event onupdate()
endevent
bool function updateobjectives()
endfunction
event onupdategametime()
endevent
function favorstartup()
endfunction
function favoraccepted()
endfunction
function favorshutdown()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1