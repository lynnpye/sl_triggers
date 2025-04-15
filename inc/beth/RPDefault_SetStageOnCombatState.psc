scriptname rpdefault_setstageoncombatstate extends rpdefault_oncombatstate
quest property targetquest auto
int property prereqstage = -1 auto
int property stagetoset auto
bool function handlecombatstatechanged(actor aktarget, int aecombatstate)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1