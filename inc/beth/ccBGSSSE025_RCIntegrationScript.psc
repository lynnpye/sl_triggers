scriptname ccbgssse025_rcintegrationscript extends referencealias
string property rare_curios_plugin = "ccbgssse037-curios.esl" autoreadonly hidden
globalvariable property rarecuriosinstalled auto
leveleditem property ingredientsshiveringcommon50 auto
leveleditem property ingredientsshiveringcommon100 auto
leveleditem property ingredientsshiveringrare100 auto
leveleditem property ingredientsfirestalk100 auto
leveleditem property ingredientsorderheart100 auto
leveleditem property elytradeathitemlist auto
leveleditem property spriggandeathuniqueitemlist50 auto
leveleditem property spriggandeathuniqueitemlist100 auto
int property ingredient_id_alocasiafruit = 0x0d62 autoreadonly hidden
int property ingredient_id_watcherseye = 0x0821 autoreadonly hidden
int property ingredient_id_blisterpodcap = 0x0d6a autoreadonly hidden
int property ingredient_id_hydnumspore = 0x080d autoreadonly hidden
int property ingredient_id_redkelpbladder = 0x0817 autoreadonly hidden
int property ingredient_id_scalonfin = 0x081b autoreadonly hidden
int property ingredient_id_witheringmoon = 0x0824 autoreadonly hidden
int property ingredient_id_wormsheadcap = 0x0825 autoreadonly hidden
int property ingredient_id_asterbloomcore = 0x0d66 autoreadonly hidden
int property ingredient_id_blindwatcherseye = 0x0822 autoreadonly hidden
int property ingredient_id_gnarlbark = 0x082c autoreadonly hidden
int property ingredient_id_orderheart = 0x0851 autoreadonly hidden
int property ingredient_id_hungertongue = 0x080c autoreadonly hidden
int property ingredient_id_voidessence = 0x0820 autoreadonly hidden
int property ingredient_id_elytraichor = 0x0828 autoreadonly hidden
int property ingredient_id_flamestalk = 0x082a autoreadonly hidden
event onplayerloadgame()
endevent
function runintegration()
endfunction
bool function israrecuriosinstalled()
endfunction
function populatelists()
endfunction
function addformtolist(int aiformid, leveleditem firstlist, leveleditem secondlist = none)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1