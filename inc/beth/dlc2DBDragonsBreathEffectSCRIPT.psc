scriptname dlc2dbdragonsbreatheffectscript extends activemagiceffect  
armor property dragonarms auto
effectshader property dragonarmsfx auto
actorbase property specdragon auto
explosion property dragonexplosion auto
bool property bspawndragons auto
event oneffectstart(actor target, actor caster)
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
function spawndragons()
endfunction
function despawndragons()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1