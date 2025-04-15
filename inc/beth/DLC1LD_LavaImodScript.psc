scriptname dlc1ld_lavaimodscript extends activemagiceffect
bool property bplayeronly = false auto
float property fdelay = 0.83 auto
imagespacemodifier property introfx auto
imagespacemodifier property loopfx auto
imagespacemodifier property outrofx auto
float property fimodstrength = 1.0 auto
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1