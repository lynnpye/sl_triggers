scriptname dunhalldirbossbattle2 extends referencealias 
referencealias property halldir auto
referencealias property halldirfire auto
referencealias property halldirfrost auto
referencealias property halldirstorm auto
bool property hassplit auto
effectshader property vfxshader auto
float property alpha auto
explosion property explosionfx auto
keyword property linkcustom02 auto
weapon property halldirsstaff auto
imagespacemodifier property trapimod auto
sound property trapsoundfx auto ; create a sound property we'll point to in the editor
visualeffect property targetvfx auto
visualeffect property castervfx auto
effectshader property casterfxs auto
effectshader property targetfxs auto
objectreference property halldirmovetopoint auto
quest property dunhalldirscairnqst auto
int property stagetosetondeath auto
function readyhalldir()
endfunction
event onactivate(objectreference obj)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function startfinalbattle()
endfunction
event ondying(actor killer)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1