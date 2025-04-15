scriptname dlc2miraakaltarscript extends dlc2apocryphabookscript conditional
formlist[] property perkarray  auto  
spell property dlc2apocrypharewardspell auto
event oncellload()
endevent
auto state waiting
event onactivate(objectreference akactivator)
endevent
endstate
state busy
event onactivate(objectreference akactivator)
endevent
endstate
function openbook()
endfunction
function showrewards()
endfunction
function constellationactivated(objectreference constellation, int constellationid)
endfunction
int function countperks(int iskill, bool bclearperks = false)
endfunction
message property dlc2altarnosoulsmsg auto
message property dlc2altarnoperksinthisskillmsg auto
message property dlc2altarnotincombatmsg  auto
formlist property dlc2altarskillmessagessingular  auto  
formlist property dlc2altarskillmessagesplural  auto  
message property dlc2altarperkpointsrefundedsingular auto
message property dlc2altarperkpointsrefundedplural auto
explosion property explosionillusionmassivelight01 auto
keyword property linkcustom01 auto
;This file was cleaned with PapyrusSourceHeadliner 1