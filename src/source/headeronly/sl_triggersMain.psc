scriptname sl_triggersmain extends quest
actor               property playerref    auto
sl_triggerssetup property sltmcm     auto
keyword property loctypeplayerhome  auto 
keyword property loctypejail  auto 
keyword property loctypedungeon  auto  
keyword property locsetcave  auto 
keyword property loctypedwelling  auto  
keyword property loctypecity  auto  
keyword property loctypetown  auto  
keyword property loctypehabitation  auto  
keyword property loctypedraugrcrypt  auto  
keyword property loctypedragonpriestlair  auto  
keyword property loctypebanditcamp  auto  
keyword property loctypefalmerhive  auto  
keyword property loctypevampirelair  auto  
keyword property loctypedwarvenautomatons  auto  
keyword property loctypemilitaryfort  auto  
keyword property loctypemine  auto  
keyword property loctypeinn  auto
keyword property loctypehold auto
keyword[] property locationkeywords auto hidden
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
function getplayerlocationflags(bool[] flagset)
endfunction
function getactorlocationflags(actor theactor, bool[] flagset)
endfunction
keyword function getplayerlocationkeyword()
endfunction
keyword function getactorlocationkeyword(actor theactor)
endfunction
bool function islocationkeywordsafe(keyword lockeyword)
endfunction
bool function islocationkeywordcity(keyword lockeyword)
endfunction
bool function islocationkeywordwilderness(keyword lockeyword)
endfunction
bool function islocationkeyworddungeon(keyword lockeyword)
endfunction
bool function playerisindungeon()
endfunction
bool function playerisinwilderness()
endfunction
bool function playerisincity()
endfunction
bool function playerisinsafelocation()
endfunction
bool function actorisindungeon(actor theactor)
endfunction
bool function actorisinwilderness(actor theactor)
endfunction
bool function actorisincity(actor theactor)
endfunction
bool function actorisinsafelocation(actor theactor)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1