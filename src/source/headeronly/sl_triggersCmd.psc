scriptname sl_triggerscmd extends activemagiceffect
string[] function getvarscope(string varname, bool forassignment = false) global native
string[] function getvarscopewithresolution(string varname, bool forassignment = false)
endfunction
sl_triggersmain  property slt auto
actor   property playerref auto
keyword   property actortypenpc auto
keyword   property actortypeundead auto
string function make_kframe_map_prefix()
endfunction
string function make_kframe_list_prefix()
endfunction
string function make_kthread_map_prefix()
endfunction
string function make_kthread_list_prefix()
endfunction
string function make_ktarget_map_prefix(int formid)
endfunction
string function make_ktarget_list_prefix(int formid)
endfunction
string function make_ktarget_v_prefix(int formid)
endfunction
string function make_ktarget_type_v_prefix(int formid)
endfunction
string function make_krequest_v_prefix()
endfunction
actor   property cmdtargetactor hidden
actor function get()
endfunction
function set(actor value)
endfunction
endproperty
int             property cmdtargetformid auto hidden
int         property frameid hidden
int function get()
endfunction
function set(int value)
endfunction
endproperty
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
string[]    property customresolveliststringresult hidden
string[] function get()
endfunction
function set(string[] value)
endfunction
endproperty
string[]    property customresolvelistlabelresult hidden
string[] function get()
endfunction
function set(string[] value)
endfunction
endproperty
bool[]    property customresolvelistboolresult hidden
bool[] function get()
endfunction
function set(bool[] value)
endfunction
endproperty
int[]    property customresolvelistintresult hidden
int[] function get()
endfunction
function set(int[] value)
endfunction
endproperty
float[]    property customresolvelistfloatresult hidden
float[] function get()
endfunction
function set(float[] value)
endfunction
endproperty
form[]    property customresolvelistformresult hidden
form[] function get()
endfunction
function set(form[] value)
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
function setvarfromcustomresult(string[] varscope)
endfunction
function setcustomresolvefromvar(string[] varscope)
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
string[]    property mostrecentliststringresult hidden
string[] function get()
endfunction
function set(string[] value)
endfunction
endproperty
string[]    property mostrecentlistlabelresult hidden
string[] function get()
endfunction
function set(string[] value)
endfunction
endproperty
bool[]    property mostrecentlistboolresult hidden
bool[] function get()
endfunction
function set(bool[] value)
endfunction
endproperty
int[]    property mostrecentlistintresult hidden
int[] function get()
endfunction
function set(int[] value)
endfunction
endproperty
float[]    property mostrecentlistfloatresult hidden
float[] function get()
endfunction
function set(float[] value)
endfunction
endproperty
form[]    property mostrecentlistformresult hidden
form[] function get()
endfunction
function set(form[] value)
endfunction
endproperty
function invalidatemostrecentresult()
endfunction
int property ifnestlevel hidden
int function get()
endfunction
function set(int value)
endfunction
endproperty
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
int function actorracetype(actor _actor)
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
string[] function resolveliststring(string token)
endfunction
bool[] function resolvelistbool(string token)
endfunction
int[] function resolvelistint(string token)
endfunction
float[] function resolvelistfloat(string token)
endfunction
form[] function resolvelistform(string token)
endfunction
string[] function resolvelistlabel(string token)
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
bool function hasframevar(string[] varscope)
endfunction
string function getframemapkey(string[] varscope)
endfunction
string function getframelistkey(string[] varscope)
endfunction
int function getframevartype(string[] varscope)
endfunction
string function getframevarstring(string[] varscope, string missing)
endfunction
string function getframevarlabel(string[] varscope, string missing)
endfunction
bool function getframevarbool(string[] varscope, bool missing)
endfunction
int function getframevarint(string[] varscope, int missing)
endfunction
float function getframevarfloat(string[] varscope, float missing)
endfunction
form function getframevarform(string[] varscope, form missing)
endfunction
function unsetframemapkey(string[] varscope, string mapkey)
endfunction
function setframevartype(string[] varscope, int newtype)
endfunction
string function setframevarstring(string[] varscope, string value)
endfunction
string function setframevarlabel(string[] varscope, string value)
endfunction
bool function setframevarbool(string[] varscope, bool boolvalue)
endfunction
int function setframevarint(string[] varscope, int value)
endfunction
float function setframevarfloat(string[] varscope, float value)
endfunction
form function setframevarform(string[] varscope, form formvalue)
endfunction
bool function hasthreadvar(string[] varscope)
endfunction
string function getthreadmapkey(string[] varscope)
endfunction
string function getthreadlistkey(string[] varscope)
endfunction
int function getthreadvartype(string[] varscope)
endfunction
string function getthreadvarstring(string[] varscope, string missing)
endfunction
string function getthreadvarlabel(string[] varscope, string missing)
endfunction
bool function getthreadvarbool(string[] varscope, bool missing)
endfunction
int function getthreadvarint(string[] varscope, int missing)
endfunction
float function getthreadvarfloat(string[] varscope, float missing)
endfunction
form function getthreadvarform(string[] varscope, form missing)
endfunction
function unsetthreadmapkey(string[] varscope, string mapkey)
endfunction
function setthreadvartype(string[] varscope, int newtype)
endfunction
string function setthreadvarstring(string[] varscope, string value)
endfunction
string function setthreadvarlabel(string[] varscope, string value)
endfunction
bool function setthreadvarbool(string[] varscope, bool boolvalue)
endfunction
int function setthreadvarint(string[] varscope, int value)
endfunction
float function setthreadvarfloat(string[] varscope, float value)
endfunction
form function setthreadvarform(string[] varscope, form formvalue)
endfunction
bool function hastargetvar(string[] varscope)
endfunction
string function gettargetmapkey(string mapprefix, string[] varscope)
endfunction
string function gettargetlistkey(string mapprefix, string[] varscope)
endfunction
int function gettargetvartype(string typeprefix, string mapprefix, string[] varscope)
endfunction
string function gettargetvarstring(string typeprefix, string dataprefix, string mapprefix, string[] varscope, string missing)
endfunction
string function gettargetvarlabel(string typeprefix, string dataprefix, string mapprefix, string[] varscope, string missing)
endfunction
bool function gettargetvarbool(string typeprefix, string dataprefix, string mapprefix, string[] varscope, bool missing)
endfunction
int function gettargetvarint(string typeprefix, string dataprefix, string mapprefix, string[] varscope, int missing)
endfunction
float function gettargetvarfloat(string typeprefix, string dataprefix, string mapprefix, string[] varscope, float missing)
endfunction
form function gettargetvarform(string typeprefix, string dataprefix, string mapprefix, string[] varscope, form missing)
endfunction
function unsettargetmapkey(string mapprefix, string[] varscope, string mapkey)
endfunction
function settargetvartype(string typeprefix, string[] varscope, int newtype)
endfunction
string function settargetvarstring(string typeprefix, string dataprefix, string mapprefix, string[] varscope, string value)
endfunction
string function settargetvarlabel(string typeprefix, string dataprefix, string mapprefix, string[] varscope, string value)
endfunction
bool function settargetvarbool(string typeprefix, string dataprefix, string mapprefix, string[] varscope, bool boolvalue)
endfunction
int function settargetvarint(string typeprefix, string dataprefix, string mapprefix, string[] varscope, int value)
endfunction
float function settargetvarfloat(string typeprefix, string dataprefix, string mapprefix, string[] varscope, float value)
endfunction
form function settargetvarform(string typeprefix, string dataprefix, string mapprefix, string[] varscope, form formvalue)
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
int function getvartype(string[] varscope)
endfunction
string function getmapkey(string[] varscope)
endfunction
string function getvarlistkey(string[] varscope)
endfunction
string function getvarstring(string[] varscope, string missing)
endfunction
string function getvarlabel(string[] varscope, string missing)
endfunction
bool function getvarbool(string[] varscope, bool missing)
endfunction
int function getvarint(string[] varscope, int missing)
endfunction
float function getvarfloat(string[] varscope, float missing)
endfunction
form function getvarform(string[] varscope, form missing)
endfunction
string[] function getvarliststring(string[] varscope)
endfunction
bool[] function getvarlistbool(string[] varscope)
endfunction
int[] function getvarlistint(string[] varscope)
endfunction
float[] function getvarlistfloat(string[] varscope)
endfunction
form[] function getvarlistform(string[] varscope)
endfunction
string[] function getvarlistlabel(string[] varscope)
endfunction
function unsetmapkey(string[] varscope, string mapkey)
endfunction
function setvartype(string[] varscope, int value)
endfunction
string function setvarstring(string[] varscope, string value)
endfunction
string function setvarlabel(string[] varscope, string value)
endfunction
bool function setvarbool(string[] varscope, bool value)
endfunction
int function setvarint(string[] varscope, int value)
endfunction
float function setvarfloat(string[] varscope, float value)
endfunction
form function setvarform(string[] varscope, form value)
endfunction
string[] function setvarliststring(string[] varscope, string[] values)
endfunction
bool[] function setvarlistbool(string[] varscope, bool[] values)
endfunction
int[] function setvarlistint(string[] varscope, int[] values)
endfunction
float[] function setvarlistfloat(string[] varscope, float[] values)
endfunction
form[] function setvarlistform(string[] varscope, form[] values)
endfunction
string[] function setvarlistlabel(string[] varscope, string[] values)
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