scriptname dunhalldirbossbattleforms extends referencealias
effectshader property vfxshader auto
effectshader property ghostshader auto
float property alpha auto
explosion property explosionfx auto
keyword property summonspotlink auto
referencealias property halldir auto
imagespacemodifier property trapimod auto
sound property trapsoundfx auto ; create a sound property we'll point to in the editor
visualeffect property targetvfx auto
visualeffect property castervfx auto
effectshader property casterfxs auto
effectshader property targetfxs auto
function movetoposition()
endfunction
function manifest()
endfunction
event ondying(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1