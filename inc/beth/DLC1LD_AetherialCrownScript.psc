scriptname dlc1ld_aetherialcrownscript extends referencealias
quest property dlc1ld_postquest auto
perk property dlc1ld_aetherialcrownperk auto
spell property pdoomapprenticeability auto    ;1
spell property pdoomapprenticenegativeability auto 
spell property pdoomatronachability auto    ;2
spell property pdoomladyability auto     ;3
spell property pdoomlordability auto     ;4
spell property pdoomloverability auto     ;5
spell property pdoommageability auto     ;6
spell property pdoomritualability auto     ;7
perk property pdoomritualperk auto
spell property pdoomserpentability auto     ;8
spell property pdoomshadowability auto     ;9
spell property pdoomsteedability auto     ;10
spell property pdoomthiefability auto     ;11
spell property pdoomtowerability auto     ;12
spell property pdoomwarriorability auto     ;13
message property pdoomapprenticeremovedmsg auto
message property pdoomatronachremovedmsg auto
message property pdoomladyremovedmsg auto
message property pdoomlordremovedmsg auto
message property pdoomloverremovedmsg auto
message property pdoommageremovedmsg auto
message property pdoomritualremovedmsg auto
message property pdoomserpentremovedmsg auto
message property pdoomshadowremovedmsg auto
message property pdoomsteedremovedmsg auto
message property pdoomthiefremovedmsg auto
message property pdoomtowerremovedmsg auto
message property pdoomwarriorremovedmsg auto
spell property prested auto
spell property pwellrested auto
spell property pmarriagerested auto
event onequipped(actor akactor)
endevent
event onunequipped(actor akactor)
endevent
function doomstoneactivated()
endfunction
event onupdate()
endevent
function runupdate()
endfunction
function applycrowneffect(bool shouldadd)
endfunction
function selectnewcrowneffect(int neweffect)
endfunction
int function identifycurrentdoomstoneeffect()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1