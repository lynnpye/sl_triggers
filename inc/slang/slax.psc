scriptname slax
event onbeginstate()
endevent
event onendstate()
endevent
bool function debugspam_isenabled() global
endfunction
int function debugspam_getseverity() global
endfunction
function debugspam_setinfo() global
endfunction
function debugspam_setwarning() global
endfunction
function debugspam_seterror() global
endfunction
function debugspam_setalert() global
endfunction
function debugspam_off_alertson() global
endfunction
function debugspam_off() global
endfunction
function enabledebugspam(bool enable) global
endfunction
function notify(string txtmsg) global
endfunction
function messagebox(string txtmsg) global
endfunction
function enabletracespam(int severity) global
endfunction
function disabletracespam() global
endfunction
function trace(int severity, string txtmsg) global
endfunction
function info(string txtmsg) global
endfunction
function infoconditional(string txtmsg, bool condition) global
endfunction
function warning(string txtmsg) global
endfunction
function warningconditional(string txtmsg, bool condition) global
endfunction
function error(string txtmsg) global
endfunction
function errorconditional(string txtmsg, bool condition) global
endfunction
function spam(string txtmsg) global
endfunction
function alert(string txtmsg) global
endfunction
function alertconditional(string txtmsg, bool condition) global
endfunction
function dumpstackconditional(string txtmsg, bool condition) global
endfunction
string function formatfloat_n2(float value) global
endfunction
string function formatfloat_n1(float value) global
endfunction
string function formatfloat_n0(float value) global
endfunction
string function formatfloatpercent_n0(float value) global
endfunction
string function formatfloatpercent_n1(float value) global
endfunction
string function formatdecimal_x10(int value) global
endfunction
string function formatdecimal_x100(int value) global
endfunction
string function formatdecimal_00(int value) global
endfunction
string function formatdecimal_000(int value) global
endfunction
string function formathex(int value) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1