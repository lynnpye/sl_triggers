scriptname dlc1randomlightningstriketrigscript extends objectreference 
float property waitforcastmax = 10.0 auto
float property waitforcastmin = 8.0 auto
spell property lightningspell auto
bool property isconcentratedspell = false auto
float property timebeforeinterruptingconcentratedspell = 0.2 auto
sound property distantimpactsound auto
sound property closeimpactsound auto
sound property prestrikesound auto
float property prestrikedelay = 1.0 auto
bool property forcequiet = false auto
event oncellattach()
endevent
function handlelightning()
endfunction
function castlightingbolts()
endfunction
event oncelldetach()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1