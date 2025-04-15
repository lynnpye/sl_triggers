scriptname rpdefault_setstagelockstatechange extends rpdefault_onlockstatechange
quest property targetquest auto
int property prereqstage = -1 auto
int property stagetoset auto
bool function handlelockstatechanged()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1