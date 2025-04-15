scriptname magicnighteyescript extends activemagiceffect
float property fdelay = 0.83 auto
imagespacemodifier property introfx auto
imagespacemodifier property mainfx auto
imagespacemodifier property outrofx auto
float property fimodstrength = 1.0 auto
sound property introsoundfx auto ; create a sound property we'll point to in the editor
sound property outrosoundfx auto ; create a sound property we'll point to in the editor
globalvariable property nighteyetransitionglobal auto
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1