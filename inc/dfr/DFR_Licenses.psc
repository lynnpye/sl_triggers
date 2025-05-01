scriptname dfr_licenses extends quest conditional
actor property playerref auto
qf__gift_09000d62 property flow auto
adv_licenseutils property util auto
referencealias property masteralias auto
dfr_relationshipmanager property relmanager auto
_dfgoldconqscript property goldcontrol auto
int property minfavourrequired = 0 auto hidden conditional
globalvariable[] property licensestatuses auto
bool property waitingforrefresh = false auto hidden conditional
bool property hasgivenlicenses auto hidden conditional
bool property prefersregulararmor auto hidden conditional
bool property licensesavailable auto hidden conditional
bool property enabled auto hidden conditional
bool property handlinglicenses = false auto hidden conditional
bool property needslicenses auto hidden conditional
float property baseprice = 150.0 auto hidden
float property markup = 10.0 auto hidden
int[] property defaultstatus auto
formlist property licensinglocations auto
keyword[] property citykeywords auto
dfr_licenses function get() global
endfunction
function beginlicensing()
endfunction
function reset()
endfunction
function checklicensestatus()
endfunction
function togglearmorpreference()
endfunction
function togglelicense(int aitype)
endfunction
function refreshlicenses()
endfunction
function givelicense(int aitype)
endfunction
bool function canrefresh()
endfunction
function queuerefresh()
endfunction
function tryrefresh()
endfunction 
function loadbarracks()
endfunction
bool function ishandlingbikiniarmor()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1