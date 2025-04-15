scriptname rpdefault_setstagelocationchangealias extends rpdefault_onlocationchangealias
int property prereqstage = -1 auto
int property stagetoset auto
bool function handlelocationchange(location akoldloc, location aknewloc)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1