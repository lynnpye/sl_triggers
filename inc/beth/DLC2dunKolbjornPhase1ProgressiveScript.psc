scriptname dlc2dunkolbjornphase1progressivescript extends objectreference
objectreference property battlemanager auto
keyword property enemylinkkeyword auto
int property simultaneousenemies auto
bool property startsactive = false auto
float property delay = 0.0 auto
objectreference property refactivateoncomplete auto
bool property usesmallrandomdelay = true auto
bool property isactive auto
int property totalenemies auto hidden
int property currentenemylink = 0 auto
float property updatetime = 1.0 auto
bool property doonce auto hidden
bool property breakloop auto hidden
bool property busy auto hidden
event oncellattach()
endevent
event oncelldetach()
endevent
function updateloop()
endfunction
function runupdate()
endfunction
event onactivate(objectreference obj)
endevent
bool function updatebattle()
endfunction
int function countactiveenemies(objectreference manager, int linkstocount)
endfunction
function activatenextenemy()
endfunction
function activateallenemies()
endfunction
function activateandkillallenemies()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1