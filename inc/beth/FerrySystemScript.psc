scriptname ferrysystemscript extends quest  conditional
function travel(int idestination = -1, actor pdriver)
endfunction
function clearwaitingstate()
endfunction
function playerissitting()
endfunction
event onupdate()
endevent
function skiptodestinationsimple()
endfunction
keyword property dlc1linkferryseat1 auto
keyword property dlc1linkferryseat2 auto
globalvariable property dlc1ferrycostsmall auto
globalvariable property dlc1ferrycostlarge auto
bool property bwaitforplayertosit = true auto conditional
miscobject property gold  auto  
topic property dialoguecarriagechattertopic auto
actor property currentdriver auto  ; save current driver for update loop
objectreference property solitude  auto  
objectreference property windhelm  auto  
objectreference property dawnstar  auto  
objectreference property castlevolkihar auto
int property currentdestination auto conditional
function skiptodestination()
endfunction
function disableallotherdrivers(objectreference mydriver)
endfunction
function resetalldrivers()
endfunction
function resetdriver(referencealias driveralias)
endfunction
referencealias property cartriderplayer  auto  
topic property arrivaltopic  auto  
referencealias property solitudeferryman auto
referencealias property dawnstarferryman auto
referencealias property windhelmferryman auto
globalvariable property carriageallowcwdisable  auto  
globalvariable property sittinganglelimit  auto  
idle property exitcartbegin  auto  
idle property exitcartend  auto  
idle property idlecartexitinstant  auto  
globalvariable property testcartquickexit  auto  
referencealias property playerrider  auto  
referencealias property playerrider2  auto  
imagespacemodifier property fadetoblackimod  auto  
imagespacemodifier property fadetoblackholdimod  auto  
imagespacemodifier property fadetoblackbackimod  auto  
;This file was cleaned with PapyrusSourceHeadliner 1