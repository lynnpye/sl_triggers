scriptname defaultsetstageonplayeracquireitem extends objectreference  
quest property myqst auto
int property prereqstage = -1 auto
int property stagetoset auto
auto state waiting 
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
endstate
state inactive
endstate
;This file was cleaned with PapyrusSourceHeadliner 1