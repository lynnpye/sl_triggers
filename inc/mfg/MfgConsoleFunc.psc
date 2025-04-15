scriptname mfgconsolefunc hidden
int function getphonememodifier(actor act, int mode, int id) global native
bool function setphonememodifier(actor act, int mode, int id, int value) global native
event onbeginstate()
endevent
event onendstate()
endevent
bool function setphoneme(actor act, int id, int value) global
endfunction
bool function setmodifier(actor act, int id, int value) global
endfunction
bool function resetphonememodifier(actor act) global
endfunction
int function getphoneme(actor act, int id) global
endfunction
int function getmodifier(actor act, int id) global
endfunction
int function getexpressionvalue(actor act) global
endfunction
int function getexpressionid(actor act) global
endfunction
bool function getmodifiedscript() global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1