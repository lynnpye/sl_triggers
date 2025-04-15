scriptname dunreachwaterrockjyrikbossbattle extends referencealias
keyword property linkcustom02 auto
objectreference property position1 auto
objectreference property position2 auto
objectreference property position3 auto
objectreference property position4 auto
objectreference property position5 auto
objectreference property position6 auto
activator property summonfx auto
activator property banishfx auto
quest property dungauldursonqst auto
event onload()
endevent
function beginjyrikbattle()
endfunction
function endjyrikbattle()
endfunction
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ondying(actor killer)
endevent
function teleport()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1