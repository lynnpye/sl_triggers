scriptname sla_sexlabplugin extends sla_pluginbase
sla_ddplugin property ddplugin auto
sla_defaultplugin property defaultplugin auto
actor property playerref auto
bool function checkdependencies()
endfunction
bool function hasslso()
endfunction
float function getlewd(actor who)
endfunction
float function getanimationduration(sslthreadcontroller thisthread)
endfunction
bool function canotheractorgiveorgasm(actor[] actorlist, actor except, bool anal, bool oral, bool breasts)
endfunction
bool[] function findactorwillorgasm(sslthreadcontroller thisthread, sslbaseanimation animation, actor[] actorlist)
endfunction
float function getoptionvalue(int optionid)
endfunction
function onupdateoption(int optionid, float value)
endfunction
event onendstate()
endevent
function onstagestart(int tid, bool hasplayer)
endfunction
function onanimationend(int tid, bool hasplayer)
endfunction
function onsexlaborgasm(form who, int enjoyment, int orgasms)
endfunction
state installed
function addoptions()
endfunction
function disableplugin()
endfunction
function enableplugin()
endfunction
function onanimationend(int tid, bool hasplayer)
endfunction
function onsexlaborgasm(form who, int enjoyment, int orgasms)
endfunction
function onstagestart(int tid, bool hasplayer)
endfunction
function updateactor(actor who, bool fullupdate)
endfunction
function updateobserver(actor observer, actor observed)
endfunction
event onendstate()
endevent
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1