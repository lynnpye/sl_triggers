scriptname slaframeworkscr extends quest
int property decayfunction = 1 autoreadonly
int property linearfunction = 2 autoreadonly
actor property playerref auto
sexlabframework property sexlab auto
faction property slaarousal auto
faction property slaarousalblocked auto
int property slaarousalcap = 100 autoreadonly
faction property slaarousallocked auto
formlist property slaarousedvoicelist auto
slaconfigscr property slaconfig auto
faction property slaexhibitionist auto
faction property slaexposure auto
faction property slaexposurerate auto
faction property slafatigue auto
faction property slafrustration auto
faction property slagenderpreference auto
slamainscr property slamain auto
faction property slatimerate auto
faction property slatrauma auto
formlist property slaunarousedvoicelist auto
globalvariable property sla_nextmaintenance auto
function updateactororgasmdate(actor who)
endfunction
float function getdynamiceffectvalue(actor who, string effectid)
endfunction
function setdynamicarousaleffect(actor who, string effectid, float initialvalue, int functionid, float param, float limit)
endfunction
function moddynamicarousaleffect(form who, string effectid, float modifier, float limit)
endfunction
int function getversion()
endfunction
int function getgenderpreference(actor who, bool forconfig)
endfunction
function setgenderpreference(actor who, int gender)
endfunction
bool function isactorexhibitionist(actor who)
endfunction
function setactorexhibitionist(actor who, bool isexhibitionist)
endfunction
float function getactorexposurerate(actor who)
endfunction
float function setactorexposurerate(actor who, float exposurerate)
endfunction
float function updateactorexposurerate(actor who, float exposureratedelta)
endfunction
int function getactorexposure(actor who)
endfunction
int function setactorexposure(actor who, int newactorexposure)
endfunction
int function updateactorexposure(actor who, int exposuredelta, string debugmessage)
endfunction
float function getactortimerate(actor who)
endfunction
float function setactortimerate(actor who, float timerate)
endfunction
float function updateactortimerate(actor who, float timeratedelta)
endfunction
float function getactordayssincelastorgasm(actor who)
endfunction
float function getactordayssincelastrape(actor who)
endfunction
bool function isactorarousallocked(actor who)
endfunction
function setactorarousallocked(actor who, bool islocked)
endfunction
bool function isactorarousalblocked(actor who)
endfunction
function setactorarousalblocked(actor who, bool isblocked)
endfunction
int function getactorarousal(actor who)
endfunction
actor function getmostarousedactorinlocation()
endfunction
function updatesosposition(actor who, int actorarousal)
endfunction
function handleerection(actor who, int position)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1