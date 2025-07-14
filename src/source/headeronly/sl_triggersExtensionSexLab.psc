scriptname sl_triggersextensionsexlab extends sl_triggersextension
form    property sexlabform     auto hidden
faction             property sexlabanimatingfaction  auto hidden
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
sslthreadcontroller function getthreadforactor(actor theactor)
endfunction
bool function customresolvescoped(sl_triggerscmd cmdprimary, string scope, string token)
endfunction
event onsexlabstart(string _eventname, string _args, float _argc, form _sender)
endevent
event onsexlaborgasm(string _eventname, string _args, float _argc, form _sender)
endevent
event onsexlabend(string _eventname, string _args, float _argc, form _sender)
endevent
event onsexlaborgasms(form actorref, int thread)
endevent
function refreshtriggercache()
endfunction
function updatesexlabstatus()
endfunction
function registerevents()
endfunction
function handlesexlabcheckevents(int tid, actor specactor, string [] _eventtriggerkeys)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1