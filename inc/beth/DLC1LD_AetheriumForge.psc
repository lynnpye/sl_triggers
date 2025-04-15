scriptname dlc1ld_aetheriumforge extends objectreference
miscobject property dlc1ld_aetheriumcrest auto
miscobject property ingotmalachite auto
miscobject property ingotdwarven auto
miscobject property ingotgold auto
miscobject property ingotebony auto
miscobject property gemsapphireflawless auto
sound property objdwemergearforge auto
objectreference property aetheriumforgeobject auto
objectreference property dlc1ld_forgesteam auto
quest property achievementsquest auto
auto state ready
event onactivate(objectreference akactivator)
endevent
endstate
state done
event onactivate(objectreference akactivator)
endevent
endstate
function disablesteam()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1