scriptname wiadditem07script extends worldinteractionsscript  conditional
locationalias property itemlocation auto
referencealias property item auto
referencealias property letter auto
referencealias property calcelmo auto
referencealias property player auto
globalvariable property wiadditem07paya auto
globalvariable property wiadditem07payb auto
book property wiadditem07note auto
form property itembase auto hidden
int property itemcount auto conditional hidden
event onstoryaddtoplayer(objectreference akowner, objectreference akcontainer, location aklocation, form akitembase, int aiacquiretype)
endevent
function setitemcount()
endfunction
function setpaymentglobals()
endfunction
function payplayer(int payment1or2)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1