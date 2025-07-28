scriptname sl_triggersadaptersla
int function getversion() global
endfunction
int function getarousal(actor target) global
endfunction
int function getexposure(actor target) global
endfunction
int function setexposure(actor target, int value) global
endfunction
int function updateexposure(actor target, int value, string debugmsg = "") global
endfunction
function sendupdateexposureevent(actor target, float value) global
endfunction
float function getactordayssincelastorgasm(actor target) global
endfunction
int function getactorhourssincelastsex(actor target) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1