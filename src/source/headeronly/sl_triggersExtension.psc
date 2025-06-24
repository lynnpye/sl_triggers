scriptname sl_triggersextension extends quest
string    property sltextensionkey auto
string    property sltfriendlyname auto
int     property sltpriority auto
actor               property playerref auto
sl_triggersmain  property slt auto hidden ; will be populated on startup
keyword    property actortypenpc auto hidden ; will be populated on startup
keyword    property actortypeundead auto hidden ; will be populated on startup
bool    property isenabled = true auto hidden
bool    property benabled = true auto hidden ; enable/disable our extension
function setenabled(bool _newenabledflag)
endfunction
string[]   property triggerkeys auto hidden
string    property fn_s auto hidden
string function fn_t(string _triggerkey)
endfunction
function sltready()
endfunction
function sltsettingsupdated()
endfunction
bool function customresolve(sl_triggerscmd cmdprimary, string token)
endfunction
bool function customresolveform(sl_triggerscmd cmdprimary, string token)
endfunction
bool    property isdebugmsg
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
int function actorrace(actor _actor)
endfunction
int function actorpos(int idx, int count)
endfunction
int function daytime()
endfunction
bool    property _bdebugmsg = false auto hidden ; enable/disable debug logging for our extension
string    property currenttriggerid auto hidden ; used for simple iteration
event _slt_onsltsettingsupdated(string eventname, string strarg, float numarg, form sender)
endevent
function sltinit()
endfunction
bool function requestcommand(actor _theactor, string _thescript)
endfunction
event _slt_onsltinternalready(string eventname, string strarg, float numarg, form sender)
endevent
function _slt_refreshtriggers()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1