scriptname fxalduinscript extends actor 
armor property alduinunderskin auto  
explosion property alduindeathexplosion auto 
explosion property shoutalduindeathexplosion auto 
explosion property explosionshoutareaalduindeathbig auto 
effectshader property alduindeathfxs auto
effectshader property alduinholesfxs auto
effectshader property alduincracksfxs auto
effectshader property alduinfadefxs auto
spell property stormspell auto
weather property weatherform auto
visualeffect property fxalduinsoulescapeeffect auto
imagespacemodifier property alduindeathbloom auto
imagespacemodifier property magalduinfinalexplosionimod auto
explosion property havokrocksexplosion auto
explosion property havokrocksexplosionbig auto
objectreference property rockfallmarker1 auto
objectreference property rockfallmarker2 auto
objectreference property rockfallmarker3 auto
objectreference property rockfallmarkerbig1 auto
objectreference property rockfallmarkerbig2 auto
objectreference property rockfallmarkerbig3 auto
objectreference property crumblingstatue1 auto
objectreference property crumblingstatue2 auto
objectreference property crumblingstatue3 auto
objectreference property crumblingstatue4 auto
sound property qstalduindeathexplosiona auto   
sound property qstalduindeathexplosionb auto   
sound property qstalduindeathexplosionc auto   
sound property qstalduindeathsoulsa auto   
sound property qstalduindeathsoulsb auto   
auto  state waiting
event onload()
endevent
event ondying(actor akkiller)
endevent 
endstate
state earthquake
event onbeginstate()
endevent
endstate
state soulexplode
event onbeginstate()
endevent
endstate
state cleanup
event onbeginstate()
endevent
endstate
function crumblestatue()
endfunction
faction property mqkilldragonfaction  auto  
weather property sovngardeclear  auto  
;This file was cleaned with PapyrusSourceHeadliner 1