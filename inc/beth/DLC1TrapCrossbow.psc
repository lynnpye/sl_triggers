scriptname dlc1trapcrossbow extends trapbase
int property shotcount = 3 auto
float property initialdelay = 0.0 auto
bool property fireallshots = true auto
bool property isfiring auto hidden
bool property isloaded auto hidden
bool property shotfired = false auto hidden
bool property weaponresolved = false auto hidden
message property dlc1trapcrossbowneededmessage auto
weapon property crossbow auto
ammo property bolt auto
int property messagereturn auto hidden
bool property startdisarmed = false auto
bool property hasloadedonce = false auto hidden
;This file was cleaned with PapyrusSourceHeadliner 1