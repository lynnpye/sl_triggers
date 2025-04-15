scriptname dlc2dunnchardakwaterplane extends objectreference conditional
quest property dlc2dunnchardaktracking auto  ;tracking/registry quest.
float[] property waterstages auto     ;array of potential water heights.
int property startingwaterstage auto     ;which index we actually start at.
float property watertranslationspeed = 50.0 auto ;speed of water translation.
sound property qstnchardakwaterrise2dlpm auto
sound property qstnchardakwaterdrain2dlpm auto
objectreference[] property waterobjectsregistry auto ;array of dlc2dunnchardakwaterregisteredscripts.
int property mywaterstage = -1 auto hidden conditional
function oncellattach()
endfunction
function oncelldetach()
endfunction
function initializewater()
endfunction
function onupdate()
endfunction
int function getwaterstage()
endfunction
float function getwaterheight()
endfunction
function incrementwaterstage(bool shouldincrement)
endfunction
function setwaterstage(int newstage)
endfunction
function beginwaterstagetranslation()
endfunction
event ontranslationcomplete()
endevent
event onactivate(objectreference akactivator)
endevent
function startwatersfx(bool isrising)
endfunction
function stopwatersfx()
endfunction
int function registerwaterobject(objectreference obj)
endfunction
bool function unregisterwaterobject(objectreference obj)
endfunction
int function getregistryindex(objectreference obj)
endfunction
bool function performwaterupdate()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1