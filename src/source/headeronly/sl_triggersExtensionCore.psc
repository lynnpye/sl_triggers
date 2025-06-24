scriptname sl_triggersextensioncore extends sl_triggersextension
actorbase property pksentinelbase auto
actor property pksentinel auto hidden
globalvariable  property dakstatus    auto hidden
bool    property dakavailable   auto hidden
globalvariable  property dakhotkey    auto hidden
float    property tohelapsedtime   auto hidden
float    property lasttopofthehour  auto hidden
float    property nexttopofthehour  auto hidden
event oninit()
endevent
event onupdate()
endevent
function sltready()
endfunction
function refreshdata()
endfunction
event onupdategametime()
endevent
event onnewsession(int _newsessionid)
endevent
event ontopofthehour(string eventname, string strarg, float fltarg, form sender)
endevent
event onkeyup(int keycode, float holdtime)
endevent
event onkeydown(int keycode)
endevent
function sendplayercellchangeevent()
endfunction
function relocateplayerloadingscreensentinel()
endfunction
function sltr_internal_playernewspaceevent()
endfunction
function refreshtriggercache()
endfunction
function aligntonexthour(float _curtime = -1.0)
endfunction
function updatedakstatus()
endfunction
function registerevents()
endfunction
function registerforkeyevents()
endfunction
function handlenewsession(int _newsessionid)
endfunction
function handletopofthehour()
endfunction
function handleonkeydown()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1