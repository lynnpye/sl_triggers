scriptname dunfolgunthurbossbattlespell extends activemagiceffect
imagespacemodifier property trapimod auto
sound property trapsoundfx auto ; create a sound property we'll point to in the editor
visualeffect property targetvfx auto
visualeffect property castervfx auto
effectshader property casterfxs auto
effectshader property targetfxs auto
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1