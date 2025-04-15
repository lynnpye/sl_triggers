scriptname survival_hungereatingdetection extends referencealias
actor property playerref auto
formlist property survival_foodpoisoningimmuneraces auto
formlist property survival_foodrawmeat auto
keyword property survival_diseasefoodpoisoningkeyword auto
magiceffect property da11abfortifyhealth auto
magiceffect property werewolffeedrestorehealth auto
message property survival_foodpoisoningmsg auto
spell property survival_diseasefoodpoisoning auto
race property playerrace auto hidden
event oninit()
endevent
event onobjectequipped(form akbaseobject, objectreference akreference)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
function eatingalternative()
endfunction
function checkfoodpoisoning(form akbaseobject)
endfunction
function getplayerrace()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1