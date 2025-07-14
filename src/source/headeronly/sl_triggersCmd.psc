scriptname sl_triggerscmd extends activemagiceffect
sl_triggersmain  property slt auto
actor   property playerref auto
keyword   property actortypenpc auto
keyword   property actortypeundead auto
function set_krequest_v_prefix()
endfunction
string function make_ktarget_v_prefix(int formid)
endfunction
string function make_ktarget_type_v_prefix(int formid)
endfunction
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
int         property cmdrequestid hidden
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
actor       property iteractor = none auto hidden
string      property currentscriptname = "" auto hidden
int         property currentline = 0 auto hidden
int         property totallines = 0 auto hidden
int         property linenum = 1 auto hidden
string[]    property callargs auto hidden
string      property command = "" auto hidden
float       property initialgametime = 0.0 auto hidden
string      property canary_get_var_string = "<^&*0xdeadbeef*&<^" autoreadonly
int         property clrr_invalid = 0 autoreadonly
int         property clrr_advance = 1 autoreadonly
int         property clrr_noadvance = 2 autoreadonly
int         property clrr_return  = 3 autoreadonly
string function clrr_tostring(int _clrr)
endfunction
int         property customresolvetype auto hidden
string      property customresolveunresolvedresult hidden
string function get()
endfunction
function set(string value)
endfunction
endproperty
string      property customresolvestringresult hidden
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
string      property customresolvelabelresult hidden
string function get()
endfunction
function set(string value)
endfunction
endproperty
function invalidatecr()
endfunction
bool        property iscrliteral auto hidden
bool        property iscrbare auto hidden
string function crtostring()
endfunction
bool function crtobool()
endfunction
int function crtoint()
endfunction
float function crtofloat()
endfunction
form function crtoform()
endfunction
string function crtolabel()
endfunction
function setvarfromcustomresult(string varscope, string varname)
endfunction
function setcustomresolvefromvar(string varscope, string varname)
endfunction
bool function iscustomresolvevalidreadable()
endfunction
function setmostrecentfromcustomresolve()
endfunction
int         property mostrecentresulttype auto hidden
string     property mostrecentstringresult hidden
string function get()
endfunction
function set(string value)
endfunction
endproperty
bool        property mostrecentboolresult hidden
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
int         property mostrecentintresult  hidden
int function get()
endfunction
function set(int value)
endfunction
endproperty
float        property mostrecentfloatresult  hidden
float function get()
endfunction
function set(float value)
endfunction
endproperty
form        property mostrecentformresult hidden
form function get()
endfunction
function set(form value)
endfunction
endproperty
string      property mostrecentlabelresult hidden
string function get()
endfunction
function set(string value)
endfunction
endproperty
function invalidatemostrecentresult()
endfunction
int property be_none        = 0 autoreadonly hidden
int property be_if          = 1 autoreadonly hidden
int property be_beginsub    = 2 autoreadonly hidden
int property be_while       = 3 autoreadonly hidden
function setblockendtarget(int betype)
endfunction
function resetblockendtarget()
endfunction
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
string function resolvestring(string token)
endfunction
string function resolvelabel(string token)
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
function resetblockcontext()
endfunction
int function runcommandline(string[] cmdline, int startidx, int endidx, bool subcommand = true)
endfunction
function runscript()
endfunction
string function _slt_islabel(string[] _tokens = none)
endfunction
function sfe(string msg)
endfunction
function sfw(string msg)
endfunction
function sfi(string msg)
endfunction
function sfd(string msg)
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
function slt_pushwhilereturn(int targetline)
endfunction
int function slt_popwhilereturn()
endfunction
bool function hasframevar(string _key)
endfunction
int function getframevartype(string _key)
endfunction
string function getframevarstring(string _key, string missing)
endfunction
string function getframevarlabel(string _key, string missing)
endfunction
bool function getframevarbool(string _key, bool missing)
endfunction
int function getframevarint(string _key, int missing)
endfunction
float function getframevarfloat(string _key, float missing)
endfunction
form function getframevarform(string _key, form missing)
endfunction
string function setframevarstring(string _key, string value)
endfunction
string function setframevarlabel(string _key, string value)
endfunction
bool function setframevarbool(string _key, bool value)
endfunction
int function setframevarint(string _key, int value)
endfunction
float function setframevarfloat(string _key, float value)
endfunction
form function setframevarform(string _key, form value)
endfunction
bool function hasthreadvar(string _key)
endfunction
int function getthreadvartype(string _key)
endfunction
string function getthreadvarstring(string _key, string missing)
endfunction
string function getthreadvarlabel(string _key, string missing)
endfunction
bool function getthreadvarbool(string _key, bool missing)
endfunction
int function getthreadvarint(string _key, int missing)
endfunction
float function getthreadvarfloat(string _key, float missing)
endfunction
form function getthreadvarform(string _key, form missing)
endfunction
string function setthreadvarstring(string _key, string value)
endfunction
string function setthreadvarlabel(string _key, string value)
endfunction
bool function setthreadvarbool(string _key, bool value)
endfunction
int function setthreadvarint(string _key, int value)
endfunction
float function setthreadvarfloat(string _key, float value)
endfunction
form function setthreadvarform(string _key, form value)
endfunction
bool function hastargetvar(string _key)
endfunction
int function gettargetvartype(string typeprefix, string _key)
endfunction
string function gettargetvarstring(string typeprefix, string dataprefix, string _key, string missing)
endfunction
string function gettargetvarlabel(string typeprefix, string dataprefix, string _key, string missing)
endfunction
bool function gettargetvarbool(string typeprefix, string dataprefix, string _key, bool missing)
endfunction
int function gettargetvarint(string typeprefix, string dataprefix, string _key, int missing)
endfunction
float function gettargetvarfloat(string typeprefix, string dataprefix, string _key, float missing)
endfunction
form function gettargetvarform(string typeprefix, string dataprefix, string _key, form missing)
endfunction
string function settargetvarstring(string typeprefix, string dataprefix, string _key, string value)
endfunction
string function settargetvarlabel(string typeprefix, string dataprefix, string _key, string value)
endfunction
bool function settargetvarbool(string typeprefix, string dataprefix, string _key, bool value)
endfunction
int function settargetvarint(string typeprefix, string dataprefix, string _key, int value)
endfunction
float function settargetvarfloat(string typeprefix, string dataprefix, string _key, float value)
endfunction
form function settargetvarform(string typeprefix, string dataprefix, string _key, form value)
endfunction
string function getrequeststring(string _key)
endfunction
bool function getrequestbool(string _key)
endfunction
int function getrequestint(string _key)
endfunction
float function getrequestfloat(string _key)
endfunction
form function getrequestform(string _key)
endfunction
bool function isassignablescope(string varscope)
endfunction
function getvarscope2(string varname, string[] varscope, bool forassignment = false)
endfunction
int function getvartype(string scope, string varname)
endfunction
string function getvarstring2(string scope, string varname, string missing)
endfunction
string function getvarlabel(string scope, string varname, string missing)
endfunction
bool function getvarbool(string scope, string varname, bool missing)
endfunction
int function getvarint(string scope, string varname, int missing)
endfunction
float function getvarfloat(string scope, string varname, float missing)
endfunction
form function getvarform(string scope, string varname, form missing)
endfunction
string function setvarstring2(string scope, string varname, string value)
endfunction
string function setvarlabel(string scope, string varname, string value)
endfunction
bool function setvarbool(string scope, string varname, bool value)
endfunction
int function setvarint(string scope, string varname, int value)
endfunction
float function setvarfloat(string scope, string varname, float value)
endfunction
form function setvarform(string scope, string varname, form value)
endfunction
function precacherequeststring(sl_triggersmain slthost, int requesttargetformid, int requestid, string varname, string value) global
endfunction
function precacherequestbool(sl_triggersmain slthost, int requesttargetformid, int requestid, string varname, bool value) global
endfunction
function precacherequestint(sl_triggersmain slthost, int requesttargetformid, int requestid, string varname, int value) global
endfunction
function precacherequestfloat(sl_triggersmain slthost, int requesttargetformid, int requestid, string varname, float value) global
endfunction
function precacherequestform(sl_triggersmain slthost, int requesttargetformid, int requestid, string varname, form value) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1