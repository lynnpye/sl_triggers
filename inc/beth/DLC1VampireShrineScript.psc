scriptname dlc1vampireshrinescript extends objectreference  
globalvariable property chosenpower  auto  
message property messageprompt  auto  
event oninit()
endevent
event onactivate(objectreference akactor)
endevent
function playerisvampirelord(bool isplayervampirelord) ;called by dlc1playervampirechangescript on dlc1playervampirequest
endfunction
function playerequippeditem(int myvalue)
endfunction
function playerunequippeditem(int myvalue)
endfunction
function setchosenpower()
endfunction
spell property dlc1vampirechange  auto  
;This file was cleaned with PapyrusSourceHeadliner 1