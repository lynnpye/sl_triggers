scriptname defaultaliaschangeoutfit extends referencealias  
location property changeoutfitlocation  auto  
int property prereqstageopt  auto  
outfit property newoutfit  auto  
bool property bchangeonexit = true  auto  
auto state waiting
event onlocationchange(location akoldloc, location aknewloc)
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1