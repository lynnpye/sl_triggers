scriptname cwmissionpollforsoldiersscript extends quest
int property stagetostartpolling auto  ;stage after which we should be polling
int property stagetostoppolling auto  ;stage after which we should no longer be polling (most likely the same as stagetoset)
int property stagetosetifalldead auto  ;stage we set when polling conditions are met 
quest property cw  auto  
referencealias property additionalaliastocheck1 auto  ;in addition to dead npcs with locationreftype cwsoldier, we need to check if this soldier is dead
referencealias property additionalaliastocheck2 auto  ;in addition to dead npcs with locationreftype cwsoldier, we need to check if this soldier is dead
referencealias property additionalaliastocheck3 auto  ;in addition to dead npcs with locationreftype cwsoldier, we need to check if this soldier is dead
locationalias property locationaliastopoll auto   ;where should we be polling for soldiers
cwscript property cws auto hidden
event oninit()
endevent
auto state notpolling
event onupdate()
endevent
endstate
state polling
event onupdate()
endevent
endstate
bool function iscorrectstage()
endfunction
int function getalivecountcwsoldiers()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1