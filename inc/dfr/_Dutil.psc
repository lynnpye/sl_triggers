scriptname _dutil
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
function enabletracespam(int severity = 0) global
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
function dumpstackconditional(string txtmsg, bool condition) global ; must set info level to see these
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1