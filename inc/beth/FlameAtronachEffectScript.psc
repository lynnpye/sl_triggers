scriptname flameatronacheffectscript extends activemagiceffect  
visualeffect property atronachflametrail auto
armor property atronachflamedeadskin  auto  
effectshader property atronachflamedeathfxs auto
effectshader property atronachunsummondeathfxs auto
explosion property atronachflamedeathexplosion auto
event oneffectstart(actor target, actor caster) 
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
event ondying(actor mykiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1