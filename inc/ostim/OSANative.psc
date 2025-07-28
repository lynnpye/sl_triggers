scriptname osanative
int function getsex(actorbase base) global native
race function getrace(actorbase base) global native
voicetype function getvoicetype(actorbase base) global native
actorbase function getleveledactorbase(actor act) global native
actor[] function getactors(objectreference centerref = none, float radius = 0.0) global native
function setpositionex(actor act, float x, float y, float z) global native
actor function getactorfrombase(actorbase act) global native
actorbase[] function lookuprelationshippartners(actor firstactor, associationtype relationshiptype) global native
actor[] function sortactorsbydistance(objectreference from, actor[] actors) global native
actor[] function removeactorswithgender(actor[] actors, int gender) global native
form[] function getequippedammo(actor act) global native
bool function iswig(actor act, armor item) global native
function setfacelight (string stateval, actor act, string light) global native
function applyfacelight (string stateval, actor act) global
endfunction
function firedebugoption(string stateval) global
endfunction
function firedebugactoroption(string stateval, actor act) global 
endfunction
function control(int direction, int glyph) global native
function endplayerdialogue() global native
bool function setface(actor act, int mode, int id, int value) global native
int function getface(actor act, int mode, int id) global native
bool function resetface(actor act) global
endfunction
bool function setfacephoneme(actor act, int id, int value) global
endfunction
bool function setfacemodifier(actor act, int id, int value) global
endfunction
int function getfacephoneme(actor act, int id) global
endfunction
int function getfacemodifier(actor act, int id) global
endfunction
int function getfaceexpression(actor act) global
endfunction
int function getfaceexpressionid(actor act) global
endfunction
int function getformid(form formref) global native
float function getweight(form formref) global native
string function getname(form formref) global native
string function getdisplayname(objectreference objectref) global native
objectreference[] function findbed(objectreference centerref, float radius = 1000.0, float samefloor = 0.0) global native
float[] function getcoords(objectreference objectref) global native
float function getscalefactor(objectreference objectref) global native
objectreference function getlocationmarker(location loc) global native
form[] function removeformsbelowvalue(form[] forms, int goldvalue) global native
function addactor(int stageid, actor act) global native
function removeactor(int stageid) global native
function togglecombat(bool a_enable) global native
bool function detectionactive() global native
function printconsole(string a_str) global native
int function randomint(int min = 0, int max = 100) global native
float function randomfloat(float min = 0.0, float max = 1.0) global native
function sendevent(form formref, string evnt) global native
bool function trylock(string a_lock) global native
function unlock(string a_lock) global native
string function translate(string a_key) global native
function setlocale(string a_locale = "") global native
string function getsceneidfromanimid(string id) global native
int function getspeedfromanimid(string id) global native
string function getanimclass(string id) global native
function setglyph(int glyph) global native
;This file was cleaned with PapyrusSourceHeadliner 1