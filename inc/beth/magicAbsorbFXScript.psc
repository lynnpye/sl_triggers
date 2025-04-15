scriptname magicabsorbfxscript extends activemagiceffect
imagespacemodifier property trapimod auto
visualeffect property targetvfx auto
visualeffect property castervfx auto
float property fimodfadedistance = 2048.0 auto
float property feffectdurationmax = 40.0 auto
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1