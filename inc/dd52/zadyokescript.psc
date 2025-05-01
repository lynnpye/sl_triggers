scriptname zadyokescript extends zadrestraintscript
message property customstruggleimpossiblemsg auto
message property customstrugglemsg auto
bool property locked = true auto
zadyokequestscript property ybq auto
message property zad_yokedisablelocksmsg auto
message property zad_yokeenablelocksmsg auto
message property zad_yokeequippostmsg auto
message property zad_yokepreequipmsg auto
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