scriptname sla_pluginbase extends quest
bool property isenabled = false auto hidden
slamainscr property main auto
string property name auto
function addoptions()
endfunction
function clearactor(actor who)
endfunction
function enableplugin()
endfunction
function onupdateoption(int optionid, float value)
endfunction
function update(actor[] actors, actor[] nakedactors)
endfunction
function updateactor(actor who, bool fullupdate)
endfunction
function updateobserver(actor observer, actor observed)
endfunction
function logdebug(string msg)
endfunction
bool function isinterfaceactive()
endfunction
event oninit()
endevent
function on_sla_int_playerloadsgame(string eventname, string strarg, float numarg, form sender)
endfunction
function playerloadsgame()
endfunction
bool function checkdependencies()
endfunction
function disableplugin()
endfunction
function clearoptions()
endfunction
int function getnumberofoptions()
endfunction
int function addtoggleoption(string category, string title, string description, bool defaultvalue)
endfunction
int function addoptionex(string category, string title, string description, float defaultvalue, float min, float max, float step, string format)
endfunction
int function addoption(string category, string title, string description, float defaultvalue)
endfunction
function setoptiondefault(int option, float defaultvalue)
endfunction
function settoggleoption(int option)
endfunction
float function getoptionvalue(int optionid)
endfunction
function registerforperodicupdates()
endfunction
function registerforlosupdates()
endfunction
function unregisterforlosupdates()
endfunction
function hideeffectinui(int effectid)
endfunction
function showeffectinui(int effectid)
endfunction
int function registereffect(string id, string title, string description)
endfunction
function unregistereffect(string id)
endfunction
bool function iseffectactive(actor who, int effectidx)
endfunction
float function getarousaleffectvalue(actor who, int effectidx)
endfunction
function setarousaleffectvalue(actor who, int effectidx, float value)
endfunction
float function modarousaleffectvalue(actor who, int effectidx, float diff, float limit)
endfunction
function setarousaleffectfunction(actor who, int effectidx, int functionid, float param, float limit, int auxilliary)
endfunction
function setlineararousaleffect(actor who, int effectidx, float rateperday, float limit, int auxilliary)
endfunction
function setarousaldecayeffect(actor who, int effectidx, float halflifeindays, float limit, int auxilliary)
endfunction
int function getarousaleffectfncaux(actor who, int effectidx)
endfunction
float function getarousaleffectfnclimit(actor who, int effectidx)
endfunction
float function getarousaleffectfncparam(actor who, int effectidx)
endfunction
function forceupdatearousal(actor who)
endfunction
function disablearousaleffect(actor who, int effectidx)
endfunction
bool function groupeffects(actor who, int effidx1, int effidx2)
endfunction
bool function removeeffectgroup(actor who, int effidx)
endfunction
function oninstalled()
endfunction
function onuninstalled()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1