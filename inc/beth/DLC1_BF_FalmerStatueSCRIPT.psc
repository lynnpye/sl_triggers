scriptname dlc1_bf_falmerstatuescript extends actor hidden
keyword property linkcustom01 auto
keyword property linkcustom02 auto
effectshader property iceformbreak01fxs auto
effectshader property iceformbreak02fxs auto
effectshader property frosticeformfxshader auto
effectshader property frosticeformfxshader02 auto
explosion property cricewraithexplosion auto
bool property alreadydied = false auto hidden
bool property onlydeathevent = false auto
dlc1_bf_wavecontrollerscript property wavecontroller auto hidden
effectshader property dlc1bficeformfxs auto
bool property doonce = false auto
bool property doonce2 = false auto
event oncellattach()
endevent
event onload()
endevent
event onactivate(objectreference akactionref)
endevent
event ondeath(actor akkiller)
endevent
function assignwavecontroller(dlc1_bf_wavecontrollerscript akwavecontroller)
endfunction
objectreference property hiddenmarker  auto  
;This file was cleaned with PapyrusSourceHeadliner 1