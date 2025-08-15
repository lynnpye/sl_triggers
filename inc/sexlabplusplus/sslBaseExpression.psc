scriptname sslbaseexpression extends sslbaseobject
int function getversion(string asid) native global
bool function getenabled(string asid) native global
function setenabled(string asid, bool abenabled) native global
int function getexpressionscalemode(string asid) native global
function setexpressionscalemode(string asid, int aiidx) native global
string[] function getexpressiontags(string asid) native global
function setexpressiontags(string asid, string[] asnewtags) native global
int[] function getlevelcounts(string asid) native global
float[] function getvalues(string asid, bool abfemale, float afstrength) native global
float[] function getnthvalues(string asid, bool abfemale, int n) native global
function setvalues(string asid, bool abfemale, int ailevel, float[] afvalues) native global
float function getmodifier(actor actorref, int id) global native
float function getphoneme(actor actorref, int id) global native
float function getexpression(actor actorref, bool getid) global native
function applyexpression(string asexpression, actor akactor, float afstrength) global
endfunction
function clearphoneme(actor actorref) global
endfunction
function clearmodifier(actor actorref) global
endfunction
function clearmfg(actor actorref) global
endfunction
function openmouth(actor actorref) global
endfunction
function closemouth(actor actorref) global
endfunction
bool function ismouthopen(actor actorref) global
endfunction
float[] function getcurrentmfg(actor actorref) global
endfunction
bool function createemptyprofile(string asid) native global
function saveexpression(string asid) native global
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
function applypresetfloats(actor actorref, float[] preset) global
endfunction
int property male       = 0 autoreadonly
int property female     = 1 autoreadonly
int property malefemale = -1 autoreadonly
int property phoneme  = 0 autoreadonly
int property modifier = 16 autoreadonly
int property mood     = 30 autoreadonly
int property phonemeids  = 15 autoreadonly
int property modifierids = 13 autoreadonly
int[] property phasecounts hidden
int[] function get()
endfunction
endproperty
int property phasesmale hidden
int function get()
endfunction
endproperty
int property phasesfemale hidden
int function get()
endfunction
endproperty
function apply(actor actorref, int strength, int gender)
endfunction
function applyphase(actor actorref, int phase, int gender)
endfunction
int function pickphase(int strength, int gender)
endfunction
float[] function selectphase(int strength, int gender)
endfunction 
function transitpresetfloats(actor actorref, float[] frompreset, float[] topreset, float speed = 1.0, float time = 1.0) global 
endfunction
function applypresetfloatslegacy(actor actorref, float[] preset, bool ismouthopen) global 
endfunction
function setindex(int phase, int gender, int mode, int id, int value)
endfunction
function setpreset(int phase, int gender, int mode, int id, int value)
endfunction
function setmood(int phase, int gender, int id, int value)
endfunction
function setmodifier(int phase, int gender, int id, int value)
endfunction
function setphoneme(int phase, int gender, int id, int value)
endfunction
function emptyphase(int phase, int gender)
endfunction
function addphase(int phase, int gender)
endfunction
bool function hasphase(int phase, actor actorref)
endfunction
float[] function getphonemes(int phase, int gender)
endfunction
float[] function getmodifiers(int phase, int gender)
endfunction
int function getmoodtype(int phase, int gender)
endfunction
int function getmoodamount(int phase, int gender)
endfunction
int function getindex(int phase, int gender, int mode, int id)
endfunction
int property moodids = 16 autoreadonly
function countphases()
endfunction
float[] function genderphase(int phase, int gender)
endfunction
function setphase(int phase, int gender, float[] preset)
endfunction
int function validatepreset(float[] preset)
endfunction
string property file hidden
string function get()
endfunction
endproperty
bool function importjson()
endfunction
bool function exportjson()
endfunction
function save(int id = -1)
endfunction
function applyto(actor actorref, int strength = 50, bool isfemale = true, bool openmouth = false)
endfunction
int[] function getphase(int phase, int gender)
endfunction
int[] function pickpreset(int strength, bool isfemale)
endfunction
int function calcphase(int strength, bool isfemale)
endfunction
function applypreset(actor actorref, int[] preset) global
endfunction
int[] function tointarray(float[] floatarray) global
endfunction
float[] function tofloatarray(int[] intarray) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1