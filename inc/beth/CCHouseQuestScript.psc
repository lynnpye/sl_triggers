scriptname cchousequestscript extends quest conditional
objectreference[] property cchousemarkers auto hidden
int property cchouseminid = 101 autoreadonly hidden
int property cchousemaxid = 120 autoreadonly hidden
event oninit()
endevent
function sethousedata(int houseid, objectreference housecentermarker, location houseinteriorlocation, location houseexteriorlocation = none)
endfunction
function sethouseowned(int houseid, bool isowned = true)
endfunction
function updateanyhouseownedstatus()
endfunction
function sethaschildbedroom(int houseid, bool haschildbedroom = true)
endfunction
function updatehousechildbedroomstatus()
endfunction
int function validatecchousemovedestination(int destination, int secondary)
endfunction
objectreference function translatecchouseinttoobj(int newhouse)
endfunction
location function translatecchouseinttoexteriorloc(int newhouse)
endfunction
location function translatecchouseinttointeriorloc(int newhouse)
endfunction
int function translatecchouseexteriorloctoint(location newloc)
endfunction
bool function iscchousedestination(int adestination)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1