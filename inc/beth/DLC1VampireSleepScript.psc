scriptname dlc1vampiresleepscript extends quest  
bool property isbedcoffin auto hidden
message property dlc1vampiresleepmsg auto
spell property dlc1vampiresleeprested auto
perk property dlc1vampiresleepperk auto
function playeractivatebed(bool iscoffin = false)
endfunction
event onsleepstop(bool abinterrupted)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1