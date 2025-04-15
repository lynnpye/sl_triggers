scriptname cwmapactivatorscript extends objectreference hidden 
activator property cwmapflagbluesolitude auto
activator property cwmapflagbluewinterhold auto
activator property cwmapflagbluewindhelm auto
activator property cwmapflagblueriften auto
activator property cwmapflagbluewhiterun auto
activator property cwmapflagbluefalkreath auto
activator property cwmapflagbluemorthal auto
activator property cwmapflagbluemarkarth auto
activator property cwmapflagbluedawnstar auto
activator property cwmapflagbluekarthwasten auto
activator property cwmapflagbluedragonbridge auto
activator property cwmapflagbluerorikstead auto
activator property cwmapflagbluehelgen auto
activator property cwmapflagblueivarstead auto
activator property cwmapflagblueshorsstone auto
activator property cwmapflagblueriverwood auto
activator property cwmapflagbluefortgreymoor auto
activator property cwmapflagbluefortsungard auto
activator property cwmapflagblueforthraggstad auto
activator property cwmapflagbluefortdunstad auto
activator property cwmapflagbluefortkastav auto
activator property cwmapflagbluefortamol auto
activator property cwmapflagbluefortgreenwall auto
activator property cwmapflagbluefortneugrad auto
activator property cwmapflagbluefortsnowhawk auto
activator property cwmapflagredsolitude auto
activator property cwmapflagredwinterhold auto
activator property cwmapflagredwindhelm auto
activator property cwmapflagredriften auto
activator property cwmapflagredwhiterun auto
activator property cwmapflagredfalkreath auto
activator property cwmapflagredmorthal auto
activator property cwmapflagredmarkarth auto
activator property cwmapflagreddawnstar auto
activator property cwmapflagredkarthwasten auto
activator property cwmapflagreddragonbridge auto
activator property cwmapflagredrorikstead auto
activator property cwmapflagredhelgen auto
activator property cwmapflagredivarstead auto
activator property cwmapflagredshorsstone auto
activator property cwmapflagredriverwood auto
activator property cwmapflagredfortgreymoor auto
activator property cwmapflagredfortsungard auto
activator property cwmapflagredforthraggstad auto
activator property cwmapflagredfortdunstad auto
activator property cwmapflagredfortkastav auto
activator property cwmapflagredfortamol auto
activator property cwmapflagredfortgreenwall auto
activator property cwmapflagredfortneugrad auto
activator property cwmapflagredfortsnowhawk auto
objectreference property cwmapflagsolituderef auto hidden
objectreference property cwmapflagwinterholdref auto hidden
objectreference property cwmapflagwindhelmref auto hidden
objectreference property cwmapflagriftenref auto hidden
objectreference property cwmapflagwhiterunref auto hidden
objectreference property cwmapflagfalkreathref auto hidden
objectreference property cwmapflagmorthalref auto hidden
objectreference property cwmapflagmarkarthref auto hidden
objectreference property cwmapflagdawnstarref auto hidden
objectreference property cwmapflagkarthwastenref auto hidden
objectreference property cwmapflagdragonbridgeref auto hidden
objectreference property cwmapflagroriksteadref auto hidden
objectreference property cwmapflaghelgenref auto hidden
objectreference property cwmapflagivarsteadref auto hidden
objectreference property cwmapflagshorsstoneref auto hidden
objectreference property cwmapflagriverwoodref auto hidden
objectreference property cwmapflagfortgreymoorref auto hidden
objectreference property cwmapflagfortsungardref auto hidden
objectreference property cwmapflagforthraggstadref auto hidden
objectreference property cwmapflagfortdunstadref auto hidden
objectreference property cwmapflagfortkastavref auto hidden
objectreference property cwmapflagfortamolref auto hidden
objectreference property cwmapflagfortgreenwallref auto hidden
objectreference property cwmapflagfortneugradref auto hidden
objectreference property cwmapflagfortsnowhawkref auto hidden
location property solitudelocation auto
location property winterholdlocation auto
location property windhelmlocation auto
location property riftenlocation auto
location property whiterunlocation auto
location property falkreathlocation auto
location property morthallocation auto
location property markarthlocation auto
location property dawnstarlocation auto
location property karthwastenlocation auto
location property dragonbridgelocation auto
location property roriksteadlocation auto
location property helgenlocation auto
location property ivarsteadlocation auto
location property shorsstonelocation auto
location property riverwoodlocation auto
location property fortgreymoorlocation auto
location property fortsungardlocation auto
location property forthraggstadlocation auto
location property fortdunstadlocation auto
location property fortkastavlocation auto
location property fortamollocation auto
location property fortgreenwalllocation auto
location property fortneugradlocation auto
location property fortsnowhawklocation auto
keyword property cwowner auto
event oncellattach()
endevent
function removeflags()
endfunction
function trytoremoveflag(objectreference flagtodisable)
endfunction
function placeflags()
endfunction
objectreference function trytoplaceflag(objectreference refofflag, activator activatorofflagred, activator activatorofflagblue, location locationofflag, string nodeofflag)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1