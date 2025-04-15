scriptname survival_heatcheck extends quest
survival_needcold property cold auto
survival_conditionsscript property conditions auto
actor property playerref auto
globalvariable property survival_coldrestoresmallamount auto
quest property survival_heatsourcelocatorquest auto
objectreference[] property lastknownheatrefs auto
function startupdating()
endfunction
function stopupdating()
endfunction
event onupdate()
endevent
event onupdategametime()
endevent
bool function isplayernearheatandstanding()
endfunction
function locateheatsources()
endfunction
function checkheat()
endfunction
function updateuiwhennearheat()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1