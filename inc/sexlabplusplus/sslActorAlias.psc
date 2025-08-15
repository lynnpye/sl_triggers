scriptname sslactoralias extends referencealias
string function getactorname()
endfunction
bool function isvictim()
endfunction
bool function isaggressor()
endfunction
function setvictim(bool victimize)
endfunction
int function getsex()
endfunction
bool function getisdead()
endfunction
function disableorgasm(bool bnoorgasm)
endfunction
bool function isorgasmallowed()
endfunction
int function getorgasmcount()
endfunction
int function getpain()
endfunction
int function getenjoyment()
endfunction
function adjustpain(int adjustby)
endfunction
function adjustenjoyment(int adjustby)
endfunction
bool function isanalpenetrated()
endfunction
bool function isgenitalinteraction()
endfunction
int function getfullenjoyment()
endfunction
function setstripping(int aislots, bool abstripweapons, bool abapplynow)
endfunction
function deletecustomstripping()
endfunction
function disablestripanimation(bool abdisable)
endfunction
function setallowredress(bool aballowredress)
endfunction
form function getstrapon()
endfunction
bool function isusingstrapon()
endfunction
function setstrapon(form tostrapon)
endfunction
string function getactorvoice() native
function setactorvoiceimpl(string asnewvoice) native
function setactorvoice(string asnewvoice, bool abforcesilent)
endfunction
bool function issilent()
endfunction
string function getactorexpression() native
function setactorexpressionimpl(string asexpression) native
function setactorexpression(string asexpression)
endfunction
function setmouthforcedopen(bool abforceopen)
endfunction
int property pathing_disable = -1 autoreadonly
int property pathing_enable = 0 autoreadonly
int property pathing_force = 1 autoreadonly
function setpathing(int aipathingflag)
endfunction
function updatebasespeed(float afbasespeed)
endfunction
function updateanimationspeed()
endfunction
string property state_idle   = "empty" autoreadonly
string property state_setup  = "ready" autoreadonly
string property state_paused = "paused" autoreadonly
string property state_playing = "animating" autoreadonly
string property track_added  = "added" autoreadonly
string property track_start  = "start" autoreadonly
string property track_orgasm  = "orgasm" autoreadonly
string property track_end    = "end" autoreadonly
int property livestatus_alive    = 0 autoreadonly
int property livestatus_dead     = 1 autoreadonly
int property livestatus_unconscious = 2 autoreadonly
actor property actorref
actor function get()
endfunction
endproperty
bool property doredress
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property doundress
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property issilent hidden
bool function get()
endfunction
endproperty
bool property forceopenmouth auto hidden
bool property openmouth
bool function get()
endfunction
function set(bool abset)
endfunction
endproperty
bool property dopathtocenter
bool function get()
endfunction
endproperty
auto state empty
bool function setactor(actor prospectref)
endfunction
function clear()
endfunction
string function getactorname()
endfunction
event onendstate()
endevent
endstate
bool function setactor(actor prospectref)
endfunction
state ready
event onbeginstate()
endevent
function setstrapon(form tostrapon)
endfunction
function setactorvoice(string asnewvoice, bool abforcesilent)
endfunction
event ondoprepare(string aseventname, string asstringarg, float afnumarg, form akpathto)
endevent
function clear()
endfunction
event onendstate()
endevent
endstate
event ondoprepare(string aseventname, string asstringarg, float afnumarg, form akpathto)
endevent
event prepareactor()
endevent
function pathtocenter()
endfunction
state paused
function readyactor(int aistripdata, int aipositiongenders)
endfunction
event onstartplaying(string aseventname, string asstringarg, float afnumarg, form aksender)
endevent
function setstrapon(form tostrapon)
endfunction
function resolvestrapon(bool force = false)
endfunction
function trylock()
endfunction
function lockactor()
endfunction
function removestrapon()
endfunction
function clear()
endfunction
function initialize()
endfunction
endstate
function readyactor(int aistripdata, int aipositiongenders)
endfunction
function lockactor()
endfunction
event onstartplaying(string aseventname, string asstringarg, float afnumarg, form aksender)
endevent
function removestrapon()
endfunction
function trylock()
endfunction
function lockactorimpl() native
form[] function stripbydata(int aistripdata, int[] aidefaults, int[] aioverwrites) native
float property update_interval = 0.250 autoreadonly hidden
int property holdbackkeycode = 0x100 autoreadonly hidden ; lmb
state animating
event onbeginstate()
endevent
function updatenext(int aistripdata)
endfunction
function setstrapon(form tostrapon)
endfunction
function resolvestrapon(bool force = false)
endfunction
event onupdate()
endevent
function tryrefreshexpression()
endfunction
function refreshexpressionex(float afstrength)
endfunction
function playlouder(sound sfx, objectreference fromref, float volume)
endfunction
event onorgasm(string eventname, string strarg, float numarg, form sender)
endevent
function doorgasm(bool forced = false)
endfunction
function tryunlock()
endfunction
function unlockactor()
endfunction
function resetposition(int aistripdata, int aipositiongenders)
endfunction
function clear()
endfunction
function initialize()
endfunction
event onkeydown(int keycode)
endevent
event onendstate()
endevent
endstate
function unlockactor()
endfunction
function updatenext(int aistripdata)
endfunction
function resetposition(int aistripdata, int aipositiongenders)
endfunction
function refreshexpression()
endfunction
function refreshexpressionex(float afstrength)
endfunction
function doorgasm(bool forced = false)
endfunction
function playlouder(sound sfx, objectreference fromref, float volume)
endfunction
event onorgasm(string eventname, string strarg, float numarg, form sender)
endevent
function tryunlock()
endfunction
function tryrefreshexpression()
endfunction
function unlockactorimpl() native
form[] function stripbydataex(int aistripdata, int[] aidefaults, int[] aioverwrites, form[] akmergewith) native
function senddefaultanimevent(bool exit = false)
endfunction
function trackedevent(string eventname)
endfunction
bool function isseparateorgasm()
endfunction
function resolvestrapon(bool force = false)
endfunction
function setstraponanimationimpl(form aknewstrapon)
endfunction
function resolvestraponimpl()
endfunction
int[] function getstripsettings()
endfunction
function redress()
endfunction
function updateenjoyment(float afenjoyment) native
function resetenjoymentvariables()
endfunction
function updatebaseenjoymentcalculations()
endfunction
function updateeffectiveenjoymentcalculations()
endfunction
float function getholdbacktimewindow()
endfunction
float function calccontextpain(float bestrelation)
endfunction
float function calcenjoymentfactor(bool samesexthread, float bestrelation)
endfunction
float function calceffectivepain()
endfunction
float function calceffectiveenjoyment()
endfunction
int function calcreaction()
endfunction
function internalcompensatestageskip()
endfunction
function debugbasecalcvariables()
endfunction
function debugeffectivecalcvariables()
endfunction
function applycum() ; note: temporary?
endfunction
function setup()
endfunction
function initialize()
endfunction
event onrequestclear(string aseventname, string asstringarg, float afdostatistics, form aksender)
endevent
event oncelldetach()
endevent
event onunload()
endevent
event ondying(actor akkiller)
endevent
function log(string msg, string src = "")
endfunction
function error(string msg, string src = "")
endfunction
function offsetcoords(float[] output, float[] centercoords, float[] offsetby) global
endfunction
bool function isinposition(actor checkactor, objectreference checkmarker, float maxdistance = 30.0) global
endfunction
int function calcenjoyment(float[] xp, float[] skillsamounts, bool isleadin, bool isfemaleactor, float timer, int onstage, int maxstage) global
endfunction
int property position
int function get()
endfunction
endproperty
bool property usestrapon hidden
bool function get()
endfunction
endproperty
bool property doragdoll hidden
bool function get()
endfunction
function set(bool value)
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
sslbaseexpression function getexpression()
endfunction
function setexpression(sslbaseexpression toexpression)
endfunction
sslbasevoice function getvoice()
endfunction
function setvoice(sslbasevoice tovoice = none, bool forcesilence = false)
endfunction
int function getgender()
endfunction
function disablepathtocenter(bool disabling)
endfunction
function forcepathtocenter(bool forced)
endfunction
function attachmarker()
endfunction
function syncthread()
endfunction
function overridestrip(bool[] setstrip)
endfunction
function strip()
endfunction
function unstrip()
endfunction
function setendanimationevent(string eventname)
endfunction
function setstartanimationevent(string eventname, float playtime)
endfunction
function orgasmeffect()
endfunction
event orgasmstage()
endevent
bool function needsorgasm()
endfunction
function setorgasmcount(int value)
endfunction
function registerevents()
endfunction
function clearevents()
endfunction
function equipstrapon()
endfunction
function unequipstrapon()
endfunction
function refreshloc()
endfunction
function synclocation(bool force = false)
endfunction
function snap()
endfunction
function setadjustkey(string keyvar)
endfunction
function loadshares()
endfunction
bool function continuestrip(form itemref, bool dostrip = true)
endfunction
int function intifelse(bool check, int istrue, int isfalse)
endfunction
function clearalias()
endfunction
bool function pregnancyrisk()
endfunction
function dostatistics()
endfunction
string function getactorkey()
endfunction
function logredundant(string asfunction)
endfunction
function getpositioninfo()
endfunction
function syncactor()
endfunction
function syncall(bool force = false)
endfunction
function refreshactor()
endfunction
function restoreactordefaults()
endfunction
function sendanimation()
endfunction
function stopanimating(bool quick = false, string resetanim = "idleforcedefaultstate")
endfunction
function startanimating()
endfunction
event resetactor()
endevent
function cleareffects()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1