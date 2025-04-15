scriptname dlc01dundbchimescript extends objectreference hidden 
keyword property linkcustom07 auto
int property chimenumber = 0 auto
effectshader property glowyeffect auto
objectreference property chimemaster auto hidden
bool property alreadyhit = false auto hidden
auto state waitingforhit
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state waitingforreset
endstate
function startglow()
endfunction
function stopglow()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1