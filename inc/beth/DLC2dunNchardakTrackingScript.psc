scriptname dlc2dunnchardaktrackingscript extends quest conditional
objectreference[] property cubes auto     ;references to the cube objects (5)
objectreference[] property cubecontainers auto   ;inaccessible containers we can store the cubes in when the player doesn't have them. safer than using an xmarker, etc.
objectreference[] property registry auto    ;array of objects that might be affected by the water level in nchardak.
referencealias[] property nameclearingaliases auto ;array of aliases, equal in length to the registry, we can use to clear names on activators affected by the water level.
miscobject property dlc2dunnchardakcube auto   ;base object for the cube.
location property dlc2nchardaklocation auto   ;nchardak's location.
globalvariable property dlc2dunnchardakcubecount auto ;number of cubes the player has. maintained for text replacement.
quest property dlc2mq04 auto        ;mq04 quest, which has the objectives.
int property cubesinneloth = 1 auto conditional    ;number of cubes being carried by neloth. initially two.
int property cubesinboilerpedestals = 0 auto   ;number of cubes in boiler pedestals. initially none.
int property cubesinwaterpedestals = 0 auto   ;number of cubes in water pedestals. initially one (the one neloth inserted).
int property cubesinotherpedestals = 4 auto   ;number of cubes in other types of pedestals. initially four (1 in console, 2 in workshop, 1 in aqueduct)
bool property areboilersready = false auto
objectreference property waterpedestal01 auto
objectreference property waterpedestal02 auto
objectreference property waterpedestal03 auto
objectreference property boilerpedestal01 auto
objectreference property boilerpedestal02 auto
objectreference property boilerpedestal03 auto
objectreference property boilerpedestal04 auto
message property dlc2dunnchardakcuberemovedmessagemanyleft auto
message property dlc2dunnchardakcuberemovedmessageoneleft auto
message property dlc2dunnchardakcuberemovedmessagenoneleft auto
message property dlc2dunnchardakcuberemovedmessagemanyadded auto
message property dlc2dunnchardakcuberemovedmessageoneadded auto
int function registerobject(objectreference obj)
endfunction
int function getregistryindex(objectreference obj)
endfunction
function updatepollingcounter(bool shouldincrement)
endfunction
event onupdate()
endevent
function clearname(int index, objectreference obj)
endfunction
function restorename(int index)
endfunction
function takeacube(bool displaymessage = true)
endfunction
function giveacube(bool displaymessage = true)
endfunction
function giveallnelothcubes()
endfunction
function handlecubeobjectiveevent(objectreference pedestal, bool isboilerpedestal, bool isboilerwaterpedestal, bool wasinserted, bool byneloth)
endfunction
function updatecubecounters(objectreference pedestal, bool isboilerpedestal, bool isboilerwaterpedestal, bool wasinserted, bool byneloth)
endfunction
function updateboilersready()
endfunction
function updateboilersdone(bool wasinserted, objectreference pedestal)
endfunction
function showboilerobjectives(objectreference pedestal)
endfunction
function hideboilerobjectives()
endfunction
function addobjectivetowaterpedestal()
endfunction
function removeobjectivetowaterpedestal()
endfunction
function addobjectivetoneloth()
endfunction
function removeobjectivetoneloth()
endfunction
function addobjectivetopedestal(objectreference pedestal)
endfunction
function removeobjectivetopedestal(objectreference pedestal)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1