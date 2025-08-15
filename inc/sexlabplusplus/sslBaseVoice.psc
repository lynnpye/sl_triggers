scriptname sslbasevoice extends sslbaseobject
bool function getenabled(string asid) native global
function setenabled(string asid, bool abenabled) native global
string[] function getvoicetags(string asid) native global
int function getcompatiblesex(string asid) native global
string[] function getcompatibleraces(string asid) native global
sound function getsoundobject(string asid, int aistrength, string asscene, int aipositionidx, bool abmuffled) native global
sound function getorgasmsound(string asid, string asscene, int aipositionidx, bool abmuffled) native global
function playsound(actor akactor, sound aksound, float afstrength, bool absynclips) global
endfunction
string function getdisplayname(string asid) native global
bool function initializevoiceobject(string asid) native global
function finalizevoiceobject(string asid) native global
int property soundidx_hot    = 0 autoreadonly hidden
int property soundidx_mild   = 1 autoreadonly hidden
int property soundidx_medium = 2 autoreadonly hidden
sound function getsoundobjectleg(string asid, int aiidx) native global
function setsoundobjectleg(string asid, int aiidx, sound aset) native global
function setvoicetags(string asid, string[] asnewtags) native global
function setcompatiblesex(string asid, int aset) native global
function setcompatibleraces(string asid, string[] aset) native global
string function _getregistryid()
endfunction
function _setregistryid(string asset)
endfunction
string function _getname()
endfunction
bool function _getenabled()
endfunction
function _setenabled(bool abenabled)
endfunction
string[] function _gettags()
endfunction
function _settags(string[] asset)
endfunction
function movelips(actor actorref, sound soundref = none, float strength = 1.0) global
endfunction
function movelipsex(actor actorref, sound soundref = none, float strength = 1.0, int soundcut = 0, float movetime = 0.2, int phoneme = 1, int minvalue = 20, int maxvalue = 50, bool isfixedvalue = false, bool usemfg = false) global
endfunction
sound property hot
sound function get()
endfunction
function set(sound aset)
endfunction
endproperty
sound property mild
sound function get()
endfunction
function set(sound aset)
endfunction
endproperty
sound property medium
sound function get()
endfunction
function set(sound aset)
endfunction
endproperty
topic property lipsync hidden
topic function get()
endfunction
endproperty
string[] property racekeys hidden
string[] function get()
endfunction
function set(string[] aset)
endfunction
endproperty
int property gender hidden
int function get()
endfunction
function set(int aset)
endfunction
endproperty
bool property male hidden
bool function get()
endfunction
endproperty
bool property female hidden
bool function get()
endfunction
endproperty
bool property creature hidden
bool function get()
endfunction
endproperty
function playmoan(actor actorref, int strength = 30, bool isvictim = false, bool uselipsync = false)
endfunction
function playmoanex(actor actorref, int strength = 30, bool isvictim = false, bool uselipsync = false, int soundcut = 0, float movetime = 0.2, int phoneme = 1, int minvalue = 20, int maxvalue = 50, bool isfixedvalue = false, bool usemfg = false)
endfunction
function moan(actor actorref, int strength = 30, bool isvictim = false) ;deprecated
endfunction
function moannowait(actor actorref, int strength = 30, bool isvictim = false, float volume = 1.0) ;deprecated
endfunction
sound function getsound(int strength, bool isvictim = false)
endfunction
function lipsync(actor actorref, int strength, bool forceuse = false)
endfunction
function transitup(actor actorref, int from, int to) global
endfunction
function transitdown(actor actorref, int from, int to) global
endfunction
bool function checkgender(int checkgender)
endfunction
function setracekeys(string racelist)
endfunction
function addracekey(string racekey)
endfunction
bool function hasracekey(string racekey)
endfunction
bool function hasracekeymatch(string[] racelist)
endfunction
function save(int id = -1)
endfunction
function initialize()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1