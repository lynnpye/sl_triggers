scriptname dlc01dundbchimemasterscript extends objectreference hidden 
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
keyword property linkcustom04 auto
keyword property linkcustom05 auto
keyword property linkcustom06 auto
keyword property linkcustom07 auto
keyword property linkcustom08 auto
keyword property linkcustom09 auto
objectreference property spider01 auto
objectreference property spider02 auto
objectreference property spider03 auto
objectreference property spider04 auto
objectreference property sphere01 auto
objectreference property sphere02 auto
objectreference property evileyes auto
objectreference property wineyes auto
objectreference property ballista01 auto
objectreference property ballista02 auto
sound property qstarkngthamzpuzzlefail auto
sound property qstarkngthamzpuzzlesuccessa auto
sound property qstarkngthamzpuzzlesuccessb auto
sound property qstarkngthamzpuzzlesuccessc auto
sound property qstarkngthamzpuzzlesuccessd auto
sound property qstarkngthamzpuzzlesuccesse auto
int property chimefailcount = 0 auto hidden
bool property doonce auto hidden
int property chimecount = 1 auto hidden
int property nextcorrectchime = 1 auto hidden
quest property dlc1ld_arkngthamz auto
scene property dlc1ld_13e_katriasuccess1 auto
scene property dlc1ld_13f_katriasuccess2 auto
scene property dlc1ld_13g_katriafail auto
globalvariable property dlc1arkgnthamzrumbleglobal auto
objectreference property puzzlehinttrigger auto
event oncellattach()
endevent
function chimehit(int akchimenumber, objectreference chimeref)
endfunction
function resetchimes(objectreference aklink)
endfunction
function setupchimes(objectreference aklink)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1