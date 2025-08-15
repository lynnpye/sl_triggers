scriptname sslexpressionslots extends quest
int property status_none     = 0 autoreadonly hidden
int property status_submissive  = 1 autoreadonly hidden
int property status_dominant  = 2 autoreadonly hidden
string[] function getallprofileids() native global
string[] function getexpressionsbystatus(actor akactor, int aivictimstatus) native global
string[] function getexpressionsbytags(actor akactor, string astags) native global
string[] property registry
string[] function get()
endfunction
endproperty
int property slotted hidden
int function get()
endfunction
endproperty
sslbaseexpression[] property expressions hidden
sslbaseexpression[] function get()
endfunction
endproperty
function syncbackend()
endfunction
actor property playerref
actor function get()
endfunction
endproperty
sslsystemconfig property config
sslsystemconfig function get()
endfunction
endproperty
sslbaseexpression function pickexpression(actor actorref, actor victimref = none)
endfunction
sslbaseexpression function pickbystatus(actor actorref, bool isvictim = false, bool isaggressor = false)
endfunction
sslbaseexpression[] function getbystatus(actor actorref, bool isvictim = false, bool isaggressor = false)
endfunction
sslbaseexpression function randombytag(string tag, bool forfemale = true)
endfunction
sslbaseexpression[] function getbytag(string tag, bool forfemale = true)
endfunction
sslbaseexpression function selectrandom(bool[] valid)
endfunction
sslbaseexpression[] function getlist(bool[] valid)
endfunction
string[] function getnames(sslbaseexpression[] slotlist)
endfunction
sslbaseexpression function getbyslot(int index)
endfunction
bool function isregistered(string registrar)
endfunction
int function findbyregistrar(string registrar)
endfunction
int function findbyname(string findname)
endfunction
sslbaseexpression function getbyname(string findname)
endfunction
sslbaseexpression function getbyregistrar(string registrar)
endfunction
int function pagecount(int perpage = 125)
endfunction
int function findpage(string registrar, int perpage = 125)
endfunction
string[] function getslotnames(int page = 1, int perpage = 125)
endfunction
sslbaseexpression[] function getslots(int page = 1, int perpage = 125)
endfunction
int function findempty()
endfunction
int function register(string registrar)
endfunction
sslbaseexpression function registerexpression(string registrar, form callbackform = none, referencealias callbackalias = none)
endfunction
function registerslots()
endfunction
bool function unregisterexpression(string registrar)
endfunction
function setup()
endfunction
bool function testslots()
endfunction
function log(string msg)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1