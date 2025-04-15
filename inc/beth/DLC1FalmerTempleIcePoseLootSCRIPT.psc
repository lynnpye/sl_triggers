scriptname dlc1falmertempleiceposelootscript extends objectreference hidden 
int property actorlevel auto
bool property justbreak = false auto
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
keyword property linkcustom04 auto
keyword property linkcustom05 auto
keyword property linkcustom06 auto
keyword property linkcustom07 auto
keyword property linkcustom08 auto
keyword property linkcustom09 auto
keyword property linkcustom10 auto
objectreference property creaturetospawn01 auto
objectreference property creaturetospawn02 auto
objectreference property creaturetospawn03 auto
objectreference property creaturetospawn04 auto
objectreference property creaturetospawn05 auto
objectreference property creaturetospawn06 auto
objectreference property creaturetospawn07 auto
objectreference property creaturetospawn08 auto
objectreference property creaturetospawn09 auto
objectreference property creaturetospawn10 auto
actorbase property dlc1_bf_lvlfrozenfalmermelee auto
actorbase property dlc1_bf_lvlfrozenchaurus auto
actorbase property dlc1_bf_lvlfrozenfalmershaman auto
effectshader property dlc1bficeformfxs auto
event oncellattach()
endevent
event onload()
endevent
event onactivate(objectreference triggerref)
endevent
function releasetohavok()
endfunction
function trytospawnactors()
endfunction
function spawnactor(objectreference aklink, objectreference creaturetospawn)
endfunction
function trytosetupactors()
endfunction
function setupactor(objectreference aklink)
endfunction
function pluginactor(objectreference akreference)
endfunction
function trytodoublecheckactors()
endfunction
function doublecheckactors(objectreference creaturetospawn, objectreference aklink)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1