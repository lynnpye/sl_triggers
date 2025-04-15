scriptname atronachfrostscript extends activemagiceffect  
effectshader property atronachfrostfxs auto
effectshader property atronachunsummondeathfxs auto
explosion property deathexplosion auto
event oneffectstart(actor target, actor caster) 
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
event ondying(actor mykiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1