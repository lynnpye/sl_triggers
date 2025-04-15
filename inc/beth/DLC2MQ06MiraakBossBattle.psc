scriptname dlc2mq06miraakbossbattle extends referencealias
quest property dlc2mq06 auto
actor property selfactor auto hidden
objectreference property selfref auto hidden
actor property playeractor auto hidden
actorbase property selfbase auto hidden
actor property actordragon1 auto hidden
actor property actordragon2 auto hidden
actor property actordragon3 auto hidden
faction property dlc2tamedragonfaction auto
actor property tamedragon auto hidden
referencealias property dragon1 auto
referencealias property dragon2 auto
referencealias property dragon3 auto
referencealias property tamedragonalias auto
bool property scriptvariablesinitialized = false auto hidden
bool property initialized = false auto hidden
musictype property dlc2muscombatboss auto
float property currenttime auto hidden
bool property ismounted auto hidden
int property dragonbeingridden = 1 auto hidden
bool property dragonriddenwasflying auto hidden
bool property dragonriddenisflying auto hidden
bool property dragon1isflying auto hidden
bool property dragon2isflying auto hidden
bool property dragon3isflying auto hidden
bool property dragon1isdead = false auto hidden
bool property dragon2isdead = false auto hidden
bool property dragon3isdead = false auto hidden
int property playerposition = 0 auto hidden     ;didn't end up using this
objectreference property dlc2mq06dragonlandingmarkerfar auto
objectreference property dlc2mq06dragonkilllandingmarker002 auto
objectreference property dlc2mq06dragonkilllandingmarker003 auto
bool property cansprintincombat = true auto
bool property tamedragonshouldneverland = true auto
bool property firemiraakkill = false auto
function initializemiraakbattle() 
endfunction
function initializescriptvariables()
endfunction
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
auto state ready
event onbeginstate()
endevent
endstate
state busy
event onbeginstate()
endevent
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent        
function processonupdateoronhitevent(objectreference aggressor, form weap)
endfunction
endstate
state done
event onbeginstate()
endevent
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent        
function processonupdateoronhitevent(objectreference aggressor, form weap)
endfunction
function onupdate()
endfunction
endstate
state runningmiraakdeathstate
event onbeginstate()
endevent
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent        
function processonupdateoronhitevent(objectreference aggressor, form weap)
endfunction
function onupdate()
endfunction
endstate
function onupdate()
endfunction
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function processonupdateoronhitevent(objectreference aggressor, form weap)
endfunction
function checkdragons()
endfunction
float property dragondrainthreshold1 = 0.3 auto hidden
float property dragondrainthreshold2 = 0.3 auto hidden
float property dragondrainthreshold3 = 0.3 auto hidden
float property minsprinthealththreshold = 0.5 auto hidden
float property finalkillthreshold = 0.1 auto hidden
int property totaldragonskilled = 0 auto hidden
bool property runningdragonkillevent = false auto hidden
bool property runningmiraakdeathevent = false auto hidden
bool property fightisover = false auto hidden
spell property dlc2miraakdragonkillspell auto
scene property dlc2mq06miraakkilldragonscene  auto  
referencealias property dragontokillalias auto
actor property dragontokill auto hidden
spell property dlc2miraakfakeshoutspell auto
bool property waitingfordragonkillscenetoend auto hidden
bool property prefertokillplayerdragon = false auto
quest property dlc2tamedragon auto
function miraakstealssoul()
endfunction
function rundragonkillevent()
endfunction
function setdragonnoland()
endfunction
function setdragonscanland()
endfunction
function settamedragoncanland(bool canland = true)
endfunction
actor function pickdragontokill()
endfunction
function dragonkillsceneended()
endfunction
function trackdragondeath(int dragonnumber)
endfunction
visualeffect property dragonabsorbeffect auto
visualeffect property dragonabsorbmaneffect auto
sound property npcdragondeathsequencewind auto
sound property npcdragondeathsequenceexplosion auto
effectshader property dragonpowerabsorbfxs auto
spell property dlc2killmiraakspell auto
globalvariable property dlc2soulstealcount  auto  
objectreference property mq06miraakdeathmarker auto
idle property idledlc02miraakdeathfinish auto
armor property dlc2miraakskeleton auto ; miraaks skeleton for death fx
objectreference property dlc2mq06centerpoolref auto
objectreference property dlc2mq06centerpoolfakeref auto
visualeffect property dlc2miraakabsorbmane auto ;..autofills
visualeffect property dlc2miraakabsorbe auto ;...autofills
effectshader property dlc2miraakbitsfxs auto
effectshader property dlc2miraakbitslite2fxs auto
effectshader property dlc2miraaksmokefxs auto
effectshader property dlc2miraakmagicfxs auto
armor property dlc2miraakskinhider auto
sound property qstmiraakdeathburnmarker auto
function runmiraakdeathevent()
endfunction
event miraakdeath()
endevent
weapon property miraaksword auto hidden
weapon property miraakstaff auto hidden
spell property dlc2lightningstormrighthand auto
objectreference property sword1 auto hidden
objectreference property staff auto hidden
objectreference property dlc2tamedragonorbitmarker auto
globalvariable property dlc2mq06miraakcombatstyle auto
int property currentcombatstyle auto hidden
function picknewcombatstyle()
endfunction
function changemiraakcombatstyle(int newcombatstyle = 1)
endfunction
function checkmiraakhealthandmodifneeded()
endfunction
function setplayerpositionvariable(int newposition)
endfunction
referencealias property sprinttarget auto
scene property dlc2mq06miraaksprintscene auto
bool property waitingforsprintscenetoend auto hidden
objectreference[] property dlc2mq06sprinttargets auto
spell property dlc2miraaketherealfxspell auto
function sprintaway(bool pickclosest = false)
endfunction
function sprinttotarget(objectreference target)
endfunction
function sprinttotargetandteleportaway(objectreference target)
endfunction
function sprintsceneended()
endfunction
objectreference function picksprintawaytarget(bool pickclosest = false)
endfunction
objectreference property dlc2miraakfightteleportmarkermid auto
objectreference property dlc2miraakfightteleportmarker01 auto
objectreference property dlc2miraakfightteleportmarker02 auto
objectreference property dlc2miraakfightteleportmarker03 auto
objectreference property dlc2miraakfightteleportmarker04 auto
objectreference property dlc2miraakfightteleportmarker05 auto
objectreference property dlc2miraakfightteleportmarker06 auto
objectreference property dlc2mq06fightfallteleportmarker auto
objectreference property dlc2mq06killscenefallteleportmarker auto
formlist property dlc2mq06teleporttargetfl auto
objectreference property dlc2mq06miraaksaferoom auto
explosion property dlc2mq06miraakteleportexplosion auto
explosion property dlc2miraakawayexplosion auto
explosion property dlc2miraakbackexplosion auto
scene property dlc2mq06playerfallrecoveryscene auto
scene property dlc2mq06miraakfallrecoveryscene auto
visualeffect property dlc2miraakstreake auto ;streak art...autofills
function teleportmiraakfromoffcliff()
endfunction
function teleportplayerfromoffcliff()
endfunction
function teleportmiraak(objectreference teleporttarget)
endfunction
function teleportaway()
endfunction
function teleportplayertotarget(objectreference teleporttarget)
endfunction
objectreference function pickteleportmarkernearby()
endfunction
dlc2mqbosstentaclecontroller property tentaclecontroller auto hidden
objectreference property dlc2mqbosstentaclecontrollerref auto
float property tentacletimer auto hidden
float property tentacletimedelayinit = 15.0 auto hidden
float property tentacletimedelay = 15.0 auto hidden
bool property dotentacleattacks = false auto
function triggertentacleattack(int targetarea)
endfunction
function triggertentacleattackfull(bool bclockwise = false, float fattacktimer = 0.5)
endfunction
function triggertentacleattacksingle(int itargetarea = 1, bool bclockwise = false, float fattacktimer = 0.5)
endfunction
int property stage1 = 37 auto hidden
int property stage2 = 44 auto hidden
int property stage3 = 51 auto hidden  
int property stage4 = 58 auto hidden  
int property stage5 = 65 auto hidden  
weapon property dlc2mkmiraakfightsword1 auto
weapon property dlc2mkmiraakfightsword2 auto
weapon property dlc2mkmiraakfightsword3 auto
weapon property dlc2mkmiraakfightsword4 auto
weapon property dlc2mkmiraakfightsword5 auto
weapon property dlc2mkmiraakfightsword6 auto
weapon property dlc2mkmiraakfightstaff1 auto
weapon property dlc2mkmiraakfightstaff2 auto
weapon property dlc2mkmiraakfightstaff3 auto
weapon property dlc2mkmiraakfightstaff4 auto
weapon property dlc2mkmiraakfightstaff5 auto
weapon property dlc2mkmiraakfightstaff6 auto
function setmiraakcombatlevel()
endfunction
globalvariable property dlc2mq06maskheavychance auto
globalvariable property dlc2mq06masklightchance auto
function setrewardgear()
endfunction
function swaptorewardgear()
endfunction
objectreference property mq06miraakdeathteleportmarker  auto  
;This file was cleaned with PapyrusSourceHeadliner 1