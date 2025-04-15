scriptname survival_playerinfo extends quest
survival_conditionsscript property conditions auto
survival_needcold property cold auto
survival_needexhaustion property exhaustion auto
survival_needhunger property hunger auto
actor property playerref auto
formlist property survival_fasttraveldragonbornblackbooks auto
formlist property survival_oblivionareas auto
formlist property survival_oblivioncells auto
formlist property survival_oblivionlocations auto
formlist property survival_travelobjects auto
globalvariable property survival_playerlastknowndaysjailed auto
globalvariable property survival_waslastnearbytravelref auto
message property survival_oblivionareamessage auto
quest property da16 auto
referencealias property playeralias auto
function startupdating()
endfunction
function stopupdating()
endfunction
event onupdate()
endevent
function update()
endfunction
function checkfasttravel()
endfunction
function enablefasttravelifdisabled()
endfunction
function disablefasttravelifenabled()
endfunction
function storeplayerlastknowndaysjailed()
endfunction
bool function checkisinplaneofoblivion(worldspace akcurrentworldspace = none, bool abcheckdreamstride = true, bool abindreamstride = false)
endfunction
function handleisinplaneofoblivion()
endfunction
function enteroblivion()
endfunction
function exitoblivion()
endfunction
bool function playerindreamstride()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1