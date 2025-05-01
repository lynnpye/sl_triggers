scriptname dfr_defeathandler extends quest conditional
actor property playerref auto
referencealias property masteralias auto
globalvariable property lives auto
qf__gift_09000d62 property q auto
_dflowmcm property mcm auto
_dfgoldconqscript property goldcon auto
_dftools property tool auto
dfr_jobs property jobs auto
bool property rescuevalid = false auto hidden
bool property bothdowned = false auto hidden conditional
bool property wasdefeated = false auto hidden conditional
bool property followersavedplayer auto hidden conditional
function maintenance()
endfunction
event onqueststart(quest akquest)
endevent
event onnewagreement(form akmaster)
endevent
function resettaunts()
endfunction
event onactordefeated(actor akvictim)
endevent
event onactorrescued(actor akvictim)
endevent
function rescuedebt()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1