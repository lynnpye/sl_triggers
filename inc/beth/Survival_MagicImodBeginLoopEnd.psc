scriptname survival_magicimodbeginloopend extends activemagiceffect
float property delay = 0.0 auto
imagespacemodifier property introfx auto
imagespacemodifier property loopfx auto
imagespacemodifier property outrofx auto
float property fimodstrength = 1.0 auto
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
bool function hasimods()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1