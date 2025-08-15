scriptname sexlabregistry hidden
int function getraceid(actor akactor) native global
int function mapracekeytoid(string asracekey) native global
int[] function getraceida(actor akactor) native global
int[] function mapracekeytoida(string asracekey) native global
string function getracekey(actor akactor) native global
string function getracekeybyrace(race akrace) native global
string function mapraceidtoracekey(int airaceid) native global
string[] function getracekeya(actor akactor) native global
string[] function getracekeybyracea(race akrace) native global
string[] function mapraceidtoracekeya(int airaceid) native global
string[] function getallracekeys(bool abignoreambiguous) native global
int function getsex(actor akactor, bool abignoreoverwrite) native global
string[] function lookupscenes(actor[] akpositions, string astags, actor aksubmissive, int aifurniturepreference, objectreference akcenter) native global
string[] function lookupscenesa(actor[] akpositions, string astags, actor[] aksubmissives, int aifurniturepreference, objectreference akcenter) native global
bool function validatescene(string assceneid, actor[] akpositions, string astags, actor aksubmissive) native global
bool function validatescenea(string assceneid, actor[] akpositions, string astags, actor[] aksubmissives) native global
string[] function validatescenes(string[] assceneids, actor[] akpositions, string astags, actor aksubmissive) native global
string[] function validatescenesa(string[] assceneids, actor[] akpositions, string astags, actor[] aksubmissive) native global
bool function sortbyscene(actor[] akpositions, actor aksubmissive, string asscene) native global
bool function sortbyscenea(actor[] akpositions, actor[] aksubmissives, string asscene) native global
int function sortbysceneex(actor[] akpositions, actor aksubmissive, string[] asscenes) native global
int function sortbysceneexa(actor[] akpositions, actor[] aksubmissives, string[] asscenes) native global
string function getscenebyname(string asname) native global
bool function sceneexists(string asid) native global
string[] function sceneexista(string[] assceneids) native global
bool function stageexists(string asid, string asstage) native global
bool function issceneenabled(string asid) native global
function setsceneenabled(string asid, bool abenabled) native global
string function getscenename(string asid) native global
bool function iscompatiblecenter(string asid, objectreference akcenter) native global
bool function isscenetag(string asid, string astag) native global
bool function isscenetaga(string asid, string[] astags) native global
bool function isstagetag(string asid, string asstage, string astag) native global
bool function isstagetaga(string asid, string asstage, string[] astags) native global
string[] function getscenetags(string asid) native global
string[] function getstagetags(string asid, string asstage) native global
string[] function getcommontags(string[] asids) native global
string function getanimationevent(string asid, string asstage, int n) native global
string[] function getanimationeventa(string asid, string asstage) native global
string function getstartanimation(string asid) native global
int function getnumstages(string asid) native global
string[] function getallstages(string asid) native global
string function branchto(string asid, string asstage, int n) native global
int function getnumbranches(string asid, string asstage) native global
int function getnodetype(string asid, string asstage) native global
string[] function getpathmin(string asid, string asstage) native global
string[] function getpathmax(string asid, string asstage) native global
string[] function getendingstages(string asid) native global
string[] function getfixedlengthstages(string asid) native global
float function getfixedlength(string asid, string asstage) native global
string[] function getclimaxstages(string asid, int n = -1) native global
int[] function getclimaxingactors(string asid, string asstage) native global
int function getactorcount(string asid) native global
bool function issimilarposition(string asid, int n, int m) native global
bool function canfillposition(string asid, int n, actor akactor) native global
int function getpositionsex(string asid, int n) native global
int[] function getpositionsexa(string asid) native global
bool function getismaleposition(string asid, int n) global
endfunction
bool function getisfemaleposition(string asid, int n) global
endfunction
bool function getisfutapositon(string asid, int n) global
endfunction
bool function getiscreaturepositon(string asid, int n) global
endfunction
bool function getismalecreaturepositon(string asid, int n) global
endfunction
bool function getisfemalecreaturepositon(string asid, int n) global
endfunction
int function getraceidposition(string asid, int n) native global
int[] function getraceidpositiona(string asid) native global
string function getracekeyposition(string asid, int n) native global
string[] function getracekeypositiona(string asid) native global
int function getstripdata(string asid, string asstage, int n) native global
int[] function getstripdataa(string asid, string asstage) native global
float[] function getsceneoffset(string asid) native global
float[] function getsceneoffsetraw(string asid) native global
function setsceneoffset(string asid, float afvalue, int aioffsetid) native global
function setsceneoffseta(string asid, float[] afnewoffset) native global
function resetsceneoffset(string asid) native global
float[] function getstageoffset(string asid, string asstage, int n) native global
float[] function getstageoffsetraw(string asid, string asstage, int n) native global
function setstageoffset(string asid, string asstage, int n, float afvalue, int aioffsetid) native global
function setstageoffseta(string asid, string asstage, int n, float[] afnewoffset) native global
function resetstageoffset(string asid, string asstage, int n) native global
function resetstageoffseta(string asid, string asstage) native global
bool function hassceneannotation(string asid, string astag) native global
function removesceneannotation(string asid, string astag) native global
function addsceneannotation(string asid, string astag) native global
string[] function getsceneannotations(string asid) native global
bool function haspositionannotation(string asid, int n, string astag) native global
function removepositionannotation(string asid, int n, string astag) native global
function addpositionannotation(string asid, int n, string astag) native global
string[] function getpositionannotations(string asid, int n) native global
;This file was cleaned with PapyrusSourceHeadliner 1