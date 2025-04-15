scriptname survival_attributeeffectwatchscript extends referencealias
actor property playerref auto
string property penaltyavname auto
string property attributeavname auto
survival_needbase property need auto
globalvariable property survival_modeenabled auto
bool property locked = false auto hidden
event oninit()
endevent
event onplayerloadgame()
endevent
event onupdate()
endevent
function waitforunlock()
endfunction
function checkattributepenalty()
endfunction
function handleattributediseaseapply(spell akdisease, activemagiceffect akeffecttodispel, actor aktarget)
endfunction
bool function within(float affirstvalue, float afsecondvalue, float aflowertolerance, float afuppertolerance)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1