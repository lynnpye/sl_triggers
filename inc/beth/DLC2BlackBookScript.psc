scriptname dlc2blackbookscript extends objectreference  conditional
globalvariable property dlc2booksactive auto
keyword property dlc2linkblackbookenabled auto
bool property reenablecontrols=true auto conditional
bool property disablelooking=false auto conditional
bool property bplayerhasread = false auto conditional hidden
event onread()
endevent
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
function setdungeonmarker(objectreference newmarker)
endfunction
dlc2bookdungeoncontrollerscript property dlc2bookdungeoncontroller  auto  
objectreference property dungeonmarker auto
location property dungeonlocation auto
quest property myquest  auto  
int property myqueststage  auto  
objectreference property myreference  auto  
;This file was cleaned with PapyrusSourceHeadliner 1