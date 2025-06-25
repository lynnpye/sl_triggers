scriptname sl_triggersextensioncore extends sl_triggersextension
actorbase property    pksentinelbase auto
formlist property    thecontainersweknowandlove auto ; so many naming schemes to choose from
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
function send_sltr_onplayercellchange()
endfunction
function sltr_internal_playercellchange()
endfunction
function relocateplayerloadingscreensentinel()
endfunction
function send_sltr_onplayerloadingscreen()
endfunction
function sltr_internal_playernewspaceevent()
endfunction
function send_sltr_onplayeractivatecontainer(objectreference containerref, bool container_is_corpse, bool container_is_empty)
endfunction
function sltr_internal_playeractivatedcontainer(objectreference containerref, bool container_is_corpse, bool container_is_empty)
endfunction
function refreshthecontainersweknowandlove()
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
function handleonplayercellchange()
endfunction
function handleonplayerloadingscreen()
endfunction
function handleplayercontaineractivation(objectreference containerref, bool container_is_corpse, bool container_is_empty, keyword playerlocationkeyword)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1