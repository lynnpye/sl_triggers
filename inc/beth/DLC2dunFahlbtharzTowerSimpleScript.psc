scriptname dlc2dunfahlbtharztowersimplescript extends objectreference  
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
sound property objrotatingstonepillarlpm auto
sound property objrotatingstonepillarrelease auto
int property soundinstanceid auto hidden
float property waittimer = 3.0 auto
bool property rumble = true auto
auto state closed
event onactivate(objectreference akactivator)
endevent
endstate
state busy
endstate
state open
event onactivate(objectreference akactivator)
endevent
endstate
function doeffects()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1