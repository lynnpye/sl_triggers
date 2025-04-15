scriptname cwmaptablescenescript extends quest  conditional
quest property externalquest auto
int property externalqueststagetosetwhensceneends auto
int property scenephase auto hidden conditional
bool property shutdownquestonplayerlocationchange = true auto
scene property myscene auto
event onstorychangelocation(objectreference akactor, location akoldlocation, location aknewlocation)
endevent
event onupdate()
endevent
function startmyscene(bool waituntilscenecompletes = false, int waittimemax = 600)
endfunction
function stopmyscene()
endfunction
function incrementscenephase()
endfunction
function sceneend()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1