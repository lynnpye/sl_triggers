scriptname zadrestraintarmbinderscript extends zadrestraintscript
message property customstruggleimpossiblemsg auto
message property customstrugglemsg auto
bool property locked = true auto
zadarmbinderquestscript property abq auto
message property zad_armbinderdisablelocksmsg auto
message property zad_armbinderenablelocksmsg auto
message property zad_armbinderequippostmsg auto
message property zad_armbinderpreequipmsg auto
function onequippedpre(actor akactor, bool silent)
endfunction
function onequippedpost(actor akactor)
endfunction
function setcustommessage()
endfunction
function setdefaultmessages()
endfunction
int function onequippedfilter(actor akactor, bool silent)
endfunction
function devicemenu(int msgchoice)
endfunction
function onremovedevice(actor akactor)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1