scriptname _dftools extends quest hidden conditional
_ldc property ldc auto
sexlabframework property sexlab  auto 
zadlibs property libs auto
_dflowmcm property mcm auto
quest property q  auto  ; _dflow
quest property g  auto  ; _dflowgames
quest property _dflowfindfollower auto
quest property _dflowsexscan auto
quest property _dflowhorsescan auto
quest property _dflowguardscan auto
quest property _dflowgames auto
bool property firsttime auto hidden conditional
referencealias property follower auto
referencealias property vanillafollower auto
referencealias property speaker auto
referencealias[] property approachers auto
bool property suspended auto
bool property penslave auto
bool property dealodog auto
actor property playerref auto
actor property horse auto
actor property pc auto
actor property dog auto
keyword property loctypeinn auto
keyword property loctypeplayerhouse auto
keyword property loctypedwelling auto
keyword property loctypecity auto
keyword property loctypehold auto
keyword property loctypebanditcamp auto
keyword property loctypedungeon auto
keyword property slns auto
keyword property armorclothing auto
keyword property armorlight auto
keyword property armorheavy auto
keyword property warmer auto
keyword property _dfendless auto
keyword property ddrestraintskey auto
keyword property ddchastitykey auto
keyword property ddpiercingkey auto
keyword property _dfgemp  auto
faction property crimefacwhiterun  auto ; whiterun
faction property crimefacriften    auto ; riften
faction property crimefacsolitude  auto ; haafingar
faction property crimefacmarkarth  auto ; markarth
faction property crimefacwindhelm  auto ; windhelm - eastmarch
faction property crimefacwinterhold auto ; winterhold
faction property crimefacdawnstar  auto ; dawnstar - pale
faction property crimefacmorthal   auto ; morthal - hjaalmarch
faction property crimefacfalkreath auto ; falkreath
faction property dismissedfollowerfac auto
objectreference property pit auto
armor property punishbelti auto
armor property punishbeltr auto
armor property punishplugvi auto
armor property punishplugvr auto
armor property punishplugai auto
armor property punishplugar auto
armor property _dfwhoreheavyarmor auto
armor property _dfwhorelightarmor auto
armor property _dfwhoremagearmor auto
armor property _dfwhoreheavyarmorcust auto
armor property _dfwhorelightarmorcust auto
armor property _dfwhoremagearmorcust auto
armor property collar auto
armor property armcuffs auto
armor property legcuffs auto
armor property boots auto
armor property gloves auto
armor property jacket auto
armor property jacketr auto
armor property gag auto
armor property mittens auto
armor property mittensr auto
armor property binder auto
armor property binderr auto
armor property blindfold auto
armor property prisonerchainsr auto
armor property prisonerchainsi auto
armor property chainsofdebtr auto
armor property chainsofdebti auto
globalvariable property _dflowwill auto
globalvariable property _dflowresist auto
globalvariable property _dwillmed auto
globalvariable property _dwilllow auto
globalvariable property _dffatigue auto
globalvariable property _dffatiguerate auto
globalvariable property _dfgoldperfatigue auto
globalvariable property _dfexpecteddealcount auto
globalvariable property _dfboredom auto
globalvariable property _dfboredomtimer auto
globalvariable property _dfboredomintervaldays auto
globalvariable property _dfspankeagerness auto
globalvariable property _dfoutdoorspanking auto
globalvariable property _dfspankdealrequests auto
globalvariable property _dfresistancebroken auto
globalvariable property _dfpunishmenttimer auto
globalvariable property _dfgamecommenttimer auto
globalvariable property gamedayspassed auto
globalvariable property etimerp auto
globalvariable property hedebt  auto  
globalvariable property debt  auto  
globalvariable property _dfslutcount auto
globalvariable property _dfsexscanradius auto
globalvariable property _dfsexscanallowmale auto
globalvariable property _dfsexscanallowfemale auto
globalvariable property _dfinternalenslaveweight auto
globalvariable property _dflolaenslaveweight auto
globalvariable property _dflowsimpleslaveryodds auto
globalvariable property _dfslaverytarget auto
spell property hitlistspell  auto
formlist property actorlist auto
formlist property hitlist auto
formlist property _dfsexscanfound auto
formlist property _dfhorsescanfound auto
formlist property _dfguardscanfound auto
message property _dflowdealb1 auto
message property _dflowdealb2 auto
message property _dflowdealb3 auto
message property _dflowdealb4 auto
message property _dflowdealo1 auto
message property _dflowdealo2 auto
message property _dflowdealo3 auto
message property _dflowdealo4 auto
message property _dflowdealh1 auto
message property _dflowdealh2 auto
message property _dflowdealh3 auto
message property _dflowdealh4 auto
message property _dflowdealp1 auto
message property _dflowdealp2 auto
message property _dflowdealp3 auto
message property _dflowdeals1 auto
message property _dflowdeals2 auto
message property _dflowdeals3 auto
message property _dfkeygameall auto
message property _dfkeygamecprice auto
message property _dfkeygameckeys auto
message property _dfkeygamecall auto
message property _dfkeygamealls auto
message property _dfkeygameckeyss auto
message property _dfkeygamecalls auto
float property punishmentinterval = 0.02083 auto ; around half an hour game time.
float property spankingtimer auto
float property maxresistancefatigue = 100.0 auto
int property rapistcounter = 0 auto
int property suspend = 0 auto ; flags the dhlp-suspend/enable event status
race property horserace auto
_ddeal property db auto
_ddeal property do auto
_ddeal property dh auto
_ddeal property dp auto
_ddeal property ds auto
_mddeal property dm1 auto
_mddeal property dm2 auto
_mddeal property dm3 auto
_mddeal property dm4 auto
_mddeal property dm5 auto
string property tagneverdevious = "df_followerneverdevious" autoreadonly 
string property tagmaster = "df_followermaster" autoreadonly
string property tagmasterdays = "df_followermasterdays" autoreadonly
string property tagboredom = "df_followerboredom" autoreadonly
string property taglasthiretime = "taglasthiretime" autoreadonly
string property tagenslavedpunishcount = "df_enslaved_punishcount" autoreadonly
string property tagenslavedtotalpunishcount = "df_enslaved_totalpunishcount" autoreadonly
string property tagpersonality = "df_followerpersonality" autoreadonly
string property tagaggression = "df_followeraggression" autoreadonly
string property taggreed = "df_followergreed" autoreadonly
string property taghonor = "df_followerhonor" autoreadonly
string property taglust = "df_followerlust" autoreadonly
string property tagcontrol = "df_followercontrol" autoreadonly
string property tagplayful = "df_followerplayful" autoreadonly
int property personalitydefault = 0 autoreadonly
int property personalityslaver = 1 autoreadonly
int property personalityprofiteer = 2 autoreadonly
int property personalitysexy = 3 autoreadonly
int property personalitysadist = 4 autoreadonly
int property personalitymoral = 5 autoreadonly
int property personalitynightmare = 6 autoreadonly
miscobject property gold001 auto
scene property _dflowgamesdogkitten auto  ; dog sex scene 1
scene property _dflowgamesdogkitten2 auto ; dog sex scene 2
scene property _dflowgamesdogscene3 auto
scene property rapetimeintro auto
scene property rapetimeending auto
scene property rapetimetransition auto
bool property dendmgstop = false auto
idle property bleedoutstart auto
idle property bleedoutstop auto
key property rkey auto
key property ckey auto
key property ptool auto
string[] property spankanimationnames auto
string[] property spankanimationnamesext auto
string[] property spankanimationnamesextalt auto
_dftools function get() global
endfunction
function sexscanstart(float radius)
endfunction
int function sexscanupdate(actor[] foundthistime, int offset = 0)
endfunction
function sexscanrestart(float delay = 0.1)
endfunction
bool function insex()
endfunction
function setscangenders(int allowmask)
endfunction
function waitforsex(float maxtime = 180.0)
endfunction
int function guardscan(actor[] foundthistime, int offset = 0, bool clearfoundlist = true)
endfunction
int function horsescan(actor[] foundthistime, int offset = 0, bool clearfoundlist = true)
endfunction
function adddealitem(string itemname)
endfunction
function placepcnearplayer()
endfunction
function sceneerrorcatch(scene thescene, int timer)
endfunction
function sceneerrorcatchandplay(scene thescene, int timer)
endfunction
function addpunishmentdebt(int multiple = 1)
endfunction
actor function getnearestactor()
endfunction
bool function horsetime()
endfunction
function sleepgamecheck()
endfunction
function addcum()
endfunction
function denialdmg(int dmg, bool iscreature, bool hbondage)
endfunction
function denialdmgcon(int dmg, bool iscreature, bool hbondage)
endfunction
int function rapetime(float secondstotry = -1.0, float scanradius = 1024.0)
endfunction
function startrapetimeapproach(actor[] akrapists)
endfunction
function setsexscanradius(float radius = -1.0)
endfunction
bool function singlerape(actor b)
endfunction
bool function singlesex(actor b)
endfunction
bool function masturbation(actor b)
endfunction
bool function foreplay(actor b)
endfunction
bool function sexgrope(actor b) 
endfunction
bool function sexanal(actor b)
endfunction
bool function sexoral(actor b) 
endfunction
bool function sex(actor npc0)
endfunction
bool function sex2(actor npc0, actor npc1)
endfunction
bool function sex3(actor npc0, actor npc1, actor npc2)
endfunction
bool function sex4(actor npc0, actor npc1, actor npc2, actor npc3)
endfunction
bool function sexinternal_1(actor b, bool waitcomplete = false) 
endfunction
bool function sexinternal_2(actor b, actor c, bool waitcomplete = false)
endfunction
bool function sexinternal_3(actor b, actor c, actor d, bool waitcomplete = false)
endfunction
bool function sexinternal_4(actor b, actor c, actor d, actor e, bool waitcomplete = false)
endfunction
bool function vaginalok(actor who)
endfunction
bool function analok(actor who)
endfunction
bool function oralok(actor who)
endfunction
bool function boobsok(actor who)
endfunction
function resetspanking()
endfunction
function allowspanking()
endfunction
function updatespankingstatus()
endfunction
bool function checkspanking()
endfunction
bool function checkoutdoorspanking()
endfunction
string function getspankinganims()
endfunction
bool function checkspankingcode()
endfunction
string function getspankingcodestatus()
endfunction
bool function spank(actor spanker, int severity = -1)
endfunction
int function playsexanimation(actor[] sexactors, bool hasvictim, sslbaseanimation playanim, string hook = "")
endfunction
function spankplayerass()
endfunction
function spankplayertits()
endfunction
function spankplayersound()
endfunction
bool function disablestaspanking()
endfunction
function enablestaspanking()
endfunction
function fixupspanks(int assspanks, int titspanks)
endfunction
bool function havesta()
endfunction
bool function havelola()
endfunction
bool function havesimpleslavery()
endfunction
function btimerreset() ; reset the boredom timer
endfunction
function resetexpectations()
endfunction
function reduceboredom(int dealreduce = 0)
endfunction
function adjustboredom(float delta, bool resettimer = false)
endfunction
function addfatigue()
endfunction
function addfatiguevalue(float rate)
endfunction
function increasewill(int maxincrease) ; no longer used.
endfunction
function reducewill() ; reduce by one point. this is used by reduceresist
endfunction
function increaseresist(int lo, int hi) ; no longer used.
endfunction
function increaseresistfloat(float gain)
endfunction
function reduceresist(int loss) ; this is still used a lot
endfunction
function reduceresistfloat(float loss)
endfunction
function restoreresist()
endfunction
float function getmaxwill()
endfunction
float function findmaxresist(float willpower, float maxresist)
endfunction
int function countdeviceclasses()
endfunction
function removegear()
endfunction
function dropgear()
endfunction
function unequipgear()
endfunction
function abandonplayer(actor who)
endfunction
function addallholdbounties(bool skiponehold)
endfunction
function fitbeltandplugs()
endfunction
function fitchainsofdebt()
endfunction
function fitprisonerchains()
endfunction
function fitfullset()
endfunction
function tryadddevice(keyword devicekeyword)
endfunction
function addchainsofdebt()
endfunction
function addprisonerchains()
endfunction
bool function randomdevice(int b)
endfunction
bool function piercingactivate(bool reward = true, int howstrong = 2)
endfunction
function keygame(int cost, actor sender) 
endfunction
bool function checkandremovekeys(actor followeractor, objectreference destinationcontainer = none)
endfunction
function pauseall() 
endfunction
function resumeall()  
endfunction
function enslaved()
endfunction
function unenslaved()
endfunction
function dealdelayhr()
endfunction
function dealreset()
endfunction
function dealmessages()
endfunction
function makedonation(int amount)
endfunction
actor[] function getallfollowers()
endfunction
function endscene()
endfunction
actor function findguard(actor oldguard) 
endfunction
function jarlscene(actor jarl)
endfunction
function jarlscene2(actor jarl)
endfunction
function delayplaysceneandwait(float predelay, float timeoutafter, scene toplay)
endfunction
function incrementslutcount()
endfunction
function updatechaos()
endfunction
function addpunishmentscore(int score)
endfunction
function restorepunishmenttracking(actor whomaster)
endfunction
function pundebt()
endfunction
function deferpunishments()
endfunction
actor function findnewfollower()
endfunction
function advancecommenttimer(float seconds)
endfunction
function disablecontrolsforscene()
endfunction
function enableplayercontrols()
endfunction
function prepareforscene()
endfunction
function cleanupafterscene()
endfunction
function pickslaverydestination()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1