scriptname outils
osexintegrationmain function getostim() global
endfunction
function console(string in) global
endfunction
int function gettimeofday() global ; 0 - day | 1 - morning/dusk | 2 - night
endfunction
float function getcurrenthourofday() global
endfunction
function registerforoupdate(form f) global
endfunction
function storenpcdatafloat(actor npc, string keys, float num) global
endfunction
float function getnpcdatafloat(actor npc, string keys) global
endfunction
function storenpcdataint(actor npc, string keys, int num) global
endfunction
int function getnpcdataint(actor npc, string keys) global
endfunction
function storenpcdatabool(actor npc, string keys, bool value) global
endfunction
bool function getnpcdatabool(actor npc, string keys) global
endfunction
bool function intarraycontainsvalue(int[] arr, int val) global
endfunction
bool function stringarraycontainsvalue(string[] arr, string val) global
endfunction
bool function stringcontains(string str, string contains) global
endfunction
bool function ismodloaded(string espfile) global
endfunction
float[] function getnodelocation(actor act, string node) global
endfunction
int function getfloatmin(float[] arr) global 
endfunction
int function getfloatmax(float[] arr) global 
endfunction
float function threedeedistance(float[] pointset1, float[] pointset2) global
endfunction
function displaytextbanner(string txt) global
endfunction
function displaytoasttext(string txt, float lengthoftime) global
endfunction
function hidetutorialtext() global
endfunction
string function keycodetokey(int keycode) global
endfunction 
int function keytokeycode(string p_key) global
endfunction 
string function getbuttontag(int keycode) global
endfunction 
bool function ischild(actor act) global
endfunction 
actor[] function basearrtoactorarr(actorbase[] base) global
endfunction
actor function getnpc(int id, string source = "skyrim.esm") global
endfunction
float function getoriginalscale(objectreference obj) global
endfunction
float function triganglez(float gameanglez) global
endfunction
int[] function boolarrtointarr(bool[] arr) global 
endfunction
form[] function objrefarrtoformarr(objectreference[] arr) global 
endfunction
objectreference[] function formarrtoobjrefarr(form[] arr) global 
endfunction
bool function chanceroll(int chance) global ; input 60: 60% of returning true
endfunction
string function formattodecimalplace(float num, int decimalplacestoshow) global
endfunction
string function padstring(string str, int to, int side = 0, string char = " ") global
endfunction
form function getformfromfile(int aiformid, string asfilename) global
endfunction 
bool function menuopen() global
endfunction
actor[] function filtertoplayerfollowers(actor[] acts) global
endfunction
bool function isinfirstperson() global
endfunction
bool function appearsfemale(actor act) global
endfunction
function setskyuiwidgetsvisible(bool visible) global
endfunction
bool function isnaked(actor npc) global 
endfunction
function setuivisible(bool visible) global
endfunction
bool function isuivisible() global
endfunction 
objectreference function getblankobject() global
endfunction
actor[] function shuffleactorarray(actor[] arr) global
endfunction
function lock(string mutex_key, float spinlockrate = 0.1) global
endfunction
string[] function blowjobclasses() global
endfunction 
string[] function handjobclasses() global
endfunction 
string[] function cunnilingusclasses() global
endfunction 
string[] function vagplayclasses() global
endfunction 
string[] function stringarray(string one = "", string two = "", string three = "", string four = "", string five = "", string six = "", string seven = "", string eight = "", string nine = "", string ten = "") global
endfunction
function restoreoffset(actor act, float offset) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1