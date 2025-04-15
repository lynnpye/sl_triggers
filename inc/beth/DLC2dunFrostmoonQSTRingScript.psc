scriptname dlc2dunfrostmoonqstringscript extends quest
globalvariable property dlc2dunfrostmooncurrentring auto ;ring the player currently has equipped. 0=none, 1=bloodlust, 2=moon, 3=instinct, 4=hunt
armor property dlc2dunfrostmoonringbloodlust auto
armor property dlc2dunfrostmoonringmoon auto
armor property dlc2dunfrostmoonringinstinct auto
armor property dlc2dunfrostmoonringhunt auto
referencealias property playeralias auto
function frostmoonringequipped(int ringid)
endfunction
function frostmoonringunequipped(int ringid)
endfunction
event onupdate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1