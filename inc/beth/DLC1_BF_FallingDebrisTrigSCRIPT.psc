scriptname dlc1_bf_fallingdebristrigscript extends objectreference hidden 
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
keyword property linkcustom04 auto
keyword property linkcustom05 auto
keyword property linkcustom06 auto
keyword property linkcustom07 auto
spell property voiceunrelentingforce3 auto
explosion property dlc1snowelfcolumnhavokexplosion auto
explosion property dlc1snowelfflathavokexplosion auto
visualeffect property dlc01_sunauracloakeffect  auto  
sound property fxrumblefalmerboss2d auto
sound property qstfalmerbosscolumndestruction2d auto
quest property myquest auto
int property stagetocheck auto
bool property debriswastriggered = false auto hidden
bool property checkforplayer = false auto hidden
objectreference property debriscontroller auto hidden
bool property forcecollapse = false auto hidden
objectreference property prince auto
idle property princecast auto
idle property princebigcast auto
idle property princebigcastend auto
weather property dlc1falmervalley_bf auto
int property pillarposition auto
event onactivate(objectreference akactionref)
endevent
function checkforplayer()
endfunction
function assigndebriscontroller(objectreference akwavecontroller)
endfunction
function forcecollapse()
endfunction
function trytodisablelightbeams()
endfunction
event onanimationevent(objectreference aksource, string eventname)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1