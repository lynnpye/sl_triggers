scriptname dlc1magiceatenbybatsscript extends activemagiceffect  
visualeffect property dlc1vampirebatsvfx auto
impactdataset property bloodspraybleedimpactsetred auto
effectshader property dlc1batseatenbloodsplats auto
effectshader property dlc1vampbatseatenbybatsskinfxs auto
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
function decalspray(actor bleedingactor, int xtimes)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1