scriptname dlc1ld_ghostscript extends actor 
scene property dlc1ld_katriakilledbyplayer auto
spell property ghostresistsability auto
spell property dlc1ld_ghostability auto
bool property katriateleportingout = false auto hidden
event onload()
endevent
event onattach()
endevent
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onenterbleedout()
endevent
function katriafinale()
endfunction
function catchup(objectreference movetarget)
endfunction
function fadein()
endfunction
function fadeout()
endfunction
function fadeinnowait()
endfunction
function fadeoutnowait()
endfunction
function onupdate()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1