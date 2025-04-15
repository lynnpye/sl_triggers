scriptname dlc1dunharkonshadowshield extends objectreference  
referencealias property dlc1vq08harkonalias auto
magiceffect property dlc1enchsundamage auto
magiceffect property dlc1enchsundamagearrow auto
actor property player auto
event oncellattach()
endevent
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
auto state ready
function checkscene()
endfunction
endstate
state busy
function checkscene()
endfunction
endstate
function checkscene()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1