scriptname ccbgssse001_crabmq4crabspawner extends quest
actor property playerref auto
actorbase property lvlcrab auto
actorbase property potcrab auto
int property crabobjective auto
objectreference[] property spawners auto
referencealias[] property guards auto
referencealias[] property potcrabs auto
miscobject property flamingpot auto
globalvariable property ccbgssse001_mq4crabskilled auto
globalvariable property ccbgssse001_mq4crabskilledpct auto
globalvariable property ccbgssse001_crabmq4catapultcount auto
globalvariable property ccbgssse001_crabmq4catapulttotal auto
int property wave1stagetosetondone auto
int property wave2stagetosetondone auto
int property wave2midobjectivestagetoset auto
int property levelmod_boss = 3 autoreadonly
int property levelmod_hard = 2 autoreadonly
int property levelmod_medium = 1 autoreadonly
int property levelmod_easy = 0 autoreadonly
int property crabs_to_kill_wave_1 = 8 auto
int property crabs_to_kill_wave_2 = 15 auto
int property crabs_to_kill_wave_3 = 10 auto
int property flaming_pot_crabs_to_kill_wave_3 = 12 auto
int property max_crabs_wave_1 = 4 auto
int property max_crabs_wave_2 = 6 auto
int property max_crabs_wave_3 = 3 auto
int property crab_count_normal_spawn = 2 auto
int property initial_crabs_wave_1 = 3 auto
int property initial_crabs_wave_2 = 6 auto
int property initial_crabs_wave_3 = 3 auto
int property threshold_boss_wave_1 = 6 auto
int property threshold_hard_wave_1 = 4 auto
int property threshold_medium_wave_1 = 2 auto
int property threshold_boss_wave_2 = 12 auto
int property threshold_hard_wave_2 = 8 auto
int property threshold_medium_wave_2 = 6 auto
int property threshold_boss_wave_3 = 4 auto
int property threshold_hard_wave_3 = 3 auto
int property threshold_medium_wave_3 = 2 auto
int property objective_modulo_wave_1 = 4 auto
int property objective_modulo_wave_2 = 5 auto
function setwave(int aiwave)
endfunction
function spawninitialcrabs()
endfunction
function modobjectiveglobalandcheckobjectiveredisplay(int aiobjectivemodulo, int aicrabskilledthiswave, int aitargetcrabstokillthiswave)
endfunction
function crabkilled()
endfunction
int function spawncrabs(int aimaxspawncount, int aicrabsspawnedthiswave, int aicrabskilledthiswave, int aimaxcrabsthiswave, int aitargetcrabstokillthiswave, int aibossthreshold, int aihardthreshold, int aimediumthreshold, bool isinitialspawn = false)
endfunction
function spawnflamingpotcrab(int aicount)
endfunction
function flamingpotcrabkilled()
endfunction
auto state waveone
function spawninitialcrabs()
endfunction
function crabkilled()
endfunction
endstate
state wavetwo
event onbeginstate()
endevent
function spawninitialcrabs()
endfunction
function crabkilled()
endfunction
endstate
state wavethree
event onbeginstate()
endevent
function spawninitialcrabs()
endfunction
function crabkilled()
endfunction
function flamingpotcrabkilled()
endfunction
function spawnflamingpotcrab(int aicount)
endfunction
endstate
bool function isvalidalias(actor akactor)
endfunction
int function getrandomspawner()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1