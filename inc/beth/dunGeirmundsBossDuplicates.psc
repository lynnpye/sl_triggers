scriptname dungeirmundsbossduplicates extends actor
effectshader property shader auto
effectshader property illusionfx auto
event onload()
endevent
event ondying(actor akkiller)
endevent
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function dismissduplicate()
endfunction
function finishduplication()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1