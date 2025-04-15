scriptname dlc2hmdaedraeffectscript extends activemagiceffect  
effectshader property dlc2hmdaedrafxs auto
effectshader property dlc2hmdaedradeathfxs auto
effectshader property dlc2hmdaedraunsummondeathfxs auto
explosion property dlc2hmdaedradeathexplosion auto
event oneffectstart(actor target, actor caster) 
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
event ondying(actor mykiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1