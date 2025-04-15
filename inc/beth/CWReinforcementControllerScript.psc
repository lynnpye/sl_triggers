scriptname cwreinforcementcontrollerscript extends quest 
int property reinforcementinterval = 5 auto
float property poolattacker auto hidden ;the current reinforcement pool value
float property pooldefender auto hidden ;the current reinforcement pool value
float property startingpoolattacker auto hidden
float property startingpooldefender auto hidden
bool property infiniterespawnattacker auto hidden ;don't subtract from pools, always treat checks for cost to respawn as passing
bool property infiniterespawndefender auto hidden ;don't subtract from pools, always treat checks for cost to respawn as passing
int property thresholdcounterpoolattacker = -999 auto hidden    ;chunk of reinforcements left, when increments, it means it's time to show objective to player -- for example, every 5% change in pool, increment this value and show the pools to the player
int property thresholdcounterpooldefender = -999 auto hidden ;chunk of reinforcements left, when increments, it means it's time to show objective to player -- for example, every 5% change in pool, increment this value and show the pools to the player
int property postticketattackercountthreshold = 5 auto
int property postticketdefendercountthreshold = 5 auto
int property stagetosetifattackerwipedout auto
int property stagetosetifdefenderwipedout auto
int property stagetosetifattacker25percentremainging auto
int property stagetosetifdefender25percentremainging auto
bool property showattackerpoolobjective  auto
bool property showdefenderpoolobjective  auto
quest property poolremainingobjectivequest auto
int property poolremainingattackerobjective auto
int property poolremainingdefenderobjective auto
objectreference property spawnattacker1 auto hidden
objectreference property spawnattacker2 auto hidden
objectreference property spawnattacker3 auto hidden
objectreference property spawnattacker4 auto hidden
objectreference property spawnattackerfailsafe auto hidden
objectreference property spawndefender1 auto hidden
objectreference property spawndefender2 auto hidden
objectreference property spawndefender3 auto hidden
objectreference property spawndefender4 auto hidden
objectreference property spawndefenderfailsafe auto hidden
quest property cw auto
quest property cwcampaign auto
cwcampaignscript property cwcampaigns auto hidden ;set in oninit()
cwscript property cws auto hidden ;set in oninit()
event oninit()
endevent
state stopspawning
function registerdeath(referencealias deadalias)  
endfunction
endstate
state respawning
function registerdeath(referencealias deadalias)  ;called in ondeath event of the dying actor/referencealias
endfunction
endstate
function stopspawning()
endfunction
function registerdeath(referencealias deadalias)   ;called in ondeath event of the dying actor/referencealias
endfunction
function trytorespawnaliass()
endfunction
function trytorespawnalias(referencealias aliastorespawn)
endfunction
bool function isaliasattacker(referencealias aliastorespawn)
endfunction
int function countattackersalive()
endfunction
int function countdefendersalive()
endfunction
int function isaliasalive(referencealias aliasvariabletocheck)
endfunction
function registerattackpoint(location siegelocationattackpoint)
endfunction
function registeralias(referencealias aliastoadd)
endfunction
function registeraliasattacker(referencealias aliastoadd)
endfunction
function registeraliasdefender(referencealias aliastoadd)
endfunction
objectreference function trytogetpriorityspawnlinkedref(referencealias aliastocheckfor)
endfunction
objectreference function trytogetforcedspawnlinkedref(referencealias aliastocheckfor)
endfunction
objectreference function getattackerspawnref(referencealias aliastocheckfor)
endfunction
objectreference function getdefenderspawnref(referencealias aliastocheckfor)
endfunction
function registerspawnattackeraliases(referencealias marker1alias, referencealias marker2alias, referencealias marker3alias, referencealias marker4alias, referencealias failsafemarkeralias)
endfunction
function registerspawndefenderaliases(referencealias marker1alias, referencealias marker2alias, referencealias marker3alias, referencealias marker4alias, referencealias failsafemarkeralias)
endfunction
function setinfinitepools(bool attackerhasinfinite = true, bool defenderhasinfinite = true)
endfunction
function setpoolattacker(int basepool = 10, float attackdeltamult = 1.0, float scalemult = 1.0, bool infinitepool = false)
endfunction
function setpooldefender(int basepool = 10, float attackdeltamult = 1.0, float scalemult = 1.0, bool infinitepool = false)
endfunction
function shufflespawnmarkers()
endfunction
function subtractfromattackerpool(int numsoldierstosubtractby = 1)
endfunction
function subtractfromdefenderpool(int numsoldierstosubtractby = 1)
endfunction
function addbacktoattackerpool(int numsoldierstoaddbackby = 1)
endfunction
function addbacktodefenderpool(int numsoldierstoaddbackby = 1)
endfunction
function modifypool(bool modattackerpool, int numsoldierstomodifyby)
endfunction
function killoffscreendefender()
endfunction
bool function trytokilloffscreendefender(referencealias aliastotrytokill)
endfunction
int function getpoolexpressedassoldiercount(float pool)
endfunction
function showpoolstoplayer()
endfunction
int function getthresholdcounter(float startingpool, float currentpool, float percentthreshold = 5.0)
endfunction
function trytoshowattackerpools()
endfunction
function trytoshowdefenderpools()
endfunction
function showattackerpool()
endfunction
function showdefenderpool()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1