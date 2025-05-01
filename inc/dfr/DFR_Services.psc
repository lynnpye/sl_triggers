scriptname dfr_services extends quest conditional
actor property playerref auto
dfr_services_follower property followeralias auto
referencealias property serviceevent auto
referencealias property sharpenweapon auto
globalvariable property gamedayspassed auto
keyword[] property townkeywords auto
keyword[] property staminapotioneffectkwds auto
keyword[] property healthpotioneffectkwds auto
keyword[] property magickapotioneffectkwds auto
int property food_service_index = 0 autoreadonly hidden
int property potion_service_index = 1 autoreadonly hidden
int property sharpen_service_index = 2 autoreadonly hidden
int property arrow_service_index = 3 autoreadonly hidden
formlist[] property inventoryfilters auto
globalvariable[] property desiredcounts auto
globalvariable[] property currentcounts auto
actor property dummy auto
float[] property timetocomplete auto hidden
int property received auto hidden conditional
bool property overdue auto hidden conditional
globalvariable property variant auto
event oninit()
endevent
function maintenance()
endfunction
bool function selectservice(int aiindex)
endfunction
bool function startservice(actor akmaster, int aiindex)
endfunction
function startcompletiontimer(int aiindex)
endfunction
function opengiftmenu(int aiindex)
endfunction
event onmenuclose(string asmenu)
endevent
function handleitem(form akitem, int aicount, objectreference akref)
endfunction
bool function iscorrectpotiontype(form akitem)
endfunction
int function getobjectiveindex(int aiserviceindex)
endfunction
function completeservice(int aiindex)
endfunction
event onupdategametime()
endevent
function setoverdue()
endfunction
function fail()
endfunction
dfr_failableevent function geteventscr(int aiindex)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1