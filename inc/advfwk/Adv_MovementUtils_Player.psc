scriptname adv_movementutils_player extends referencealias  
actor property playerref auto
int property nioverride_script_version = 6 autoreadonly
int property smoothcam_script_version = 17 autoreadonly
string property ninode_root = "npc" autoreadonly
string property racemenuhh_key = "racemenuhh.esp" autoreadonly
string property internal_key = "internal" autoreadonly
event oninit()
endevent
event onplayerloadgame()
endevent
function initialize()
endfunction
event onobjectequipped(form akbaseobject, objectreference akreference)
endevent
event onobjectunequipped(form akbaseobject, objectreference akreference)
endevent
bool function iscrawling()
endfunction
function removefix()
endfunction
function fixcamera(bool abcrawling)
endfunction
function fixheight()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1