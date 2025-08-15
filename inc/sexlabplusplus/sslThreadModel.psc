scriptname sslthreadmodel extends sexlabthread hidden
int function getthreadid()
endfunction
string function getactivescene() native
string function getactivestage() native
string[] function getplayingscenes() native
function stopanimation()
endfunction
float function gettime()
endfunction
float function gettimetotal()
endfunction
string[] function getstagehistory()
endfunction
int function getstagehistorylength()
endfunction
actor[] function getpositions() native
bool function hasplayer()
endfunction
bool function hasactor(actor actorref)
endfunction
int function getpositionidx(actor akactor)
endfunction
int function getactorsex(actor akactor)
endfunction
int function getnthpositionsex(int n)
endfunction
int[] function getpositionsexes()
endfunction
function setcustomstrip(actor akactor, int aislots, bool abweapon, bool abapplynow)
endfunction
function resetcustomstrip(actor akactor)
endfunction
bool function isundressanimationallowed(actor akactor)
endfunction
function setisundressanimationallowed(actor akactor, bool aballowed)
endfunction
bool function isredressallowed(actor akactor)
endfunction
function setisredressallowed(actor akactor, bool aballowed)
endfunction
function setpathingflag(actor akactor, int aipathingflag)
endfunction
function setactorvoice(actor akactor, string asvoice, bool abforcesilent)
endfunction
string function getactorvoice(actor akactor)
endfunction
string function getactorexpression(actor akactor)
endfunction
function setactorexpression(actor akactor, string asexpression)
endfunction
int function getpain(actor actorref)
endfunction
int function getenjoyment(actor actorref)
endfunction
function adjustpain(actor actorref, int adjustby)
endfunction
function adjustenjoyment(actor actorref, int adjustby)
endfunction
function disableorgasm(actor actorref, bool orgasmdisabled = true)
endfunction
bool function isorgasmallowed(actor actorref)
endfunction
function forceorgasm(actor actorref)
endfunction
actor[] function canbeimpregnated(actor akactor,  bool aballowfutaimpregnation, bool abfutacanpregnate, bool abcreaturecanpregnate)
endfunction
bool function isusingstrapon(actor actorref)
endfunction
function setstrapon(actor actorref, form tostrapon)
endfunction
form function getstrapon(actor actorref)
endfunction
bool function isconsent()
endfunction
function setconsent(bool abisconsent)
endfunction
actor[] function getsubmissives()
endfunction
function setissubmissive(actor akactor, bool abissubmissive)
endfunction
bool function getsubmissive(actor akactor)
endfunction
bool function isvictim(actor actorref)
endfunction
bool function isaggressor(actor actorref)
endfunction
bool function hastag(string tag)
endfunction
bool function hasscenetag(string tag)
endfunction
bool function isvaginal()
endfunction
bool function isanal()
endfunction
bool function isoral()
endfunction
bool function hasstagetag(string tag)
endfunction
string[] function gettags()
endfunction
bool function hascontext(string astag)
endfunction
function addcontext(string ascontext)
endfunction
function removecontext(string ascontext)
endfunction
string[] function addcontexteximpl(string[] asoldcontext, string ascontext) native
function addcontextex(string ascontext)
endfunction
bool function isleadin()
endfunction
bool function isinteractionregistered()
endfunction
int[] function getinteractiontypes(actor akposition, actor akpartner)
endfunction
bool function hasinteractiontype(int aitype, actor akposition, actor akpartner)
endfunction
actor function getpartnerbytype(actor akposition, int aitype)
endfunction
actor[] function getpartnersbytype(actor akposition, int aitype)
endfunction
actor function getpartnerbytyperev(actor akpartner, int aitype)
endfunction
actor[] function getpartnersbytyperev(actor akpartner, int aitype)
endfunction
float function getvelocity(actor akposition, actor akpartner, int aitype)
endfunction
function sethook(string addhooks)
endfunction
function removehook(string delhooks)
endfunction
string[] function gethooks()
endfunction
int property tid hidden
int function get()
endfunction
endproperty
actor property playerref auto
bool property hasplayer hidden
bool function get()
endfunction
endproperty
sslsystemconfig property config auto
package property donothingpackage auto ; used in the alias scripts
message property invalidcentermsg auto ; invalid new cewnter -> [0: keep old center, 1: end scene]
int property position_count_max = 5 autoreadonly
string property state_idle   = "unlocked" autoreadonly
string property state_setup  = "making" autoreadonly
string property state_setup_m = "making_m" autoreadonly
string property state_playing = "animating" autoreadonly
string property state_end   = "ending" autoreadonly
int property consent_connonsub   = 0 autoreadonly hidden
int property consent_nonconnonsub = 1 autoreadonly hidden
int property consent_consub    = 2 autoreadonly hidden
int property consent_nonconsub   = 3 autoreadonly hidden
int property actorint_nonpart  = 0 autoreadonly hidden
int property actorint_passive  = 1 autoreadonly hidden
int property actorint_active   = 2 autoreadonly hidden
int property asltype_none = -1 autoreadonly  ; none
int property asltype_gr  = 0  autoreadonly  ; grinding
int property asltype_hj  = 1  autoreadonly  ; handjob
int property asltype_fj  = 2  autoreadonly  ; footjob
int property asltype_or  = 3  autoreadonly  ; oral
int property asltype_vg  = 4  autoreadonly  ; vaginal
int property asltype_an  = 5  autoreadonly  ; anal
int property asltype_srvg = 6  autoreadonly  ; spitroast (oral+vaginal)
int property asltype_sran = 7  autoreadonly  ; spitroast (oral+anal)
int property asltype_dp  = 8  autoreadonly  ; double penetration
int property asltype_tp  = 9  autoreadonly  ; triple penetration
bool property islocked hidden
bool function get()
endfunction
endproperty
int function getstatus()
endfunction
bool function isowningscenemenu() native
bool function tryopenscenemenu() native
bool function tryclosescenemenu() native
function tryupdatemenutimer(float aftime) native
sslactoralias[] property actoralias auto
int property stage hidden
int function get()
endfunction
function set(int aset)
endfunction
endproperty
int property furni_disallow = 0 autoreadonly
int property furni_allow   = 1 autoreadonly
int property furni_prefer  = 2 autoreadonly
referencealias property centeralias auto ; the alias referencing _center
objectreference property centerref hidden ; shorthand for centeralias
objectreference function get()
endfunction
function set(objectreference aknewcenter)
endfunction
endproperty
float property startedat auto hidden
float property totaltime hidden
float function get()
endfunction
endproperty
bool property autoadvance auto hidden
bool property leadin auto hidden
auto state unlocked
sslthreadmodel function make()
endfunction
int function getstatus()
endfunction
endstate
sslthreadmodel function make()
endfunction
state making
event onbeginstate()
endevent
event onupdate()
endevent
int function addactor(actor actorref, bool isvictim = false, sslbasevoice voice = none, bool forcesilent = false)
endfunction
bool function addactors(actor[] actorlist, actor victimactor = none)
endfunction
bool function addactorsa(actor[] actorlist, actor[] akvictims)
endfunction
function setscenes(string[] asscenes)
endfunction
function clearscenes()
endfunction
function setforcedscenes(string[] asscenes)
endfunction
function clearforcedscenes()
endfunction
function setleadinscenes(string[] asscenes)
endfunction
function clearleadinscenes()
endfunction
function addscene(string assceneid)
endfunction
function disableleadin(bool disabling = true)
endfunction
function setfurniturestatus(int aistatus)
endfunction
function centeronobject(objectreference centeron, bool resync = true)
endfunction
sslthreadcontroller function startthread()
endfunction
function continuesetup(bool abcontinue)
endfunction
function endanimation(bool quickly = false)
endfunction
int function getstatus()
endfunction
endstate
state making_m
event onbeginstate()
endevent
function preparedone()
endfunction
function endanimation(bool quickly = false)
endfunction
int function getstatus()
endfunction
endstate
sslthreadcontroller function startthread()
endfunction
int function addactor(actor actorref, bool isvictim = false, sslbasevoice voice = none, bool forcesilent = false)
endfunction
bool function addactors(actor[] actorlist, actor victimactor = none)
endfunction
bool function addactorsa(actor[] akactors, actor[] akvictims)
endfunction
function setscenes(string[] asscenes)
endfunction
function clearscenes()
endfunction
function setforcedscenes(string[] asscenes)
endfunction
function clearforcedscenes()
endfunction
function setleadinscenes(string[] asscenes)
endfunction
function clearleadinscenes()
endfunction
function addscene(string assceneid)
endfunction
function setstartingscene(string asfirstanimation)
endfunction
function disableleadin(bool disabling = true)
endfunction
function setfurniturestatus(int aistatus)
endfunction
function continuesetup(bool abcontinue)
endfunction
function createinstance(actor[] aksubmissives, string[] asprimaryscenes, string[] asleadinscenes, string[] ascustomscenes, int aifurniturestatus) native
string[] function getleadinscenes() native
string[] function getprimaryscenes() native
string[] function getcustomscenes() native
float property animating_update_interval = 0.5 autoreadonly
float[] property timers hidden
float[] function get()
endfunction
function set(float[] value)
endfunction
endproperty
state animating
event onbeginstate()
endevent
function animationstart()
endfunction
bool function resetscene(string asnewscene)
endfunction
function playnext(int ainextbranch)
endfunction
function playnextimpl(string asnewstage)
endfunction
function triggerorgasm()
endfunction
function resetstage()
endfunction
function startstage(string[] ashistory, string asnextstageid)
endfunction
function gotostage(int tostage)
endfunction
function branchto(int ainextbranch)
endfunction
function skipto(string asnextstage)
endfunction
function restarttimer()
endfunction
function updatetimer(float addseconds = 0.0)
endfunction
function settimers(float[] settimers)
endfunction
float function gettimer()
endfunction
float function getstagetimer(int maxstage)
endfunction
event onupdate()
endevent
function centeronobject(objectreference centeron, bool resync = true)
endfunction
function realignactors()
endfunction
function changeactors(actor[] newpositions)
endfunction
function endleadin()
endfunction
function initialize()
endfunction
function endanimation(bool quickly = false)
endfunction
bool function resetanimation(actor[] aknewpositions, actor[] aksubmissives, objectreference akcenter)
endfunction
int function getstatus()
endfunction
event onendstate()
endevent
endstate
function realignactors()
endfunction
function changeactors(actor[] newpositions)
endfunction
bool function resetscene(string asnewscene)
endfunction
function resetstage()
endfunction
function startstage(string[] ashistory, string asnextstageid)
endfunction
function endleadin()
endfunction
function playnext(int ainextbranch)
endfunction
function playnextimpl(string asnewstage)
endfunction
function gotostage(int tostage)
endfunction
function triggerorgasm()
endfunction
function restarttimer()
endfunction
function updatetimer(float addseconds = 0.0)
endfunction
function settimers(float[] settimers)
endfunction
float function gettimer()
endfunction
float function getstagetimer(int maxstage)
endfunction
function branchto(int ainextbranch)
endfunction
function skipto(string asnextstage)
endfunction
function playstageanimations()
endfunction
string[] function advancescene(string[] ashistory, string asnextstageid) native
int function selectnextstage(string[] asthreadtags) native
bool function setactivescene(string asscene) native
bool function reassigncenter(objectreference centeron) native
function updateplacement(actor akactor) native
bool function iscollisionregistered() native
function unregistercollision() native
int[] function getcollisionactions(actor akposition, actor akpartner) native
bool function hascollisionaction(int aitype, actor akposition, actor akpartner) native
actor function getpartnerbyaction(actor akposition, int aitype) native
actor[] function getpartnersbyaction(actor akposition, int aitype) native
actor function getpartnerbyactionrev(actor akpartner, int aitype) native
actor[] function getpartnersbyactionrev(actor akpartner, int aitype) native
float function getactionvelocity(actor akposition, actor akpartner, int aitype) native
state ending
event onbeginstate()
endevent
bool function resetanimation(actor[] aknewpositions, actor[] aksubmissives, objectreference akcenter)
endfunction
event onupdategametime()
endevent
event onendstate()
endevent
int function getstatus()
endfunction
endstate
sslactoralias function pickalias(actor actorref)
endfunction
function setfurnitureignored(bool disabling = true)
endfunction
function stoptranslations()
endfunction
function starttranslations()
endfunction
function centeronobject(objectreference centeron, bool resync = true)
endfunction
function endanimation(bool quickly = false)
endfunction
bool function resetanimation(actor[] aknewpositions, actor[] aksubmissives, objectreference akcenter)
endfunction
function preparedone()
endfunction
function animationstart()
endfunction
int function findslot(actor actorref)
endfunction
sslactoralias function actoralias(actor actorref)
endfunction
sslactoralias function positionalias(int position)
endfunction
function sortaliasestopositions()
endfunction
sound function getaliassound(sslactoralias akthis, string asvoice, int aistrength)
endfunction
sound function getaliasorgasmsound(sslactoralias akthis, string asvoice)
endfunction
function addexperience(actor[] akpositions, string asactivestage, string[] asstagehistory) native
function updatestatistics(actor akactor, actor[] akpositions,  string asactivescene, string[] asplayedstages, float aftimeinthread) native
function requeststatisticupdate(actor akposition, float afregisteredat) ; called when one of the _positions is cleared
endfunction
function updateencounters(actor akactor, int i = 0)
endfunction
function updateallencounters()
endfunction
float function getinteractionfactor(actor actorref, int typeasl, int infoactor)
endfunction
float function calcphysicfactor(actor actorref)
endfunction
int function getinteractiontypeasl()
endfunction
int function guessactorinterinfo(actor actorref, int actorsex, bool isactorsub, int consubstatus, bool samesexthread)
endfunction
float function calcinteractionfactorasl(int typeasl, int infoactor)
endfunction
associationtype property spouseassocation auto
faction property playermarriedfaction auto
int function getrelationforscene(actor actorref, actor targetref, int consubstatus)
endfunction
int function getbestrelationforscene(actor actorref, int consubstatus)
endfunction
bool function samesexthread()
endfunction
int function identifyconsentsubstatus()
endfunction
bool function crtmalehugepp()
endfunction
bool function isvaginalcomplex(actor actorref, int typeinterasl)
endfunction
bool function isanalcomplex(actor actorref, int typeinterasl)
endfunction
bool function isoralcomplex(actor actorref, int typeinterasl)
endfunction
function applycumfx(actor sourceref)
endfunction
function runhook(int aihookid)
endfunction
function sendthreadevent(string hookevent)
endfunction
function setupthreadevent(string hookevent)
endfunction
function settid(int id)
endfunction
function initialize()
endfunction
function destroyinstance() native
function log(string msg, string src = "")
endfunction
function fatal(string msg, string src = "", bool halt = true)
endfunction
sslthreadlibrary property threadlib hidden
sslthreadlibrary function get()
endfunction
endproperty
sslanimationslots property animslots hidden
sslanimationslots function get()
endfunction
endproperty
sslcreatureanimationslots property creatureslots hidden
sslcreatureanimationslots function get()
endfunction
endproperty
sslactorlibrary property actorlib hidden
sslactorlibrary function get()
endfunction
endproperty
actor[] property positions hidden
actor[] function get()
endfunction
endproperty
int property actorcount hidden
int function get()
endfunction
endproperty
actor[] property victims hidden
actor[] function get()
endfunction
endproperty
string[] property scenes hidden
string[] function get()
endfunction
endproperty
int[] property genders hidden
int[] function get()
endfunction
function set(int[] aset)
endfunction
endproperty
int property males hidden
int function get()
endfunction
endproperty
int property females hidden
int function get()
endfunction
endproperty
bool property hascreature hidden
bool function get()
endfunction
endproperty
int property creatures hidden
int function get()
endfunction
endproperty
int property malecreatures hidden
int function get()
endfunction
endproperty
int property femalecreatures hidden
int function get()
endfunction
endproperty
string[] property animevents hidden
string[] function get()
endfunction
endproperty
string property adjustkey hidden
string function get()
endfunction
endproperty
bool[] property istype hidden ; [0] isaggressive, [1] isvaginal, [2] isanal, [3] isoral, [4] isloving, [5] isdirty, [6] hadvaginal, [7] hadanal, [8] hadoral
bool[] function get()
endfunction
function set(bool[] aset)
endfunction
endproperty
bool property isaggressive hidden
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property isvaginal hidden
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property isanal hidden
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property isoral hidden
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property isloving hidden
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property isdirty hidden
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
int[] property bedstatus hidden
int[] function get()
endfunction
function set(int[] aset)
endfunction
endproperty
objectreference property bedref hidden
objectreference function get()
endfunction
function set(objectreference aset)
endfunction
endproperty
int property bedtypeid hidden
int function get()
endfunction
endproperty
bool property usingbed hidden
bool function get()
endfunction
endproperty
bool property usingbedroll hidden
bool function get()
endfunction
endproperty
bool property usingsinglebed hidden
bool function get()
endfunction
endproperty
bool property usingdoublebed hidden
bool function get()
endfunction
endproperty
bool property usenpcbed hidden
bool function get()
endfunction
endproperty
actor property victimref hidden
actor function get()
endfunction
function set(actor actorref)
endfunction
endproperty
actor[] function getallvictims()
endfunction
function setvictim(actor actorref, bool victimize = true)
endfunction
float[] property centerlocation hidden
float[] function get()
endfunction
function set(float[] aset)
endfunction
endproperty
sslbaseanimation function getsetanimationlegacycast(string asscene)
endfunction
sslbaseanimation property animation hidden
sslbaseanimation function get()
endfunction
function set(sslbaseanimation aset)
endfunction
endproperty
sslbaseanimation property startinganimation hidden
sslbaseanimation function get()
endfunction
function set(sslbaseanimation aset)
endfunction
endproperty
sslbaseanimation[] property animations hidden
sslbaseanimation[] function get()
endfunction
endproperty
function logconsole(string asreport)
endfunction
function logredundant(string asfunction)
endfunction
function addanimation(sslbaseanimation addanimation, bool forceto = false)
endfunction
function setanimation(int aid = -1)
endfunction
function setanimationimpl(sslbaseanimation akanimation)
endfunction
function setvoice(actor actorref, sslbasevoice voice, bool forcesilent = false)
endfunction
sslbasevoice function getvoice(actor actorref)
endfunction
function setexpression(actor actorref, sslbaseexpression expression)
endfunction
sslbaseexpression function getexpression(actor actorref)
endfunction
bool function addtag(string tag)
endfunction
bool function removetag(string tag)
endfunction
bool function toggletag(string tag)
endfunction
bool function addtagconditional(string tag, bool addtag)
endfunction
bool function checktags(string[] checktags, bool requireall = true, bool suppress = false)
endfunction
string[] function addstring(string[] arrayvalues, string toadd, bool removedupes = true)
endfunction
sound property soundfx hidden
sound function get()
endfunction
function set(sound aset)
endfunction
endproperty
function syncevent(int id, float waittime)
endfunction
function synceventdone(int id)
endfunction
function syncdone()
endfunction
function refreshdone()
endfunction
function resetdone()
endfunction
function stripdone()
endfunction
function orgasmdone()
endfunction
function startupdone()
endfunction
sslbaseanimation[] function getanimationslegacycast(string[] asscenes)
endfunction
sslbaseanimation[] function getforcedanimations()
endfunction
sslbaseanimation[] function getanimations()
endfunction
sslbaseanimation[] function getleadanimations()
endfunction
int function gethighestpresentrelationshiprank(actor actorref)
endfunction
int function getlowestpresentrelationshiprank(actor actorref)
endfunction
string function gethook()
endfunction
function action(string firestate)
endfunction
function fireaction()
endfunction
function endaction()
endfunction
function initshares()
endfunction
int function filteranimations()
endfunction
function hookanimationstarting()
endfunction
function hookstagestart()
endfunction
function hookstageend()
endfunction
function hookanimationend()
endfunction
function sendtrackedevent(actor actorref, string hook = "")
endfunction
function setupactorevent(actor actorref, string callback)
endfunction
function updateadjustkey()
endfunction
string function key(string callback)
endfunction
function quickevent(string callback)
endfunction
race property creatureref hidden
race function get()
endfunction
function set(race aset)
endfunction
endproperty
float[] property realtime hidden
float[] function get()
endfunction
function set(float[] aset)
endfunction
endproperty
bool property fastend auto hidden
actor function getplayer()
endfunction
actor function getvictim()
endfunction
function removefade()
endfunction
function applyfade()
endfunction
bool function isplayeractor(actor actorref)
endfunction
bool function isplayerposition(int position)
endfunction
int function getposition(actor actorref)
endfunction
int function getplayerposition()
endfunction
function disableragdollend(actor actorref = none, bool disabling = true)
endfunction
function setstartanimationevent(actor actorref, string eventname = "idleforcedefaultstate", float playtime = 0.1)
endfunction
function setendanimationevent(actor actorref, string eventname = "idleforcedefaultstate")
endfunction
bool function centeronbed(bool askplayer = true, float radius = 750.0)
endfunction
function centeroncoords(float locx = 0.0, float locy = 0.0, float locz = 0.0, float rotx = 0.0, float roty = 0.0, float rotz = 0.0, bool resync = true)
endfunction
int function areusingfurniture(actor[] actorlist) 
endfunction
function resolvetimers()
endfunction
function setstrip(actor actorref, bool[] stripslots)
endfunction
function setnostripping(actor actorref)
endfunction
bool function uselimitedstrip()
endfunction
function disableundressanimation(actor actorref = none, bool disabling = true)
endfunction
function disableredress(actor actorref = none, bool disabling = true)
endfunction
function disablepathtocenter(actor actorref = none, bool disabling = true)
endfunction
function forcepathtocenter(actor actorref = none, bool forced = true)
endfunction
function setanimations(sslbaseanimation[] animationlist)
endfunction
function clearanimations()
endfunction
function setforcedanimations(sslbaseanimation[] animationlist)
endfunction
function clearforcedanimations()
endfunction
function setleadanimations(sslbaseanimation[] animationlist)
endfunction
function clearleadanimations()
endfunction
function setstartinganimation(sslbaseanimation firstanimation)
endfunction
function disablebeduse(bool disabling = true)
endfunction
function setbedflag(int flag = 0)
endfunction
function setbedding(int flag = 0)
endfunction
bool property disableorgasms hidden
bool function get()
endfunction
function set(bool abdisable)
endfunction
endproperty
function disableallorgasms(bool orgasmsdisabled = true)
endfunction
bool function needsorgasm(actor actorref)
endfunction
function equipstrapon(actor actorref)
endfunction
function unequipstrapon(actor actorref)
endfunction
bool function pregnancyrisk(actor actorref, bool allowfemalecum = false, bool allowcreaturecum = false)
endfunction
float[] property skillbonus hidden
float[] function get()
endfunction
endproperty
float[] property skillxp hidden
float[] function get()
endfunction
endproperty
function setbonuses()
endfunction
function recordskills()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1