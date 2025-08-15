scriptname sslanimationslots extends quest
string[] function createproxyarray(int aireturnsize, int aionlycreatures, string astags = "", string aspackage = "") native global
string[] function getallpackages() native global
int property slotted hidden
int function get()
endfunction
function set(int aset)
endfunction
endproperty
actor property playerref hidden
actor function get()
endfunction
function set(actor aset)
endfunction
endproperty
sslsystemconfig property config hidden
sslsystemconfig function get()
endfunction
function set(sslsystemconfig aset)
endfunction
endproperty
sslactorlibrary property actorlib hidden
sslactorlibrary function get()
endfunction
function set(sslactorlibrary aset)
endfunction
endproperty
sslthreadlibrary property threadlib hidden
sslthreadlibrary function get()
endfunction
function set(sslthreadlibrary aset)
endfunction
endproperty
string[] function getbytagsimpl(int aiactorcount, string[] astags) native
string[] function getbytypeimpl(int aiactorcount, int aimales, int aifemales, string[] astags) native
string[] function pickbyactorsimpl(actor[] akactors, string[] astags) native
function syncbackend()
endfunction
sslbaseanimation function getsetanimation(string asscene)
endfunction
sslbaseanimation[] function asbaseanimation(string[] assceneids)
endfunction
sslbaseanimation[] function getbytags(int actorcount, string tags, string tagssuppressed = "", bool requireall = true)
endfunction
sslbaseanimation[] function getbycommontags(int actorcount, string commontags, string tags, string tagssuppressed = "", bool requireall = true)
endfunction
sslbaseanimation[] function getbytype(int actorcount, int males = -1, int females = -1, int stagecount = -1, bool aggressive = false, bool sexual = true)
endfunction
sslbaseanimation[] function pickbyactors(actor[] positions, int limit = 64, bool aggressive = false)
endfunction
sslbaseanimation[] function getbydefault(int males, int females, bool isaggressive = false, bool usingbed = false, bool restrictaggressive = true)
endfunction
sslbaseanimation[] function getbydefaulttags(int males, int females, bool isaggressive = false, bool usingbed = false, bool restrictaggressive = true, string tags, string tagssuppressed = "", bool requireall = true)
endfunction
sslbaseanimation function getbyslot(int index)
endfunction
sslbaseanimation function getbyname(string findname)
endfunction
sslbaseanimation function getbyregistrar(string registrar)
endfunction
int function findbyregistrar(string registrar)
endfunction
int function findbyname(string findname)
endfunction
bool function isregistered(string registrar)
endfunction
sslbaseanimation[] function getlist(bool[] valid)
endfunction
string[] function getnames(sslbaseanimation[] slotlist)
endfunction
int function counttag(sslbaseanimation[] anims, string tags)
endfunction
int function getcount(bool ignoredisabled = true)
endfunction
int function findfirsttagged(string tags, bool ignoredisabled = true, bool reverse = false)
endfunction
int function counttagusage(string tags, bool ignoredisabled = true)
endfunction
string[] function getalltags(int actorcount = -1, bool ignoredisabled = true)
endfunction
function clearanimcache()
endfunction
bool function validatecache()
endfunction
bool function iscached(string cachename)
endfunction
sslbaseanimation[] function checkcache(string cachename)
endfunction
function cacheanims(string cachename, sslbaseanimation[] anims)
endfunction
sslbaseanimation[] function getcacheslot(int i)
endfunction
int function oldestcache()
endfunction
function invalidatebyanimation(sslbaseanimation removing)
endfunction
function invalidatebytags(string tags)
endfunction
function invalidatebyslot(int i)
endfunction
string function cacheinfo(int i)
endfunction
function outputcachelog()
endfunction
int function pagecount(int perpage = 125)
endfunction
int function findpage(string registrar, int perpage = 125)
endfunction
string[] function getslotnames(int page = 1, int perpage = 125)
endfunction
sslbaseanimation[] function getslots(int page = 1, int perpage = 125)
endfunction
function registerslots()
endfunction
int function register(string registrar)
endfunction
sslbaseanimation function registeranimation(string registrar, form callbackform = none, referencealias callbackalias = none)
endfunction
bool function unregisteranimation(string registrar)
endfunction
bool function issuppressed(string registrar)
endfunction
function neverregister(string registrar)
endfunction
function allowregister(string registrar)
endfunction
int function clearsuppressed()
endfunction
int function getdisabledcount()
endfunction
int function getsuppressedcount()
endfunction
int function suppressdisabled()
endfunction
string[] function getsuppressedlist()
endfunction
function preloadcategoryloaders()
endfunction
string property jloaders hidden
string function get()
endfunction
function set(string aset)
endfunction
endproperty
event oninit()
endevent
int function getcrtspecifier()
endfunction
function setup()
endfunction
string property cacheid hidden
string function get()
endfunction
function set(string aset)
endfunction
endproperty
string[] function gettagcache(bool ignorecache = false)
endfunction
bool function hastagcache(string tag ,bool ignorecache = false)
endfunction
function cleartagcache()
endfunction
function docache()
endfunction
function log(string msg)
endfunction
bool function testslots()
endfunction
sslbaseanimation[] function removetagged(sslbaseanimation[] anims, string tags)
endfunction
sslbaseanimation[] function mergelists(sslbaseanimation[] list1, sslbaseanimation[] list2)
endfunction
bool[] function findtagged(sslbaseanimation[] anims, string tags)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1