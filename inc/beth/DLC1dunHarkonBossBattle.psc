scriptname dlc1dunharkonbossbattle extends referencealias
float property harkonbossbattlestate = 0.0 auto hidden
quest property dlc1vq08 auto
referencealias property harkonbattlerealharkon auto ;alias for the questline's harkon.
referencealias property harkonbattlemeleeform auto ;melee form harkon for this battle.
referencealias property harkonbattlemagicform auto ;magic form harkon for this battle.
actor property selfactor auto hidden
actor property harkonbattlerealharkonactor auto hidden
actor property harkonbattlemeleeformactor auto hidden
actor property harkonbattlemagicformactor auto hidden
spell property dlc1dunharkonconjuregargoylelefthand auto
spell property dlc1harkondrain02alt auto
spell property dlc1harkonmistform auto
spell property dlc1dunharkoninvulnerabilityshield auto
spell property dlc1abharkonfloatbodyfx auto
referencealias property harkonbattleholdpositionmarker auto ;where magic form harkon is trying to get to. effectively keeps him from running away all the time.
objectreference property harkonbattleholdpositionmarkerobj auto hidden
objectreference property vq08shrineeventmarker auto  ;location harkon teleports to (atop shrine collision)
objectreference property vq08shrineeventcollision auto ;collision to enable when harkon is on the shrine.
objectreference property vq08enemytrigger1 auto   ;traplinkers that hold the enemies to be activated.
objectreference property vq08enemytrigger2 auto
objectreference property vq08enemytrigger3 auto
bool property shielddestroyed = false auto hidden ;property checked by the shield magic effect to determine whether the shield blows up or gets dismissed quietly.
int property lastshrineevent = 0 auto hidden  ;what shrine event did we do most recently?
weapon property dlc1aurielsbow auto     ;bow and arrows to look for.
explosion property dlc1aurielsbowexp01 auto
explosion property explosionillusiondark01 auto
ammo property dlc1elvenarrowblessed auto
ammo property dlc1elvenarrowblood auto
bool property playerhasaurielsbow auto hidden
scene property dlc1vq08harkonbattlescene auto     ;scene telling the player to use the bow.
float property shrineeventscenetimer = 0.0 auto hidden  ;when did we last play this scene?
objectreference property vq08mistformeventmarker auto  ;marker to translate to at start, to make sure harkon doesn't get stuck on the shrine.
referencealias property harkonbattlenonamealias auto  ;alias with an override empty name, to avoid awkward activation text.
spell property dlc1fxcastvampirebleedspell auto
armor property dlc1vampireskeletonfxarmor auto
objectreference property deadharkonwarpmarker auto
activator property dlc1dunharkonashpile auto
objectreference property dlc1dunharkondeathfxact auto
sound property ambrumbleshake auto
effectshader property dlc1sunfireimpactfxshader auto
spell property dlc1dunharkondeathspell auto
objectreference property vq08explosionsourcemarker auto
explosion property dlc1vampiresbaneexplosion auto
objectreference property vq08harkongroundmarker auto
explosion property harkondeathexplosion auto
objectreference[] property harkonteleportpoints auto  ;array of possible teleport locations.
static property harkonteleportmarker auto   ;the unique base object for harkon's teleport markers.
objectreference[] property harkonminions auto
armor property dlc1vampirelordcape auto
musictype property muscombatboss auto
race property vampirebeastrace auto
race property werewolfbeastrace auto
function initializeharkonbattle() 
endfunction
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
function initializescriptvariables()
endfunction
function onupdate()
endfunction
auto state ready
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function processonupdateoronhitevent(objectreference aggressor, form weap)
endfunction
endstate
state busy
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent 
function processonupdateoronhitevent(objectreference aggressor, form weap)
endfunction
endstate
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function processonupdateoronhitevent(objectreference aggressor, form weap)
endfunction
function processshadowshieldhit(objectreference aggressor, form weap)
endfunction
int function countactiveminions()
endfunction
function recordsummonedgargoyle()
endfunction
function resethitclock()
endfunction
function picknewholdpositiontargetwithevp()
endfunction
function picknewholdpositiontargetwithoutevp()
endfunction
function teleportharkon()
endfunction
objectreference function pickteleportmarkerrandomly()
endfunction
objectreference function pickteleportmarkernearby()
endfunction
function batteleporttoendsameform(objectreference target)
endfunction
function batteleporttoendswapform(objectreference target)
endfunction
function batteleporttoendmagic(objectreference target)
endfunction
function batteleporttoendmelee(objectreference target)
endfunction
function harkonreforms()
endfunction
function setupshrineevent(int eventnum)
endfunction
function startshrineevent()
endfunction
function endshrineevent(actor aggressorifany, weapon weaponifany)
endfunction
function selectpostshrinecombatstage()
endfunction
function dealshrineeventhealthdamage(int damage)
endfunction
function startmistform()
endfunction
function endmistform()
endfunction
event ondeath(actor akkiller)
endevent
function begindeaththroes()
endfunction
event enddeaththroes()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1