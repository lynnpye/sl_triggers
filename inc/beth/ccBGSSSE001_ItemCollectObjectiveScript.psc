scriptname ccbgssse001_itemcollectobjectivescript extends referencealias
actor property playerref auto
formlist property questitems auto
quest property myquest auto
globalvariable[] property optcountglobals auto
globalvariable[] property opttotalglobals auto
int property hasallitemsobjective auto
int property readnotestage auto
int property givenitemsstage auto
int property auxobjective = -1 auto
event oninit()
endevent
function displayallobjectives()
endfunction
function completeauxobjective()
endfunction
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
event onitemremoved(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference akdestcontainer)
endevent
function onitemaddedorremoved(form akbaseitem)
endfunction
function updateobjectivesfirsttime()
endfunction
function checkfinalobjective()
endfunction
function trackeditemchanged(form akitem)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1