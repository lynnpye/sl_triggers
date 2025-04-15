scriptname dlc1dunharkonbatteleport extends referencealias
referencealias property harkonbattlemainform auto
referencealias property harkonbattlemagicform auto
referencealias property harkonbattlemeleeform auto
actor property selfactor auto hidden
actor property oldactor auto hidden
actor property harkonbattlerealharkonactor auto hidden
actor property harkonbattlemeleeformactor auto hidden
actor property harkonbattlemagicformactor auto hidden
objectreference property vq08harkonswapmarker auto
objectreference property vq08harkonwarpmarker1 auto
objectreference property vq08harkonwarpmarker2 auto
objectreference property teleportobject auto hidden ;the location we're teleporting to.
spell property dlc1vq08bats auto       ;bat spell that handles the actual teleport.
spell property dlc1vq08swapbats auto       ;bat spell that handles the actual teleport.
bool property swappingharkons auto hidden    ;are we swapping harkons on this teleport?
objectreference property newharkon auto hidden   ;if so, who are we swapping to?
function initialize()
endfunction
function batteleportto(objectreference obj)
endfunction
function batteleportandswapto(objectreference obj)
endfunction
function batteleporttoendmagic(objectreference obj)
endfunction
function batteleporttoendmelee(objectreference obj)
endfunction
function swapharkons()
endfunction
function transferavs(actor source, actor destination)
endfunction
function batsalldone()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1