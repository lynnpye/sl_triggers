scriptname ccbgssse001_fishingactscript extends objectreference
ccbgssse001_fishingsystemscript property fishingsystem auto
int property biometype = 0 auto
quest property myquest = none auto
formlist property myquestcatchdatalist = none auto
int property myqueststagetoset = -1 auto
int property myquestrequiredstage = -1 auto
int property myquestrequiredstagemax = -1 auto
globalvariable property myquestitemcaughtglobal = none auto
globalvariable property myquestallowcatchglobal = none auto
int property myquestsetstagerequiredrodtype = -1 auto
float property myquestcatchchance = 1.0 auto
formlist property myoverridejunkcatchdatalist auto
auto state waiting
event onactivate(objectreference akactivatorref)
endevent
endstate
state busy
endstate
objectreference function getfishingmarker()
endfunction
function registerforpopulationupdate(float afhours)
endfunction
event onupdategametime()
endevent
function updatenibble()
endfunction
function updatefishcatchsuccess()
endfunction
function updatefish()
endfunction
function setfishpopulation(int aivalue)
endfunction
function reducefishpopulation(int aiamount)
endfunction
bool function getcalculatedpopulationrecently()
endfunction
function setcalculatedpopulationrecently(bool akcalculatedrecently)
endfunction
bool function getwasmorningevening()
endfunction
function setwasmorningevening(bool abwasmorningevening)
endfunction
int function getcurrentfishpopulation()
endfunction
bool function cancatchquestitem()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1