scriptname sl_triggersmain extends quest
actor               property playerref    auto
sl_triggerssetup property sltmcm     auto
bool    property benabled  = true auto hidden
bool    property bdebugmsg  = false auto hidden
form[]    property extensions    auto hidden
int     property nextinstanceid   auto hidden
function setenabled(bool _newenabledflag)
endfunction
event oninit()
endevent
function doplayerloadgame()
endfunction
function bootstrapsltinit()
endfunction
event onupdate()
endevent
event onsltregisterextension(string _eventname, string extensionkey, float fltval, form extensiontoregister_asform)
endevent
event onsltrequestlist(string _eventname, string _storageutilstringlistkey, float _isglobal, form _storageutilobj)
endevent
event onsltrequestcommand(string _eventname, string _scriptname, float __ignored, form _thetarget)
endevent
function doregistrationbeacon()
endfunction
int function getnextinstanceid()
endfunction
function doregistrationactivity(sl_triggersextension _extensiontoregister)
endfunction
function doinmemoryreset()
endfunction
function queueupdateloop(float afdelay = 1.0)
endfunction
function sendeventsltonnewsession()
endfunction
function sendsltinternalready()
endfunction
function sendsettingsupdatebroadcast()
endfunction
function sendinternalsettingsupdateevents()
endfunction
sl_triggersextension function getextensionbyindex(int _index)
endfunction
sl_triggersextension function getextensionbykey(string _extensionkey)
endfunction
event onsltdelaystartcommand(string eventname, string initialscriptname, float reattemptcount, form sender)
endevent
string function getglobalvar(string _key, string missing)
endfunction
string function setglobalvar(string _key, string value)
endfunction
string[] function claimnextthread(int targetformid)
endfunction
function startcommand(form targetform, string initialscriptname)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1