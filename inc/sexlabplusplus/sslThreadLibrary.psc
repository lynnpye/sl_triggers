scriptname sslthreadlibrary extends sslsystemlibrary
int property bedtype_none = 0 autoreadonly
int property bedtype_bedroll = 1 autoreadonly
int property bedtype_single = 2 autoreadonly
int property bedtype_double = 3 autoreadonly
objectreference[] function findbeds(objectreference akcenterref, float afradius = 4096.0, float afradiusz = 512.0) native global
int function getbedtypeimpl(objectreference akreference) native global
bool function isbed(objectreference akreference) native global
int function getbedtype(objectreference bedref)
endfunction
bool function isbedroll(objectreference bedref)
endfunction
bool function isdoublebed(objectreference bedref)
endfunction
bool function issinglebed(objectreference bedref)
endfunction
bool function isbedavailable(objectreference bedref)
endfunction
objectreference function findbed(objectreference centerref, float radius = 1000.0, bool ignoreused = true, objectreference ignoreref1 = none, objectreference ignoreref2 = none)
endfunction
objectreference function getnearestunusedbed(objectreference akcenterref, float afradius)
endfunction
actor[] function sortactors(actor[] positions, bool femalefirst = true)
endfunction
bool function islessergender(int i, int n, bool abfemalefirst)
endfunction
actor[] function sortactorsbyanimationimpl(string assceneid, actor[] akpositions, actor[] akvictims) native
actor[] function sortactorsbyanimation(actor[] positions, sslbaseanimation animation = none)
endfunction
actor[] function findavailableactors(objectreference centerref, float radius = 5000.0, int findgender = -1, actor ignoreref1 = none, actor ignoreref2 = none, actor ignoreref3 = none, actor ignoreref4 = none, string racekey = "") native
actor function findavailableactor(objectreference centerref, float radius = 5000.0, int findgender = -1, actor ignoreref1 = none, actor ignoreref2 = none, actor ignoreref3 = none, actor ignoreref4 = none, string racekey = "") native
actor function findavailableactorinfaction(faction factionref, objectreference centerref, float radius = 5000.0, int findgender = -1, actor ignoreref1 = none, actor ignoreref2 = none, actor ignoreref3 = none, actor ignoreref4 = none, bool hasfaction = true, string racekey = "", bool justsamefloor = false) native
actor function findavailableactorwornform(int slotmask, objectreference centerref, float radius = 5000.0, int findgender = -1, actor ignoreref1 = none, actor ignoreref2 = none, actor ignoreref3 = none, actor ignoreref4 = none, bool avoidnostripkeyword = true, bool haswornform = true, string racekey = "", bool justsamefloor = false) native
actor[] function findavailablepartners(actor[] positions, int total, int males = -1, int females = -1, float radius = 10000.0) native
actor[] function findanimationpartnersimpl(string asanimid, objectreference akcenterref, float afradius, actor[] akincludes) native
actor[] function findanimationpartners(sslbaseanimation animation, objectreference centerref, float radius = 5000.0, actor includedref1 = none, actor includedref2 = none, actor includedref3 = none, actor includedref4 = none)
endfunction
function trackactorimpl(actor akactor, string ascallback, bool abtrack) native global
function trackfactionimpl(faction akfaction, string ascallback, bool abtrack) native global
bool function isactortrackedimpl(actor akactor) native global
string[] function getalltrackingevents(actor aktrackedactor, string ashook) native global
function sendtrackingevents(actor akactor, string ashook, int aiid) global
endfunction
function maketrackingevent(actor akactor, string ascallback, int aiid) global
endfunction
keyword property furniturebedroll auto
formlist property bedslist auto
formlist property doublebedslist auto
formlist property bedrollslist auto
bool function samefloor(objectreference bedref, float z, float tolerance = 15.0)
endfunction
bool function checkactor(actor checkref, int checkgender = -1)
endfunction
int function findnext(actor[] positions, sslbaseanimation animation, int offset, bool findcreature)
endfunction
bool function checkbed(objectreference bedref, bool ignoreused = true)
endfunction
bool function leveledangle(objectreference objectref, float tolerance = 5.0)
endfunction
actor[] function sortcreatures(actor[] positions, sslbaseanimation animation = none)
endfunction
function trackactor(actor actorref, string callback)
endfunction
function trackfaction(faction factionref, string callback)
endfunction
function untrackactor(actor actorref, string callback)
endfunction
function untrackfaction(faction factionref, string callback)
endfunction
bool function isactortracked(actor actorref)
endfunction
function sendtrackedevent(actor actorref, string hook = "", int id = -1)
endfunction
function setupactorevent(actor actorref, string callback, int id = -1)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1