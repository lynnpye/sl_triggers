scriptname dlc2dunkarstaagsummonscript extends actor
referencealias property conjuredkarstaag auto
spell property dlc2dunkarstaagfrostcloak auto
spell property dlc2dunkarstaagblizzard auto
spell property dlc2dunkarstaagconjureicewraith auto
scene property dlc2dunkarstaagqst_blizzard auto
scene property dlc2dunkarstaagqst_icewraiths auto
actor property icewraith01 auto
actor property icewraith02 auto
event onload()
endevent
event onupdate()
endevent
event onanimationevent(objectreference source, string eventname)
endevent
function requesticewraithsummon()
endfunction
function summonicewraiths()
endfunction
function recordicewraith(actor newicewraith)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1