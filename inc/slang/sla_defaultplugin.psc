scriptname sla_defaultplugin extends sla_pluginbase
sla_ddplugin property ddplugin auto
keyword property kactortypecreature auto
faction property slacreaturesexloverfaction auto
faction property slanaked auto
slainternalscr property slautil auto
function updatedenialmodifier(actor who)
endfunction
function updatedenialcycle(actor who)
endfunction
float function getoptionvalue(int optionid)
endfunction
function onupdateoption(int optionid, float value)
endfunction
function onorgasm(actor who, float enjoyment)
endfunction
float function modexposurelegacy(actor who, float exposurevalue)
endfunction
float function getexposurelegacy(actor who)
endfunction
event onendstate()
endevent
state installed
function addoptions()
endfunction
function disableplugin()
endfunction
function enableplugin()
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