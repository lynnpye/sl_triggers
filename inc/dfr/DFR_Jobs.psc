scriptname dfr_jobs extends quest conditional
actor property playerref auto
globalvariable property gamedayspassed auto
globalvariable property gamehour auto
referencealias property masteralias auto
dfr_relationshipmanager property relmanager auto
qf__gift_09000d62 property flow auto
string[] property activejobs auto hidden
_dflowmcm property config auto
dfr_collar property collar auto
quest property townmode auto
scene property jobprovisionscene auto
float property jobtimer auto hidden conditional
int property numjobs = 0 auto hidden conditional
bool property foundjob auto hidden conditional
bool property runningjob = false auto hidden conditional
bool property continuingnextjob = false auto hidden conditional
int property provisionmode = 0 auto hidden conditional ; 0 = pause last, 1 = complete last, 2 = fail last
int property provision_mode_interrupt = 0 autoreadonly hidden
int property provision_mode_completed = 1 autoreadonly hidden
int property provision_mode_failed = 2 autoreadonly hidden
int property provision_mode_begin = 3 autoreadonly hidden
int property provision_mode_canceled = 4 autoreadonly hidden
int property maxjobs = 1 auto hidden
int property minjobs auto hidden
bool property mastermode = true auto hidden conditional
bool property jobfgflag = false auto hidden conditional
float property forcedjobdelay = 1.0 auto hidden
function maintenance()
endfunction
dfr_jobs function get() global
endfunction
string function select(bool ablocation = true)
endfunction
function onlocationchange(location aklocation)
endfunction
function setupdialogue(bool ablocation = true)
endfunction
function accept()
endfunction
function refuse()
endfunction
function pausecurrentjob()
endfunction
function delay(string asjob)
endfunction
function log(string asmsg)
endfunction
function add(string asjob)
endfunction
function remove(string asjob)
endfunction
bool function canresumejob(string asjob)
endfunction
function onstartjob(string asjob)
endfunction
function oncanceljob(string asjob)
endfunction
function onresumejob(string asjob)
endfunction
function onpausejob(string asjob)
endfunction
function onstagecomplete(string asjob)
endfunction
function ondone(string asjob, bool abfailed)
endfunction
function playscene(scene akscene)
endfunction
function nextjob()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1