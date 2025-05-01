scriptname slamainscr extends quest
int[] property actortypes auto hidden
keyword property armorcuirass auto
keyword property clothingbody auto
sla_defaultplugin property defaultplugin auto
globalvariable property gamedayspassed auto
actor property playerref auto
int property plugincount auto
sla_pluginbase[] property plugins auto hidden
sexlabframework property sexlab auto
faction property slaarousal auto
slaconfigscr property slaconfig auto
spell property sladesirespell auto
faction property slanaked auto
quest property slanakednpc auto
globalvariable property slanexttimeplayernaked auto
quest property slascanall auto
quest property slascanallnpcs auto
slainternalscr property slautil auto
globalvariable property sla_animatefemales auto
globalvariable property sla_animatemales auto
globalvariable property sla_animationthreshhold auto
formlist property sla_nakedarmorlist auto
globalvariable property sla_nextmaintenance auto
globalvariable property sla_uselineofsight auto
float property updatefrequency = 30.0 auto hidden
bool property wasplayerraped auto
function clearfromactorstorage(form formref)
endfunction
event oninit()
endevent
int function getcurrentversion()
endfunction
function logdebug(string msg)
endfunction
function registerplugin(sla_pluginbase plugin)
endfunction
function unregisterplugin(sla_pluginbase plugin)
endfunction
function setpluginlosevents(sla_pluginbase plugin, bool listentolos)
endfunction
function setpluginupdateevents(sla_pluginbase plugin, bool listentoupdate)
endfunction
function registerdynamiceffect(string id, string title, string description)
endfunction
int function registereffect(string id, string title, string description, sla_pluginbase effectowner)
endfunction
function unregistereffect(string id)
endfunction
function seteffectvisible(int effectidx, bool visible)
endfunction
int function getdynamiceffectcount(actor who)
endfunction
string function getdynamiceffect(actor who, int number)
endfunction
float function getdynamiceffectvalue(actor who, int number)
endfunction
float function getdynamiceffectvaluebyname(actor who, string effectid)
endfunction
int function geteffectcount()
endfunction
bool function iseffectvisible(int effectidx)
endfunction
string function geteffecttitle(int effectidx)
endfunction
string function geteffectdescription(int effectidx)
endfunction
bool function iseffectactive(actor who, int effectidx)
endfunction
float function geteffectvalue(actor who, int effectidx)
endfunction
float function gettimedeffectparameter(actor who, int effectidx)
endfunction
int function gettimedeffectauxilliary(actor who, int effectidx)
endfunction
float function gettimedeffectlimit(actor who, int effectidx)
endfunction
function setdynamicarousaleffect(form whof, string effectid, float initialvalue, int functionid, float param, float limit)
endfunction
function moddynamicarousaleffect(form whof, string effectid, float modifier, float limit)
endfunction
float function modeffectvalue(actor who, int effectidx, float diff, float limit)
endfunction
function seteffectvalue(actor who, int effectidx, float value)
endfunction
function settimedeffectfunction(actor who, int effectidx, int functionid, float param, float limit, int auxilliary)
endfunction
bool function groupeffects(actor who, int effidx1, int effidx2)
endfunction
bool function removeeffectgroup(actor who, int effidx)
endfunction
function updatesingleactorarousal(actor who)
endfunction
event onplayerloadgame()
endevent
int function isanimatingfemales()
endfunction
function setisanimatingfemales(int newvalue)
endfunction
int function isanimatingmales()
endfunction
function setisanimatingmales(int newvalue)
endfunction
int function getanimationthreshold()
endfunction
function setanimationthreshold(int newvalue)
endfunction
int function getuselos()
endfunction
int function getnakedonly()
endfunction
function setnakedonly(int newvalue)
endfunction
int function getdisabled()
endfunction
function setdisabled(int newvalue)
endfunction
function setuselos(int newvalue)
endfunction
function setupdatefrequency(float frequency)
endfunction
function setcleaningtime()
endfunction
function maintenance()
endfunction
function startcleaning()
endfunction
int function getallactors(int lockid)
endfunction
actor[] function getnearbyactors()
endfunction
event onupdate()
endevent
function updateactorarousals(bool fullupdate)
endfunction
function forceupdateactor(actor who)
endfunction
function modifyexposure(form actorform, float exposurevalue)
endfunction
bool function isactornaked(actor who)
endfunction
bool function isactornakedvanilla(actor who)
endfunction
bool function isactornakedextended(actor who)
endfunction
int function getversion()
endfunction
function updatekeyregistery()
endfunction
function setversion(int newversion)
endfunction
function updatedesirespell()
endfunction
function onkeydown(int keycode)
endfunction
function onkeyup(int keycode, float holdtime)
endfunction
function startpcmasturbation()
endfunction
function oncrosshairrefchange(objectreference ref)
endfunction
function onplayerarousalupdate(int arousal)
endfunction
function cleanactorstorage()
endfunction
bool function isimportant(actor who)
endfunction
function registerformodevents()
endfunction
state cleaning
event onupdate()
endevent
endstate
state initializing
event onupdate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1