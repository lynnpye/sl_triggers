scriptname rpdefault_utility
function positionrelativeto(objectreference akmoveme, objectreference akrelativeto, float[] afoffsetposition, float[] afoffsetangle) global
endfunction
objectreference function placeinfrontofme(form akplaceform, objectreference akplaceinfrontof, float afdistance, bool abfadein = true) global
endfunction
function movebehindplayer(objectreference akmoveme, float afdistance) global
endfunction
function movebehind(objectreference akmoveme, objectreference akmovebehindtarget, float afdistance) global
endfunction
function moverefsbehindplayer(objectreference[] akmoveme, float afdistance) global
endfunction
function moverefsbehind(objectreference[] akmoveme, objectreference akmovebehindtarget, float afdistance) global
endfunction
objectreference function createaliaseditem(form aitemtoadd, referencealias aobjectalias, objectreference akcontaineroractor, bool abputininventory = true) global
endfunction
bool function withingamedaterange(int aimonthtocheck, int aidaytocheck, int aistartmonth, int aistartday, int aiendmonth, int aiendday) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1