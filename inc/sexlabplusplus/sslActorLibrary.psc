scriptname sslactorlibrary extends sslsystemlibrary
string property active_set_prefix = "sexlabactiveset" autoreadonly hidden
string property active_layer_prefix = "sexlabactivelayer" autoreadonly hidden
string property last_applied_time_prefix = "sexlablastappliedtime" autoreadonly hidden
string property last_applied_texture_prefix = "sexlablastappliedtexture" autoreadonly hidden
string property applied_texture_list = "sexlabappliedtexturelist" autoreadonly hidden
int property fx_all = -1 autoreadonly hidden
int property fx_vaginal = 0 autoreadonly hidden
int property fx_anal = 1 autoreadonly hidden
int property fx_oral = 2 autoreadonly hidden
spell property abcumfx auto
spell property cumvaginalspell auto
spell property cumoralspell auto
spell property cumanalspell auto
function addcumfx(actor akactor, int aitype)
endfunction
function removecumfx(actor aktarget, int aitype)
endfunction
int function countcumfx(actor akactor, int aitype)
endfunction
function writestrip(form akexcludeform, bool abneverstrip) native global
function erasestrip(form akexcludeform) native global
function erasestripall() native global
int function checkstrip(form akcheckform) native global
function makenostrip(form itemref)
endfunction
function makealwaysstrip(form itemref)
endfunction
function clearstripoverride(form itemref)
endfunction
function resetstripoverrides()
endfunction
bool function isnostrip(form itemref)
endfunction
bool function isalwaysstrip(form itemref)
endfunction
bool function isstrippable(form itemref)
endfunction
form[] function stripactor(actor actorref, actor victimref = none, bool doanimate = true, bool leadin = false)
endfunction
form[] function stripslots(actor actorref, bool[] strip, bool doanimate = false, bool allownudesuit = true)
endfunction
form function stripslot(actor actorref, int slotmask)
endfunction
function unstripactor(actor actorref, form[] stripped, bool isvictim = false)
endfunction
faction property forbiddenfaction auto
int function validateactorimpl(actor akactor) native global
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
faction property genderfaction auto
int[] function getsexall(actor[] akpositions) global
endfunction
function treatassex(actor akactor, int aisextag)
endfunction
function clearforcedsex(actor akactor)
endfunction
int[] function countsexall(actor[] akpositions) global
endfunction
int function countmale(actor[] akpositions) global
endfunction
int function countfemale(actor[] akpositions) global
endfunction
int function countfuta(actor[] akpositions) global
endfunction
int function countcreatures(actor[] akpositions) global
endfunction
int function countcrtmale(actor[] akpositions) global
endfunction
int function countcrtfemale(actor[] akpositions) global
endfunction
bool function hasvehicle(actor akactor) native global
form[] function unequipslots(actor akactor, int aislots) native global
string function pickrandomfxset(int astype) native global
int function getfxsetcount(int astype, string asset) native global
form[] function stripactorimpl(actor akactor, int aislots, bool abstripweapons = true, bool abanimate = false)
endfunction
function beginoverlay(actor aktarget, int aitype)
endfunction
function applyoverlay(actor aktarget, bool isfemale, string asarea, string asoverlayslot, string astexture, string asset)
endfunction
function removepartoverlay(actor aktarget, bool isfemale, string lasteffect)
endfunction
int function getemptyslot(actor aktarget, bool isfemale, string asarea, int aitype)
endfunction
string[] function getareas()
endfunction
int function getnumslots(string area)
endfunction
string function typetostring(int aitype)
endfunction
faction property animatingfaction hidden
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
endproperty
keyword property cumvaginalstackedkeyword hidden
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
keyword property actortypenpc hidden
keyword function get()
endfunction
endproperty
bool function iscreature(actor actorref)
endfunction
int function getgender(actor actorref)
endfunction
function treatasgender(actor actorref, bool asfemale)
endfunction
function clearforcedgender(actor actorref) ; replaced to stay consistent with vocabulary
endfunction
function treatasmale(actor actorref)
endfunction
function treatasfemale(actor actorref)
endfunction
int function gettrans(actor actorref)
endfunction
int[] function gettransall(actor[] positions)
endfunction
int[] function transcount(actor[] positions)
endfunction
int[] function getgendersall(actor[] positions)
endfunction
int[] function gendercount(actor[] positions)
endfunction
int function malecount(actor[] positions)
endfunction
int function femalecount(actor[] positions)
endfunction
int function creaturecount(actor[] positions)
endfunction
int function creaturemalecount(actor[] positions)
endfunction
int function creaturefemalecount(actor[] positions)
endfunction
string function makegendertag(actor[] positions)
endfunction
string function getgendertag(int females = 0, int males = 0, int creatures = 0)
endfunction
bool function continuestrip(form itemref, bool dostrip = true) global
endfunction
bool function cananimate(actor actorref)
endfunction
function applycum(actor actorref, int cumid)
endfunction
function addcum(actor actorref, bool vaginal = true, bool oral = true, bool anal = true)
endfunction
int function countcum(actor actorref, bool vaginal = true, bool oral = true, bool anal = true)
endfunction
function clearcum(actor actorref)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1