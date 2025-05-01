scriptname adversity hidden 
string[] function getcontextevents(string ascontext) global native
string[] function getcontexttags(string ascontext) global native
string[] function getpacks(string ascontext) global native
bool function getcontextbool(string asid, string askey, bool abdefault = false, bool abpersist = true) global native
bool function setcontextbool(string asid, string askey, bool abvalue, bool abpersist = true) global native
int function getcontextint(string asid, string askey, int aidefault = 0, bool abpersist = true) global native
bool function setcontextint(string asid, string askey, int aivalue, bool abpersist = true) global native
float function getcontextfloat(string asid, string askey, float afdefault = 0.0, bool abpersist = true) global native
bool function setcontextfloat(string asid, string askey, float afvalue, bool abpersist = true) global native
string function getcontextstring(string asid, string askey, string asdefault = "", bool abpersist = true) global native
bool function setcontextstring(string asid, string askey, string asdefault = "", bool abpersist = true) global native
form function getcontextform(string asid, string askey, form akdefault = none, bool abpersist = true) global native
bool function setcontextform(string asid, string askey, form akvalue, bool abpersist = true) global native
string[] function getcontextstringlist(string asid, string askey, string[] asdefault, bool abpersist = true) global native
bool function setcontextstringlist(string asid, string askey,  string[] asdefault, bool abpersist = true) global native
form[] function getcontextformlist(string asid, string askey, form[] akdefault, bool abpersist = true) global native
bool function setcontextformlist(string asid, string askey, form[] akvalue, bool abpersist = true) global native
quest function getpackquest(string aspack) global native
adv_packbase function getpackscript(string aspack) global
endfunction
string[] function getpackevents(string aspack) global native
string function getpackname(string aspack) global native
string function geteventname(string asevent) global native
string function geteventpack(string asevent) global native
string function geteventdesc(string asevent) global native
string[] function geteventtags(string asevent) global native
int function geteventseverity(string asevent) global native
int function geteventstatus(string asevent) global native
bool function seteventstatus(string asevent, int aistatus) global native
string[] function filtereventsbylocation(string[] asevents) global native
string[] function sorteventsbyclosesttoref(string[] asevents, objectreference akref = none) global native
float function geteventcooldown(string asevent) global
endfunction
objectreference[] function geteventtargets(string asevent) global
endfunction
bool function seteventcooldown(string asevent, float afcooldown) global
endfunction
bool function eventhastag(string asevent, string astag) global
endfunction
bool function isexclusive(string asevent) global native
bool function canstart(string asevent) global
endfunction
bool function doeseventexist(string asevent) global
endfunction
bool function iseventactive(string asevent) global
endfunction
bool function iseventenabled(string asevent) global
endfunction
bool function iseventselectable(string asevent) global
endfunction
bool function iseventdisabled(string asevent) global
endfunction
string[] function getconflictingevents(string asevent) global native
bool function geteventbool(string asid, string askey, bool abdefault = false, bool abpersist = true) global native
bool function seteventbool(string asid, string askey, bool abvalue, bool abpersist = true) global native
int function geteventint(string asid, string askey, int aidefault = 0, bool abpersist = true) global native
bool function seteventint(string asid, string askey, int aivalue, bool abpersist = true) global native
float function geteventfloat(string asid, string askey, float afdefault = 0.0, bool abpersist = true) global native
bool function seteventfloat(string asid, string askey, float afvalue, bool abpersist = true) global native
string function geteventstring(string asid, string askey, string asdefault = "", bool abpersist = true) global native
bool function seteventstring(string asid, string askey, string asdefault = "", bool abpersist = true) global native
form function geteventform(string asid, string askey, form akdefault = none, bool abpersist = true) global native
bool function seteventform(string asid, string askey, form akvalue, bool abpersist = true) global native
form[] function geteventformlist(string asid, string askey, form[] akdefault = none, bool abpersist = true) global native
bool function seteventformlist(string asid, string askey, form[] akvalue, bool abpersist = true) global native
function setlock(bool abenable) global native
bool function accquirelock(string asevent) global
endfunction
bool function releaselock(string asevent) global
endfunction
string function getlocker() global
endfunction
bool function islocked() global
endfunction
adv_eventbase function getevent(string asevent) global
endfunction
string[] function filtereventsbystatus(string[] asevents, int aistatus) global native
string[] function filtereventsbyseverity(string[] asevents, int aiseverity, bool abgreater = true, bool abequal = true) global native
string[] function filtereventsbytags(string[] asevents, string[] astags, bool aball = false, bool abinvert = false) global native
string[] function filtereventsbytype(string[] asevents, string astype) global
endfunction
string[] function filtereventsbyvalid(string[] asevents, actor aktarget = none) global native
string[] function filtereventsbycooldown(string[] asevents) global native
int[] function weigheventsbyactor(string ascontext, actor akactor, string[] asevents, int aiweight, bool abdislikes = true, bool abstack = false) global native
bool function enableevent(string asevent) global
endfunction
bool function disableevent(string asevent) global
endfunction
bool function selectevent(string asevent, actor akspeaker = none) global
endfunction
bool function unselectevent(string asevent) global
endfunction
bool function startevent(string asevent, actor aktarget = none) global
endfunction
bool function stopevent(string asevent) global
endfunction
bool function pauseevent(string asevent, actor aktarget = none) global
endfunction
bool function resumeevent(string asevent) global
endfunction
bool function reserveevent(string asevent) global
endfunction
string[] function getselectedevents(string ascontext) global
endfunction
string[] function getactiveevents(string ascontext, string astype) global
endfunction
function clearselectedevents(string ascontext, string astype) global
endfunction
string[] function filtertagsbykey(string[] astags, string askey) global
endfunction
float function getwillpower() global native
float function getresistance() global native
function modresistance(float afdelta) global native
bool function iswillpowerlow() global native
bool function iswillpowerhigh() global native
int function getweightedindex(int[] weights) global native
int[] function sumarrays(int[] aiweights1, int[] aiweights2) global native
string[] function filterbyprefix(string[] asstrs, string asprefix) global native
string[] function removeprefix(string[] asstrs, string asprefix) global native
string function getconfigpath(string ascontext, string aspack = "", string asfile = "config") global
endfunction
armor[] function getdevicesbykeyword(string ascontext, actor akactor, keyword akkwd) global native
armor function getdevicebykeyword(string ascontext, actor akactor, keyword akkwd) global
endfunction
function lockdevicebykeyword(string ascontext, actor akactor, keyword akkwd) global
endfunction
string[] function getoutfits(string ascontext, string asname) global native
string function getnextoutfit(string asvariant, int aitargetseverity) global native
string function getrandomoutfit(string ascontext, string asname) global
endfunction
bool function addvariant(string ascontext, string aspack, string asname, int aiseverity) global native
armor[] function getoutfitpieces(string asid) global native
bool function validateoutfits(string[] asids) global native
int function getoutfitseverity(string asid) global native
string[] function getoutfittags(string asid) global native
bool function outfithastag(string asid, string astag) global
endfunction
string[] function filteroutfitsbyseverity(string[] asids, int aiseverity, bool abgreater = true, bool abequal = true) global native
string[] function filteroutfitsbytags(string[] asids, string[] astags, bool aball = false, bool abinvert = false) global native
int function giveoutfitpieces(actor akactor, string asid) global
endfunction
int function equipoutfitpieces(actor akactor, string asid) global
endfunction
int function swapoutfitpieces(actor akactor, string ascurrent, string asnext, bool abequip = false) global
endfunction
int function removeoutfitpieces(actor akactor, string asid) global
endfunction
string function giverandomoutfit(actor akactor, string ascontext, string asname) global
endfunction
string function equiprandomoutfit(actor akactor, string ascontext, string asname) global
endfunction
int function getnumgroups(string ascontext, string asname) global native ; todo
string[] function gettattoogroup(string ascontext, string asname, int aiindex) global native ; todo
string[] function splittattoo(string astattoo) global
endfunction
string[] function getrandomtattoogroup(string ascontext, string asname) global
endfunction
function applytattoogroup(actor aktarget, string[] asgroup, bool ablocked = false, bool absilent = true) global
endfunction
function removetattoogroup(actor aktarget, string[] asgroup, bool absilent = true) global
endfunction
string[] function gettraits(string ascontext, actor akactor) global native
function initializeactor(string ascontext, actor akactor) global native
actor[] function getactorsbybool(string ascontext, string askey, bool abvalue) global native
bool function getactorbool(string ascontext, actor akactor, string askey, bool abdefault = false) global native
bool function setactorbool(string ascontext, actor akactor, string askey, bool abvalue) global native
int function getactorint(string ascontext, actor akactor, string askey, int aidefault = 0) global native
bool function setactorint(string ascontext, actor akactor, string askey, int aivalue) global native
float function getactorfloat(string ascontext, actor akactor, string askey, float afdefault = 0.0) global native
bool function setactorfloat(string ascontext, actor akactor, string askey, float afvalue) global native
string function getactorstring(string ascontext, actor akactor, string askey, string asdefault = "") global native
bool function setactorstring(string ascontext, actor akactor, string askey, string asdefault = "") global native
form function getactorform(string ascontext, actor akactor, string askey, form akdefault = none) global native
bool function setactorform(string ascontext, actor akactor, string askey, form akvalue) global native
;This file was cleaned with PapyrusSourceHeadliner 1