scriptname sexlabframework extends quest
int function getversion()
endfunction
string function getstringver()
endfunction
bool property enabled hidden
bool function get()
endfunction
endproperty
bool property isrunning hidden
bool function get()
endfunction
endproperty
int property activeanimations hidden
int function get()
endfunction
endproperty
bool property allowcreatures hidden
bool function get()
endfunction
endproperty
bool property creaturegenders hidden
bool function get()
endfunction
endproperty
sexlabthread function startscene(actor[] akpositions, string astags, actor aksubmissive = none, objectreference akcenter = none, int aifurniture = 1, string ashook = "")
endfunction
sexlabthread function startscenea(actor[] akpositions, string astags, actor[] aksubmissives, objectreference akcenter = none, int aifurniture = 1, string ashook = "")
endfunction
sexlabthread function startsceneex(actor[] akpositions, string[] asscenes, actor aksubmissive = none, string ascontext = "", \
objectreference akcenter = none, int aifurniture = 1, string ashook = "")
endfunction
sexlabthread function startsceneexa(actor[] akpositions, string[] asscenes, actor[] aksubmissives, string ascontext = "", \
objectreference akcenter = none, int aifurniture = 1, string ashook = "")
endfunction
sexlabthread function startscenequick(actor akactor1, actor akactor2 = none, actor akactor3 = none, actor akactor4 = none, actor akactor5 = none, \
actor aksubmissive = none, string astags = "", string ashook = "")
endfunction
sexlabthread function getthread(int aithreadid)
endfunction
sexlabthread function getthreadbyactor(actor akactor)
endfunction
bool function registerhook(sexlabthreadhook akhook)
endfunction
bool function unregisterhook(sexlabthreadhook akhook)
endfunction
bool function ishooked(sexlabthreadhook akhook)
endfunction
bool function isactoractive(actor actorref)
endfunction
int function getsex(actor akactor)
endfunction
int[] function getsexall(actor[] akpositions)
endfunction
function treatassex(actor akactor, int aisextag)
endfunction
function treatasmale(actor actorref)
endfunction
function treatasfemale(actor actorref)
endfunction
function treatasfuta(actor actorref)
endfunction
function clearforcedsex(actor akactor)
endfunction
int[] function countsexall(actor[] akpositions)
endfunction
int function countmale(actor[] akpositions)
endfunction
int function countfemale(actor[] akpositions)
endfunction
int function countfuta(actor[] akpositions)
endfunction
int function countcreatures(actor[] akpositions)
endfunction
int function countcrtmale(actor[] akpositions)
endfunction
int function countcrtfemale(actor[] akpositions)
endfunction
int function validateactor(actor actorref)
endfunction
bool function isvalidactor(actor actorref)
endfunction
function forbidactor(actor actorref)
endfunction
function allowactor(actor actorref)
endfunction
bool function isforbidden(actor actorref)
endfunction
function addcumfx(actor akactor, int aitype)
endfunction
function addcumfxlayers(actor akactor, int aitype, int ailayers)
endfunction
function removecumfx(actor akactor, int aitype = -1)
endfunction
int function countcumfx(actor actorref, int aitype = -1)
endfunction
int function countcumvaginal(actor actorref)
endfunction
int function countcumoral(actor actorref)
endfunction
int function countcumanal(actor actorref)
endfunction
form[] function stripactor(actor actorref, actor victimref = none, bool doanimate = true, bool leadin = false)
endfunction
form[] function stripslots(actor actorref, bool[] strip, bool doanimate = false, bool allownudesuit = true)
endfunction
function unstripactor(actor actorref, form[] stripped, bool isvictim = false)
endfunction
bool function isstrippable(form itemref)
endfunction
form function stripslot(actor actorref, int slotmask)
endfunction
form function wornstrapon(actor actorref)
endfunction
bool function hasstrapon(actor actorref)
endfunction
form function pickstrapon(actor actorref)
endfunction
armor function loadstrapon(string esp, int id)
endfunction
function loadstraponex(armor akstrapon)
endfunction
objectreference function findbed(objectreference centerref, float radius = 1000.0, bool ignoreused = true, objectreference ignoreref1 = none, objectreference ignoreref2 = none)
endfunction
bool function isbedroll(objectreference bedref)
endfunction
bool function isdoublebed(objectreference bedref)
endfunction
bool function issinglebed(objectreference bedref)
endfunction
bool function isbedavailable(objectreference bedref)
endfunction
bool function addcustombed(form basebed, int bedtype = 0)
endfunction
bool function setcustombedoffset(form basebed, float forward = 30.0, float sideward = 0.0, float upward = 37.0, float rotation = 0.0)
endfunction
bool function clearcustombedoffset(form basebed)
endfunction
float[] function getbedoffsets(form basebed)
endfunction
function trackactor(actor actorref, string callback)
endfunction
function untrackactor(actor actorref, string callback)
endfunction
function trackfaction(faction factionref, string callback)
endfunction
function untrackfaction(faction factionref, string callback)
endfunction
bool function isactortracked(actor actorref)
endfunction
string function selectvoice(actor akactor)
endfunction
string function selectvoicebytags(actor akactor, string astags)
endfunction
string function selectvoicebytagsa(actor akactor, string[] astags)
endfunction
function storevoice(actor akactor, string asvoice)
endfunction
bool function hasstoredvoice(actor akactor)
endfunction
string function getstoredvoice(actor akactor)
endfunction
function clearvoice(actor akactor)
endfunction
float[] function getcurrentmfg(actor actorref)
endfunction
function clearmfg(actor actorref)
endfunction
function clearphoneme(actor actorref)
endfunction
function clearmodifier(actor actorref)
endfunction
function applypresetfloats(actor actorref, float[] preset)
endfunction
actor[] function makeactorarray(actor actor1 = none, actor actor2 = none, actor actor3 = none, actor actor4 = none, actor actor5 = none)
endfunction
string function parsetime(int time)
endfunction
sslthreadcontroller function hookcontroller(string argstring)
endfunction
sslbaseanimation function hookanimation(string argstring)
endfunction
int function hookstage(string argstring)
endfunction
actor function hookvictim(string argstring)
endfunction
actor[] function hookactors(string argstring)
endfunction
float function hooktime(string argstring)
endfunction
bool function hascreatureanimation(race creaturerace, int gender = -1)
endfunction
sslbaseanimation[] function getanimationsbytag(int actorcount, string tag1, string tag2 = "", string tag3 = "", string tagsuppress = "", bool requireall = true)
endfunction
sslbaseanimation[] function getcreatureanimationsbytags(int actorcount, string tags, string tagsuppress = "", bool requireall = true)
endfunction
sslbasevoice function getvoicebytag(string tag1, string tag2 = "", string tagsuppress = "", bool requireall = true)
endfunction
function applycum(actor actorref, int cumid)
endfunction
form function stripweapon(actor actorref, bool righthand = true)
endfunction
sslbaseanimation[] property animations hidden
sslbaseanimation[] function get()
endfunction
endproperty
sslbaseanimation[] property creatureanimations hidden
sslbaseanimation[] function get()
endfunction
endproperty
sslbasevoice[] property voices hidden
sslbasevoice[] function get()
endfunction
endproperty
sslbaseexpression[] property expressions hidden
sslbaseexpression[] function get()
endfunction
endproperty
sslbaseexpression function randomexpressionbytag(string tag)
endfunction
function applypreset(actor actorref, int[] preset)
endfunction
sslthreadcontroller[] property threads hidden
sslthreadcontroller[] function get()
endfunction
endproperty
int function startsex(actor[] positions, sslbaseanimation[] anims, actor victim = none, objectreference centeron = none, bool allowbed = true, string hook = "")
endfunction
sslthreadcontroller function quickstart(actor actor1, actor actor2 = none, actor actor3 = none, actor actor4 = none, actor actor5 = none, actor victim = none, string hook = "", string animationtags = "")
endfunction
string function makeanimationgendertag(actor[] positions)
endfunction
string function getgendertag(int females = 0, int males = 0, int creatures = 0)
endfunction
sslbaseanimation[] function getanimationsbytags(int actorcount, string tags, string tagsuppress = "", bool requireall = true)
endfunction
sslbaseanimation[] function getanimationsbytype(int actorcount, int males = -1, int females = -1, int stagecount = -1, bool aggressive = false, bool sexual = true)
endfunction
sslbaseanimation[] function pickanimationsbyactors(actor[] positions, int limit = 64, bool aggressive = false)
endfunction
sslbaseanimation[] function getanimationsbydefault(int males, int females, bool isaggressive = false, bool usingbed = false, bool restrictaggressive = true)
endfunction
sslbaseanimation[] function getanimationsbydefaulttags(int males, int females, bool isaggressive = false, bool usingbed = false, bool restrictaggressive = true, string tags, string tagssuppressed = "", bool requireall = true)
endfunction
actor[] function sortcreatures(actor[] positions, sslbaseanimation animation = none)
endfunction
sslbaseanimation[] function getcreatureanimationsbyrace(int actorcount, race raceref)
endfunction
sslbaseanimation[] function getcreatureanimationsbyracetags(int actorcount, race raceref, string tags, string tagsuppress = "", bool requireall = true)
endfunction
sslbaseanimation[] function getcreatureanimationsbyracegenders(int actorcount, race raceref, int malecreatures = 0, int femalecreatures = 0, bool forceuse = false)
endfunction
sslbaseanimation[] function getcreatureanimationsbyracegenderstags(int actorcount, race raceref, int malecreatures = 0, int femalecreatures = 0, string tags, string tagsuppress = "", bool requireall = true)
endfunction
sslbaseanimation[] function getcreatureanimationsbyracekey(int actorcount, string racekey)
endfunction
sslbaseanimation[] function getcreatureanimationsbyracekeytags(int actorcount, string racekey, string tags, string tagsuppress = "", bool requireall = true)
endfunction
sslbaseanimation[] function getcreatureanimationsbyactors(int actorcount, actor[] positions)
endfunction
sslbaseanimation[] function getcreatureanimationsbyactorstags(int actorcount, actor[] positions, string tags, string tagsuppress = "", bool requireall = true)
endfunction
sslbaseanimation function registeranimation(string registrar, form callbackform = none, referencealias callbackalias = none)
endfunction
sslbaseanimation function registercreatureanimation(string registrar, form callbackform = none, referencealias callbackalias = none)
endfunction
sslbaseanimation function newanimationobject(string token, form owner)
endfunction
sslbaseanimation function getsetanimationobject(string token, string callback, form owner)
endfunction
sslbaseanimation function newanimationobjectcopy(string token, sslbaseanimation copyfrom, form owner)
endfunction
sslbaseanimation function getanimationobject(string token)
endfunction
sslbaseanimation[] function getowneranimations(form owner)
endfunction
sslbaseanimation function makeanimationregistered(string token)
endfunction
bool function removeregisteredanimation(string registrar)
endfunction
bool function removeregisteredcreatureanimation(string registrar)
endfunction
int function getgender(actor actorref)
endfunction
function treatasgender(actor actorref, bool asfemale) ;  see treatassex()
endfunction
function clearforcedgender(actor actorref)  ; see clearforcedsex()
endfunction
int[] function gendercount(actor[] positions)
endfunction
int[] function transgendercount(actor[] positions)
endfunction
int function malecount(actor[] positions)
endfunction
int function femalecount(actor[] positions)
endfunction
int function creaturecount(actor[] positions)
endfunction
int function transmalecount(actor[] positions)
endfunction
int function transfemalecount(actor[] positions)
endfunction
int function transcreaturecount(actor[] positions)
endfunction
form function equipstrapon(actor actorref)
endfunction
function unequipstrapon(actor actorref)
endfunction
int function countcum(actor actorref, bool vaginal = true, bool oral = true, bool anal = true)
endfunction
function addcum(actor actorref, bool vaginal = true, bool oral = true, bool anal = true)
endfunction
function clearcum(actor actorref)
endfunction
bool function checkbardaudience(actor actorref, bool removefromaudience = true)
endfunction
actor[] function sortactors(actor[] positions, bool femalefirst = true)
endfunction
actor[] function sortactorsbyscene(string assceneid, actor[] akpositions, actor[] aksubmissives)
endfunction
actor function findavailableactor(objectreference centerref, float radius = 5000.0, int findgender = -1, actor ignoreref1 = none, actor ignoreref2 = none, actor ignoreref3 = none, actor ignoreref4 = none)
endfunction
actor function findavailableactorbyfaction(faction factionref, objectreference centerref, float radius = 5000.0, int findgender = -1, actor ignoreref1 = none, actor ignoreref2 = none, actor ignoreref3 = none, actor ignoreref4 = none, bool hasfaction = true)
endfunction
actor function findavailableactorwornform(int slotmask, objectreference centerref, float radius = 5000.0, int findgender = -1, actor ignoreref1 = none, actor ignoreref2 = none, actor ignoreref3 = none, actor ignoreref4 = none, bool avoidnostripkeyword = true, bool haswornform = true)
endfunction
actor function findavailablecreature(string racekey, objectreference centerref, float radius = 5000.0, int findgender = 2, actor ignoreref1 = none, actor ignoreref2 = none, actor ignoreref3 = none, actor ignoreref4 = none)
endfunction
actor function findavailablecreaturebyfaction(string racekey, faction factionref, objectreference centerref, float radius = 5000.0, int findgender = -1, actor ignoreref1 = none, actor ignoreref2 = none, actor ignoreref3 = none, actor ignoreref4 = none, bool hasfaction = true)
endfunction
actor function findavailablecreaturewornform(string racekey, int slotmask, objectreference centerref, float radius = 5000.0, int findgender = -1, actor ignoreref1 = none, actor ignoreref2 = none, actor ignoreref3 = none, actor ignoreref4 = none, bool avoidnostripkeyword = true, bool haswornform = true)
endfunction
actor[] function findavailablepartners(actor[] positions, int totalactors, int males = -1, int females = -1, float radius = 10000.0)
endfunction
function sendtrackedevent(actor actorref, string hook, int id = -1)
endfunction
sslthreadcontroller function getcontroller(int tid)
endfunction
int function findactorcontroller(actor actorref)
endfunction
int function findplayercontroller()
endfunction
sslthreadcontroller function getactorcontroller(actor actorref)
endfunction
sslthreadcontroller function getplayercontroller()
endfunction
int function getenjoyment(int tid, actor actorref)
endfunction
bool function isvictim(int tid, actor actorref)
endfunction
bool function isaggressor(int tid, actor actorref)
endfunction
bool function isusingstrapon(int tid, actor actorref)
endfunction
bool function pregnancyrisk(int tid, actor actorref, bool allowfemalecum = false, bool allowcreaturecum = false)
endfunction
actor[] function sortactorsbyanimation(actor[] positions, sslbaseanimation animation = none)
endfunction
sslbaseanimation function getanimationbyname(string findname)
endfunction
sslbaseanimation function getanimationbyregistry(string registry)
endfunction
int function findanimationbyname(string findname)
endfunction
int function getanimationcount(bool ignoredisabled = true)
endfunction
sslbaseanimation[] function mergeanimationlists(sslbaseanimation[] list1, sslbaseanimation[] list2)
endfunction
sslbaseanimation[] function removetagged(sslbaseanimation[] anims, string tags)
endfunction
int function counttag(sslbaseanimation[] anims, string tags)
endfunction
int function counttagusage(string tags, bool ignoredisabled = true)
endfunction
int function countcreaturetagusage(string tags, bool ignoredisabled = true)
endfunction
string[] function getallanimationtags(int actorcount = -1, bool ignoredisabled = true)
endfunction
string[] function getallanimationtagsinarray(sslbaseanimation[] list)
endfunction
sslbaseanimation function getcreatureanimationbyname(string findname)
endfunction
sslbaseanimation function getcreatureanimationbyregistry(string registry)
endfunction
bool function hascreatureraceanimation(race creaturerace, int actorcount = -1, int gender = -1)
endfunction
bool function hascreatureracekeyanimation(string racekey, int actorcount = -1, int gender = -1)
endfunction
bool function allowedcreature(race creaturerace)
endfunction
bool function allowedcreaturecombination(race creaturerace, race creaturerace2)
endfunction
string[] function getallcreatureanimationtags(int actorcount = -1, bool ignoredisabled = true)
endfunction
string[] function getallbothanimationtags(int actorcount = -1, bool ignoredisabled = true)
endfunction
int function registerstat(string name, string value, string prepend = "", string append = "")
endfunction
function alter(string name, string newname = "", string value = "", string prepend = "", string append = "")
endfunction
int function findstat(string name)
endfunction
string function getactorstat(actor actorref, string name)
endfunction
int function getactorstatint(actor actorref, string name)
endfunction
float function getactorstatfloat(actor actorref, string name)
endfunction
string function setactorstat(actor actorref, string name, string value)
endfunction
int function actoradjustby(actor actorref, string name, int adjustby)
endfunction
string function getactorstatfull(actor actorref, string name)
endfunction
string function getstatfull(string name)
endfunction
string function getstat(string name)
endfunction
int function getstatint(string name)
endfunction
float function getstatfloat(string name)
endfunction
string function setstat(string name, string value)
endfunction
int function adjustby(string name, int adjustby)
endfunction
bool function isimpure(actor actorref)
endfunction
float function adjustpurity(actor actorref, float amount)
endfunction
float function getpurity(actor actorref)
endfunction
int function getpuritylevel(actor actorref)
endfunction
string function getpuritytitle(actor actorref)
endfunction
bool function ispure(actor actorref)
endfunction
bool function islewd(actor actorref)
endfunction
float function adjustplayerpurity(float amount)
endfunction
int function getplayerpuritylevel()
endfunction
string function getplayerpuritytitle()
endfunction
float function dayssincelastsex(actor actorref)
endfunction
float function hourssincelastsex(actor actorref)
endfunction
float function minutessincelastsex(actor actorref)
endfunction
float function secondssincelastsex(actor actorref)
endfunction
string function lastsextimerstring(actor actorref)
endfunction
float function lastsexrealtime(actor actorref)
endfunction
float function dayssincelastsexrealtime(actor actorref)
endfunction
float function hourssincelastsexrealtime(actor actorref)
endfunction
float function minutessincelastsexrealtime(actor actorref)
endfunction
float function secondssincelastsexrealtime(actor actorref)
endfunction
string function lastsextimerstringrealtime(actor actorref)
endfunction
int function calcsexuality(bool isfemale, int males, int females)
endfunction
int function calclevel(float total, float curve = 0.65)
endfunction
int function getplayerstatlevel(string skill)
endfunction
string function getplayersexualitytitle()
endfunction
string function getplayerskilltitle(string skill)
endfunction
int function getplayerskilllevel(string skill)
endfunction
string function getsexualitytitle(actor actorref)
endfunction
string function getskilltitle(actor actorref, string skill)
endfunction
int function playersexcount(actor actorref)
endfunction
bool function hadplayersex(actor actorref)
endfunction
actor function mostusedplayersexpartner()
endfunction
actor[] function mostusedplayersexpartners(int maxactors = 5)
endfunction
float function lastsexgametime(actor actorref)
endfunction
actor function lastsexpartner(actor actorref)
endfunction
bool function hashadsextogether(actor actorref1, actor actorref2)
endfunction
actor function lastaggressor(actor actorref)
endfunction
bool function wasvictimof(actor victimref, actor aggressorref)
endfunction
actor function lastvictim(actor actorref)
endfunction
bool function wasaggressorto(actor aggressorref, actor victimref)
endfunction
function setsexuality(actor actorref, int amount)
endfunction
function setsexualitystraight(actor actorref)
endfunction
function setsexualitybisexual(actor actorref)
endfunction
function setsexualitygay(actor actorref)
endfunction
int function getsexuality(actor actorref)
endfunction
int function getskill(actor actorref, string skill)
endfunction
int function getskilllevel(actor actorref, string skill)
endfunction
bool function isstraight(actor actorref)
endfunction
bool function isbisexual(actor actorref)
endfunction
bool function isgay(actor actorref)
endfunction
int function sexcount(actor actorref)
endfunction
bool function hadsex(actor actorref)
endfunction
sslbasevoice function newvoiceobject(string token, form owner)
endfunction
sslbaseexpression function newexpressionobject(string token, form owner)
endfunction
sslbasevoice function getsetvoiceobject(string token, string callback, form owner)
endfunction
sslbaseexpression function getsetexpressionobject(string token, string callback, form owner)
endfunction
sslbasevoice function newvoiceobjectcopy(string token, sslbasevoice copyfrom, form owner)
endfunction
sslbaseexpression function newexpressionobjectcopy(string token, sslbaseexpression copyfrom, form owner)
endfunction
sslbasevoice function getvoiceobject(string token)
endfunction
sslbaseexpression function getexpressionobject(string token)
endfunction
sslbasevoice[] function getownervoices(form owner)
endfunction
sslbaseexpression[] function getownerexpressions(form owner)
endfunction
bool function hasvoiceobject(string token)
endfunction
bool function hasexpressionobject(string token)
endfunction
bool function releasevoiceobject(string token)
endfunction
bool function releaseexpressionobject(string token)
endfunction
int function releaseownervoices(form owner)
endfunction
int function releaseownerexpressions(form owner)
endfunction
sslbasevoice function makevoiceregistered(string token)
endfunction
sslbaseexpression function makeexpressionregistered(string token)
endfunction
bool function hasanimationobject(string token)
endfunction
bool function releaseanimationobject(string token)
endfunction
int function releaseowneranimations(form owner)
endfunction
sslbaseexpression function pickexpression(actor actorref, actor victimref = none)
endfunction
sslbaseexpression function pickexpressionbystatus(actor actorref, bool isvictim = false, bool isaggressor = false)
endfunction
sslbaseexpression[] function getexpressionsbystatus(actor actorref, bool isvictim = false, bool isaggressor = false)
endfunction
sslbaseexpression function pickexpressionsbytag(actor actorref, string tag)
endfunction
sslbaseexpression[] function getexpressionsbytag(actor actorref, string tag)
endfunction
sslbaseexpression function getexpressionbyname(string findname)
endfunction
int function findexpressionbyname(string findname)
endfunction
sslbaseexpression function getexpressionbyslot(int slot)
endfunction
function openmouth(actor actorref)
endfunction
function closemouth(actor actorref)
endfunction
bool function ismouthopen(actor actorref)
endfunction
sslbasevoice function pickvoice(actor actorref)
endfunction
sslbasevoice function getvoice(actor actorref)
endfunction
function savevoice(actor actorref, sslbasevoice saving)
endfunction
function forgetvoice(actor actorref)
endfunction
sslbasevoice function getsavedvoice(actor actorref)
endfunction
bool function hascustomvoice(actor actorref)
endfunction
sslbasevoice function getvoicebygender(int gender)
endfunction
sslbasevoice[] function getvoicesbygender(int gender)
endfunction
sslbasevoice function getvoicebyname(string findname)
endfunction
int function findvoicebyname(string findname)
endfunction
sslbasevoice function getvoicebyslot(int slot)
endfunction
sslbasevoice function getvoicebytags(string tags, string tagsuppress = "", bool requireall = true)
endfunction
sslbasevoice[] function getvoicesbytags(string tags, string tagsuppress = "", bool requireall = true)
endfunction
sslbasevoice function registervoice(string registrar, form callbackform = none, referencealias callbackalias = none)
endfunction
sslbaseexpression function registerexpression(string registrar, form callbackform = none, referencealias callbackalias = none)
endfunction
bool function removeregisteredvoice(string registrar)
endfunction
bool function removeregisteredexpression(string registrar)
endfunction
sslsystemconfig property config auto
sslactorlibrary property actorlib auto
sslthreadlibrary property threadlib auto
sslthreadslots property threadslots auto
function setup()
endfunction
sslthreadmodel function newthread(float timeout = 5.0)
endfunction
sexlabthread function startsceneimpl(actor[] akpositions, string[] asscenes, string ascontext, actor[] aksubmissive, objectreference akcenter, int aifurniture, string ashook)
endfunction
function log(string log, string type = "notice")
endfunction
auto state disabled
sslthreadmodel function newthread(float timeout = 5.0)
endfunction
sexlabthread function startscene(actor[] akpositions, string astags, actor aksubmissive = none, objectreference akcenter = none, int aifurniture = 1, string ashook = "")
endfunction
sexlabthread function startscenea(actor[] akpositions, string astags, actor[] aksubmissives, objectreference akcenter = none, int aifurniture = 1, string ashook = "")
endfunction
sexlabthread function startsceneex(actor[] akpositions, string[] asanims, actor aksubmissive = none, string ascontext = "", \
objectreference akcenter = none, int aifurniture = 1, string ashook = "")
endfunction
sexlabthread function startsceneexa(actor[] akpositions, string[] asscenes, actor[] aksubmissives, string ascontext = "", \
objectreference akcenter = none, int aifurniture = 1, string ashook = "")
endfunction
sexlabthread function startscenequick(actor akactor1, actor akactor2 = none, actor akactor3 = none, actor akactor4 = none, actor akactor5 = none, \
actor aksubmissive = none, string astags = "", string ashook = "")
endfunction
sexlabthread function startsceneimpl(actor[] akpositions, string[] asscenes, string ascontext, actor[] aksubmissive, objectreference akcenter, int aifurniture, string ashook)
endfunction
sslthreadcontroller function quickstart(actor actor1, actor actor2 = none, actor actor3 = none, actor actor4 = none, actor actor5 = none, actor victim = none, string hook = "", string animationtags = "")
endfunction
int function startsex(actor[] positions, sslbaseanimation[] anims, actor victim = none, objectreference centeron = none, bool allowbed = true, string hook = "")
endfunction
event onbeginstate()
endevent
endstate
function logdisabled(string asfunc)
endfunction
state enabled
event onbeginstate()
endevent
endstate
actor property playerref
actor function get()
endfunction
endproperty
faction property animatingfaction
faction function get()
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
sslvoiceslots property voiceslots hidden
sslvoiceslots function get()
endfunction
endproperty
sslobjectfactory property factory hidden
sslobjectfactory function get()
endfunction
endproperty
sslactorstats property stats hidden
sslactorstats function get()
endfunction
endproperty
sslexpressionslots property expressionslots hidden
sslexpressionslots function get()
endfunction
endproperty
event oninit()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1