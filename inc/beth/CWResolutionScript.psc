scriptname cwresolutionscript extends cwmissionscript  conditional
int property questhooksaid auto hidden conditional    ;0 = inset, 1 = fieldco gave the spiel and should now forcegreet goodbye 
int property playerfoundarmy auto hidden conditional    ;0 = unset, 1 = player rendezvoused with army (set in stage 20, set by cwresolution01soldierfriendlyscript)
int property barricadedestroyed auto hidden conditional   ;0 = unset, 1 = player has broken down the barricade (set in stage 30, set by cwresolution01barricadescript)
int property jarlwillsurrender auto hidden conditional   ;0 = unset, 1 = will surrender to player (set in stage 40, set by cwresolution01jarlbodyjarl & cwresolution01jarlbodyguardscript)
int property jarlhassurrendered auto hidden conditional   ;0 = unset, 1 = has surrendered to player (set in stage 50, set by cwresolution01jarlscript)
int property countbodyguards auto hidden 
int property holdinitialposition = 1 auto hidden conditional   ;1 = soldiers should guard their defender marker, 0 = they guard the door to the jarls house
referencealias property spawnbarricade auto
int property distancefromspawnbarricadetocauseguardstoguarddoor = 1500 auto
function incrementcountbodyguards() ;called in the oninit() events of body guard aliases
endfunction
function decrementcountbodyguards() ;called in the oninit() events of body guard aliases
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1