scriptname fxdragonmoundscript extends objectreference  
activator property fxdragonmoundprefx  auto   
explosion property dragonmounddirtexplosion  auto  
explosion property dragonmoundfakeexplosion  auto  
explosion property dragonmoundfakeexplosionheavy  auto  
actor property dragonref auto
armor property dragonunderskin  auto   
effectshader property dragonresdirtfxs auto
effectshader property dragonholesresfxs auto
effectshader property dragonholesresbitsfxs auto
visualeffect property dragonresstreakseffects auto
quest property myquest  auto  
sound property npcdragonskeletalresurrectionrumble auto
int property isdragonhome auto 
objectreference property mydirtcap auto
int property donestage auto
weather property weatherform auto
quest property mq106  auto  
auto  state load
endstate
event oncellload()
endevent
event onunload()
endevent
state waiting
event onactivate(objectreference akactionref)
endevent
endstate ; waiting
state nodragon
endstate
state inprogress
endstate
function startresurrection()
endfunction
function abortresurrection()
endfunction
function changestate(int inewstate)
endfunction
event onupdate()
endevent
location property noweatherreleaselocation  auto  
;This file was cleaned with PapyrusSourceHeadliner 1