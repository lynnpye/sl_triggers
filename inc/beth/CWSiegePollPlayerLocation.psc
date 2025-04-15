scriptname cwsiegepollplayerlocation extends quest  
int property distanceatwhichplayerdistancefail = 20000 auto
int property stagetosetifplayerisattackingdistancefail = 50 auto
int property stagetosetifplayerisdefendingdistancefail = 200 auto  
int property stagethatmeansplayerisconsiderednottohaverunawayfromattack = 50 auto
int property stagethatmeansplayerisconsiderednottohaverunawayfromdefense = 200 auto
int property stagethatmeansplayerhasenteredfinalcitybattle = 60 auto
cwscript property cws auto
keyword property cwsiegeplayerranaway auto
location property windhelmlocation auto
location property solitudelocation auto
location property whiterunlocation auto
location property locationofbattle auto hidden
objectreference property battlecentermarker auto hidden
bool property playerhasbeentolocationofbattle auto hidden ; i don't remember why this is a property, but for safety sake, leaving it as is
bool property playerhasrunaway auto hidden
state busy
event onupdate()
endevent
endstate
state done
event onupdate()
endevent
endstate
function registerbattlecentermarkerandlocation(objectreference battlecentermarkerref, location citylocation)
endfunction
event onupdate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1