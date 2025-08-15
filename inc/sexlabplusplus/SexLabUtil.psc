scriptname sexlabutil hidden
int function getversion() global
endfunction
string function getstringver() global
endfunction
sexlabframework function getapi() global
endfunction
bool function sexlabisactive() global
endfunction
bool function sexlabisready() global
endfunction
sexlabthread function startscene(actor[] akpositions, string astags, actor aksubmissive = none, objectreference akcenter = none, \
int aifurniture = 1, string ashook = "") global
endfunction
sexlabthread function startsceneex(actor[] akpositions, string[] asanims, actor aksubmissive = none, string ascontext = "", objectreference akcenter = none, \
int aifurniture = 1, string ashook = "") global
endfunction
sexlabthread function startscenequick(actor akactor1, actor akactor2 = none, actor akactor3 = none, actor akactor4 = none, actor akactor5 = none, \
actor aksubmissive = none, string astags = "", string ashook = "") global
endfunction
sslsystemconfig function getconfig() global
endfunction
int[] function getversionpack() global
endfunction
bool function haskeywordsub(form objref, string lookfor) global native
function printconsole(string output) global native
actor[] function makeactorarray(actor actor1 = none, actor actor2 = none, actor actor3 = none, actor actor4 = none, actor actor5 = none) global native
float function getcurrentgamerealtime() global native
string[] function mergesplittags(string astags, string astagssuppress, bool abrequireall) global
endfunction
int function startsex(actor[] sexactors, sslbaseanimation[] anims, actor victim = none, objectreference centeron = none, bool allowbed = true, string hook = "") global
endfunction
sslthreadmodel function newthread(float timeout = 30.0) global
endfunction
sslthreadcontroller function quickstart(actor a1, actor a2 = none, actor a3 = none, actor a4 = none, actor a5 = none, actor victim = none, string hook = "", string animationtags = "") global
endfunction
string function actorname(actor actorref) global
endfunction
int function getsex(actor akactor) global
endfunction
bool function isactoractive(actor actorref) global
endfunction
bool function isvalidactor(actor actorref) global
endfunction
bool function hascreature(actor actorref) global
endfunction
bool function hasrace(race raceref) global
endfunction
function vehiclefixmode(int mode) global
endfunction
float function floatifelse(bool istrue, float returntrue, float returnfalse = 0.0) global
endfunction
int function intifelse(bool istrue, int returntrue, int returnfalse = 0) global
endfunction
string function stringifelse(bool istrue, string returntrue, string returnfalse = "") global
endfunction
form function formifelse(bool istrue, form returntrue, form returnfalse = none) global
endfunction
actor function actorifelse(bool istrue, actor returntrue, actor returnfalse = none) global
endfunction
objectreference function objectifelse(bool istrue, objectreference returntrue, objectreference returnfalse = none) global
endfunction
referencealias function aliasifelse(bool istrue, referencealias returntrue, referencealias returnfalse = none) global
endfunction
function log(string msg, string source, string type = "notice", string display = "trace", bool minimal = true) global
endfunction
function debuglog(string log, string type = "notice", bool debugmode = false) global
endfunction
int function getpluginversion() global
endfunction
string function removesubstring(string inputstring, string removestring) global native
int function intminmaxvalue(int[] searcharray, bool findhighestvalue = true) global native
int function intminmaxindex(int[] searcharray, bool findhighestvalue = true) global native
float function floatminmaxvalue(float[] searcharray, bool findhighestvalue = true) global native
int function floatminmaxindex(float[] searcharray, bool findhighestvalue = true) global native
float function getcurrentgametimehours() global
endfunction
float function getcurrentgametimeminutes() global
endfunction
float function getcurrentgametimeseconds() global
endfunction
function wait(float seconds) global
endfunction
float function timer(float timestamp, string log) global
endfunction
int function getgender(actor actorref) global
endfunction
string function makegendertag(actor[] positions) global
endfunction
bool function isimportant(actor actorref, bool strict = false) global
endfunction
string function getgendertag(int females = 0, int males = 0, int creatures = 0) global
endfunction
string function getreversegendertag(int females = 0, int males = 0, int creatures = 0) global
endfunction
bool function isactor(form formref) global
endfunction
function enablefreecamera(bool enabling = true, float sucsm = 5.0) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1