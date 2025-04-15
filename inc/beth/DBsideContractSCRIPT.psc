scriptname dbsidecontractscript extends actor
quest property dbsidecontract auto    ; define an editor-set variable for which quest this npc is in
auto state actoralive          ; assume actor is alive by default
event ondeath(actor actor)
endevent
endstate
state actordead
endstate
;This file was cleaned with PapyrusSourceHeadliner 1