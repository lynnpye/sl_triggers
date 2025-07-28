scriptname othread
int function quickstart(actor[] actors, string startinganimation = "", objectreference furnitureref = none) global native
bool function isrunning(int threadid) global native
function stop(int threadid) global native
int function getthreadcount() global native
int[] function getallthreadids() global native
string function getscene(int threadid) global native
function navigateto(int threadid, string sceneid) global native
function queuenavigation(int threadid, string sceneid, float duration) global native
function warpto(int threadid, string sceneid, bool usefades = false) global native
function queuewarp(int threadid, string sceneid, float duration) global native
bool function autotransition(int threadid, string type) global native
bool function autotransitionforactor(int threadid, int index, string type) global native
int function getspeed(int threadid) global native
function setspeed(int threadid, int speed) global native
function playsequence(int threadid, string sequence, bool navigateto = false, bool usefades = false) global native
actor[] function getactors(int threadid) global native
actor function getactor(int threadid, int index) global native
int function getactorposition(int threadid, actor act) global native
function stallclimax(int threadid) global native
function permitclimax(int threadid, bool permitactors = false) global native
bool function isclimaxstalled(int threadid) global native
objectreference function getfurniture(int threadid) global native
string function getfurnituretype(int threadid) global native
function changefurniture(int threadid, objectreference furnitureref, string sceneid = "") global native
bool function isinautomode(int threadid) global native
function startautomode(int threadid) global native
function stopautomode(int threadid) global native
bool function hasmetadata(int threadid, string metadata) global native
function addmetadata(int threadid, string metadata) global native
string[] function getmetadata(int threadid) global native
bool function hasmetafloat(int threadid, string metaid) global native
float function getmetafloat(int threadid, string metaid) global native
function setmetafloat(int threadid, string metaid, float value) global native
bool function hasmetastring(int threadid, string metaid) global native
string function getmetastring(int threadid, string metaid) global native
function setmetastring(int threadid, string metaid, string value) global native
function callevent(int threadid, string eventname, int actor, int target = -1, int performer = -1) global native
;This file was cleaned with PapyrusSourceHeadliner 1