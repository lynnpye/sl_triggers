scriptname dlc2apocryphabookscript extends objectreference  
quest property dlc2bookdungeoncontroller auto
quest property myquest  auto  
int property myqueststage  auto  
bool property requirequeststagetomove = false auto
keyword property linkcustom04 auto
keyword property linkcustom05 auto
keyword property linkcustom06 auto
event oninit()
endevent
auto state waiting
event onactivate(objectreference akactivator)
endevent
endstate
state busy
event onactivate(objectreference akactivator)
endevent
endstate
function disablebothactivators()
endfunction
function enabletosolstheimactivator()
endfunction
function enablebookactivator()
endfunction
function disabletosolstheimactivator()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1