scriptname shaderparticlegeometryscript extends activemagiceffect
shaderparticlegeometry property psgd auto
float property fadeintime = 1.0 auto
float property fadeouttime = 1.0 auto
bool property busedistancecheck = false auto
float property fdistncecheck = 1000.0 auto
objectreference property distancecheckerref auto
activator property activatorref auto
event oninit()
endevent
event oneffectstart(actor target, actor caster)
endevent
event onupdate()
endevent
event oneffectfinish(actor target, actor caster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1