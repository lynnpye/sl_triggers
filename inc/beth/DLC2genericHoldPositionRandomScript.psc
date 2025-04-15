scriptname dlc2genericholdpositionrandomscript extends actor
int property combatstate = 0 auto hidden
bool property actorisdead = false auto hidden
bool property breakout = false auto hidden
float property changeholdpostime auto hidden
float property timebeforenextpos = 20.0 auto
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
keyword property linkcustom04 auto
keyword property linkcustom05 auto
keyword property linkcustom06 auto
bool property haslink01 = false auto hidden
bool property haslink02 = false auto hidden
bool property haslink03 = false auto hidden
bool property haslink04 = false auto hidden
bool property haslink05 = false auto hidden
bool property haslink06 = false auto hidden
int property totalholdmarkers = 0 auto hidden
event oncellattach()
endevent
event oncelldetach()
endevent
auto state waiting
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
endstate
state combat
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event onupdate()
endevent
endstate
state dead
endstate
event ondeath(actor akkiller)
endevent
function changeholdposition()
endfunction
function registerholdpositions()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1