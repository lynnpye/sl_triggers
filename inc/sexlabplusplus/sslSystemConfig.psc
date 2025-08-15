scriptname sslsystemconfig extends sslsystemlibrary
sound[] property hotkeyup auto
sound[] property hotkeydown auto
message property cleansystemfinish auto
message property checkskse auto
message property checkskyrim auto
message property checkpapyrusutil auto
message property checkskyui auto
message property takethreadcontrol auto
soundcategory property audiosfx auto
soundcategory property audiovoice auto
float function getminsetuptime() native global
int function getanimationcount() native global
float[] function getenjoymentfactors() native global
int function getenjoymentsettingint(string assetting) native global
float function getenjoymentsettingflt(string assetting) native global
form[] function getstrippableitems(actor akactor, bool abwornonly) native global
bool function getsettingbool(string assetting) native global
int function getsettingint(string assetting) native global
float function getsettingflt(string assetting) native global
string function getsettingstr(string assetting) native global
int function getsettinginta(string assetting, int n) native global
float function getsettingflta(string assetting, int n) native global
function setsettingbool(string assetting, bool abvalue) native global
function setsettingint(string assetting, int aivalue) native global
function setsettingflt(string assetting, float aivalue) native global
function setsettingstr(string assetting, string asvalue) native global
function setsettinginta(string assetting, int aivalue, int n) native global
function setsettingflta(string assetting, float aivalue, int n) native global
int property climaxtype_scene  = 0 autoreadonly
int property climaxtype_legacy = 1 autoreadonly
int property climaxtype_extern = 2 autoreadonly
spell[] property matchmakerspells auto
bool property matchmaker hidden
bool function get()
endfunction
function set(bool abvalue)
endfunction
endproperty
function addremovematchmakerspells()
endfunction
string function parsemmtagstring() global
endfunction
string function mergetagstring(string req, string[] add, string prefix) global
endfunction
bool property debugmode hidden
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property allowcreatures hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property usecreaturegender hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property redressvictim hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property uselipsync hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property useexpressions hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property usecum hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property disableplayer hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property autotfc hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property autoadvance hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property orgasmeffects hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property showinmap hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property setanimspeedbyenjoyment hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property disableteleport hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property disablescale hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property undressanimation hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property submissiveplayer hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property submissivetarget hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
int property askbed hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property npcbed hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property usefade hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
string property requiredtags hidden
string function get()
endfunction
function set(string asset)
endfunction
endproperty
string property excludedtags hidden
string function get()
endfunction
function set(string asset)
endfunction
endproperty
string property optionaltags hidden
string function get()
endfunction
function set(string asset)
endfunction
endproperty
bool property lipsfixedvalue hidden
bool function get()
endfunction
function set(bool aiset)
endfunction
endproperty
int property lipssoundtime hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
bool property adjusttargetstage  hidden
bool function get()
endfunction
function set(bool abset)
endfunction
endproperty
int property adjuststage hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property advanceanimation hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property changeanimation hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property changepositions hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property adjustchange hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property adjustforward hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property adjustsideways hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property adjustupward hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property realignactors hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property movescene hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property restoreoffsets hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property rotatescene hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property endanimation hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property adjustschlong hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property backwards hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property togglefreecamera hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
int property targetactor hidden
int function get()
endfunction
function set(int aiset)
endfunction
endproperty
float property cumtimer hidden
float function get()
endfunction
function set(float afset)
endfunction
endproperty
float property shakestrength hidden
float function get()
endfunction
function set(float afset)
endfunction
endproperty
float property autosucsm hidden
float function get()
endfunction
function set(float afset)
endfunction
endproperty
float property malevoicedelay hidden
float function get()
endfunction
function set(float afset)
endfunction
endproperty
float property femalevoicedelay hidden
float function get()
endfunction
function set(float afset)
endfunction
endproperty
float property voicevolume hidden
float function get()
endfunction
function set(float afset)
endfunction
endproperty
float property sfxdelay hidden
float function get()
endfunction
function set(float afset)
endfunction
endproperty
float property sfxvolume hidden
float function get()
endfunction
function set(float afset)
endfunction
endproperty
float[] property stagetimer hidden
float[] function get()
endfunction
function set(float[] aset)
endfunction
endproperty
float[] function _getftimers(int aiidx0)
endfunction
function _setftimers(int aiidx0, float[] afset)
endfunction
bool property hasnioverride hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool property hasmfgfix hidden
bool function get()
endfunction
endproperty
bool function hasanimspeedse() global
endfunction
float function getvoicedelay(bool isfemale = false, int stage = 1, bool issilent = false)
endfunction
int[] function getstripforms(bool abfemaleorsubmissive, bool abaggressive) global
endfunction
bool function setcustombedoffset(form basebed, float forward = 0.0, float sideward = 0.0, float upward = 37.0, float rotation = 0.0)
endfunction
bool function clearcustombedoffset(form basebed)
endfunction
float[] function getbedoffsets(form basebed)
endfunction
sound property orgasmfx auto
sound property squishingfx auto
sound property suckingfx auto
sound property sexmixedfx auto
spell property selectedspell auto
actor property targetref auto hidden
event oncrosshairrefchange(objectreference actorref)
endevent
event onkeydown(int keycode)
endevent
function settargetactor()
endfunction
function togglefreecamera()
endfunction
bool function backwardspressed()
endfunction
bool function adjuststagepressed()
endfunction
bool function isadjuststagepressed()
endfunction
bool function mirrorpress(int mirrorkey)
endfunction
sslthreadcontroller function getthreadcontrolled()
endfunction
bool function hasthreadcontrol(sexlabthread akthread)
endfunction
function getthreadcontrol(sslthreadcontroller targetthread)
endfunction
function disablethreadcontrol(sslthreadcontroller targetthread)
endfunction
int property hookid_starting    = 0 autoreadonly
int property hookid_stagestart  = 1 autoreadonly
int property hookid_stageend    = 2 autoreadonly
int property hookid_end         = 3 autoreadonly
bool function addhook(sexlabthreadhook akhook)
endfunction
bool function removehook(sexlabthreadhook akhook)
endfunction
bool function ishooked(sexlabthreadhook akhook)
endfunction
function runhook(int aihookid, sexlabthread akthread)
endfunction
faction property bardexcludefaction auto
referencealias property bardbystander1 auto
referencealias property bardbystander2 auto
referencealias property bardbystander3 auto
referencealias property bardbystander4 auto
referencealias property bardbystander5 auto
bool function checkbardaudience(actor actorref, bool removefromaudience = true)
endfunction
bool function bystanderclear(actor actorref, referencealias bardbystander)
endfunction
armor property calypsstrapon auto
form[] property strapons auto hidden
form function getstrapon()
endfunction
form function wornstrapon(actor actorref)
endfunction
bool function hasstrapon(actor actorref)
endfunction
form function pickstrapon(actor actorref)
endfunction
function loadstrapons()
endfunction
armor function loadstrapon(string esp, int id)
endfunction
function loadstraponex(armor akstraponform)
endfunction
bool function checksystempart(string checksystem)
endfunction
bool function checksystem()
endfunction
function reload()
endfunction
function setup()
endfunction
imagespacemodifier property fadetoblackandbackimod auto
imagespacemodifier property blurandbackimod auto
function applyfade(bool forcetest = false)
endfunction
function removefade(bool forcetest = false)
endfunction
function storeactor(form formref) global
endfunction
int function getversion()
endfunction
string function getstringver()
endfunction
bool property enabled hidden
bool function get()
endfunction
endproperty
sexlabframework property sexlab
sexlabframework function get()
endfunction
endproperty
message property checkfnis hidden
message function get()
endfunction
endproperty
message property checksexlabutil hidden
message function get()
endfunction
endproperty
faction property animatingfaction hidden
faction function get()
endfunction
endproperty
faction property genderfaction hidden
faction function get()
endfunction
endproperty
faction property forbiddenfaction hidden
faction function get()
endfunction
endproperty
weapon property dummyweapon hidden
weapon function get()
endfunction
endproperty
armor property nudesuit hidden
armor function get()
endfunction
endproperty
keyword property actortypenpc hidden
keyword function get()
endfunction
endproperty
keyword property sexlabactive hidden
keyword function get()
endfunction
endproperty
keyword property furniturebedroll hidden
keyword function get()
endfunction
endproperty
furniture property basemarker hidden
furniture function get()
endfunction
endproperty
package property donothing hidden
package function get()
endfunction
endproperty
formlist property bedslist hidden
formlist function get()
endfunction
endproperty
formlist property bedrollslist hidden
formlist function get()
endfunction
endproperty
formlist property doublebedslist hidden
formlist function get()
endfunction
endproperty
static property locationmarker hidden
static function get()
endfunction
endproperty
message property usebed hidden
message function get()
endfunction
endproperty
topic property lipsync hidden
topic function get()
endfunction
endproperty
voicetype property sexlabvoicem hidden
voicetype function get()
endfunction
endproperty
voicetype property sexlabvoicef hidden
voicetype function get()
endfunction
endproperty
formlist property sexlabvoices hidden
formlist function get()
endfunction
endproperty
idle property idlereset hidden
idle function get()
endfunction
endproperty
spell property cumvaginaloralanalspell hidden
spell function get()
endfunction
endproperty
spell property cumoralanalspell hidden
spell function get()
endfunction
endproperty
spell property cumvaginaloralspell hidden
spell function get()
endfunction
endproperty
spell property cumvaginalanalspell hidden
spell function get()
endfunction
endproperty
spell property cumvaginalspell hidden
spell function get()
endfunction
endproperty
spell property cumoralspell hidden
spell function get()
endfunction
endproperty
spell property cumanalspell hidden
spell function get()
endfunction
endproperty
spell property vaginal1oral1anal1 hidden
spell function get()
endfunction
endproperty
spell property vaginal2oral1anal1 hidden
spell function get()
endfunction
endproperty
spell property vaginal2oral2anal1 hidden
spell function get()
endfunction
endproperty
spell property vaginal2oral1anal2 hidden
spell function get()
endfunction
endproperty
spell property vaginal1oral2anal1 hidden
spell function get()
endfunction
endproperty
spell property vaginal1oral2anal2 hidden
spell function get()
endfunction
endproperty
spell property vaginal1oral1anal2 hidden
spell function get()
endfunction
endproperty
spell property vaginal2oral2anal2 hidden
spell function get()
endfunction
endproperty
spell property oral1anal1 hidden
spell function get()
endfunction
endproperty
spell property oral2anal1 hidden
spell function get()
endfunction
endproperty
spell property oral1anal2 hidden
spell function get()
endfunction
endproperty
spell property oral2anal2 hidden
spell function get()
endfunction
endproperty
spell property vaginal1oral1 hidden
spell function get()
endfunction
endproperty
spell property vaginal2oral1 hidden
spell function get()
endfunction
endproperty
spell property vaginal1oral2 hidden
spell function get()
endfunction
endproperty
spell property vaginal2oral2 hidden
spell function get()
endfunction
endproperty
spell property vaginal1anal1 hidden
spell function get()
endfunction
endproperty
spell property vaginal2anal1 hidden
spell function get()
endfunction
endproperty
spell property vaginal1anal2 hidden
spell function get()
endfunction
endproperty
spell property vaginal2anal2 hidden
spell function get()
endfunction
endproperty
spell property vaginal1 hidden
spell function get()
endfunction
endproperty
spell property vaginal2 hidden
spell function get()
endfunction
endproperty
spell property oral1 hidden
spell function get()
endfunction
endproperty
spell property oral2 hidden
spell function get()
endfunction
endproperty
spell property anal1 hidden
spell function get()
endfunction
endproperty
spell property anal2 hidden
spell function get()
endfunction
endproperty
keyword property cumoralkeyword hidden
keyword function get()
endfunction
endproperty
keyword property cumanalkeyword hidden
keyword function get()
endfunction
endproperty
keyword property cumvaginalkeyword hidden
keyword function get()
endfunction
endproperty
keyword property cumoralstackedkeyword hidden
keyword function get()
endfunction
endproperty
keyword property cumanalstackedkeyword hidden
keyword function get()
endfunction
function set(keyword aset)
endfunction
endproperty
keyword property cumvaginalstackedkeyword hidden
keyword function get()
endfunction
endproperty
globalvariable property debugvar1 hidden
globalvariable function get()
endfunction
endproperty
globalvariable property debugvar2 hidden
globalvariable function get()
endfunction
endproperty
globalvariable property debugvar3 hidden
globalvariable function get()
endfunction
endproperty
globalvariable property debugvar4 hidden
globalvariable function get()
endfunction
endproperty
globalvariable property debugvar5 hidden
globalvariable function get()
endfunction
endproperty
actor[] property targetrefs auto hidden
bool property hasschlongs hidden
bool function get()
endfunction
endproperty
bool property hasfrostfall
bool function get()
endfunction
endproperty
formlist property frostexceptions
formlist function get()
endfunction
endproperty
float[] property bedoffset hidden
float[] function get()
endfunction
endproperty
function setdefaults()
endfunction
function exportprofile(int profile = 1)
endfunction
function importprofile(int profile = 1)
endfunction
function swaptoprofile(int profile)
endfunction
bool function setadjustmentprofile(string profilename) global
endfunction
bool function saveadjustmentprofile() global
endfunction
function exportsettings()
endfunction
function importsettings()
endfunction
function exportint(string name, int value)
endfunction
int function importint(string name, int value)
endfunction
function exportbool(string name, bool value)
endfunction
bool function importbool(string name, bool value)
endfunction
function exportfloat(string name, float value)
endfunction
float function importfloat(string name, float value)
endfunction
function exportfloatlist(string name, float[] values, int len)
endfunction
float[] function importfloatlist(string name, float[] values, int len)
endfunction
function exportboollist(string name, bool[] values, int len)
endfunction
bool[] function importboollist(string name, bool[] values, int len)
endfunction
function exportanimations()
endfunction
function importanimations()
endfunction
function exportcreatures()
endfunction
function importcreatures()
endfunction
function exportvoices()
endfunction
function importvoices()
endfunction
function exportexpressions()
endfunction
function importexpressions()
endfunction
bool property restrictaggressive = false auto hidden
bool property restrictstrapons = false auto hidden
bool property usemalenudesuit = false auto hidden
bool property usefemalenudesuit = false auto hidden
bool property npcsavevoice = true auto hidden
bool property ragdollend = false auto hidden
bool property refreshexpressions = true auto hidden
bool property allowffcum = false auto hidden
bool property foreplaystage = false auto hidden
bool property bedremovestanding = true auto hidden
bool property restrictgendertag = false auto hidden
bool property removeheeleffect = true auto hidden
bool property seednpcstats = true auto hidden
bool property fixvictimpos = true auto hidden
bool property forcesort = true auto hidden
bool property limitedstrip = false auto hidden
bool property scaleactors = false auto hidden ; scale is encoded in animation, disable all scale with other setting
int property animprofile = 1 auto hidden  ; scaling is considered absolute, 1 profile to fit them all
float property expressiondelay = 2.0 auto hidden
float property leadincooldown = 0.0 auto hidden
bool property raceadjustments = false auto hidden    ; this and v is used for actorkey scale profile settings
bool property usestrapons = true auto hidden
bool property restrictsamesex = false auto hidden
int property lipsphoneme = 0 auto hidden
int property lipsminvalue = 20 auto hidden
int property lipsmaxvalue = 50 auto hidden
float property lipsmovetime = 0.2 auto hidden
int property openmouthsize = 80 auto hidden
bool property separateorgasms hidden
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
float[] property stagetimerleadin hidden
float[] function get()
endfunction
endproperty
float[] property stagetimeraggr hidden
float[] function get()
endfunction
endproperty
float[] property openmouthmale hidden
float[] function get()
endfunction
endproperty
float[] property openmouthfemale hidden
float[] function get()
endfunction
endproperty
float[] function getopenmouthphonemes(bool isfemale)
endfunction
bool function setopenmouthphonemes(bool isfemale, float[] phonemes)
endfunction
bool function setopenmouthphoneme(bool isfemale, int id, float value)
endfunction
int function getopenmouthexpression(bool isfemale)
endfunction
bool function setopenmouthexpression(bool isfemale, int value)
endfunction
event oninit()
endevent
bool function addcustombed(form basebed, int bedtype = 0)
endfunction
form function equipstrapon(actor actorref)
endfunction
function unequipstrapon(actor actorref)
endfunction
bool function usesnudesuit(bool isfemale)
endfunction
bool property hashdtheels hidden
bool function get()
endfunction
endproperty
spell function gethdtspell(actor actorref)
endfunction
function addtargetactor(actor actorref)
endfunction
int function registerthreadhook(sslthreadhook hook)
endfunction
sslthreadhook[] function getthreadhooks()
endfunction
int function getthreadhookcount()
endfunction
function initthreadhooks()
endfunction
bool function hascreatureinstall()
endfunction
function reloaddata()
endfunction
int[] function getstripsettings(bool isfemale, bool isleadin = false, bool isaggressive = false, bool isvictim = false)
endfunction
bool[] function getstrip(bool isfemale, bool isleadin = false, bool isaggressive = false, bool isvictim = false)
endfunction
bool[] property stripmale hidden
bool[] function get()
endfunction
endproperty
bool[] property stripfemale hidden
bool[] function get()
endfunction
endproperty
bool[] property stripleadinmale hidden
bool[] function get()
endfunction
endproperty
bool[] property stripleadinfemale hidden
bool[] function get()
endfunction
endproperty
bool[] property stripvictim hidden
bool[] function get()
endfunction
endproperty
bool[] property stripaggressor hidden
bool[] function get()
endfunction
endproperty
bool property brestrictaggressive hidden
bool function get()
endfunction
endproperty
bool property ballowcreatures hidden
bool function get()
endfunction
endproperty
bool property busestrapons hidden
bool function get()
endfunction
endproperty
bool property bredressvictim hidden
bool function get()
endfunction
endproperty
bool property bragdollend hidden
bool function get()
endfunction
endproperty
bool property bundressanimation hidden
bool function get()
endfunction
endproperty
bool property bscaleactors hidden
bool function get()
endfunction
endproperty
bool property busecum hidden
bool function get()
endfunction
endproperty
bool property ballowffcum hidden
bool function get()
endfunction
endproperty
bool property bdisableplayer hidden
bool function get()
endfunction
endproperty
bool property bautotfc hidden
bool function get()
endfunction
endproperty
bool property bautoadvance hidden
bool function get()
endfunction
endproperty
bool property bforeplaystage hidden
bool function get()
endfunction
endproperty
bool property borgasmeffects hidden
bool function get()
endfunction
endproperty
;This file was cleaned with PapyrusSourceHeadliner 1