scriptname sslbasevoice extends sslbaseobject
sound property hot auto
sound property mild auto
sound property medium auto
topic property lipsync auto hidden
string[] property racekeys auto hidden
int property gender auto hidden
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
function movelips(actor actorref, sound soundref = none, float strength = 1.0) global
endfunction
function movelipsex(actor actorref, sound soundref = none, float strength = 1.0, int soundcut = 0, float movetime = 0.2, int phoneme = 1, int minvalue = 20, int maxvalue = 50, bool isfixedvalue = false, bool usemfg = false) global
endfunction
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