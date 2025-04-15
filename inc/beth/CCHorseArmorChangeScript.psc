scriptname cchorsearmorchangescript extends quest
actor property playerref auto
quest property stables auto
referencealias property stablesplayershorse auto
keyword property ccdisallowsaddleswap auto
actorbase[] property disallowedhorses auto
faction property playerhorsefaction auto
miscobject property gold001 auto
globalvariable property cchorsearmorcost auto
globalvariable property cchorsearmorcostswaponly auto
spell property cchorsearmorabessentialflag auto
formlist property cchorsearmorlist auto
armor[] property arrayhorsearmors auto ;fixed array of horse armors
armor[] property arrayunicornarmors auto ;fixed array of unicorn armors
miscobject[] property arrayhorsearmorsmisc auto ;fixed array of misc items that represent the armors to give to the player
message property cchorsearmormessagearmorcannotuse auto
message property cchorsearmormessagearmorchanged auto
message property cchorsearmormessagearmorremoved auto
message property cchorsearmormessagenohorsesowned auto
message property cchorsearmormessagenotenoughgold auto
message property cchorsearmormessagearmoralreadyequipped auto
function changehorsearmor(int armorid)
endfunction
function equiphorsearmor(actor akplayerhorseref, armor akarmortoequip)
endfunction
bool function swaparmorformiscobject(actor playerhorse)
endfunction
bool function canchangehorsearmor(actor playerhorse)
endfunction
miscobject function getmiscobjectforarmor(armor horsearmor)
endfunction
armor function getarmorformiscobject(miscobject horsearmormisc)
endfunction
function removehorsearmor()
endfunction
actor function getplayerhorse()
endfunction
bool function isunicorn(actor akplayerhorseref)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1