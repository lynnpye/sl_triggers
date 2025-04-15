scriptname dlc2dunfahlbtharztowercomplexscript extends objectreference  
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
keyword property linkcustom04 auto
keyword property traplink auto
objectreference property dlc2dunfahlbtharzcomplextowermarkern auto
objectreference property dlc2dunfahlbtharzcomplextowermarkers auto
objectreference property dlc2dunfahlbtharzcomplextowermarkere auto
objectreference property dlc2dunfahlbtharzcomplextowermarkerw auto
bool property floor1 auto hidden
bool property floor2 auto hidden
sound property objrotatingstonepillarlpm auto
sound property objrotatingstonepillarrelease auto
int property soundinstanceid auto hidden
float property waittimer = 3.0 auto
bool property rumble = true auto
auto state waiting
event onactivate(objectreference akactivator)
endevent
endstate
state busy
endstate
function managebridges(int floornumber)
endfunction
function doeffects()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1