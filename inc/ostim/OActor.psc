scriptname oactor
float function getexcitement(actor act) global native
function setexcitement(actor act, float excitement) global native
function modifyexcitement(actor act, float excitement, bool respectmultiplier = false) global native
float function getexcitementmultiplier(actor act) global native
function setexcitementmultiplier(actor act, float multiplier) global native
function stallclimax(actor act) global native
function permitclimax(actor act) global native
bool function isclimaxstalled(actor act, bool checkthread = true) global native
function climax(actor act, bool ignorestall = false) global native
int function gettimesclimaxed(actor act) global native
function setexpressionsenabled(actor act, bool enabled, bool allowoverride = true) global native
float function playexpression(actor act, string expression) global native
function clearexpression(actor act) global native
bool function hasexpressionoverride(actor act) global native
function mute(actor act) global native
function unmute(actor act) global native
bool function ismuted(actor act) global native
function undress(actor act) global native
function redress(actor act) global native
function undresspartial(actor act, int mask) global native
function redresspartial(actor act, int mask) global native
function removeweapons(actor act) global native
function addweapons(actor act) global native
bool function equipobject(actor act, string type) global native
function unequipobject(actor act, string type) global native
bool function isobjectequipped(actor act, string type) global native
bool function setobjectvariant(actor act, string type, string variant, float duration = 0.0) global native
function unsetobjectvariant(actor act, string type) global native
bool function autotransition(actor act, string type) global native
bool function hasmetadata(actor act, string metadata) global native
function addmetadata(actor act, string metadata) global native
string[] function getmetadata(actor act) global native
bool function hasmetafloat(actor act, string metaid) global native
float function getmetafloat(actor act, string metaid) global native
function setmetafloat(actor act, string metaid, float value) global native
bool function hasmetastring(actor act, string metaid) global native
string function getmetastring(actor act, string metaid) global native
function setmetastring(actor act, string metaid, string value) global native
bool function isinostim(actor act) global native
int function getsceneid(actor act) global native
bool function verifyactors(actor[] actors) global native
function updateexpression(actor act) global
endfunction
bool function hasschlong(actor act) global
endfunction
actor[] function sortactors(actor[] actors, int playerindex = -1) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1