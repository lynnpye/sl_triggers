scriptname dlc2expspiderglowingscript extends actor hidden 
spell property spelltocast auto
quest property dlc2expspiderquest auto
bool property bisfriendly = false auto
bool property balreadyforcedref = false auto hidden
explosion property spidercrumbleexplosion auto
bool property balreadyloaded = false auto hidden
float property secondsalive = 0.0 auto hidden
event onload()
endevent
function countdowntodeath()
endfunction
event ondying(actor akkiller)
endevent
function spidercrumble()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1