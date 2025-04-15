scriptname survival_mainscript extends quest
survival_needhunger property hunger auto
survival_needexhaustion property exhaustion auto
survival_needcold property cold auto
survival_playerinfo property playerinfo auto
survival_heatcheck property heatcheck auto
survival_mainquestplayeralias property updates auto
survival_dialoguedetectquestscript property dialoguedetect auto
quest property mq101 auto
globalvariable property survival_modeenabled auto
globalvariable property survival_modeenabledshared auto
globalvariable property survival_modecanbeenabled auto
globalvariable property survival_playerhasbeenprompted auto
globalvariable property survival_modetoggle auto
formlist property helpmanualpc auto
formlist property helpmanualxbox auto
message property survival_helpsurvivalmodelong auto
message property survival_helpsurvivalmodelongxbox auto
actor property playerref auto
message property survival_startprompt auto
formlist property survival_survivalafflictions auto
formlist property survival_survivaldiseases auto
spell property survival_freezingwaterdamage auto
perk property survival_templeblessingcostperk auto
perk property survival_exhuastionreduceconsumables auto
perk property survival_needsdamageattributes auto
leveleditem property litemfoodsalt auto
leveleditem property litemfoodsaltsmall auto
leveleditem property litemfoodsalt75 auto
objectreference[] property heatsourcetriggerrefs auto
objectreference property survival_heatsourcereturnref auto
event oninit()
endevent
event onupdate()
endevent
function prompttostartsurvivalmode()
endfunction
function startsurvivalmode()
endfunction
function stopsurvivalmode()
endfunction
function startsurvivalneeds()
endfunction
function stopsurvivalneeds()
endfunction
function removesurvivaldiseases()
endfunction
function removesurvivalafflictions()
endfunction
function removesurvivalspells()
endfunction
function addsurvivalperks()
endfunction
function removesurvivalperks()
endfunction
function populatesurvivalitems()
endfunction
function depopulatesurvivalitems()
endfunction
function storeheatsourcetriggervolumes()
endfunction
function restartupdatetimer()
endfunction
bool function modeshouldbeenabled()
endfunction
bool function modecanbeenabled()
endfunction
bool function modeshouldbedisabled()
endfunction
bool function modeisenabled()
endfunction
bool function modeisdisabled()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1