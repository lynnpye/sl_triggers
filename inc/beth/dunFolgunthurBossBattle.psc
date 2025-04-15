scriptname dunfolgunthurbossbattle extends dunprogressivecombatscriptrefalias
faction property mikrulfaction auto
faction property thrallfaction auto
faction property playerfaction auto
referencealias property ally1alias auto
referencealias property ally2alias auto
referencealias property ally3alias auto
referencealias property mikrul auto
float property timeforspellcasting auto hidden
event onactivate(objectreference obj)
endevent
event onunload()
endevent
function updateloop()
endfunction
function runupdate()
endfunction
function findlivingaliases()
endfunction
function updatequestaliases()
endfunction
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1