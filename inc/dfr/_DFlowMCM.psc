scriptname _dflowmcm extends  ski_configbase conditional
referencealias property follower auto ; the follower alias on _dflow '_dmaster' - use this for everything.
referencealias property mcmfollower auto ; the follower alias on the mcm quest - which has no reason to exist and is just a source of bugs.
referencealias property scan auto
qf__gift_09000d62 property q  auto  
_dtick property tick auto
_dftools property tool auto
_dfpotionquest property dfpotq auto
_dfgoldconqscript property goldcont  auto  
qf__dflowdealcontroller_0a01c86d property dc auto
_dfsold property dsold auto
_dflowmoddealcontroller property mdc auto
_dflowsleepquestscript  property sq auto
_dflowunflaggedfollowerscan property unflaggedfollowersscan auto
_ldc property ldc auto
dialoguefollowerscript property vanillafollowerquest auto 
dfr_licenses property _dflicenses auto
dfr_rules property rulemanager auto
quest property dflow  auto  ; same quest as q ...
quest property dealo  auto 
quest property dealb  auto 
quest property dealh  auto 
quest property dealp  auto 
quest property deals  auto 
quest property dealcontroller  auto 
quest property games  auto 
quest property sevents  auto 
quest property ds1  auto 
quest property ds2  auto 
quest property dsb  auto 
quest property boredomquest auto
quest property forcedstart auto ; this didn't get set originally, so it's now useless...
quest property _dflowgames auto
qf__dflowforcedstart_081abd14 property _dflowforcedstart auto ; above replaced with this.
message property _dfscan auto
message property _dfscan2 auto
message property reseted auto
faction property _dfmaster auto
faction property _dfdisable auto
faction property currentfollowerfaction auto
faction property dismissedfollowerfaction auto
faction property potentialfollowerfaction auto
faction property enabledfollowerfaction auto ; followers that won't be picked up in an all followers marked ignored scan. doesn't make an ignored follower not ignored.
faction property hirelingfollowerfaction auto
formlist property _dfpausemodslist auto
miscobject property _dfdebt001 auto
actor property playerref auto
actor property factor auto
int property sexpreferenceindex auto
int property dismissalindex auto
int property dealostage auto
int property dealbstage auto
int property dealhstage auto
int property dealpstage auto
int property dealsstage auto
int property _dfminstolenper = 5 auto
int property _dfmaxstolenper = 40 auto
int property clevel = 0 auto 
int property _dfkeydiffi = 1 auto
int property _dfremovalmode = 0 auto conditional
int property _dfmaxresistmcm auto
int property _dfmaxresistmin auto
int property _dfwillregainmode = 0 auto ; not used at this time.
int property debtdifficulty = 3 auto
bool property _dfdealscustarmor auto
bool property _dfwillbool = true auto
bool property _dftheifsbool = false auto
bool property _dfchaoconcealed = false auto
bool property _dfchaogo = false auto
bool property _dflocnoti = true auto conditional
bool property _dfanimalcont = true auto conditional
bool property _dfshowrollmsg = false auto
bool property _dfzazautopause = false auto
bool property _dfmaxresistdevices auto 
bool property _dfmaxresistdeal auto ; unused
bool property _dfdealeffectwill auto  ; unused
bool property skiptotheend auto conditional
bool property ispaused auto conditional
bool property enslavedgoldcontrol = true auto hidden conditional
float property _dfdebtmaxpl = 0.0 auto ; unused
float property _dfdebtminpl = 0.0 auto ; unused
float property _dfremovalmultimax = 0.0 auto ; unused
float property _dfremovalmultimin = 0.0 auto ; unused
float property customdifficultycurve = 0.5 auto ; => _dflowdebtexponent
float property dealearlymulti = 500.0 auto ; => _dflowdealmulti
float property punishmentdebt = 100.0 auto ; => _dfpundebt
float property deviceremovalfirst = 100.0 auto ; => _dflowremovalbaseprice
float property deviceremovalinc = 50.0 auto ; => _dflowremovalinc
float property dealdurationdays = 2.0 auto ; => _dflowdealbasedays
float property followerlivesmax = 11.0 auto ; => mlives
float property minwillregain = 2.0 auto
float property maxwillregain = 7.0 auto
float property willregainease = 1.2 auto
float property spankingcooldownhours = 3.5 auto
float property _dfsweightd = 50.0 auto
float property _dfsweighte = 50.0  auto
float property _dfsweighted = 50.0 auto
float property _dfkconceal = 0.3 auto
float property _dfresistancewilldelta = 0.0 auto
float property _dfresistancedealdelta = 0.0 auto
float property _dfresistanceleveldelta = 0.0 auto
float property debtperdaylolevel = 250.0 auto
float property debtperdayhilevel = 12000.0 auto
float property enslavementdebtscale = 5.0 auto
float property freedomcostscale = 5.0 auto
float property failurescale = 10.0 auto
float property basedebtrelief = 200.0 auto ; percentage of daily cost relieved by deal
float property basedebtbuyout = 100.0 auto ; percentage of daily cost to buyout of deal once expired
float property _dfchaospercent = 40.0 auto 
float property _dfchaosdays = 1.0 auto
float property _dfchaostimer = 0.0 auto
float property _dfdebtperdaymax = 10.0 auto ; daily debt scale range
float property _dfdebtperdaymin = 0.1 auto
float property _dfpundebtmax = 10.0 auto ; punishment debt scale
float property _dfpundebtmin = 0.1 auto
float property _dfremovalmax = 10.0 auto ; removal cost scale range
float property _dfremovalmin = 0.1 auto
float property _dfremovalincmax = 10.0 auto ; removal increment scale range
float property _dfremovalincmin = 0.1 auto
float property _dfdealsmaxdebt = 10.0 auto ; debt relief
float property _dfdealsmindebt = 0.1 auto
float property _dfdealsmaxprice = 10.0 auto ; debt buyout
float property _dfdealsminprice = 0.1 auto
float property _dfdealsmaxptime = 100.0 auto ; deal duration
float property _dfdealsminptime = 0.0 auto
float property _dfdealsmaxmulti = 10.0 auto ; premature payoff scale
float property _dfdealsminmulti = 1.0 auto
float property _dfliveschaomax = 21.0 auto ; lives
float property _dfliveschaomin = 6.0 auto
float property chaosdailydebt = 1.0 auto
float property chaospunishmentdebt = 1.0 auto
float property chaosdeviceremovalfirst = 1.0 auto
float property chaosdeviceremovalinc = 1.0 auto
float property chaosdealrelief = 1.0 auto
float property chaosdealbuyout = 1.0 auto
float property chaosdealearlymulti = 5.0 auto
float property chaosdealdurationdays = 2.0 auto
float property chaosfollowerlivesmax = 11.0 auto ; => mlives and lives
float property pausetimerelapsed auto ; for saving the main debt-update timer
globalvariable property _dfsolddeals auto
globalvariable property hedebt  auto  
globalvariable property debtperday auto   ; this is always a derived value
globalvariable property debtperlevel auto ; this now means something ... different ... it's a derived value
globalvariable property _dflowdebtexponent auto ; new - the power factor for debt calculation
globalvariable property _dfpundebt  auto  ; derived from punishmentdebt, chaospunishmentdebt and dailydebt
globalvariable property _dflowdealbasedebt auto     ; the calculated debt relief amount
globalvariable property _dflowdealbaseprice auto    ; the calculated amount you pay back
globalvariable property _dflowdealmulti auto        ; early buyout scale percentage
globalvariable property _dfdeepdebtdifficulty auto  ; multiplier to deep debt extra cost.
globalvariable property _dflowremovaldebttimes auto  ; no chaos value for this
globalvariable property _dflowremovalbaseprice auto  ; comes from deviceremovalfirst and chaosdeviceremovalfirst
globalvariable property _dflowremovalinc auto        ; comes from deviceremovalinc and chaosdeviceremovalinc
globalvariable property _dflowdealbasedays auto     ; comes from chaosdealdurationdays or dealdurationdays
globalvariable property enslavementdebt auto ; derived
globalvariable property freedomcost auto ; derived
globalvariable property failure auto ; derived
globalvariable property _dflowitemsperremoved auto  
globalvariable property _dflowgamblejpot auto  
globalvariable property _dflowendlessmode auto  
globalvariable property _dflowwarmcomp  auto  
globalvariable property intrest auto
globalvariable property pause auto
globalvariable property reset auto ; this seems to serve no useful purpose
globalvariable property queststage auto ; this is used on pause.
globalvariable property debtpollhrs auto
globalvariable property etimerp auto
globalvariable property dia auto
globalvariable property debt auto
globalvariable property tats auto
globalvariable property resist auto
globalvariable property will auto
globalvariable property adfd auto
globalvariable property enslaveperlevel auto
globalvariable property debtperfollower auto
globalvariable property lives auto
globalvariable property livesm auto
globalvariable property dfcslaverychance auto
globalvariable property lolachance auto
globalvariable property sso auto
globalvariable property gamedayspassed auto
globalvariable property _dflivesfollowerrape auto
globalvariable property _dfminimumcontract auto
globalvariable property _dfminimumcontractremaining auto
globalvariable property _dfhardcoremode auto
globalvariable property _dffatigue auto
globalvariable property _dffatiguerate auto
globalvariable property _dfdailydebtincrement auto
globalvariable property _dfboredom auto
globalvariable property _dfboredomintervaldays auto
globalvariable property _dfboredomtimer auto
globalvariable property _dfdiscountlimit auto
globalvariable property _dfexpecteddealcount auto
globalvariable property _dfexpecteddeallimit auto
globalvariable property _dfgoldperfatigue auto
globalvariable property _dffollowercount auto
globalvariable property _dfdailydebtadjust auto
globalvariable property _dfallowforcestart auto
globalvariable property _dfresistancebroken auto
globalvariable property _dfdismissrule auto
globalvariable property _dfmodskoomawhorepresent auto
globalvariable property _dfmodmmepresent auto
globalvariable property _dfmodslspresent auto
float property version = 0.0 auto
_dflowmcm function get() global
endfunction
string function getscriptversionname()
endfunction
int function getscriptversion()
endfunction
float function getdfversion()
endfunction
bool function isdebug()
endfunction
event onconfiginit()
endevent
event onconfigopen()
endevent
event onconfigclose()
endevent
function updatemcm()
endfunction
function setmenunames()
endfunction
function setupdebtdifficulty()
endfunction
event onpagereset(string page)
endevent
function dostatspagemenu()
endfunction
function displaydealstatuses(string[] asdeals)
endfunction
function dogeneralpagemenu()
endfunction
function dowillpowerpagemenu()
endfunction
function docostspagemenu()
endfunction
function dorulesettingspagemenu()
endfunction
string function getstatustext(int aistatus)
endfunction
function dorulespagemenu()
endfunction
function dopunishmentspagemenu()
endfunction
function dochaospagemenu()
endfunction
function domiscadditionalcontentpagemenu()
endfunction
function doothermodsettingspagemenu()
endfunction            
function docostexplorerpagemenu()
endfunction            
function dodebugpagemenu()
endfunction
function dohelppagemenu()
endfunction
function showclassicdealoptions(int start, string name, int stage)
endfunction
event onoptionhighlight(int option)
endevent
function settextoptionworking(int option)
endfunction
function settextoptiondone(int option, bool reallow = false)
endfunction
event onoptionmenuopen(int option)
endevent
event onoptionmenuaccept(int option, int index)
endevent
event onoptionselect(int option)
endevent
event onoptionslideropen(int option)
endevent
event onoptionslideraccept(int option, float value)
endevent
function exportsettings()
endfunction
function importsettings()
endfunction
function exportfloat(string name, float value)
endfunction
float function importfloat(string name, float defaultvalue)
endfunction
function exportstring(string name, string value)
endfunction
string function importstring(string name, string defaultvalue)
endfunction
function resetquests(bool everything = false)
endfunction
function pausemod()
endfunction
function resumemod()
endfunction
int function numdeals()
endfunction
function chaos(bool forcefullupdate = false)
endfunction
float function chaosify(float lo, float hi, float weight, float current)
endfunction
function calculatescaleddebts()
endfunction
function updatelivesmax(float newmaxlivesf)
endfunction
bool function noti(string msg, int n = 0)
endfunction
function notifylocationchanged(string change)
endfunction
function adddebtnoti(int n)
endfunction
function removedebtnoti(int n)
endfunction
function notigam(float a=0.0, int roll=0)
endfunction
function they()
endfunction
float function getwilladjustedmaxresist(float willpower, float maxresist)
endfunction
int function getmaxresist()
endfunction
float function getdeviceresistancedelta()
endfunction
float function min(float x, float y)
endfunction
float function max(float x, float y)
endfunction
string function formatfloat_n2(float value) global
endfunction
string function formatfloat_n1(float value) global
endfunction
string function formatfloat_n0(float value) global
endfunction
string function formatfloatpercent_n0(float value) global
endfunction
string function formatfloatpercent_n1(float value) global
endfunction
string function formatdecimal_x10(int value) global
endfunction
string function formatdecimal_x100(int value) global
endfunction
float function fclamp(float lowerlimit, float upperlimit, float tobound) global
endfunction
int function iclamp(int lowerlimit, int upperlimit, int tobound) global
endfunction
float function log10(float x)
endfunction
function buildlogtable()
endfunction
function resetalloids()
endfunction
function setdismissalrules(int ruleindex)
endfunction
string function gettargetactorname()
endfunction
bool function havevalidtoggleactortarget()
endfunction
bool function istoggleactortargetenabled()
endfunction
bool function iscurrenttargetactivedf()
endfunction
bool function havevalidslavertarget()
endfunction
bool function settargetasslaverforss()
endfunction
bool function istargetslaver()
endfunction
bool function toggleactorenable()
endfunction
function ignorefollowers()
endfunction
function starttestgame()
endfunction
function runtest()
endfunction
function starttest2()
endfunction
function addtestdeal()
endfunction
function addtestitem()
endfunction
function addbhodeals()
endfunction
function addpiercingdeal()
endfunction
function addslutdeal()
endfunction
function adddealbynewid(int id)
endfunction
bool function isskoomawhorepresent()
endfunction
bool function ismmepresent()
endfunction
bool function isslspresent()
endfunction
dfr_relationshipmanager property relationshipmanager auto 
dfr_devicecontroller property devicecontroller auto 
dfr_loans property loans auto 
dfr_licenses property licenses auto 
dfr_confiscation property confiscation auto 
function onpageresetext(string page)
endfunction
function showrelationshippage()
endfunction
function showeventspage()
endfunction
event onoptionselectext(int a_option)
endevent
event onoptionslideropenext(int a_option)
endevent
event onoptionslideracceptext(int a_option, float a_value)
endevent
event onoptionmenuopenext(int a_option)
endevent
event onoptionmenuacceptext(int a_option, int a_index)
endevent
event onoptionhighlightext(int a_option)
endevent
function init()
endfunction
string[] function getevents()
endfunction
function populateevents()
endfunction
function geteventdesc(int a_option)
endfunction
function acceptevents(int a_option)
endfunction
function toggleevent(int aioption, string asevent)
endfunction
function dummyfunc()
endfunction
function showeventcooldown(int a_option)
endfunction
function accepteventcooldown(int a_option, float a_value)
endfunction
function getcooldowndesc(int a_option)
endfunction
string function getcurrentpack()
endfunction
int function getcurrentpackindex()
endfunction
string function setcurrentpack(int a_index)
endfunction
string[] function populatepacks()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1