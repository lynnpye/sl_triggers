scriptname dlc1vqdragonscript extends quest  conditional
int property isummoncount  auto  conditional
referencealias property dragon  auto  
bool property bdragonsummoned auto conditional
function initializesummon(objectreference newdragon)
endfunction
function teachwordtoplayer()
endfunction
function endsummonwait()
endfunction
function dispeldragon(objectreference dragonref)
endfunction
event onupdategametime()
endevent
function trytodispeldragon(actor dragonactor)
endfunction
function dragondead()
endfunction
scene property dlc1vqdragonscene1  auto  
wordofpower[] property soultearingwords  auto  
float property fsummontime = 1.0  auto  conditional
globalvariable property dlc1durnehviirdisallowflying  auto  
;This file was cleaned with PapyrusSourceHeadliner 1