scriptname magiceffectshaderapply extends activemagiceffect
effectshader property effectshaderfx auto
effectshader property effectshaderfx02 auto
effectshader property effectshaderfx03 auto
float property fduration = 0.1 auto
float property fdelay = 0.0 auto
bool property bremove = false auto
bool property buseduration = false auto
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1