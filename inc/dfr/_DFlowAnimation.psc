scriptname _dflowanimation
bool function inslanimatingfaction(actor who) global
endfunction
function setinslanimatingfaction(actor who, bool infaction) global
endfunction
int function getslvictimcount(actor who) global
endfunction
bool function inddanimatingfaction(actor who) global
endfunction
function setinddanimatingfaction(actor who, bool infaction) global
endfunction
bool function isinvalidanimationactor(actor who) global
endfunction
function setanimating(actor who, bool isanimating = true) global
endfunction
bool[] function startanimation(actor who, string animation) global
endfunction
function playanimation(actor who, string animation, float duration) global
endfunction
function endanimation(actor who, bool[] animationstate) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1