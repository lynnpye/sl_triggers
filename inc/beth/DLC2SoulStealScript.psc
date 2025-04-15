scriptname dlc2soulstealscript extends quest conditional
referencealias property player auto
referencealias property miraak auto
referencealias property dragon auto
scene property dlc2soulstealscene auto
message property dlc2soulstealmsg auto
mqkilldragonscript property mqkilldragon auto
quest property dlc2mq02 auto
quest property dlc2mq06 auto
mqgreybeardabsorbscript property mq105 auto
bool property testmiraak auto ;if true, then shouldmiraakappear() always returns true
globalvariable property dlc2soulstealcount auto  ;if miraak steals soul this goes up one, goes back down if player takes it back
wordofpower property dlc2bendtowillword1 auto
quest property dlc2mq01 auto
quest property mq104 auto
faction property mqnodragonabsorb auto
visualeffect property fxgreybeardabsorbeffect auto
effectshader property greybeardpowerabsorbfxs auto
effectshader property greybeardplayerpowerabsorbfxs auto
sound property npcdragondeathsequencewind auto
sound property npcdragondeathsequenceexplosion auto
event onupdate()
endevent
function starttimer()
endfunction
function endtimer()
endfunction
bool function trymiraakmakehisintroduction(actor dragonref)
endfunction
bool function shouldmiraakappear(actor dragonref)
endfunction
function miraakappears(objectreference dragonref)
endfunction
function delayedmiraakappears()
endfunction
function miraakdisappears()
endfunction
function stealsoul()
endfunction
function finishstealingsoul()
endfunction
function playerattackedmiraak()
endfunction
function playertakessoulback()
endfunction
function moddlc2soulstealcount(int amounttomod)
endfunction
function miraakdetached()
endfunction
function absorbsoulfrommiraak(actor target)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1