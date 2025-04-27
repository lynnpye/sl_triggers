scriptname _dflowmoddealcontroller extends quest  conditional
_dftools property tool auto
dfr_confiscation property confiscation auto
referencealias property masteralias auto
float property timersetting auto
float property allowpretendkeycheck auto conditional
int property cuffsrule auto conditional ;1 added
int property collarrule auto conditional  ;2 added
int property gagrule auto conditional ;3 added
int property nprule auto conditional ;4 added
int property vprule auto conditional ;5 added
int property nakedrule auto conditional ;6 added
int property whorerule auto conditional ;7 added
int property blindfoldrule auto conditional ;8 added
int property bootsrule auto conditional ;9 added
int property glovesrule auto conditional ;10 added
int property spankingrule auto conditional ; 21
int property sexrule auto conditional ; 22
int property lactacidrule auto conditional ; 23
int property ringrule auto conditional ; 24
int property amuletrule auto conditional ; 25
int property circletrule auto conditional ; 26
int property timerstatus auto conditional ; 0 = no timed deals, 1 = lots of time, 2 = some time, 3 = almost out of time, 4 = failed previous, have defaulted deals
int property petsuitintownrule auto conditional ;11 added 3 = added by follower
int property crawlintownrule auto conditional ;12 added using anal plug!
int property innkeeperrule auto conditional ;13 added 3 = oral || 4= fuck || 5 = fuckeveryone || 6 = fuckdog
int property boundintownrule auto conditional ;14 added 
int property merchantrule auto conditional ;added 15  || 3 == oral || 4 == fuck || 5 = dog
int property jacketrule auto conditional ; 16 jacket in town
int property expensiverule auto conditional ; 17 owe a lot of money
int property keyrule auto conditional ; 18
int property skoomarule auto conditional ; 19
int property milkingrule auto conditional ; 20
int property sexdealrequests auto conditional
int property spankdealrequests auto conditional
int property skoomadealrequests auto conditional
int property lactaciddealrequests auto conditional
int property milkdealrequests auto conditional
int property spankdealdefaults auto conditional
int property sexdealdefaults auto conditional
int property skoomadealdefaults auto conditional
int property lactaciddealdefaults auto conditional
int property milkdealdefaults auto conditional
bool property ispaused auto conditional
bool property showdiagnostics auto
globalvariable property _dfspankdealrequests auto ; updated by _dftools
globalvariable property _dfdailydealtimer auto ; checked by debtinc in qf__gift_09000d62, updated in this file.
globalvariable property _dfmodmmepresent auto
globalvariable property _dfmodskoomawhorepresent auto
globalvariable property _dfkeyfound auto
globalvariable property _dwill auto
globalvariable property _dfenablekeysearchgreeter auto
float property innkeeperruletimer auto conditional
scene property innscene auto
float property fasttraveltimer auto conditional
scene property merchantscene auto
float property merchantruletimer auto conditional
float property sexdealtimer auto conditional
float property spankdealtimer auto conditional
float property skoomadealtimer auto conditional
float property lactaciddealtimer auto conditional
float property milkdealtimer auto conditional
float property keysearchtimer auto conditional
actor property playerref auto
armor property _dflowponytaildealinventory auto
armor property _dflowponytaildealrend auto
referencealias property you  auto  
referencealias property player  auto  
referencealias property follower  auto  
referencealias property actor1  auto  
string[] property oidtext auto
string[] property oidtextdesc auto
string[] property dealnoti auto
int[] property oids auto ; putting these here was problematic. this is no longer used.
int[] property dealtype auto
int property dealsbuilt auto
int property maxmoddealssetting auto ; this actually means max number of deals
int property maxmoddealsaviliable auto ; this isn't used any longer.
bool property optimizerules auto ; this is now ignored, rules always check for conflicts.
bool property forcekeycheck auto
int[] property dealmstages auto ; save deal stages
int[] property dealmcodes auto ; save deal codes
int[] property rulesave auto ; save rule state
float property pauseddailydealtimerremaining auto
float property pausedinnkeeperinnkeeperdaysremaining auto
float property pausedfasttraveltimerdaysremaining auto
float property pausedmerchantruletimerdaysremaining auto
float property pausedsexdealtimerdaysremaining auto
float property pausedskoomadealtimerdaysremaining auto
float property lactaciddealtimerdaysremaining auto
float property milkdealtimerdaysremaining auto
quest property dealo  auto 
quest property dealb  auto 
quest property dealh  auto 
quest property dealp  auto 
quest property deals auto 
quest property dealm1 auto ; bear
quest property dealm2 auto ; wolf
quest property dealm3 auto  ;dragon
quest property dealm4 auto  ;skeever
quest property dealm5 auto ; slaughterfish
objectreference property _dfkeycontainer auto
objectreference property _dfmilkbarrel auto
keyword property vendoritemfood auto
keyword property mme_milk auto
keyword property ddrestraintskey auto
keyword property ddchastitykey auto
keyword property ddpiercingkey auto
function startmdc()
endfunction
function update()
endfunction
function disableexternalrules()
endfunction
int[] function getlowrules(int skiprule = -2)
endfunction
int[] function gethirules(int skiprule = -2)
endfunction
int function countrules(int[] rules)
endfunction
int function sett1or2rule(bool forceallocate = false)
endfunction
int function sett3rule(bool override=false)
endfunction
int function getrulestate(int ruleindex)
endfunction
bool function isskoomawhorepresent()
endfunction
bool function ismmepresent()
endfunction
function equiporlock(keyword akkwd)
endfunction
function equiporlockdevice(armor akdevice)
endfunction
function confiscateclothing()
endfunction
function setrule(int ruleindex, int b)
endfunction
function lockcrawlingboots()
endfunction
bool function isconflictingrule(int ruleindex)
endfunction
bool function isclassicdealnoconflict(string dealname, int stage)
endfunction
int function gett1or2rulesavailable()
endfunction
int function gett3rulesavailable()
endfunction
bool function havemodulardeals()
endfunction
bool function isdealtaken(int index)
endfunction
bool function checkdealenabled(int dealindex) ; indexed from 1 to 5
endfunction
int function getmaxdealinuse()
endfunction
bool function trychangemodulardealenables(int newdealcount)
endfunction
function enabledeals()
endfunction
bool function disablerule(int ruleindex)
endfunction
bool function enablerule(int ruleindex)
endfunction
function removerule(int ruleindex)
endfunction
function pauseandsave()
endfunction
function resume()
endfunction
function savetimers()
endfunction
function restoretimers()
endfunction
function end()
endfunction
function checkexternaldeals()
endfunction
function checkandcleardealrequests()
endfunction
function updatetimerstatuscondition()
endfunction    
function punishspankdealdefaults()
endfunction
function punishsexdealdefaults()
endfunction
function punishskoomadealdefaults()
endfunction
function punishlactaciddealdefaults()
endfunction
function punishmilkdealdefaults()
endfunction
function punishalldefaults()
endfunction
function skipsexwithplayer(actor who)
endfunction
function sexwithplayer(actor who, bool isrape = false)
endfunction
function spankplayer(actor who)
endfunction
function drinkskooma()
endfunction
function drinkskoomarejected()
endfunction
function drinklactacid(int amount = 1)
endfunction
function drinklactacidrejected()
endfunction
function handoverkeys(actor who)
endfunction
function searchforkeys(actor who)
endfunction
function milkingdone(int bottlesproduced)
endfunction
bool function movemilkbottles()
endfunction
bool function removemilkbottle()
endfunction
function setaliasforscene(actor akactor1 = none, actor akactor2 = none)
endfunction
function startinnscene()
endfunction
function startmerchantscene()
endfunction
function runscene(scene akscene)
endfunction
function innoutcome()
endfunction
function cleaninnscene(bool abrelease = true)
endfunction
function merchantoutcome()
endfunction
function cleanmerchantscene(bool abrelease = true)
endfunction
function fasttraveltimerstart()
endfunction
function checktrigger(int rulecode)
endfunction
function test()
endfunction
potion function getleafskooma()
endfunction
potion function getlactacid()
endfunction
function givekeys()
endfunction
function checkandremovedealkeys()
endfunction
function fakekeycheck()
endfunction
function checkkeydealtrigger()
endfunction
bool function scanlistforkeys()
endfunction
actor function setfolloweralias()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1