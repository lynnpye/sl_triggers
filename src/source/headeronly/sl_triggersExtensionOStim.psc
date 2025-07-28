scriptname sl_triggersextensionostim extends sl_triggersextension
form    property ostimform     auto hidden
bool function ismcmconfigurable()
endfunction
event oninit()
endevent
event onupdate()
endevent
function sltready()
endfunction
function refreshdata()
endfunction
bool function _slt_additionalrequirementssatisfied()
endfunction
function handleversionupdate(int oldversion, int newversion)
endfunction
bool function customresolvescoped(sl_triggerscmd cmdprimary, string scope, string token)
endfunction
function refreshtriggercache()
endfunction
function updateostimstatus()
endfunction
function registerevents()
endfunction
event onsexstart(string _eventname, string _args, float _argc, form _sender)
endevent
event onorgasm(string _eventname, string _args, float _argc, form _sender)
endevent
event onsexend(string _eventname, string _args, float _argc, form _sender)
endevent
function handlecheckevents(int tid, actor specactor, string[] _eventtriggerkeys, actor[] sceneactorlist = none)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1