scriptname qf__gift_09000d62 extends quest hidden
referencealias property alias__dmaster auto
function fragment_8()
endfunction
function fragment_6()
endfunction
function fragment_14()
endfunction
function fragment_32()
endfunction
function fragment_41()
endfunction
function fragment_12()
endfunction
function fragment_13()
endfunction
function fragment_22()
endfunction
function fragment_34()
endfunction
function fragment_10()
endfunction
function fragment_28()
endfunction
function fragment_11()
endfunction
qf__gift_09000d62 function get() global
endfunction
function prep()
endfunction
function maintenance()
endfunction
function updateversion()
endfunction
function setdeals()
endfunction
function resetdflowmain()
endfunction
function enslave()
endfunction
function enslavedirect()
endfunction
function enslavedduetodebt()
endfunction
function startslaverysetup(int aimode)
endfunction
function fitslavekit()
endfunction
function adjustpostslaverydebt()
endfunction
function setpostslaverydebt()
endfunction
function reduceexpecteddeals(float reduceby)
endfunction
function setpostslaverydeals()
endfunction
function adddealitem(string itemname)
endfunction
function resetpunishmenttracking(actor whomaster)
endfunction
function updatefollowerdismissaltags(actor whomaster)
endfunction
function updatefollowerhiretags(actor whomaster)
endfunction
int function getpersonality(actor who)
endfunction
int function getaggression(actor who)
endfunction
int function getgreed(actor who)
endfunction
int function gethonor(actor who)
endfunction
int function getlust(actor who)
endfunction
int function getcontrol(actor who)
endfunction
int function getplayful(actor who)
endfunction
function setpersonality(actor who)
endfunction
function initpersonalityvalues()
endfunction
int function rollstat(int bias)
endfunction
int function biasedint(int lo, int hi)
endfunction
function chargeforslslicense(float baseprice, float markup)
endfunction
function adjustdebt(float debtdelta)
endfunction
int function adddebt(float amount)
endfunction
int function normalizedebt()
endfunction
function debt(float adddebtamount)
endfunction
function applypunishmentdebt()
endfunction
function applypunishmentdebttimes(int aitimes)
endfunction
function pundebt()
endfunction
function puncrawl()
endfunction
function buydebt()
endfunction
function buyoutofslavery()
endfunction
function debtpercent(float scaledebt)
endfunction
function dealdebt()
endfunction
function dealrejectdebt()
endfunction
function pricereset()
endfunction
function priceupdate()
endfunction
function deviceremovalgold()
endfunction
float function calculatedeviceremovalcost()
endfunction
function deviceremovaldebt()
endfunction
function losedeviceremovallives()
endfunction
function setzerolives()
endfunction
function debtm(float amount)
endfunction
function potionpaydebt()
endfunction    
function debtpay(float amount)
endfunction
int function debtpaygoldq(float amount)    
endfunction
function setdebt(float value)
endfunction
function ddelay()
endfunction
function dtimerreset()
endfunction
function etimerreset()
endfunction
function btimerreset()
endfunction
function reduceboredom(int dealreduce = 1)
endfunction
function debtinc()
endfunction
function lend (objectreference hirelingref)
endfunction
function addfollower(objectreference newmaster)
endfunction
function addfolloweractor(actor newmaster)
endfunction
function externalremovefollower()
endfunction
function lostitems()
endfunction
function stealallitems()
endfunction
function robplayeritems(bool voluntary = false)
endfunction
function startnewagreement(actor newmaster, int queststageid)
endfunction
function quickstartnewagreement()
endfunction
function restartagreement(actor newmaster, int queststageid)
endfunction
function payofffollower(actor follower)
endfunction
function repairfollower()
endfunction
function entergoldcontrol()
endfunction
function forceenabledevious(actor who)
endfunction
function pickendlessslaverydestination()
endfunction
bool function isignore(actor who)
endfunction
_dflowfollowercontroller property q2 auto
zadlibs property libs  auto  
_dftools property tool auto
quest property pdialoguefollower auto
quest property ticker auto
quest property _goldcontrol auto ; i do not like this circular dependency, but it's been forced by poor design elsewhere :(
quest property boredomquest auto
quest property _dflowitems auto
quest property _dfslaverywatcher auto
quest property _dflicenses auto
qf__dflowdealcontroller_0a01c86d property dealcontroller auto
_dfsold property _dflowsold auto
faction property currenthireling  auto  
faction property fac  auto  ; _dmaster
faction property wr  auto  ; whiterun crime
faction property b  auto  ; rift crime
faction property c  auto  ; winterhold crime
faction property crimefactionhaafingar auto ; solitude crime
faction property pdismissedfollower auto
faction property _dfdisable auto
faction property _dmaster auto
objectreference property pit auto  
objectreference property _dflowsolditems auto
keyword property sexlabnostripkeyword auto
keyword property vendornosalekeyword auto
keyword property vendorbookkeyword auto
keyword property vendortoolkeyword auto
keyword property vendoranimalpartkeyword auto
keyword property vendorrawfoodkeyword auto
keyword property vendorfirewoodkeyword auto
keyword property vendorkeykeyword auto
keyword property _dfcrawlrequired auto
globalvariable property lives auto  
globalvariable property livesm auto  
globalvariable property will auto
globalvariable property debt auto 
globalvariable property canrehiregv  auto
globalvariable property hashirelinggv  auto  
globalvariable property failure auto
globalvariable property timer auto  
globalvariable property etimer auto  
globalvariable property etimerp auto 
globalvariable property gamedayspassed auto
globalvariable property queststage auto
globalvariable property playerfollowercount auto
globalvariable property hirelingcommentnextallowed auto
globalvariable property sso  auto
globalvariable property _dfslaverytarget auto
globalvariable property debtperday auto
globalvariable property intrest auto
globalvariable property enslavementdebt auto
globalvariable property enslavementhalfdebt auto
globalvariable property freedomcost auto
globalvariable property enslaveperlevel auto ; still used!
globalvariable property debtpollhrs auto
globalvariable property debtperfollower auto
globalvariable property debtperlevel auto ; no longer used
globalvariable property _dflowdealbasedebt auto
globalvariable property _dflowremovalbaseprice auto
globalvariable property _dflowremovalp auto
globalvariable property _dflowremovalinc auto
globalvariable property _dflowremovaldebttimes auto
globalvariable property _dfpundebt  auto
globalvariable property _dfminimumcontract auto
globalvariable property _dfminimumcontractremaining auto
globalvariable property _dffollowercount auto
globalvariable property _dfdiscountlimit auto
globalvariable property _dfboredom auto
globalvariable property _dfboredomintervaldays auto
globalvariable property _dfboredomtimer auto
globalvariable property _dfdailydebtadjust auto
globalvariable property _dfdailydebtincrement auto
globalvariable property _dfexpecteddealcount auto
globalvariable property _dfexpecteddeallimit auto
globalvariable property _dffatigue auto
globalvariable property _dfstanding auto
globalvariable property _dflowitemsperremoved auto
globalvariable property _dfdailydealtimer auto
globalvariable property _dtats  auto  
globalvariable property _dfendlessslaverytarget auto
globalvariable property pplayerfollowercount auto
actor property playerref  auto  
actor property actor1 auto
actor property actor2 auto
actor property actor3 auto
actor property actor4 auto
actor property actor5 auto
actor property scanactor auto ; the ss target slaver
int property removeddevicescount = 0 auto
int property flow = 1 auto  
int property currentlevel auto
float property punishmentdebtreduction = 25.0 auto
float property punishmentdealreduction = 4.0 auto
float property endlesssoldweight = 100.0 auto
float property endlessslaveweight = 0.0 auto
float property endlessauctionweight = 0.0 auto
float property endlesslolaweight = 0.0 auto
float property delay auto conditional
miscobject property gold001  auto
message property ssmessage auto
message property enslavemsg1  auto   
weapon property followerhuntingbow auto
ammo property followerironarrow auto
armor property collar auto  ; slave collar inventory
armor property mitts  auto  ; slave mittens inventory
armor property boots  auto  ; slave boots inventory
armor property collarr auto  ; slave collar
armor property mittsr  auto  ; slave mittens
armor property bootsr  auto  ; slave boots
armor property item  auto  
armor property rend  auto  
armor property dealring auto
armor property dealamulet auto
armor property dealcirclet auto
int property statrangeany = 0 autoreadonly
int property statrangelo = 1 autoreadonly
int property statrangemid = 2 autoreadonly
int property statrangehi = 3 autoreadonly
string property tagneverdevious = "df_followerneverdevious" autoreadonly ; non-dry duplicate of the one in tool - keep in sync.
;This file was cleaned with PapyrusSourceHeadliner 1