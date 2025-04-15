scriptname ccbgssse001_fishingsystemscript extends quest  
int property biome_type_stream = 0 autoreadonly
int property biome_type_lake = 1 autoreadonly
int property biome_type_arctic = 2 autoreadonly
int property biome_type_cave = 3 autoreadonly
string property reset_anim = "reset" autoreadonly
string property cast_anim = "cast" autoreadonly
string property linetug_animvar = "ifishbite" autoreadonly
string property population_animvar = "ifishpopulation" autoreadonly
string property linetug_fish_anim = "bitefish" autoreadonly
string property linetug_object_anim = "biteobject" autoreadonly
string property population_empty_anim = "idleempty" autoreadonly
string property population_sparse_anim = "idlesparse" autoreadonly
string property population_full_anim = "idlefull" autoreadonly
string property exit_anim = "exit" autoreadonly
string property fastexit_anim = "fastexit" autoreadonly
string property nibble_anim = "nibble" autoreadonly
string property catch_success_anim = "catchsuccess" autoreadonly
string property catch_failure_anim = "catchfail" autoreadonly
string property timeout_anim = "timeout" autoreadonly
float property linetug_type_none = 1.0 autoreadonly
float property linetug_type_nibble = 2.0 autoreadonly
float property linetug_type_tugfish = 3.0 autoreadonly
float property linetug_type_tugobject = 4.0 autoreadonly
int property updatetype_start = 1 autoreadonly
int property updatetype_sequence = 2 autoreadonly
int property updatetype_catchtimeout = 3 autoreadonly
int property updatetype_setqueststage = 4 autoreadonly
globalvariable property ccbgssse001_catchtypesmallfish auto ; constant
globalvariable property ccbgssse001_catchtypelargefish auto ; constant
globalvariable property ccbgssse001_catchtypeobject auto ; constant
float property duration_initial_waiting_period = 5.0 autoreadonly
float property duration_initial_waiting_period_variance = 2.0 autoreadonly
float property duration_showpopulation = 3.0 autoreadonly
float property duration_sheatheweapon = 1.1 autoreadonly
float property duration_cast = 3.0 autoreadonly
float property duration_nibble = 0.5 autoreadonly
float property duration_exit = 1.5 autoreadonly
float property duration_fastexit = 0.5 autoreadonly
float property duration_catch = 1.0 autoreadonly
float property duration_successview = 1.8 autoreadonly
float property duration_fadetoblackcrossfade = 0.3 autoreadonly
float property duration_junkitemcatchtime = 3.5 autoreadonly
float property duration_catchtimeout = 5.0 autoreadonly
float property duration_rodloadtime = 0.15 autoreadonly
float property duration_hooked_anim_wait = 0.35 autoreadonly
float property rumble_duration_cast = 0.6 autoreadonly
float property rumble_strength_cast_left = 0.09 autoreadonly
float property rumble_strength_cast_right = 0.0 autoreadonly
float property rumble_duration_nibble = 0.45 autoreadonly
float property rumble_strength_nibblesmall_left = 0.5 autoreadonly
float property rumble_strength_nibblesmall_right = 0.0 autoreadonly
float property rumble_strength_nibblelarge_left = 0.0 autoreadonly
float property rumble_strength_nibblelarge_right = 0.6 autoreadonly
float property rumble_duration_hooked = 0.45 autoreadonly
float property rumble_strength_hookedlargefish_left = 0.2 autoreadonly
float property rumble_strength_hookedlargefish_right = 0.65 autoreadonly
float property rumble_strength_hookedsmallfish_left = 1.0 autoreadonly
float property rumble_strength_hookedsmallfish_right = 0.05 autoreadonly
float property rumble_strength_hookedobject_left = 0.5 autoreadonly
float property rumble_strength_hookedobject_right = 0.0 autoreadonly
float property rumble_duration_hookedconstant = 2.0 autoreadonly
float property rumble_strength_hooked_leftconstant = 0.6 autoreadonly
float property rumble_strength_hooked_rightconstant = 0.0 autoreadonly
float property rumble_strength_hookedlargefish_leftconstant = 0.6 autoreadonly
float property rumble_strength_hookedlargefish_rightconstant = 0.1 autoreadonly
float property rumble_duration_success = 0.4 autoreadonly
float property rumble_strength_successsmallfish_left = 1.0 autoreadonly
float property rumble_strength_successsmallfish_right = 0.08 autoreadonly
float property rumble_strength_successlargefish_left = 0.1 autoreadonly
float property rumble_strength_successlargefish_right = 1.0 autoreadonly
float property rumble_strength_successobject_left = 0.6 autoreadonly
float property rumble_strength_successobject_right = 0.1 autoreadonly
float property rumble_duration_failure = 0.4 autoreadonly
float property rumble_strength_failure_left = 1.0 autoreadonly
float property rumble_strength_failure_right = 0.0 autoreadonly
int property base_population = 4 autoreadonly
int property base_bonus_min = 1 autoreadonly
int property base_bonus_max = 2 autoreadonly
int property rain_bonus_min = 1 autoreadonly
int property rain_bonus_max = 3 autoreadonly
int property morningevening_bonus_min = 2 autoreadonly
int property morningevening_bonus_max = 3 autoreadonly
int property population_count_full = 4 autoreadonly
float property population_type_empty = 1.0 autoreadonly
float property population_type_sparse = 2.0 autoreadonly
float property population_type_full = 3.0 autoreadonly
float property gametime_morning = 6.0 autoreadonly
float property gametime_latemorning = 9.0 autoreadonly
float property gametime_evening = 18.0 autoreadonly
float property gametime_lateevening = 21.0 autoreadonly
float property base_catch_threshold_is_fish = 0.1 autoreadonly
float property base_catch_threshold_small = 0.5 autoreadonly
float property base_catch_threshold_commonfish = 0.25 autoreadonly
float property base_catch_threshold_uncommonfish = 0.03 autoreadonly
float property base_catch_threshold_commonjunk = 0.35 autoreadonly
float property base_catch_threshold_uncommonjunk = 0.03 autoreadonly
float property special_fish_rods_commonfish_threshold_adjust = 0.2 autoreadonly
float property special_fish_rods_uncommonfish_threshold_adjust = 0.07 autoreadonly
float property morning_evening_commonfish_threshold_adjust = 0.1 autoreadonly
float property morning_evening_uncommonfish_threshold_adjust = 0.05 autoreadonly
float property special_junk_rods_commonjunk_threshold_adjust = 0.3 autoreadonly
float property special_junk_rods_uncommonjunk_threshold_adjust = 0.06 autoreadonly
float property special_junk_rods_commonjunk_bonus = 0.2 autoreadonly
float property special_junk_rods_uncommonjunk_bonus = 0.07 autoreadonly
int property rarity_list_common_index = 0 autoreadonly
int property rarity_list_uncommon_index = 1 autoreadonly
int property rarity_list_rare_index = 2 autoreadonly
int property size_list_smallfish_index = 0 autoreadonly
int property size_list_largefish_index = 1 autoreadonly
int property rodtype_none = -1 autoreadonly
int property rodtype_standard = 0 autoreadonly
int property rodtype_alikri = 1 autoreadonly
int property rodtype_argonian = 2 autoreadonly
int property rodtype_dwarven = 3 autoreadonly
int property systemstate_idle = 0 autoreadonly
int property systemstate_settingup = 1 autoreadonly
int property systemstate_fishing = 2 autoreadonly
int property systemstate_nibble = 3 autoreadonly
int property systemstate_hooked = 4 autoreadonly
int property systemstate_catch_resolve = 5 autoreadonly
int property systemstate_cleanup = 6 autoreadonly
formlist property ccbgssse001_fishcatchdatalisttemperatestreamclear auto
formlist property ccbgssse001_fishcatchdatalisttemperatestreamrain auto
formlist property ccbgssse001_fishcatchdatalisttemperatelakeclear auto
formlist property ccbgssse001_fishcatchdatalisttemperatelakerain auto
formlist property ccbgssse001_fishcatchdatalistarctic auto
formlist property ccbgssse001_fishcatchdatalistcave auto
formlist property ccbgssse001_junkcatchdatalistdefault auto
formlist property ccbgssse001_onetimecaughtlist auto
formlist property ccbgssse001_fishingrodfxactivators auto
formlist property ccbgssse001_fishingrods auto
keyword property ccbgssse001_summonsrain auto
light property torch01 auto
globalvariable property ccbgssse001_showedreelpromptthissession auto
globalvariable property ccbgssse001_showedcatchpromptthissession auto
globalvariable property ccbgssse001_fishingtutorialdisplayed auto
globalvariable property ccbgssse001_fishingdebugenabled auto ; constant
message property ccbgssse001_fishingtutorial auto
message property ccbgssse001_errornofishcombat auto
message property ccbgssse001_errornofishjumping auto
message property ccbgssse001_errornofishmounted auto
message property ccbgssse001_errornofishsitting auto
message property ccbgssse001_errorrodrequired auto
message property ccbgssse001_reellineprompt auto
message property ccbgssse001_catchprompt auto
message property ccbgssse001_fishingearlyreel auto
message property ccbgssse001_fishingearlyreelnibble auto
message property ccbgssse001_fishinghooked auto
message property ccbgssse001_fishinglostcatch auto
sound property ccbgssse001_itmfishupsm auto
sound property ccbgssse001_rarecatchsm auto
sound property ccbgssse001_catchsuccesssm auto
imagespacemodifier property ccbgssse001_catchsuccessdof auto
imagespacemodifier property ccbgssse001_fadetoblackimod auto
imagespacemodifier property ccbgssse001_fadetoblackholdimod auto
imagespacemodifier property ccbgssse001_fadetoblackbackimod auto
quest property ccbgssse001_fishingfolloweridlequest auto
referencealias property followeralias auto
referencealias property dogalias auto
actor property playerref auto
globalvariable property gamehour auto
static property xmarker auto
ccbgssse001_dialoguedetectscript property dialoguequest auto
quest property ccbgssse001_start_mq2 auto
globalvariable property ccbgssse001_hascaughtfishatleastonce auto
objectreference property reellineref auto
ccbgssse001_movedetectscript property movedetectref auto
objectreference property ccbgssse001_navblockerref auto
light property ccbgssse001_catchsuccesslight auto
weather property skyrimstormrain auto
event onupdate()
endevent
function onplayerhit()
endfunction
function onplayermoveaway()
endfunction
function onplayerindialogue()
endfunction
function docleanuptasks()
endfunction
function onfishingtriggeractivated()
endfunction
function registerfornextupdate(int aiupdatetype)
endfunction
function registerforupdatenextmorning()
endfunction
function startplayerinteraction(ccbgssse001_fishingactscript akfishingsupplies, bool abcontinuefishing = false)
endfunction
function recalculatefishpopulation()
endfunction
function fish(bool abcontinuefishing = false)
endfunction
function setvisualpopulation()
endfunction
function showfishingtutorial()
endfunction
function showreellineprompt()
endfunction
function showcatchprompt()
endfunction
function returnsurroundingvolumes()
endfunction
ccbgssse001_catchdata function getnextcatchdata()
endfunction
formlist function getjunkcatchdatalist()
endfunction
ccbgssse001_catchdata function findallowedcatchdatainlist(formlist akcatchdatalist)
endfunction
ccbgssse001_catchdata function getnextfishcatchdata(formlist akcatchdatalist)
endfunction
ccbgssse001_catchdata function getnextjunkcatchdata(formlist akcatchdatalist)
endfunction
function setupcameraandposition(bool abcontinuefishing = false)
endfunction
function moveplayertofishingmarker()
endfunction
objectreference function placefishingrodactivator(int airodtype)
endfunction
function reelline()
endfunction
bool function iscatchsuccessful()
endfunction
function catchsuccess()
endfunction
function showfanfarescreenandaddcaughtitem(form akcaughtobject)
endfunction
function catchfail(bool abfastexit, bool abreducefishpopulation = false)
endfunction
function playresetanimation()
endfunction
function playcastanimation()
endfunction
function playvisualpopulationanimation()
endfunction
function playnibbleanimation()
endfunction
function playhookedfishanimation()
endfunction
function playhookedobjectanimation()
endfunction
function playcatchsuccessanimation()
endfunction
function playcatchfailureanimation()
endfunction
function playfastexitanimation()
endfunction
function trytoapplyrainweather()
endfunction
function restorecameraandcontrols(bool abfastexit = false)
endfunction
function resetsystem()
endfunction
function clearfishingsessionvariables()
endfunction
function clearfishingattemptvariables()
endfunction
function cleanup(bool abfastexit = false)
endfunction
function cleanupfishingrodactivator(bool abfastexit)
endfunction
function registerradiantfisheventlistener(ccbgssse001_radiantfisheventlistener listener)
endfunction
function unregisterradiantfisheventlistener()
endfunction
bool function isfishingallowed(int aifishingrodtype)
endfunction
bool function isfishcatchtype(int aicatchtype)
endfunction
bool function isitemcatchtype(int aicatchtype)
endfunction
bool function playerhascaughtfishbefore()
endfunction
function trytostartquestafterfirstcatch()
endfunction
int function getcurrentfishingrodtype()
endfunction
float function getfishcatchthresholdmodifier()
endfunction
float function getfishpopulationjunkmodifier()
endfunction
float function getsmallcatchthresholdmodifier()
endfunction
float function getinitialwaitingperiod()
endfunction
int function getfishbasepopulation()
endfunction
int function getfishpopulationmorningeveningbonus()
endfunction
bool function getinrain()
endfunction
bool function getismorningevening()
endfunction
ccbgssse001_fishingactscript function getcurrentfishingsupplies()
endfunction
bool function isplayerdrawingweapon()
endfunction
bool function isvalidupdatesystemstate()
endfunction
function resumefollowerbehavior()
endfunction
function restoreweather()
endfunction
bool function isinexitablesystemstate()
endfunction
function checkenabledebug()
endfunction
function fishingdebug(string asmessage)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1