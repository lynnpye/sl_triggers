scriptname sslcreatureanimationslots extends sslanimationslots
string function getracekey(race raceref) global
endfunction
race function getracebyeditorid(string aseditorid) global native
string function getracekeybyid(string raceid) global
endfunction
bool function hasraceidtype(string raceid) global
endfunction
function addraceid(string racekey, string raceid) global
endfunction
bool function hasraceid(string racekey, string raceid) global
endfunction
bool function hasracekey(string racekey) global
endfunction
bool function clearracekey(string racekey) global
endfunction
bool function hascreaturetype(actor actorref) global
endfunction
bool function hasracetype(race raceref) global
endfunction
string[] function getallracekeys(race raceref = none) global
endfunction
string[] function getallraceids(string racekey) global native
race[] function getallraces(string racekey) global native
string[] function getbyracekeytagsimpl(int aiactorcount, string asracekey, string[] astags) native
string[] function getbycreatureactorstagsimpl(int aiactorcount, actor[] akcreatures, string[] astags) native
string[] function getbyracegenderstagsimpl(int aiactorcount, string asracekey, int aimalecrt, int aifemalecrt, string[] astags) native
sslbaseanimation[] function getbyrace(int actorcount, race raceref)
endfunction
sslbaseanimation[] function getbyracetags(int actorcount, race raceref, string tags, string tagssuppressed = "", bool requireall = true)
endfunction
sslbaseanimation[] function getbyracekey(int actorcount, string racekey)
endfunction
sslbaseanimation[] function getbyracekeytags(int actorcount, string racekey, string tags, string tagssuppressed = "", bool requireall = true)
endfunction
sslbaseanimation[] function getbycreatureactors(int actorcount, actor[] positions)
endfunction
sslbaseanimation[] function getbycreatureactorstags(int actorcount, actor[] positions, string tags, string tagssuppressed = "", bool requireall = true)
endfunction
sslbaseanimation[] function getbyracegenders(int actorcount, race raceref, int malecreatures = 0, int femalecreatures = 0, bool forceuse = false)
endfunction
sslbaseanimation[] function getbyracegenderstags(int actorcount, race raceref, int malecreatures = 0, int femalecreatures = 0, string tags, string tagssuppressed = "", bool requireall = true)
endfunction
sslbaseanimation[] function filtercreaturegenders(sslbaseanimation[] anims, int malecreatures = 0, int femalecreatures = 0)
endfunction
bool function racehasanimation(race raceref, int actorcount = -1, int gender = -1)
endfunction
bool function racekeyhasanimation(string racekey, int actorcount = -1, int gender = -1)
endfunction
bool function hascreature(actor actorref)
endfunction
bool function hasrace(race raceref)
endfunction
bool function allowedcreature(race raceref)
endfunction
bool function allowedcreaturecombination(race raceref1, race raceref2)
endfunction
bool function allowedracekeycombination(string[] keys1, string[] keys2)
endfunction
bool function hasanimation(race raceref, int gender = -1)
endfunction
int function getcrtspecifier()
endfunction
function setup()
endfunction
function registerslots()
endfunction
function registerraces()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1