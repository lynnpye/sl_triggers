scriptname defaultlinkrefstartcombatplayer extends objectreference
objectreference property victim auto
actor property attacker auto hidden
bool property makeaggressive = false auto
auto state waiting
event ontriggerenter(objectreference actronaut)
endevent
endstate
state inactive
endstate
;This file was cleaned with PapyrusSourceHeadliner 1