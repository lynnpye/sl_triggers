scriptname sl_triggersextension extends quest
string    property sltextensionkey auto
string    property sltfriendlyname auto
int     property sltpriority auto
string    property sltscope auto
actor               property playerref auto
sl_triggersmain  property slt auto hidden ; will be populated on startup
keyword    property actortypenpc auto hidden ; will be populated on startup
keyword    property actortypeundead auto hidden ; will be populated on startup
bool    property isenabled hidden
bool function get()
endfunction
endproperty
bool    property benabled = true auto hidden ; enable/disable our extension
bool function _slt_additionalrequirementssatisfied()
endfunction
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
bool function customresolvescoped(sl_triggerscmd cmdprimary, string scope, string token)
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
bool function daytime()
endfunction
bool    property _bdebugmsg = false auto hidden ; enable/disable debug logging for our extension
string    property currenttriggerid auto hidden ; used for simple iteration
event onsltsettingsupdated(string eventname, string strarg, float numarg, form sender)
endevent
function sltinit()
endfunction
bool function requestcommand(actor _theactor, string _thescript)
endfunction
bool function requestcommandwiththreadid(actor _theactor, string _thescript, int _requestid, int _threadid)
endfunction
event onsltinternalready(string eventname, string strarg, float numarg, form sender)
endevent
function _slt_refreshtriggers()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1