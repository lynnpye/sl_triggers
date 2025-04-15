scriptname dlc1ld_aetherialstaffsummonscript extends actor
activator property summonvalortargetfxactivator auto   ;activator to use.
bool property ismishapscrap = false auto
bool property ismishapdead = false auto
formlist property dlc1ld_aetherialstaffscraplist auto   ;mishap scrap to 'summon'.
faction property dlc1ld_aetherialstaffbusyfaction auto
event oninit()
endevent
event onload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1