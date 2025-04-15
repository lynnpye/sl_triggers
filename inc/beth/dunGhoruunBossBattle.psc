scriptname dunghoruunbossbattle extends actor
spell property selfinvisible auto
quest property myquest auto
int property stage auto
package property dunghoruunrunpackage  auto  
objectreference property player auto
event onload()
endevent
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function bossinvisible()
endfunction
function bossrun()
endfunction 
;This file was cleaned with PapyrusSourceHeadliner 1