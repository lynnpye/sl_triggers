scriptname arenascript extends quest conditional
bool property combatongoing auto conditional
bool property rewarddue auto conditional
quest property pointerquest auto
miscobject property gold auto
faction property arenafaction auto
referencealias property pitdoor auto
bool property combatpreset auto
bool property playergottheskinny auto conditional
int property numberofplayerfights auto
int property arrestoffset auto
weapon property loanersword auto
armor property loanershield auto
faction property eastmarchcrimefaction auto
faction property selfloathing auto
faction property pacifyfaction auto
arenacombatquest property currentfight = none auto
referencealias property combatant01 auto
referencealias property combatant02 auto
referencealias property combatant03 auto
referencealias property combatant04 auto
referencealias property combatant05 auto
referencealias property combatant06 auto
referencealias property combatant07 auto
referencealias property combatant08 auto
referencealias property combatant09 auto
referencealias property combatant10 auto
referencealias property transitioncombatant auto
objectreference property gate1 auto
objectreference property gate2 auto
objectreference property gate3 auto
keyword property wave1keyword = none auto
keyword property wave2keyword = none auto
keyword property wave3keyword = none auto
keyword property wave4keyword = none auto
keyword property wave5keyword = none auto
keyword property linkeddoorkeyword = none auto
int property fightstonextlevel auto conditional
int property level0fights auto
int property level1fights auto
int property level2fights auto
int property level3fights auto
bool property wagerongoing auto conditional
int property wageramount auto
bool property playerchosethefield auto conditional
bool property playerwonwager auto conditional
bool property wagerresolutionrequired auto conditional
arenacombatquest property nextwagerfight auto
quest property arenawagerfighterquest auto
bool property nextwagerfightistoughanimals auto conditional
bool property nextwagerfightiseasyanimals auto conditional
bool property nextwagerfightispeople auto conditional ; soylent green!
bool property nextwagerfightisexotic auto conditional
quest property db03 auto
arenacombatquest property specialfightdb auto 
bool property dbfightwentawry = false auto conditional
quest property eastmarchjail auto 
arenacombatquest property specialfightjail auto
arenacombatquest property transitionfight auto ; transition between levels
arenacombatquest property fight01 auto ; skeevers
arenacombatquest property fight02 auto ; wolves
arenacombatquest property fight03 auto ; spiders
arenacombatquest property fight04 auto ; npcs at pc+2
arenacombatquest property fight05 auto ; bear
arenacombatquest property fight06 auto ; sabre cat
arenacombatquest property fight07 auto ; chaurus
arenacombatquest property fight08 auto ; troll
arenacombatquest property fight09 auto ; npcs at pc+5
arenacombatquest property fight10 auto ; giant
arenacombatquest property fight11 auto ; npcs at pc+7
arenacombatquest property fight12 auto ; ice wraith
arenacombatquest property fight13 auto ; npcs at pc+9
arenacombatquest function getfightquestfromindex(int questindex)
endfunction
int function getindexfromfightquest(arenacombatquest rquest)
endfunction
referencealias function getcombatantalias(int index)
endfunction
function setup()
endfunction
function playerjoin()
endfunction
function placebet(int amount)
endfunction
function endwagerfight()
endfunction
function resolvewager()
endfunction
function playeravoidedwager()
endfunction
function startwagerfight()
endfunction
function picknextwagerfight(arenacombatquest lastfight)
endfunction
function promote()
endfunction
function startcombat()
endfunction
arenacombatquest function picknextfight(int offset=0)
endfunction
function combatover()
endfunction
function reward()
endfunction
function registertransitioncombatant(objectreference fighter)
endfunction
keyword function getkeywordforwave(int wave)
endfunction
objectreference function getdoorforwave(int wave)
endfunction
function registerspawnpoint(objectreference spawnmarker)
endfunction
function registercombatant(objectreference fighter)
endfunction
function cleanupbodies()
endfunction
bool function _cleanupbody(referencealias combatant)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1