scriptname dlc2standingstonescript extends objectreference  
projectile property dlc2voicepushprojectile01  auto  
projectile property dlc2voicepushprojectile03  auto  
spell property dlc2spelllearned  auto  
bool property freed auto hidden
auto state waiting
event onactivate(objectreference akactionref)
endevent
endstate
state busy
endstate
function workonpillarnpc(actor pillarnpc)
endfunction
function workonpillar(bool bsleepmove = true)
endfunction
imagespacemodifier property fadetoblackimod  auto  
imagespacemodifier property fadetoblackholdimod  auto  
imagespacemodifier property fadetoblackbackimod  auto  
topic property dlc2pillarblockingtopic  auto  
scene property dlc2pillarmiraakvoice  auto  
quest property dlc2pillar  auto  
globalvariable property gamedayspassed  auto  
message property dlc2standingstonenotreadymsg  auto  
scene property dlc2pillarfollowerscene  auto  
referencealias property followeratpillar auto
sound property magstandingstoneactivatea  auto  
sound property magstandingstoneactivateb  auto  
spell property dlc2sacredstonespell  auto  
sound property dlc2stoneactivatesound  auto  
;This file was cleaned with PapyrusSourceHeadliner 1