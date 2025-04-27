scriptname sla_ddplugin extends sla_pluginbase
sla_defaultplugin property defaultplugin auto
actor property playerref auto
bool function checkdependencies()
endfunction
function ondeviceequipped(form inventorydevice, form devicekeyword, form akactor)
endfunction
function ondeviceremoved(form inventorydevice, form devicekeyword, form akactor)
endfunction
function setteasingeffectifneeded(actor who)
endfunction
function onvibrationstart(string eventname, string actorname, float strength, form sender)
endfunction
function onvibrationstop(string eventname, string actorname, float argnum, form sender)
endfunction
event onupdate()
endevent
float function getoptionvalue(int optionid)
endfunction
function onupdateoption(int optionid, float value)
endfunction
event onendstate()
endevent
bool function canactororgasmgeneric(actor who)
endfunction
bool function cangiveorgasm(actor who, bool anal, bool oral, bool breasts)
endfunction
bool function canrecieveorgasm(actor who, bool anal)
endfunction
float function getbeltandplugmodifier(actor who)
endfunction
state installed
function addoptions()
endfunction
bool function canactororgasmgeneric(actor who)
endfunction
bool function cangiveorgasm(actor who, bool anal, bool oral, bool breasts)
endfunction
bool function canrecieveorgasm(actor who, bool anal)
endfunction
function disableplugin()
endfunction
function enableplugin()
endfunction
float function getbeltandplugmodifier(actor who)
endfunction
function updateactor(actor who, bool fullupdate)
endfunction
event onendstate()
endevent
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1