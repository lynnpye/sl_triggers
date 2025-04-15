scriptname dlc2apocryphabookrewardscript extends dlc2apocryphabookscript
bool property requirerewardsshowntomove = true auto
bool property showrewardsonactivation = true auto
bool property rewardsshown = false auto hidden
message property abilityprompt01 auto hidden
message property abilityprompt02 auto hidden
message property abilityprompt03 auto hidden
message property abilityremoved01 auto hidden
message property abilityremoved02 auto hidden
message property abilityremoved03 auto hidden
spell property spell01a auto hidden
spell property spell01b auto hidden
spell property spell01c auto hidden
spell property spell02a auto hidden
spell property spell02b auto hidden
spell property spell02c auto hidden
spell property spell03a auto hidden
spell property spell03b auto hidden
spell property spell03c auto hidden
perk property perk01a auto hidden
perk property perk01b auto hidden
perk property perk01c auto hidden
perk property perk02a auto hidden
perk property perk02b auto hidden
perk property perk02c auto hidden
perk property perk03a auto hidden
perk property perk03b auto hidden
perk property perk03c auto hidden
objectreference property rewardactivator01 auto hidden
objectreference property rewardactivator02 auto hidden
objectreference property rewardactivator03 auto hidden
actor property player auto hidden
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
spell property dlc2apocrypharewardspell auto
globalvariable property abilityglobal auto hidden
event oncellattach()
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
function showpowerprompt(objectreference rewardactivator)
endfunction
function setpower(objectreference rewardactivator)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1