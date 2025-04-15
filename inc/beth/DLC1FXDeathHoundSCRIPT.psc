scriptname dlc1fxdeathhoundscript extends activemagiceffect
visualeffect property fxdeathhoundeffect auto
effectshader property deathhounddeathfxshader auto
event oneffectstart(actor target, actor caster) 
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
event ondeath(actor mykiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1