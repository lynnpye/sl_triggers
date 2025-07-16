scriptname slaframeworkscr extends quest
faction property slaarousal auto
faction property slaexposure auto
slamainscr property slamain auto
slaconfigscr property slaconfig auto
bool property isoslarousedstub = true auto
int property slaarousalcap = 100 autoreadonly
function ongameloaded()
endfunction
int function getversion()
endfunction
int function getactorarousal(actor akref)
endfunction
actor function getmostarousedactorinlocation()
endfunction
int function getactorexposure(actor akref)
endfunction
float function getactorexposurerate(actor akref)
endfunction
float function getactortimerate(actor akref)
endfunction
float function setactortimerate(actor akref, float val)
endfunction
float function updateactortimerate(actor akref, float val)
endfunction
int function updateactorexposure(actor act, int modval, string debugmsg = "")
endfunction
int function setactorexposure(actor akref, int val)
endfunction
float function setactorexposurerate(actor akref, float val)
endfunction
float function updateactorexposurerate(actor akref, float val)
endfunction
function onactornakedupdated(actor act, bool newnaked)
endfunction
event modifyexposure(form actform, float val)
endevent
function updateactororgasmdate(actor akref)
endfunction
float function getactordayssincelastorgasm(actor akref)
endfunction
int function getactorhourssincelastsex(actor akref)
endfunction
bool function isactorarousallocked(actor akref)
endfunction
function setactorarousallocked(actor akref, bool val = false)
endfunction
bool function isactorexhibitionist(actor akref)
endfunction
function setactorexhibitionist(actor akref, bool val = false)
endfunction
bool function isactorarousalblocked(actor akref)
endfunction
int function getgenderpreference(actor akref, bool forconfig = false)
endfunction
function setgenderpreference(actor akref, int gender)
endfunction 
function log(string msg) global
endfunction 
;This file was cleaned with PapyrusSourceHeadliner 1