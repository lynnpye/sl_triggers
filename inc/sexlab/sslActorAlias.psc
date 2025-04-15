scriptname sslactoralias extends referencealias
actor property actorref auto hidden
bool property forceopenmouth auto hidden
bool property openmouth hidden
bool function get()
endfunction
endproperty
bool property issilent hidden
bool function get()
endfunction
endproperty
bool property usestrapon hidden
bool function get()
endfunction
endproperty
int property schlong hidden
int function get()
endfunction
endproperty
bool property maleposition hidden
bool function get()
endfunction
endproperty
bool function setactor(actor prospectref)
endfunction
function clearalias()
endfunction
function loadshares()
endfunction
state ready
event onupdate()
endevent
bool function setactor(actor prospectref)
endfunction
function prepareactor()
endfunction
function pathtocenter()
endfunction
endstate
state prepare
event onupdate()
endevent
function startanimating()
endfunction
event resetactor()
endevent
endstate
function sendanimation()
endfunction
function getpositioninfo()
endfunction
state animating
function sendanimation()
endfunction
event onupdate()
endevent
function syncthread()
endfunction
function syncactor()
endfunction
function syncall(bool force = false)
endfunction
function refreshactor()
endfunction
function refreshloc()
endfunction
function synclocation(bool force = false)
endfunction
function snap()
endfunction
event ontranslationcomplete()
endevent
function orgasmeffect()
endfunction
function doorgasm(bool forced = false)
endfunction
event resetactor()
endevent
endstate
state resetting
function clearalias()
endfunction
event onupdate()
endevent
function initialize()
endfunction
endstate
function syncall(bool force = false)
endfunction
function slgp_voice()
endfunction
function stopanimating(bool quick = false, string resetanim = "idleforcedefaultstate")
endfunction
function senddefaultanimevent(bool exit = false)
endfunction
function attachmarker()
endfunction
function lockactor()
endfunction
function unlockactor()
endfunction
function restoreactordefaults()
endfunction
function refreshactor()
endfunction
int function getgender()
endfunction
function setvictim(bool victimize)
endfunction
string function getactorkey()
endfunction
function setadjustkey(string keyvar)
endfunction
function adjustenjoyment(int adjustby)
endfunction
int function getenjoyment()
endfunction
int function getpain()
endfunction
int function calcreaction()
endfunction
function applycum()
endfunction
function disableorgasm(bool bnoorgasm)
endfunction
bool function isorgasmallowed()
endfunction
bool function needsorgasm()
endfunction
function setvoice(sslbasevoice tovoice = none, bool forcesilence = false)
endfunction
sslbasevoice function getvoice()
endfunction
function setexpression(sslbaseexpression toexpression)
endfunction
sslbaseexpression function getexpression()
endfunction
function setstartanimationevent(string eventname, float playtime)
endfunction
function setendanimationevent(string eventname)
endfunction
bool function isusingstrapon()
endfunction
function resolvestrapon(bool force = false)
endfunction
function equipstrapon()
endfunction
function unequipstrapon()
endfunction
function setstrapon(form tostrapon)
endfunction
form function getstrapon()
endfunction
bool function pregnancyrisk()
endfunction
function overridestrip(bool[] setstrip)
endfunction
bool function continuestrip(form itemref, bool dostrip = true)
endfunction
function strip()
endfunction
function unstrip()
endfunction
bool property doragdoll hidden
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property doundress hidden
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property doredress hidden
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
function forcepathtocenter(bool forced)
endfunction
function disablepathtocenter(bool disabling)
endfunction
bool property dopathtocenter
bool function get()
endfunction
endproperty
function refreshexpression()
endfunction
function trackedevent(string eventname)
endfunction
function cleareffects()
endfunction
int property kprepareactor = 0 autoreadonly hidden
int property ksyncactor    = 1 autoreadonly hidden
int property kresetactor   = 2 autoreadonly hidden
int property krefreshactor = 3 autoreadonly hidden
int property kstartup      = 4 autoreadonly hidden
function registerevents()
endfunction
function clearevents()
endfunction
function initialize()
endfunction
function setup()
endfunction
function log(string msg, string src = "")
endfunction
function playlouder(sound sfx, objectreference fromref, float volume)
endfunction
function prepareactor()
endfunction
function pathtocenter()
endfunction
function startanimating()
endfunction
function syncactor()
endfunction
function syncthread()
endfunction
function synclocation(bool force = false)
endfunction
function refreshloc()
endfunction
function snap()
endfunction
event ontranslationcomplete()
endevent
function orgasmeffect()
endfunction
function doorgasm(bool forced = false)
endfunction
event resetactor()
endevent
event onorgasm()
endevent
event orgasmstage()
endevent
function offsetcoords(float[] output, float[] centercoords, float[] offsetby) global native
bool function isinposition(actor checkactor, objectreference checkmarker, float maxdistance = 30.0) global native
int function calcenjoyment(float[] xp, float[] skillsamounts, bool isleadin, bool isfemaleactor, float timer, int onstage, int maxstage) global native
int function intifelse(bool check, int istrue, int isfalse)
endfunction
bool function isvictim()
endfunction
bool function iscreature()
endfunction
bool function isaggressor()
endfunction
bool function issilent()
endfunction
string function getactorname()
endfunction
function slso_initialize()
endfunction
int function getfullenjoyment()
endfunction
float function getfullenjoymentmod()
endfunction
int function calculatefullenjoyment()
endfunction
int function slso_getenjoyment()
endfunction
function bonusenjoyment(actor ref = none, int fixedvalue = 0)
endfunction
function orgasm(float experience2 = 0.0)
endfunction
function holdout(float experience2 = 0.0)
endfunction
int function getorgasmcount()
endfunction
function setorgasmcount(int setorgasms = 0)
endfunction
int function slso_doorgasm_conditions(bool forced)
endfunction
function slso_doorgasm_multiorgasm()
endfunction
function slso_doorgasm_sexlaborgasmseparate()
endfunction
function slso_startanimating()
endfunction
function slso_animating_moan()
endfunction
function slso_doorgasm_moan()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1