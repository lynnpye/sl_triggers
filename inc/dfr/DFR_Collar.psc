scriptname dfr_collar extends quest conditional
adv_collar property collar auto
qf__gift_09000d62 property flow auto
dfr_relationshipmanager property relmanager auto
referencealias property masteralias auto
quest property townmode auto
scene property leashscene auto
scene property leadscene auto
scene property locationscene auto
bool property targetset auto hidden conditional
bool property enabled = false auto hidden conditional
bool property onbreak = false auto hidden conditional
float property closedistancethreshold = 1000.0 auto
dfr_collar function get() global
endfunction
function maintenance()
endfunction
function settargetref(objectreference aktarget)
endfunction
function restrictlocation(location aklocation)
endfunction
function resetall()
endfunction
function pause(string askey)
endfunction
function resume(string askey)
endfunction
event oncollarviolation(string asevent, string asarg, float afarg, form aksender)
endevent
function oncollarupdate(float aflastdistance, float afcurrentdistance)
endfunction
function break()
endfunction
event onupdategametime()
endevent
function endbreak()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1