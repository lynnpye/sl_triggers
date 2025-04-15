scriptname rpdefault_setstagecontainerchangealias extends rpdefault_oncontainerchangedalias
int property prereqstage = -1 auto
int property stagetoset auto
bool function handlecontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1