scriptname wicrowdtriggerscript extends referencealias  
referencealias property spectator1 auto
referencealias property spectator2 auto
referencealias property spectator3 auto
referencealias property spectator4 auto
referencealias property spectator5 auto
referencealias property spectator6 auto
referencealias property spectator7 auto
referencealias property spectator8 auto
referencealias property spectator9 auto
referencealias property spectator10 auto
referencealias property spectator11 auto
referencealias property spectator12 auto
referencealias property spectator13 auto
referencealias property spectator14 auto
referencealias property spectator15 auto
referencealias property spectator16 auto
referencealias property spectator17 auto
referencealias property spectator18 auto
referencealias property spectator19 auto
referencealias property spectator20 auto
faction property factionspectator auto
referencealias property aliastocentertriggeron auto hidden
keyword property actortypenpc auto
event ontriggerenter(objectreference akactionref)
endevent
event onupdate()
endevent
function registerforupdatetriggerposition(referencealias aliastomovetriggerto, int updateeveryhowmanyseconds)
endfunction
function updatetriggerposition()
endfunction
function unregisterfortriggerpositionupdate()
endfunction
function addactortospectatoralias(actor actorref)
endfunction
function registerspectatoraliases(referencealias alias1, referencealias alias2 = none, referencealias alias3 = none, referencealias alias4 = none, referencealias alias5 = none, \
referencealias alias6 = none, referencealias alias7 = none, referencealias alias8 = none, referencealias alias9 = none, referencealias alias10 = none, \
endfunction
function registerspecatoralias(referencealias aliastoregister)
endfunction
function clearspectatoraliases()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1