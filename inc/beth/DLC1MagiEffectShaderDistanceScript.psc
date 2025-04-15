scriptname dlc1magieffectshaderdistancescript extends activemagiceffect  
effectshader property effectshaderfx01 auto
float property fspellmaxrange = 2133.33 auto
float property ffullwaittime = 0.4 auto
float property feffectshaderduration = 1.5 auto
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
globalvariable property dlc1detectallactive  auto  
;This file was cleaned with PapyrusSourceHeadliner 1