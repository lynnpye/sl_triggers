scriptname sl_triggersmain extends quest
bool property ff_versionupdate_remove_event_id_player_loading_screen = true auto hidden
bool property ff_versionupdate_sexlab_migrate_location_to_deeplocation = true auto hidden
actor               property playerref    auto
sl_triggerssetup property sltmcm     auto
sl_triggersplayeronloadgamehandler property sltplyref auto hidden
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
perk property sltrcontainerperk auto
keyword[] property locationkeywords auto hidden
string    property savetimestamp auto hidden
bool    property isresetting = false auto hidden
bool    property bdebugmsg  = false auto hidden
form[]    property extensions    auto hidden
int     property nextinstanceid   auto hidden
globalvariable   property gamedayspassed auto hidden
int     property runningscriptcount hidden
int function get()
endfunction
function set(int value)
endfunction
endproperty
int     property sltrversion = 0 auto hidden
int     property rt_invalid =    0 autoreadonly
int     property rt_string =     1 autoreadonly
int     property rt_bool =       2 autoreadonly
int     property rt_int =        3 autoreadonly
int     property rt_float =      4 autoreadonly
int     property rt_form =       5 autoreadonly
int  property rt_label =   6 autoreadonly
string function rt_tostring(int rt_type)
endfunction
bool property debug_cmd auto hidden
bool property debug_cmd_functions auto hidden
bool property debug_cmd_internalresolve auto hidden
bool property debug_cmd_internalresolve_literals auto hidden
bool property debug_cmd_resolveform auto hidden
bool property debug_cmd_runscript auto hidden
bool property debug_cmd_runscript_blocks auto hidden
bool property debug_cmd_runscript_if auto hidden
bool property debug_cmd_runscript_labels auto hidden
bool property debug_cmd_runscript_set auto hidden
bool property debug_cmd_runscript_while auto hidden
bool property debug_extension auto hidden
bool property debug_extension_core auto hidden
bool property debug_extension_core_keymapping auto hidden
bool property debug_extension_core_timer auto hidden
bool property debug_extension_core_topofthehour auto hidden
bool property debug_extension_sexlab auto hidden
bool property debug_extension_ostim auto hidden
bool property debug_extension_customresolvescoped auto hidden
bool property debug_setup auto hidden
function setupsettingsflags()
endfunction
float function getthegametime()
endfunction
bool    property isenabled hidden
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
event oninit()
endevent
function doplayerloadgame()
endfunction
function bootstrapsltinit(bool bsetupflags)
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
event onsltreset(string eventname, string strarg, float numarg, form sender)
endevent
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
sl_triggersextension function getextensionbyscope(string _scope)
endfunction
event onsltdelaystartcommand(string eventname, string initialscriptname, float reattemptcount, form sender)
endevent
bool function hasglobalvar(string _key)
endfunction
int function getglobalvartype(string _key)
endfunction
string function getglobalvarstring(string _key, string missing)
endfunction
string function getglobalvarlabel(string _key, string missing)
endfunction
bool function getglobalvarbool(string _key, bool missing)
endfunction
int function getglobalvarint(string _key, int missing)
endfunction
float function getglobalvarfloat(string _key, float missing)
endfunction
form function getglobalvarform(string _key, form missing)
endfunction
string function setglobalvarstring(string _key, string value)
endfunction
string function setglobalvarlabel(string _key, string value)
endfunction
bool function setglobalvarbool(string _key, bool value)
endfunction
int function setglobalvarint(string _key, int value)
endfunction
float function setglobalvarfloat(string _key, float value)
endfunction
form function setglobalvarform(string _key, form value)
endfunction
function startcommand(form targetform, string initialscriptname)
endfunction
function pushscriptfortarget(form targetform, int requestid, int threadid, string initialscriptname)
endfunction
function popscriptfortarget(form targetform, int[] requestid, int[] threadid, string[] initialscriptname)
endfunction
function startcommandwiththreadid(form targetform, string initialscriptname, int requestid, int threadid)
endfunction
function getlocationflags(location ploc, bool[] flagset)
endfunction
function getplayerlocationflags(bool[] flagset)
endfunction
function getactorlocationflags(actor theactor, bool[] flagset)
endfunction
keyword function getplayerlocationkeyword()
endfunction
keyword function getactorlocationkeyword(actor theactor)
endfunction
bool function isflagsetsafe(bool[] flagset)
endfunction
bool function isflagsetincity(bool[] flagset)
endfunction
bool function isflagsetinwilderness(bool[] flagset)
endfunction
bool function isflagsetindungeon(bool[] flagset)
endfunction
bool function islocationkeywordsafe(keyword lockeyword)
endfunction
bool function islocationkeywordcity(keyword lockeyword)
endfunction
bool function islocationkeywordwilderness(keyword lockeyword)
endfunction
bool function islocationkeyworddungeon(keyword lockeyword)
endfunction
bool function islocationsafe(location ploc)
endfunction
bool function islocationincity(location ploc)
endfunction
bool function islocationinwilderness(location ploc)
endfunction
bool function islocationindungeon(location ploc)
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
function checkversionupdates()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1