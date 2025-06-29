scriptname sl_triggerscmd extends activemagiceffect
sl_triggersmain  property slt auto
actor   property playerref auto
keyword   property actortypenpc auto
keyword   property actortypeundead auto
actor   property cmdtargetactor hidden
actor function get()
endfunction
function set(actor value)
endfunction
endproperty
int             property cmdtargetformid auto hidden
int         property threadid hidden
int function get()
endfunction
function set(int value)
endfunction
endproperty
bool        property runoppending = false auto hidden
bool        property isexecuting = false auto hidden
int         property previousframeid = 0 auto hidden
int   property lastkey = 0 auto  hidden
bool        property cleanedup = false auto  hidden
string     property mostrecentresult = "" auto hidden
actor       property iteractor = none auto hidden
string      property currentscriptname = "" auto hidden
int         property currentline = 0 auto hidden
int         property totallines = 0 auto hidden
int         property linenum = 1 auto hidden
string[]    property callargs auto hidden
string      property command = "" auto hidden
int         property rt_string =    1 autoreadonly
int         property rt_bool =      2 autoreadonly
int         property rt_int =       3 autoreadonly
int         property rt_float =     4 autoreadonly
int         property rt_form =      5 autoreadonly
int         property customresolvetype auto hidden
string      property customresolveresult hidden
string function get()
endfunction
function set(string value)
endfunction
endproperty
bool        property customresolveboolresult hidden
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
int         property customresolveintresult  hidden
int function get()
endfunction
function set(int value)
endfunction
endproperty
float        property customresolvefloatresult  hidden
float function get()
endfunction
function set(float value)
endfunction
endproperty
form        property customresolveformresult hidden
form function get()
endfunction
function set(form value)
endfunction
endproperty
event onsltreset(string eventname, string strarg, float numarg, form sender)
endevent
event oneffectstart(actor aktarget, actor akcaster)
endevent
event onplayerloadgame()
endevent
function dostartup()
endfunction
event onupdate()
endevent
function cleanupandremove()
endfunction
function runoperationonactor(string[] opcmdline)
endfunction
function completeoperationonactor()
endfunction
bool function internalresolve(string token)
endfunction
string function resolve(string token)
endfunction
actor function resolveactor(string token)
endfunction
form function resolveform(string token)
endfunction
bool function resolvebool(string token)
endfunction
int function resolveint(string token)
endfunction
float function resolvefloat(string token)
endfunction
function runscript()
endfunction
string function _slt_islabel(string[] _tokens = none)
endfunction
function sfe(string msg)
endfunction
event onkeydown(int keycode)
endevent
function queueupdateloop(float afdelay = 1.0)
endfunction
string function actorname(actor _person)
endfunction
string function actordisplayname(actor _person)
endfunction
int function actorgender(actor _actor)
endfunction
bool function insamecell(actor _actor)
endfunction
form function getformbyid(string _data)
endfunction
bool function slt_frame_push(string scriptfilename, string[] parm_callargs)
endfunction
bool function slt_frame_pop()
endfunction
function slt_addlinedata(int scriptlineno, string[] cmdtokens)
endfunction
function slt_addgoto(string label, int targetline)
endfunction
int function slt_findgoto(string label)
endfunction
function slt_addgosub(string label, int targetline)
endfunction
int function slt_findgosub(string label)
endfunction
function slt_pushgosubreturn(int targetline)
endfunction
int function slt_popgosubreturn()
endfunction
string function getframevar(string _key, string missing)
endfunction
string function setframevar(string _key, string value)
endfunction
string function getthreadvar(string _key, string missing)
endfunction
string function setthreadvar(string _key, string value)
endfunction
function getvarscope2(string varname, string[] varscope)
endfunction
string function getvarstring2(string scope, string varname, string missing)
endfunction
string function setvarstring2(string scope, string varname, string value)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1