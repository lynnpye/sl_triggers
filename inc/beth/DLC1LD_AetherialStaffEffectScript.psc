scriptname dlc1ld_aetherialstaffeffectscript extends objectreference
spell property dlc1ld_aetherialstaffsummondwarvenspider01spell auto
spell property dlc1ld_aetherialstaffsummondwarvenspider02spell auto
spell property dlc1ld_aetherialstaffsummondwarvensphere01spell auto
spell property dlc1ld_aetherialstaffsummondwarvensphere02spell auto
spell property dlc1ld_aetherialstaffsummonmishapspherespell auto
spell property dlc1ld_aetherialstaffsummonmishapspiderspell auto
spell property dlc1ld_aetherialstaffsummonmishapscrapspell auto
actorbase property dlc1ld_encdwarvenspidersummonmishap auto ;mishap spider to 'summon'
actorbase property dlc1ld_encdwarvenspheresummonmishap auto ;mishap sphere to 'summon'
formlist property dlc1ld_aetherialstaffscraplist auto   ;mishap scrap to 'summon'.
activator property summonvalortargetfxactivator auto   ;activator to use.
activator property dlc1ld_aetherialtimewound auto
faction property dlc1ld_aetherialstaffbusyfaction auto
event oninit()
endevent
function summonmishap() 
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1