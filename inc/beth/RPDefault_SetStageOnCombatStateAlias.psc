scriptname rpdefault_setstageoncombatstatealias extends rpdefault_oncombatstatealias
int property prereqstage = -1 auto
int property stagetoset auto
bool function handlecombatstatechanged(actor aktarget, int aecombatstate)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1