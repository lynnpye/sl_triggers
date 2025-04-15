scriptname dlc2dunfrostmoonplayerscript extends referencealias
globalvariable property dlc2dunfrostmooncurrentring auto  ;ring the player currently has equipped. 0=none, 1=bloodlust, 2=moon, 3=instinct, 4=hunt
quest property dlc2dunfrostmoonqst auto
spell property werewolfchange auto     ;werewolf change spells to watch for.
spell property werewolfchangeringofhircine auto
armor property dlc2dunfrostmoonringbloodlust auto
armor property dlc2dunfrostmoonringmoon auto
armor property dlc2dunfrostmoonringinstinct auto
armor property dlc2dunfrostmoonringhunt auto
perk property dlc2dunfrostmoonringbloodlustbloodlust auto ;bloodlust: do 50% more damage, take 50% more damage.
perk property dlc2dunfrostmoonringmoonmagnifyhowls auto ;moon: increases howl magnitude and duration by 25%.
spell property dlc2dunfrostmoonringinstinctslowtime auto ;instinct: slow time effect. cast once when beast form starts.
spell property dlc2dunfrostmoonringhuntregen auto   ;hunt: allows player health to regen.
race property werewolfbeastrace auto
event onspellcast(form akspell)
endevent
event onupdate()
endevent
function applyringeffect()
endfunction
function removeringeffectifnecessary()
endfunction
function removeringeffect()
endfunction
event onobjectequipped(form base, objectreference ref)
endevent
event onobjectunequipped(form base, objectreference ref)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1